return {
	Play1104702001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1104702001
		arg_1_1.duration_ = 7.3

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1104702002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST27a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST27a")
				var_4_0.name = "ST27a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST27a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST27a

				arg_1_1.bgs_.ST27a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST27a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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
				arg_1_1:AudioAction("play", "music", "bgm_story_quiet_1", "bgm_story_quiet_1", "bgm_story_quiet_1.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_story_quiet_1", "bgm_story_quiet_1")

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

			local var_4_13 = 1.999999999999
			local var_4_14 = 0.6

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_16 = arg_1_1:GetWordFromCfg(1104702001)
				local var_4_17 = arg_1_1:FormatText(var_4_16.content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 24 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 24)

				if (24 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_17) / 24)) > 0 and var_4_14 < var_4_19 then
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702001", "story_v_side_new_1104702.awb") ~= 0 then
					local var_4_20 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702001", "story_v_side_new_1104702.awb") / 1000

					if var_4_20 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_13
					end

					if var_4_16.prefab_name ~= "" and arg_1_1.actors_[var_4_16.prefab_name] ~= nil then
						local var_4_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_16.prefab_name].transform, "story_v_side_new_1104702", "1104702001", "story_v_side_new_1104702.awb")

						arg_1_1:RecordAudio("1104702001", var_4_21)
						arg_1_1:RecordAudio("1104702001", var_4_21)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702001", "story_v_side_new_1104702.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702001", "story_v_side_new_1104702.awb")
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
	Play1104702002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 1104702002
		arg_8_1.duration_ = 3.83

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play1104702003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.4

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:GetWordFromCfg(1104702002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 16 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 16)

				if (16 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 16)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702002", "story_v_side_new_1104702.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702002", "story_v_side_new_1104702.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_side_new_1104702", "1104702002", "story_v_side_new_1104702.awb")

						arg_8_1:RecordAudio("1104702002", var_11_6)
						arg_8_1:RecordAudio("1104702002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702002", "story_v_side_new_1104702.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702002", "story_v_side_new_1104702.awb")
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
	Play1104702003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 1104702003
		arg_12_1.duration_ = 2.6

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play1104702004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.25

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:GetWordFromCfg(1104702003)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702003", "story_v_side_new_1104702.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702003", "story_v_side_new_1104702.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_side_new_1104702", "1104702003", "story_v_side_new_1104702.awb")

						arg_12_1:RecordAudio("1104702003", var_15_6)
						arg_12_1:RecordAudio("1104702003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702003", "story_v_side_new_1104702.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702003", "story_v_side_new_1104702.awb")
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
	Play1104702004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 1104702004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play1104702005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.1

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

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(1104702004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 44 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 44)

				if (44 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 44)) > 0 and var_19_0 < var_19_3 then
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
	Play1104702005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 1104702005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play1104702006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 1.125

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(1104702005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 45 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 45)

				if (45 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 45)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play1104702006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 1104702006
		arg_24_1.duration_ = 4

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play1104702007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.525

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(1104702006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 21 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 21)

				if (21 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 21)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702006", "story_v_side_new_1104702.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702006", "story_v_side_new_1104702.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_side_new_1104702", "1104702006", "story_v_side_new_1104702.awb")

						arg_24_1:RecordAudio("1104702006", var_27_6)
						arg_24_1:RecordAudio("1104702006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702006", "story_v_side_new_1104702.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702006", "story_v_side_new_1104702.awb")
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
	Play1104702007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 1104702007
		arg_28_1.duration_ = 6.6

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play1104702008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.825

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_1 = arg_28_1:GetWordFromCfg(1104702007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 33 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 33)

				if (33 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 33)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702007", "story_v_side_new_1104702.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702007", "story_v_side_new_1104702.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_side_new_1104702", "1104702007", "story_v_side_new_1104702.awb")

						arg_28_1:RecordAudio("1104702007", var_31_6)
						arg_28_1:RecordAudio("1104702007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702007", "story_v_side_new_1104702.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702007", "story_v_side_new_1104702.awb")
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
	Play1104702008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1104702008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1104702009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.825

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(1104702008).content)

				arg_32_1.text_.text = var_35_1

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_3 = 33 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 33)

				if (33 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 33)) > 0 and var_35_0 < var_35_3 then
					arg_32_1.talkMaxDuration = var_35_3

					if var_35_3 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_3 + 0
					end
				end

				arg_32_1.text_.text = var_35_1
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_4 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_4

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play1104702009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1104702009
		arg_36_1.duration_ = 8.83

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play1104702010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 1.2

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_1 = arg_36_1:GetWordFromCfg(1104702009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 48 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 48)

				if (48 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 48)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702009", "story_v_side_new_1104702.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702009", "story_v_side_new_1104702.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_side_new_1104702", "1104702009", "story_v_side_new_1104702.awb")

						arg_36_1:RecordAudio("1104702009", var_39_6)
						arg_36_1:RecordAudio("1104702009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702009", "story_v_side_new_1104702.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702009", "story_v_side_new_1104702.awb")
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
	Play1104702010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 1104702010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play1104702011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.225

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(1104702010).content)

				arg_40_1.text_.text = var_43_1

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_3 = 9 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 9)

				if (9 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 9)) > 0 and var_43_0 < var_43_3 then
					arg_40_1.talkMaxDuration = var_43_3

					if var_43_3 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_3 + 0
					end
				end

				arg_40_1.text_.text = var_43_1
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_4 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_4

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play1104702011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 1104702011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play1104702012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.95

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(1104702011).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 38 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 38)

				if (38 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 38)) > 0 and var_47_0 < var_47_3 then
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
	Play1104702012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 1104702012
		arg_48_1.duration_ = 7

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play1104702013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_9000

			if arg_48_1.bgs_.ST84a == nil then
				local var_51_0 = Object.Instantiate(arg_48_1.paintGo_)

				var_51_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST84a")
				var_51_0.name = "ST84a"
				var_51_0.transform.parent = arg_48_1.stage_.transform
				var_51_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.bgs_.ST84a = var_51_0
			end

			if 0.7 < arg_48_1.time_ and arg_48_1.time_ <= 0.7 + arg_51_0 then
				local var_51_1 = arg_48_1.bgs_.ST84a

				arg_48_1.bgs_.ST84a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_51_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_51_2 = var_51_1:GetComponent("SpriteRenderer")

				if var_51_2 and var_51_2.sprite then
					local var_51_3 = 2 * (var_51_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_51_1.transform.localScale = Vector3.New(var_51_3 / var_51_2.sprite.bounds.size.y < var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x and var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x or var_51_3 / var_51_2.sprite.bounds.size.y, var_51_3 / var_51_2.sprite.bounds.size.y < var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x and var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x or var_51_3 / var_51_2.sprite.bounds.size.y, 0)
				end

				for iter_51_0, iter_51_1 in pairs(arg_48_1.bgs_) do
					if iter_51_0 ~= "ST84a" then
						iter_51_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_51_4 = 2

			if 2 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.allBtn_.enabled = false
			end

			if arg_48_1.time_ >= var_51_4 + 0.3 and arg_48_1.time_ < var_51_4 + 0.3 + arg_51_0 then
				arg_48_1.allBtn_.enabled = true
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				local var_51_5 = arg_48_1.var_.effectzhuanchangyixia1

				if not arg_48_1.var_.effectzhuanchangyixia1 then
					var_51_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_51_5.name = "zhuanchangyixia1"
					arg_48_1.var_.effectzhuanchangyixia1 = var_51_5
				else
					var_51_5.transform:SetParent(var_51_9000)
				end

				var_51_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_51_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_51_5.transform.localScale = Vector3.New(var_51_5.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_51_5.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_51_5.transform.localScale.z)
			end

			if 1.2 < arg_48_1.time_ and arg_48_1.time_ <= 1.2 + arg_51_0 then
				arg_48_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 1.5 < arg_48_1.time_ and arg_48_1.time_ <= 1.5 + arg_51_0 then
				arg_48_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_keyboard", "")
			end

			if 0.1 < arg_48_1.time_ and arg_48_1.time_ <= 0.1 + arg_51_0 then
				arg_48_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_club", "")
			end

			if arg_48_1.frameCnt_ <= 1 then
				arg_48_1.dialog_:SetActive(false)
			end

			local var_51_10 = 2
			local var_51_11 = 1.275

			if 2 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0

				arg_48_1.dialog_:SetActive(true)

				arg_48_1.dialogCg_.alpha = 0

				local var_51_12 = LeanTween.value(arg_48_1.dialog_, 0, 1, 0.3)

				var_51_12:setOnUpdate(LuaHelper.FloatAction(function(arg_52_0)
					arg_48_1.dialogCg_.alpha = arg_52_0
				end))
				var_51_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_48_1.dialog_)
					var_51_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_48_1.duration_ = arg_48_1.duration_ + 0.3

				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_13 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(1104702012).content)

				arg_48_1.text_.text = var_51_13

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_15 = 51 <= 0 and var_51_11 or var_51_11 * (utf8.len(var_51_13) / 51)

				if (51 <= 0 and var_51_11 or var_51_11 * (utf8.len(var_51_13) / 51)) > 0 and var_51_11 < var_51_15 then
					arg_48_1.talkMaxDuration = var_51_15
					var_51_10 = var_51_10 + 0.3

					if var_51_15 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_15 + var_51_10
					end
				end

				arg_48_1.text_.text = var_51_13
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_16 = var_51_10 + 0.3
			local var_51_17 = math.max(var_51_11, arg_48_1.talkMaxDuration)

			if var_51_10 + 0.3 <= arg_48_1.time_ and arg_48_1.time_ < var_51_16 + var_51_17 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_16) / var_51_17

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_16 + var_51_17 and arg_48_1.time_ < var_51_16 + var_51_17 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play1104702013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 1104702013
		arg_54_1.duration_ = 2

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play1104702014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if arg_54_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_57_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_54_1.stage_.transform)

				var_57_0.name = "1047ui_story"
				var_57_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.actors_["1047ui_story"] = var_57_0

				local var_57_1 = var_57_0:GetComponentInChildren(typeof(CharacterEffect))

				var_57_1.enabled = true

				local var_57_2 = GameObjectTools.GetOrAddComponent(var_57_0, typeof(DynamicBoneHelper))

				if var_57_2 then
					var_57_2:EnableDynamicBone(false)
				end

				arg_54_1:ShowWeapon(var_57_1.transform, false)

				arg_54_1.var_["1047ui_story" .. "Animator"] = var_57_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_54_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_54_1.var_["1047ui_story" .. "LipSync"] = var_57_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_57_3 = arg_54_1.actors_["1047ui_story"].transform

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1047ui_story = var_57_3.localPosition
			end

			local var_57_4 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 then
				var_57_3.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_54_1.time_ - 0) / var_57_4)
				var_57_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_3.position).x, (manager.ui.mainCamera.transform.position - var_57_3.position).y, (manager.ui.mainCamera.transform.position - var_57_3.position).z)
				var_57_3.localEulerAngles.z = 0
				var_57_3.localEulerAngles.x = 0
				var_57_3.localEulerAngles = var_57_3.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 then
				var_57_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_57_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_57_3.position).x, (manager.ui.mainCamera.transform.position - var_57_3.position).y, (manager.ui.mainCamera.transform.position - var_57_3.position).z)
				var_57_3.localEulerAngles.z = 0
				var_57_3.localEulerAngles.x = 0
				var_57_3.localEulerAngles = var_57_3.localEulerAngles
			end

			local var_57_5 = arg_54_1.actors_["1047ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_5) and arg_54_1.var_.characterEffect1047ui_story == nil then
				arg_54_1.var_.characterEffect1047ui_story = var_57_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_6 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_6 and not isNil(var_57_5) then
				if arg_54_1.var_.characterEffect1047ui_story and not isNil(var_57_5) then
					arg_54_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_6 and arg_54_1.time_ < 0 + var_57_6 + arg_57_0 and not isNil(var_57_5) and arg_54_1.var_.characterEffect1047ui_story then
				arg_54_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_57_8 = 0
			local var_57_9 = 0.05

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_8 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_10 = arg_54_1:GetWordFromCfg(1104702013)
				local var_57_11 = arg_54_1:FormatText(var_57_10.content)

				arg_54_1.text_.text = var_57_11

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_13 = 2 <= 0 and var_57_9 or var_57_9 * (utf8.len(var_57_11) / 2)

				if (2 <= 0 and var_57_9 or var_57_9 * (utf8.len(var_57_11) / 2)) > 0 and var_57_9 < var_57_13 then
					arg_54_1.talkMaxDuration = var_57_13

					if var_57_13 + var_57_8 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_13 + var_57_8
					end
				end

				arg_54_1.text_.text = var_57_11
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702013", "story_v_side_new_1104702.awb") ~= 0 then
					local var_57_14 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702013", "story_v_side_new_1104702.awb") / 1000

					if var_57_14 + var_57_8 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_14 + var_57_8
					end

					if var_57_10.prefab_name ~= "" and arg_54_1.actors_[var_57_10.prefab_name] ~= nil then
						local var_57_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_10.prefab_name].transform, "story_v_side_new_1104702", "1104702013", "story_v_side_new_1104702.awb")

						arg_54_1:RecordAudio("1104702013", var_57_15)
						arg_54_1:RecordAudio("1104702013", var_57_15)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702013", "story_v_side_new_1104702.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702013", "story_v_side_new_1104702.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_16 = math.max(var_57_9, arg_54_1.talkMaxDuration)

			if var_57_8 <= arg_54_1.time_ and arg_54_1.time_ < var_57_8 + var_57_16 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_8) / var_57_16

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_8 + var_57_16 and arg_54_1.time_ < var_57_8 + var_57_16 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
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

		arg_54_1:InitPlayNodeList()
	end,
	Play1104702014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 1104702014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play1104702015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["1047ui_story"]) and arg_58_1.var_.characterEffect1047ui_story == nil then
				arg_58_1.var_.characterEffect1047ui_story = arg_58_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["1047ui_story"]) then
				if arg_58_1.var_.characterEffect1047ui_story and not isNil(arg_58_1.actors_["1047ui_story"]) then
					arg_58_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_0)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["1047ui_story"]) and arg_58_1.var_.characterEffect1047ui_story then
				arg_58_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_61_1 = arg_58_1.actors_["1047ui_story"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1047ui_story = var_61_1.localPosition
			end

			local var_61_2 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_2 then
				var_61_1.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_58_1.time_ - 0) / var_61_2)
				var_61_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_1.position).x, (manager.ui.mainCamera.transform.position - var_61_1.position).y, (manager.ui.mainCamera.transform.position - var_61_1.position).z)
				var_61_1.localEulerAngles.z = 0
				var_61_1.localEulerAngles.x = 0
				var_61_1.localEulerAngles = var_61_1.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_2 and arg_58_1.time_ < 0 + var_61_2 + arg_61_0 then
				var_61_1.localPosition = Vector3.New(0, 100, 0)
				var_61_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_1.position).x, (manager.ui.mainCamera.transform.position - var_61_1.position).y, (manager.ui.mainCamera.transform.position - var_61_1.position).z)
				var_61_1.localEulerAngles.z = 0
				var_61_1.localEulerAngles.x = 0
				var_61_1.localEulerAngles = var_61_1.localEulerAngles
			end

			local var_61_3 = 0
			local var_61_4 = 0.175

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_3 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_5 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(1104702014).content)

				arg_58_1.text_.text = var_61_5

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_7 = 7 <= 0 and var_61_4 or var_61_4 * (utf8.len(var_61_5) / 7)

				if (7 <= 0 and var_61_4 or var_61_4 * (utf8.len(var_61_5) / 7)) > 0 and var_61_4 < var_61_7 then
					arg_58_1.talkMaxDuration = var_61_7

					if var_61_7 + var_61_3 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_7 + var_61_3
					end
				end

				arg_58_1.text_.text = var_61_5
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_8 = math.max(var_61_4, arg_58_1.talkMaxDuration)

			if var_61_3 <= arg_58_1.time_ and arg_58_1.time_ < var_61_3 + var_61_8 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_3) / var_61_8

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_3 + var_61_8 and arg_58_1.time_ < var_61_3 + var_61_8 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
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

		arg_58_1:InitPlayNodeList()
	end,
	Play1104702015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 1104702015
		arg_62_1.duration_ = 4.9

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play1104702016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1047ui_story = arg_62_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_65_0 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 then
				arg_62_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_62_1.time_ - 0) / var_65_0)
				arg_62_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1047ui_story"].transform.position).z)
				arg_62_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1047ui_story"].transform.localEulerAngles = arg_62_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 then
				arg_62_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_62_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1047ui_story"].transform.position).z)
				arg_62_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1047ui_story"].transform.localEulerAngles = arg_62_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_65_1 = arg_62_1.actors_["1047ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_1) and arg_62_1.var_.characterEffect1047ui_story == nil then
				arg_62_1.var_.characterEffect1047ui_story = var_65_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_2 and not isNil(var_65_1) then
				if arg_62_1.var_.characterEffect1047ui_story and not isNil(var_65_1) then
					arg_62_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_2 and arg_62_1.time_ < 0 + var_65_2 + arg_65_0 and not isNil(var_65_1) and arg_62_1.var_.characterEffect1047ui_story then
				arg_62_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_65_4 = 0
			local var_65_5 = 0.525

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_6 = arg_62_1:GetWordFromCfg(1104702015)
				local var_65_7 = arg_62_1:FormatText(var_65_6.content)

				arg_62_1.text_.text = var_65_7

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_9 = 21 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 21)

				if (21 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 21)) > 0 and var_65_5 < var_65_9 then
					arg_62_1.talkMaxDuration = var_65_9

					if var_65_9 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_9 + var_65_4
					end
				end

				arg_62_1.text_.text = var_65_7
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702015", "story_v_side_new_1104702.awb") ~= 0 then
					local var_65_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702015", "story_v_side_new_1104702.awb") / 1000

					if var_65_10 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_4
					end

					if var_65_6.prefab_name ~= "" and arg_62_1.actors_[var_65_6.prefab_name] ~= nil then
						local var_65_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_6.prefab_name].transform, "story_v_side_new_1104702", "1104702015", "story_v_side_new_1104702.awb")

						arg_62_1:RecordAudio("1104702015", var_65_11)
						arg_62_1:RecordAudio("1104702015", var_65_11)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702015", "story_v_side_new_1104702.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702015", "story_v_side_new_1104702.awb")
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play1104702016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 1104702016
		arg_66_1.duration_ = 6.73

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play1104702017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_69_0 = 0
			local var_69_1 = 0.8

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_2 = arg_66_1:GetWordFromCfg(1104702016)
				local var_69_3 = arg_66_1:FormatText(var_69_2.content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 32 <= 0 and var_69_1 or var_69_1 * (utf8.len(var_69_3) / 32)

				if (32 <= 0 and var_69_1 or var_69_1 * (utf8.len(var_69_3) / 32)) > 0 and var_69_1 < var_69_5 then
					arg_66_1.talkMaxDuration = var_69_5

					if var_69_5 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + var_69_0
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702016", "story_v_side_new_1104702.awb") ~= 0 then
					local var_69_6 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702016", "story_v_side_new_1104702.awb") / 1000

					if var_69_6 + var_69_0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_6 + var_69_0
					end

					if var_69_2.prefab_name ~= "" and arg_66_1.actors_[var_69_2.prefab_name] ~= nil then
						local var_69_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_2.prefab_name].transform, "story_v_side_new_1104702", "1104702016", "story_v_side_new_1104702.awb")

						arg_66_1:RecordAudio("1104702016", var_69_7)
						arg_66_1:RecordAudio("1104702016", var_69_7)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702016", "story_v_side_new_1104702.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702016", "story_v_side_new_1104702.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_8 = math.max(var_69_1, arg_66_1.talkMaxDuration)

			if var_69_0 <= arg_66_1.time_ and arg_66_1.time_ < var_69_0 + var_69_8 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_0) / var_69_8

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_0 + var_69_8 and arg_66_1.time_ < var_69_0 + var_69_8 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play1104702017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 1104702017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play1104702018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1047ui_story"]) and arg_70_1.var_.characterEffect1047ui_story == nil then
				arg_70_1.var_.characterEffect1047ui_story = arg_70_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1047ui_story"]) then
				if arg_70_1.var_.characterEffect1047ui_story and not isNil(arg_70_1.actors_["1047ui_story"]) then
					arg_70_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_0)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1047ui_story"]) and arg_70_1.var_.characterEffect1047ui_story then
				arg_70_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_73_1 = 0
			local var_73_2 = 1.175

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_3 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(1104702017).content)

				arg_70_1.text_.text = var_73_3

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_5 = 47 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 47)

				if (47 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_3) / 47)) > 0 and var_73_2 < var_73_5 then
					arg_70_1.talkMaxDuration = var_73_5

					if var_73_5 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + var_73_1
					end
				end

				arg_70_1.text_.text = var_73_3
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_6 = math.max(var_73_2, arg_70_1.talkMaxDuration)

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_6 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_1) / var_73_6

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_1 + var_73_6 and arg_70_1.time_ < var_73_1 + var_73_6 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play1104702018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 1104702018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play1104702019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1047ui_story"]) and arg_74_1.var_.characterEffect1047ui_story == nil then
				arg_74_1.var_.characterEffect1047ui_story = arg_74_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1047ui_story"]) then
				if arg_74_1.var_.characterEffect1047ui_story and not isNil(arg_74_1.actors_["1047ui_story"]) then
					arg_74_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1047ui_story"]) and arg_74_1.var_.characterEffect1047ui_story then
				arg_74_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuC", "EmotionTimelineAnimator")
			end

			local var_77_2 = 0
			local var_77_3 = 0.425

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_4 = arg_74_1:GetWordFromCfg(1104702018)
				local var_77_5 = arg_74_1:FormatText(var_77_4.content)

				arg_74_1.text_.text = var_77_5

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_7 = 17 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 17)

				if (17 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 17)) > 0 and var_77_3 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_2
					end
				end

				arg_74_1.text_.text = var_77_5
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702018", "story_v_side_new_1104702.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702018", "story_v_side_new_1104702.awb") / 1000

					if var_77_8 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_2
					end

					if var_77_4.prefab_name ~= "" and arg_74_1.actors_[var_77_4.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_4.prefab_name].transform, "story_v_side_new_1104702", "1104702018", "story_v_side_new_1104702.awb")

						arg_74_1:RecordAudio("1104702018", var_77_9)
						arg_74_1:RecordAudio("1104702018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702018", "story_v_side_new_1104702.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702018", "story_v_side_new_1104702.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_3, arg_74_1.talkMaxDuration)

			if var_77_2 <= arg_74_1.time_ and arg_74_1.time_ < var_77_2 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_2) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_2 + var_77_10 and arg_74_1.time_ < var_77_2 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play1104702019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 1104702019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play1104702020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1047ui_story"]) and arg_78_1.var_.characterEffect1047ui_story == nil then
				arg_78_1.var_.characterEffect1047ui_story = arg_78_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1047ui_story"]) then
				if arg_78_1.var_.characterEffect1047ui_story and not isNil(arg_78_1.actors_["1047ui_story"]) then
					arg_78_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_0)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1047ui_story"]) and arg_78_1.var_.characterEffect1047ui_story then
				arg_78_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_81_1 = arg_78_1.actors_["1047ui_story"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1047ui_story = var_81_1.localPosition
			end

			local var_81_2 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_2 then
				var_81_1.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_78_1.time_ - 0) / var_81_2)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_2 and arg_78_1.time_ < 0 + var_81_2 + arg_81_0 then
				var_81_1.localPosition = Vector3.New(0, 100, 0)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles
			end

			local var_81_3 = 0
			local var_81_4 = 1.3

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_3 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_5 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(1104702019).content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 52 <= 0 and var_81_4 or var_81_4 * (utf8.len(var_81_5) / 52)

				if (52 <= 0 and var_81_4 or var_81_4 * (utf8.len(var_81_5) / 52)) > 0 and var_81_4 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_3 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_3
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_8 = math.max(var_81_4, arg_78_1.talkMaxDuration)

			if var_81_3 <= arg_78_1.time_ and arg_78_1.time_ < var_81_3 + var_81_8 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_3) / var_81_8

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_3 + var_81_8 and arg_78_1.time_ < var_81_3 + var_81_8 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
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

		arg_78_1:InitPlayNodeList()
	end,
	Play1104702020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 1104702020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play1104702021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 1.125

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_1 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(1104702020).content)

				arg_82_1.text_.text = var_85_1

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_3 = 45 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 45)

				if (45 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 45)) > 0 and var_85_0 < var_85_3 then
					arg_82_1.talkMaxDuration = var_85_3

					if var_85_3 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_3 + 0
					end
				end

				arg_82_1.text_.text = var_85_1
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_4 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_4

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play1104702021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 1104702021
		arg_86_1.duration_ = 3.4

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play1104702022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1047ui_story = arg_86_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_89_0 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				arg_86_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_86_1.time_ - 0) / var_89_0)
				arg_86_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1047ui_story"].transform.position).z)
				arg_86_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1047ui_story"].transform.localEulerAngles = arg_86_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				arg_86_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_86_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1047ui_story"].transform.position).z)
				arg_86_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1047ui_story"].transform.localEulerAngles = arg_86_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_89_1 = arg_86_1.actors_["1047ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect1047ui_story == nil then
				arg_86_1.var_.characterEffect1047ui_story = var_89_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_2 and not isNil(var_89_1) then
				if arg_86_1.var_.characterEffect1047ui_story and not isNil(var_89_1) then
					arg_86_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_2 and arg_86_1.time_ < 0 + var_89_2 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.characterEffect1047ui_story then
				arg_86_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_89_4 = 0
			local var_89_5 = 0.3

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_6 = arg_86_1:GetWordFromCfg(1104702021)
				local var_89_7 = arg_86_1:FormatText(var_89_6.content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 12 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 12)

				if (12 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 12)) > 0 and var_89_5 < var_89_9 then
					arg_86_1.talkMaxDuration = var_89_9

					if var_89_9 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_7
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702021", "story_v_side_new_1104702.awb") ~= 0 then
					local var_89_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702021", "story_v_side_new_1104702.awb") / 1000

					if var_89_10 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_4
					end

					if var_89_6.prefab_name ~= "" and arg_86_1.actors_[var_89_6.prefab_name] ~= nil then
						local var_89_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_6.prefab_name].transform, "story_v_side_new_1104702", "1104702021", "story_v_side_new_1104702.awb")

						arg_86_1:RecordAudio("1104702021", var_89_11)
						arg_86_1:RecordAudio("1104702021", var_89_11)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702021", "story_v_side_new_1104702.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702021", "story_v_side_new_1104702.awb")
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

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play1104702022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 1104702022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play1104702023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1047ui_story"]) and arg_90_1.var_.characterEffect1047ui_story == nil then
				arg_90_1.var_.characterEffect1047ui_story = arg_90_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1047ui_story"]) then
				if arg_90_1.var_.characterEffect1047ui_story and not isNil(arg_90_1.actors_["1047ui_story"]) then
					arg_90_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1047ui_story"]) and arg_90_1.var_.characterEffect1047ui_story then
				arg_90_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_93_1 = 0
			local var_93_2 = 0.1

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(1104702022).content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 4 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 4)

				if (4 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 4)) > 0 and var_93_2 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_6 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_6 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_6

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_6 and arg_90_1.time_ < var_93_1 + var_93_6 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play1104702023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 1104702023
		arg_94_1.duration_ = 9.2

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play1104702024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1047ui_story"]) and arg_94_1.var_.characterEffect1047ui_story == nil then
				arg_94_1.var_.characterEffect1047ui_story = arg_94_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1047ui_story"]) then
				if arg_94_1.var_.characterEffect1047ui_story and not isNil(arg_94_1.actors_["1047ui_story"]) then
					arg_94_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1047ui_story"]) and arg_94_1.var_.characterEffect1047ui_story then
				arg_94_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_97_2 = 0
			local var_97_3 = 1.05

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_2 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_4 = arg_94_1:GetWordFromCfg(1104702023)
				local var_97_5 = arg_94_1:FormatText(var_97_4.content)

				arg_94_1.text_.text = var_97_5

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_7 = 42 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_5) / 42)

				if (42 <= 0 and var_97_3 or var_97_3 * (utf8.len(var_97_5) / 42)) > 0 and var_97_3 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_2
					end
				end

				arg_94_1.text_.text = var_97_5
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702023", "story_v_side_new_1104702.awb") ~= 0 then
					local var_97_8 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702023", "story_v_side_new_1104702.awb") / 1000

					if var_97_8 + var_97_2 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_8 + var_97_2
					end

					if var_97_4.prefab_name ~= "" and arg_94_1.actors_[var_97_4.prefab_name] ~= nil then
						local var_97_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_4.prefab_name].transform, "story_v_side_new_1104702", "1104702023", "story_v_side_new_1104702.awb")

						arg_94_1:RecordAudio("1104702023", var_97_9)
						arg_94_1:RecordAudio("1104702023", var_97_9)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702023", "story_v_side_new_1104702.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702023", "story_v_side_new_1104702.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_10 = math.max(var_97_3, arg_94_1.talkMaxDuration)

			if var_97_2 <= arg_94_1.time_ and arg_94_1.time_ < var_97_2 + var_97_10 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_2) / var_97_10

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_2 + var_97_10 and arg_94_1.time_ < var_97_2 + var_97_10 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play1104702024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 1104702024
		arg_98_1.duration_ = 6.4

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play1104702025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1047ui_story = arg_98_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_101_0 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 then
				arg_98_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_98_1.time_ - 0) / var_101_0)
				arg_98_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1047ui_story"].transform.position).z)
				arg_98_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["1047ui_story"].transform.localEulerAngles = arg_98_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 then
				arg_98_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_98_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1047ui_story"].transform.position).z)
				arg_98_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["1047ui_story"].transform.localEulerAngles = arg_98_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action435")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 1.999999999999 < arg_98_1.time_ and arg_98_1.time_ <= 1.999999999999 + arg_101_0 then
				arg_98_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action5_2")
			end

			local var_101_1 = 0
			local var_101_2 = 0.725

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:GetWordFromCfg(1104702024)
				local var_101_4 = arg_98_1:FormatText(var_101_3.content)

				arg_98_1.text_.text = var_101_4

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_6 = 29 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_4) / 29)

				if (29 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_4) / 29)) > 0 and var_101_2 < var_101_6 then
					arg_98_1.talkMaxDuration = var_101_6

					if var_101_6 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_1
					end
				end

				arg_98_1.text_.text = var_101_4
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702024", "story_v_side_new_1104702.awb") ~= 0 then
					local var_101_7 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702024", "story_v_side_new_1104702.awb") / 1000

					if var_101_7 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_7 + var_101_1
					end

					if var_101_3.prefab_name ~= "" and arg_98_1.actors_[var_101_3.prefab_name] ~= nil then
						local var_101_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_3.prefab_name].transform, "story_v_side_new_1104702", "1104702024", "story_v_side_new_1104702.awb")

						arg_98_1:RecordAudio("1104702024", var_101_8)
						arg_98_1:RecordAudio("1104702024", var_101_8)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702024", "story_v_side_new_1104702.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702024", "story_v_side_new_1104702.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_9 = math.max(var_101_2, arg_98_1.talkMaxDuration)

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_9 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_1) / var_101_9

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_1 + var_101_9 and arg_98_1.time_ < var_101_1 + var_101_9 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play1104702025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 1104702025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play1104702026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1047ui_story"]) and arg_102_1.var_.characterEffect1047ui_story == nil then
				arg_102_1.var_.characterEffect1047ui_story = arg_102_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1047ui_story"]) then
				if arg_102_1.var_.characterEffect1047ui_story and not isNil(arg_102_1.actors_["1047ui_story"]) then
					arg_102_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_0)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1047ui_story"]) and arg_102_1.var_.characterEffect1047ui_story then
				arg_102_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_105_1 = 0
			local var_105_2 = 1.075

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_3 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(1104702025).content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 43 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 43)

				if (43 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 43)) > 0 and var_105_2 < var_105_5 then
					arg_102_1.talkMaxDuration = var_105_5

					if var_105_5 + var_105_1 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + var_105_1
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_6 = math.max(var_105_2, arg_102_1.talkMaxDuration)

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_6 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_1) / var_105_6

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_1 + var_105_6 and arg_102_1.time_ < var_105_1 + var_105_6 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play1104702026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 1104702026
		arg_106_1.duration_ = 5.53

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play1104702027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1047ui_story"]) and arg_106_1.var_.characterEffect1047ui_story == nil then
				arg_106_1.var_.characterEffect1047ui_story = arg_106_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1047ui_story"]) then
				if arg_106_1.var_.characterEffect1047ui_story and not isNil(arg_106_1.actors_["1047ui_story"]) then
					arg_106_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1047ui_story"]) and arg_106_1.var_.characterEffect1047ui_story then
				arg_106_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_1")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_109_2 = 0
			local var_109_3 = 0.675

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_2 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_4 = arg_106_1:GetWordFromCfg(1104702026)
				local var_109_5 = arg_106_1:FormatText(var_109_4.content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_7 = 27 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 27)

				if (27 <= 0 and var_109_3 or var_109_3 * (utf8.len(var_109_5) / 27)) > 0 and var_109_3 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_2
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702026", "story_v_side_new_1104702.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702026", "story_v_side_new_1104702.awb") / 1000

					if var_109_8 + var_109_2 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_2
					end

					if var_109_4.prefab_name ~= "" and arg_106_1.actors_[var_109_4.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_4.prefab_name].transform, "story_v_side_new_1104702", "1104702026", "story_v_side_new_1104702.awb")

						arg_106_1:RecordAudio("1104702026", var_109_9)
						arg_106_1:RecordAudio("1104702026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702026", "story_v_side_new_1104702.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702026", "story_v_side_new_1104702.awb")
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
	Play1104702027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 1104702027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play1104702028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1047ui_story"]) and arg_110_1.var_.characterEffect1047ui_story == nil then
				arg_110_1.var_.characterEffect1047ui_story = arg_110_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1047ui_story"]) then
				if arg_110_1.var_.characterEffect1047ui_story and not isNil(arg_110_1.actors_["1047ui_story"]) then
					arg_110_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_0)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1047ui_story"]) and arg_110_1.var_.characterEffect1047ui_story then
				arg_110_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_113_1 = 0
			local var_113_2 = 0.875

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

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(1104702027).content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 35 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 35)

				if (35 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 35)) > 0 and var_113_2 < var_113_5 then
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
	Play1104702028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 1104702028
		arg_114_1.duration_ = 10.17

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play1104702029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1047ui_story"]) and arg_114_1.var_.characterEffect1047ui_story == nil then
				arg_114_1.var_.characterEffect1047ui_story = arg_114_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1047ui_story"]) then
				if arg_114_1.var_.characterEffect1047ui_story and not isNil(arg_114_1.actors_["1047ui_story"]) then
					arg_114_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1047ui_story"]) and arg_114_1.var_.characterEffect1047ui_story then
				arg_114_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_2")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_117_2 = 0
			local var_117_3 = 1.075

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_2 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_4 = arg_114_1:GetWordFromCfg(1104702028)
				local var_117_5 = arg_114_1:FormatText(var_117_4.content)

				arg_114_1.text_.text = var_117_5

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_7 = 43 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 43)

				if (43 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 43)) > 0 and var_117_3 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_2
					end
				end

				arg_114_1.text_.text = var_117_5
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702028", "story_v_side_new_1104702.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702028", "story_v_side_new_1104702.awb") / 1000

					if var_117_8 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_2
					end

					if var_117_4.prefab_name ~= "" and arg_114_1.actors_[var_117_4.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_4.prefab_name].transform, "story_v_side_new_1104702", "1104702028", "story_v_side_new_1104702.awb")

						arg_114_1:RecordAudio("1104702028", var_117_9)
						arg_114_1:RecordAudio("1104702028", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702028", "story_v_side_new_1104702.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702028", "story_v_side_new_1104702.awb")
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
	Play1104702029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1104702029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1104702030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1047ui_story"]) and arg_118_1.var_.characterEffect1047ui_story == nil then
				arg_118_1.var_.characterEffect1047ui_story = arg_118_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1047ui_story"]) then
				if arg_118_1.var_.characterEffect1047ui_story and not isNil(arg_118_1.actors_["1047ui_story"]) then
					arg_118_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_0)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1047ui_story"]) and arg_118_1.var_.characterEffect1047ui_story then
				arg_118_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_121_1 = 0
			local var_121_2 = 0.2

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(1104702029).content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 8 <= 0 and var_121_2 or var_121_2 * (utf8.len(var_121_3) / 8)

				if (8 <= 0 and var_121_2 or var_121_2 * (utf8.len(var_121_3) / 8)) > 0 and var_121_2 < var_121_5 then
					arg_118_1.talkMaxDuration = var_121_5

					if var_121_5 + var_121_1 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + var_121_1
					end
				end

				arg_118_1.text_.text = var_121_3
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_6 = math.max(var_121_2, arg_118_1.talkMaxDuration)

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_6 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_1) / var_121_6

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_1 + var_121_6 and arg_118_1.time_ < var_121_1 + var_121_6 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play1104702030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1104702030
		arg_122_1.duration_ = 2.57

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play1104702031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1047ui_story"]) and arg_122_1.var_.characterEffect1047ui_story == nil then
				arg_122_1.var_.characterEffect1047ui_story = arg_122_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1047ui_story"]) then
				if arg_122_1.var_.characterEffect1047ui_story and not isNil(arg_122_1.actors_["1047ui_story"]) then
					arg_122_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1047ui_story"]) and arg_122_1.var_.characterEffect1047ui_story then
				arg_122_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_1")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_125_2 = 0
			local var_125_3 = 0.125

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_2 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_4 = arg_122_1:GetWordFromCfg(1104702030)
				local var_125_5 = arg_122_1:FormatText(var_125_4.content)

				arg_122_1.text_.text = var_125_5

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_7 = 5 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_5) / 5)

				if (5 <= 0 and var_125_3 or var_125_3 * (utf8.len(var_125_5) / 5)) > 0 and var_125_3 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_2
					end
				end

				arg_122_1.text_.text = var_125_5
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702030", "story_v_side_new_1104702.awb") ~= 0 then
					local var_125_8 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702030", "story_v_side_new_1104702.awb") / 1000

					if var_125_8 + var_125_2 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_2
					end

					if var_125_4.prefab_name ~= "" and arg_122_1.actors_[var_125_4.prefab_name] ~= nil then
						local var_125_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_4.prefab_name].transform, "story_v_side_new_1104702", "1104702030", "story_v_side_new_1104702.awb")

						arg_122_1:RecordAudio("1104702030", var_125_9)
						arg_122_1:RecordAudio("1104702030", var_125_9)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702030", "story_v_side_new_1104702.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702030", "story_v_side_new_1104702.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_10 = math.max(var_125_3, arg_122_1.talkMaxDuration)

			if var_125_2 <= arg_122_1.time_ and arg_122_1.time_ < var_125_2 + var_125_10 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_2) / var_125_10

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_2 + var_125_10 and arg_122_1.time_ < var_125_2 + var_125_10 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play1104702031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1104702031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1104702032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1047ui_story"]) and arg_126_1.var_.characterEffect1047ui_story == nil then
				arg_126_1.var_.characterEffect1047ui_story = arg_126_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1047ui_story"]) then
				if arg_126_1.var_.characterEffect1047ui_story and not isNil(arg_126_1.actors_["1047ui_story"]) then
					arg_126_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_0)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1047ui_story"]) and arg_126_1.var_.characterEffect1047ui_story then
				arg_126_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_129_1 = arg_126_1.actors_["1047ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1047ui_story = var_129_1.localPosition
			end

			local var_129_2 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_2 then
				var_129_1.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_2)
				var_129_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_1.position).x, (manager.ui.mainCamera.transform.position - var_129_1.position).y, (manager.ui.mainCamera.transform.position - var_129_1.position).z)
				var_129_1.localEulerAngles.z = 0
				var_129_1.localEulerAngles.x = 0
				var_129_1.localEulerAngles = var_129_1.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_2 and arg_126_1.time_ < 0 + var_129_2 + arg_129_0 then
				var_129_1.localPosition = Vector3.New(0, 100, 0)
				var_129_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_1.position).x, (manager.ui.mainCamera.transform.position - var_129_1.position).y, (manager.ui.mainCamera.transform.position - var_129_1.position).z)
				var_129_1.localEulerAngles.z = 0
				var_129_1.localEulerAngles.x = 0
				var_129_1.localEulerAngles = var_129_1.localEulerAngles
			end

			local var_129_3 = 0
			local var_129_4 = 0.65

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_3 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_5 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(1104702031).content)

				arg_126_1.text_.text = var_129_5

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_7 = 26 <= 0 and var_129_4 or var_129_4 * (utf8.len(var_129_5) / 26)

				if (26 <= 0 and var_129_4 or var_129_4 * (utf8.len(var_129_5) / 26)) > 0 and var_129_4 < var_129_7 then
					arg_126_1.talkMaxDuration = var_129_7

					if var_129_7 + var_129_3 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_3
					end
				end

				arg_126_1.text_.text = var_129_5
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_8 = math.max(var_129_4, arg_126_1.talkMaxDuration)

			if var_129_3 <= arg_126_1.time_ and arg_126_1.time_ < var_129_3 + var_129_8 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_3) / var_129_8

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_3 + var_129_8 and arg_126_1.time_ < var_129_3 + var_129_8 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play1104702032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 1104702032
		arg_130_1.duration_ = 3.13

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play1104702033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1047ui_story = arg_130_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_133_0 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 then
				arg_130_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_130_1.time_ - 0) / var_133_0)
				arg_130_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1047ui_story"].transform.position).z)
				arg_130_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1047ui_story"].transform.localEulerAngles = arg_130_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 then
				arg_130_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_130_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1047ui_story"].transform.position).z)
				arg_130_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1047ui_story"].transform.localEulerAngles = arg_130_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_133_1 = arg_130_1.actors_["1047ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect1047ui_story == nil then
				arg_130_1.var_.characterEffect1047ui_story = var_133_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_2 and not isNil(var_133_1) then
				if arg_130_1.var_.characterEffect1047ui_story and not isNil(var_133_1) then
					arg_130_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_2 and arg_130_1.time_ < 0 + var_133_2 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect1047ui_story then
				arg_130_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_133_4 = 0
			local var_133_5 = 0.3

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_6 = arg_130_1:GetWordFromCfg(1104702032)
				local var_133_7 = arg_130_1:FormatText(var_133_6.content)

				arg_130_1.text_.text = var_133_7

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_9 = 12 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 12)

				if (12 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 12)) > 0 and var_133_5 < var_133_9 then
					arg_130_1.talkMaxDuration = var_133_9

					if var_133_9 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_4
					end
				end

				arg_130_1.text_.text = var_133_7
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702032", "story_v_side_new_1104702.awb") ~= 0 then
					local var_133_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702032", "story_v_side_new_1104702.awb") / 1000

					if var_133_10 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_4
					end

					if var_133_6.prefab_name ~= "" and arg_130_1.actors_[var_133_6.prefab_name] ~= nil then
						local var_133_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_6.prefab_name].transform, "story_v_side_new_1104702", "1104702032", "story_v_side_new_1104702.awb")

						arg_130_1:RecordAudio("1104702032", var_133_11)
						arg_130_1:RecordAudio("1104702032", var_133_11)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702032", "story_v_side_new_1104702.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702032", "story_v_side_new_1104702.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_12 = math.max(var_133_5, arg_130_1.talkMaxDuration)

			if var_133_4 <= arg_130_1.time_ and arg_130_1.time_ < var_133_4 + var_133_12 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_4) / var_133_12

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_4 + var_133_12 and arg_130_1.time_ < var_133_4 + var_133_12 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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

		arg_130_1:InitPlayNodeList()
	end,
	Play1104702033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 1104702033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play1104702034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1047ui_story"]) and arg_134_1.var_.characterEffect1047ui_story == nil then
				arg_134_1.var_.characterEffect1047ui_story = arg_134_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1047ui_story"]) then
				if arg_134_1.var_.characterEffect1047ui_story and not isNil(arg_134_1.actors_["1047ui_story"]) then
					arg_134_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_0)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1047ui_story"]) and arg_134_1.var_.characterEffect1047ui_story then
				arg_134_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_137_1 = 0
			local var_137_2 = 0.725

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

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_3 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(1104702033).content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 29 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 29)

				if (29 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 29)) > 0 and var_137_2 < var_137_5 then
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
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play1104702034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1104702034
		arg_138_1.duration_ = 9.57

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play1104702035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["1047ui_story"]) and arg_138_1.var_.characterEffect1047ui_story == nil then
				arg_138_1.var_.characterEffect1047ui_story = arg_138_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["1047ui_story"]) then
				if arg_138_1.var_.characterEffect1047ui_story and not isNil(arg_138_1.actors_["1047ui_story"]) then
					arg_138_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["1047ui_story"]) and arg_138_1.var_.characterEffect1047ui_story then
				arg_138_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_141_2 = 0
			local var_141_3 = 0.75

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_2 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_4 = arg_138_1:GetWordFromCfg(1104702034)
				local var_141_5 = arg_138_1:FormatText(var_141_4.content)

				arg_138_1.text_.text = var_141_5

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_7 = 30 <= 0 and var_141_3 or var_141_3 * (utf8.len(var_141_5) / 30)

				if (30 <= 0 and var_141_3 or var_141_3 * (utf8.len(var_141_5) / 30)) > 0 and var_141_3 < var_141_7 then
					arg_138_1.talkMaxDuration = var_141_7

					if var_141_7 + var_141_2 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_7 + var_141_2
					end
				end

				arg_138_1.text_.text = var_141_5
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702034", "story_v_side_new_1104702.awb") ~= 0 then
					local var_141_8 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702034", "story_v_side_new_1104702.awb") / 1000

					if var_141_8 + var_141_2 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_2
					end

					if var_141_4.prefab_name ~= "" and arg_138_1.actors_[var_141_4.prefab_name] ~= nil then
						local var_141_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_4.prefab_name].transform, "story_v_side_new_1104702", "1104702034", "story_v_side_new_1104702.awb")

						arg_138_1:RecordAudio("1104702034", var_141_9)
						arg_138_1:RecordAudio("1104702034", var_141_9)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702034", "story_v_side_new_1104702.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702034", "story_v_side_new_1104702.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_10 = math.max(var_141_3, arg_138_1.talkMaxDuration)

			if var_141_2 <= arg_138_1.time_ and arg_138_1.time_ < var_141_2 + var_141_10 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_2) / var_141_10

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_2 + var_141_10 and arg_138_1.time_ < var_141_2 + var_141_10 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play1104702035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1104702035
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play1104702036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1047ui_story"]) and arg_142_1.var_.characterEffect1047ui_story == nil then
				arg_142_1.var_.characterEffect1047ui_story = arg_142_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1047ui_story"]) then
				if arg_142_1.var_.characterEffect1047ui_story and not isNil(arg_142_1.actors_["1047ui_story"]) then
					arg_142_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_0)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1047ui_story"]) and arg_142_1.var_.characterEffect1047ui_story then
				arg_142_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_145_1 = arg_142_1.actors_["1047ui_story"].transform

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos1047ui_story = var_145_1.localPosition
			end

			local var_145_2 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_2 then
				var_145_1.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_142_1.time_ - 0) / var_145_2)
				var_145_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_1.position).x, (manager.ui.mainCamera.transform.position - var_145_1.position).y, (manager.ui.mainCamera.transform.position - var_145_1.position).z)
				var_145_1.localEulerAngles.z = 0
				var_145_1.localEulerAngles.x = 0
				var_145_1.localEulerAngles = var_145_1.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_2 and arg_142_1.time_ < 0 + var_145_2 + arg_145_0 then
				var_145_1.localPosition = Vector3.New(0, 100, 0)
				var_145_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_145_1.position).x, (manager.ui.mainCamera.transform.position - var_145_1.position).y, (manager.ui.mainCamera.transform.position - var_145_1.position).z)
				var_145_1.localEulerAngles.z = 0
				var_145_1.localEulerAngles.x = 0
				var_145_1.localEulerAngles = var_145_1.localEulerAngles
			end

			if 0.1 < arg_142_1.time_ and arg_142_1.time_ <= 0.1 + arg_145_0 then
				arg_142_1:AudioAction("play", "effect", "se_story_148", "se_story_148_soda_can_open", "")
			end

			local var_145_4 = 0
			local var_145_5 = 1.475

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_4 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_6 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(1104702035).content)

				arg_142_1.text_.text = var_145_6

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_8 = 59 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_6) / 59)

				if (59 <= 0 and var_145_5 or var_145_5 * (utf8.len(var_145_6) / 59)) > 0 and var_145_5 < var_145_8 then
					arg_142_1.talkMaxDuration = var_145_8

					if var_145_8 + var_145_4 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_4
					end
				end

				arg_142_1.text_.text = var_145_6
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_9 = math.max(var_145_5, arg_142_1.talkMaxDuration)

			if var_145_4 <= arg_142_1.time_ and arg_142_1.time_ < var_145_4 + var_145_9 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_4) / var_145_9

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_4 + var_145_9 and arg_142_1.time_ < var_145_4 + var_145_9 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
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

		arg_142_1:InitPlayNodeList()
	end,
	Play1104702036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1104702036
		arg_146_1.duration_ = 5.6

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play1104702037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1047ui_story = arg_146_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_149_0 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 then
				arg_146_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_146_1.time_ - 0) / var_149_0)
				arg_146_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1047ui_story"].transform.position).z)
				arg_146_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1047ui_story"].transform.localEulerAngles = arg_146_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 then
				arg_146_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_146_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1047ui_story"].transform.position).z)
				arg_146_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1047ui_story"].transform.localEulerAngles = arg_146_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_149_1 = arg_146_1.actors_["1047ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect1047ui_story == nil then
				arg_146_1.var_.characterEffect1047ui_story = var_149_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_2 and not isNil(var_149_1) then
				if arg_146_1.var_.characterEffect1047ui_story and not isNil(var_149_1) then
					arg_146_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_2 and arg_146_1.time_ < 0 + var_149_2 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect1047ui_story then
				arg_146_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_149_4 = 0
			local var_149_5 = 0.5

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_6 = arg_146_1:GetWordFromCfg(1104702036)
				local var_149_7 = arg_146_1:FormatText(var_149_6.content)

				arg_146_1.text_.text = var_149_7

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_9 = 20 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 20)

				if (20 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 20)) > 0 and var_149_5 < var_149_9 then
					arg_146_1.talkMaxDuration = var_149_9

					if var_149_9 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_9 + var_149_4
					end
				end

				arg_146_1.text_.text = var_149_7
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702036", "story_v_side_new_1104702.awb") ~= 0 then
					local var_149_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702036", "story_v_side_new_1104702.awb") / 1000

					if var_149_10 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_4
					end

					if var_149_6.prefab_name ~= "" and arg_146_1.actors_[var_149_6.prefab_name] ~= nil then
						local var_149_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_6.prefab_name].transform, "story_v_side_new_1104702", "1104702036", "story_v_side_new_1104702.awb")

						arg_146_1:RecordAudio("1104702036", var_149_11)
						arg_146_1:RecordAudio("1104702036", var_149_11)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702036", "story_v_side_new_1104702.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702036", "story_v_side_new_1104702.awb")
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

		arg_146_1.nodeConfigList_ = {
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

		arg_146_1:InitPlayNodeList()
	end,
	Play1104702037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1104702037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play1104702038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["1047ui_story"]) and arg_150_1.var_.characterEffect1047ui_story == nil then
				arg_150_1.var_.characterEffect1047ui_story = arg_150_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_0 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["1047ui_story"]) then
				if arg_150_1.var_.characterEffect1047ui_story and not isNil(arg_150_1.actors_["1047ui_story"]) then
					arg_150_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_0)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["1047ui_story"]) and arg_150_1.var_.characterEffect1047ui_story then
				arg_150_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_153_1 = 0
			local var_153_2 = 0.3

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_3 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(1104702037).content)

				arg_150_1.text_.text = var_153_3

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_5 = 12 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 12)

				if (12 <= 0 and var_153_2 or var_153_2 * (utf8.len(var_153_3) / 12)) > 0 and var_153_2 < var_153_5 then
					arg_150_1.talkMaxDuration = var_153_5

					if var_153_5 + var_153_1 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + var_153_1
					end
				end

				arg_150_1.text_.text = var_153_3
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_6 = math.max(var_153_2, arg_150_1.talkMaxDuration)

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_6 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_1) / var_153_6

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_1 + var_153_6 and arg_150_1.time_ < var_153_1 + var_153_6 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play1104702038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1104702038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play1104702039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1047ui_story = arg_154_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_157_0 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 then
				arg_154_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_154_1.time_ - 0) / var_157_0)
				arg_154_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1047ui_story"].transform.position).z)
				arg_154_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1047ui_story"].transform.localEulerAngles = arg_154_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 then
				arg_154_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1047ui_story"].transform.position).z)
				arg_154_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1047ui_story"].transform.localEulerAngles = arg_154_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_157_1 = 0
			local var_157_2 = 1.1

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_3 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(1104702038).content)

				arg_154_1.text_.text = var_157_3

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 44 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 44)

				if (44 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 44)) > 0 and var_157_2 < var_157_5 then
					arg_154_1.talkMaxDuration = var_157_5

					if var_157_5 + var_157_1 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + var_157_1
					end
				end

				arg_154_1.text_.text = var_157_3
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_6 = math.max(var_157_2, arg_154_1.talkMaxDuration)

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_6 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_1) / var_157_6

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_1 + var_157_6 and arg_154_1.time_ < var_157_1 + var_157_6 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
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

		arg_154_1:InitPlayNodeList()
	end,
	Play1104702039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1104702039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play1104702040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0.5 < arg_158_1.time_ and arg_158_1.time_ <= 0.5 + arg_161_0 then
				arg_158_1:AudioAction("play", "effect", "se_story_151", "se_story_151_soda_can_cheer", "")
			end

			local var_161_1 = 0
			local var_161_2 = 0.7

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_1 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_3 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(1104702039).content)

				arg_158_1.text_.text = var_161_3

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_5 = 28 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 28)

				if (28 <= 0 and var_161_2 or var_161_2 * (utf8.len(var_161_3) / 28)) > 0 and var_161_2 < var_161_5 then
					arg_158_1.talkMaxDuration = var_161_5

					if var_161_5 + var_161_1 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + var_161_1
					end
				end

				arg_158_1.text_.text = var_161_3
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_6 = math.max(var_161_2, arg_158_1.talkMaxDuration)

			if var_161_1 <= arg_158_1.time_ and arg_158_1.time_ < var_161_1 + var_161_6 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_1) / var_161_6

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_1 + var_161_6 and arg_158_1.time_ < var_161_1 + var_161_6 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play1104702040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1104702040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1104702041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0.825

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(1104702040).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 33 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 33)

				if (33 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 33)) > 0 and var_165_0 < var_165_3 then
					arg_162_1.talkMaxDuration = var_165_3

					if var_165_3 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_3 + 0
					end
				end

				arg_162_1.text_.text = var_165_1
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_4 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_4

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play1104702041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1104702041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play1104702042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1047ui_story = arg_166_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_169_0 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 then
				arg_166_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_166_1.time_ - 0) / var_169_0)
				arg_166_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1047ui_story"].transform.position).z)
				arg_166_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1047ui_story"].transform.localEulerAngles = arg_166_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 then
				arg_166_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_166_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1047ui_story"].transform.position).z)
				arg_166_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1047ui_story"].transform.localEulerAngles = arg_166_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_169_1 = arg_166_1.actors_["1047ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_1) and arg_166_1.var_.characterEffect1047ui_story == nil then
				arg_166_1.var_.characterEffect1047ui_story = var_169_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_2 and not isNil(var_169_1) then
				if arg_166_1.var_.characterEffect1047ui_story and not isNil(var_169_1) then
					arg_166_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_2 and arg_166_1.time_ < 0 + var_169_2 + arg_169_0 and not isNil(var_169_1) and arg_166_1.var_.characterEffect1047ui_story then
				arg_166_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_169_4 = 0
			local var_169_5 = 0.5

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_6 = arg_166_1:GetWordFromCfg(1104702041)
				local var_169_7 = arg_166_1:FormatText(var_169_6.content)

				arg_166_1.text_.text = var_169_7

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_9 = 20 <= 0 and var_169_5 or var_169_5 * (utf8.len(var_169_7) / 20)

				if (20 <= 0 and var_169_5 or var_169_5 * (utf8.len(var_169_7) / 20)) > 0 and var_169_5 < var_169_9 then
					arg_166_1.talkMaxDuration = var_169_9

					if var_169_9 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_9 + var_169_4
					end
				end

				arg_166_1.text_.text = var_169_7
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702041", "story_v_side_new_1104702.awb") ~= 0 then
					local var_169_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702041", "story_v_side_new_1104702.awb") / 1000

					if var_169_10 + var_169_4 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_10 + var_169_4
					end

					if var_169_6.prefab_name ~= "" and arg_166_1.actors_[var_169_6.prefab_name] ~= nil then
						local var_169_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_6.prefab_name].transform, "story_v_side_new_1104702", "1104702041", "story_v_side_new_1104702.awb")

						arg_166_1:RecordAudio("1104702041", var_169_11)
						arg_166_1:RecordAudio("1104702041", var_169_11)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702041", "story_v_side_new_1104702.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702041", "story_v_side_new_1104702.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_12 = math.max(var_169_5, arg_166_1.talkMaxDuration)

			if var_169_4 <= arg_166_1.time_ and arg_166_1.time_ < var_169_4 + var_169_12 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_4) / var_169_12

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_4 + var_169_12 and arg_166_1.time_ < var_169_4 + var_169_12 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
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

		arg_166_1:InitPlayNodeList()
	end,
	Play1104702042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 1104702042
		arg_170_1.duration_ = 13.17

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play1104702043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_173_0 = 0
			local var_173_1 = 1.275

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_2 = arg_170_1:GetWordFromCfg(1104702042)
				local var_173_3 = arg_170_1:FormatText(var_173_2.content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 51 <= 0 and var_173_1 or var_173_1 * (utf8.len(var_173_3) / 51)

				if (51 <= 0 and var_173_1 or var_173_1 * (utf8.len(var_173_3) / 51)) > 0 and var_173_1 < var_173_5 then
					arg_170_1.talkMaxDuration = var_173_5

					if var_173_5 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702042", "story_v_side_new_1104702.awb") ~= 0 then
					local var_173_6 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702042", "story_v_side_new_1104702.awb") / 1000

					if var_173_6 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_6 + var_173_0
					end

					if var_173_2.prefab_name ~= "" and arg_170_1.actors_[var_173_2.prefab_name] ~= nil then
						local var_173_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_2.prefab_name].transform, "story_v_side_new_1104702", "1104702042", "story_v_side_new_1104702.awb")

						arg_170_1:RecordAudio("1104702042", var_173_7)
						arg_170_1:RecordAudio("1104702042", var_173_7)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702042", "story_v_side_new_1104702.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702042", "story_v_side_new_1104702.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_8 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_8 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_8

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_8 and arg_170_1.time_ < var_173_0 + var_173_8 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play1104702043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 1104702043
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play1104702044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["1047ui_story"]) and arg_174_1.var_.characterEffect1047ui_story == nil then
				arg_174_1.var_.characterEffect1047ui_story = arg_174_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["1047ui_story"]) then
				if arg_174_1.var_.characterEffect1047ui_story and not isNil(arg_174_1.actors_["1047ui_story"]) then
					arg_174_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_0)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["1047ui_story"]) and arg_174_1.var_.characterEffect1047ui_story then
				arg_174_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_177_1 = arg_174_1.actors_["1047ui_story"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1047ui_story = var_177_1.localPosition
			end

			local var_177_2 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_2 then
				var_177_1.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_174_1.time_ - 0) / var_177_2)
				var_177_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_1.position).x, (manager.ui.mainCamera.transform.position - var_177_1.position).y, (manager.ui.mainCamera.transform.position - var_177_1.position).z)
				var_177_1.localEulerAngles.z = 0
				var_177_1.localEulerAngles.x = 0
				var_177_1.localEulerAngles = var_177_1.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_2 and arg_174_1.time_ < 0 + var_177_2 + arg_177_0 then
				var_177_1.localPosition = Vector3.New(0, 100, 0)
				var_177_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_1.position).x, (manager.ui.mainCamera.transform.position - var_177_1.position).y, (manager.ui.mainCamera.transform.position - var_177_1.position).z)
				var_177_1.localEulerAngles.z = 0
				var_177_1.localEulerAngles.x = 0
				var_177_1.localEulerAngles = var_177_1.localEulerAngles
			end

			local var_177_3 = 0
			local var_177_4 = 0.65

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_3 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_5 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(1104702043).content)

				arg_174_1.text_.text = var_177_5

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_7 = 26 <= 0 and var_177_4 or var_177_4 * (utf8.len(var_177_5) / 26)

				if (26 <= 0 and var_177_4 or var_177_4 * (utf8.len(var_177_5) / 26)) > 0 and var_177_4 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_3 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_3
					end
				end

				arg_174_1.text_.text = var_177_5
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_8 = math.max(var_177_4, arg_174_1.talkMaxDuration)

			if var_177_3 <= arg_174_1.time_ and arg_174_1.time_ < var_177_3 + var_177_8 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_3) / var_177_8

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_3 + var_177_8 and arg_174_1.time_ < var_177_3 + var_177_8 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
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

		arg_174_1:InitPlayNodeList()
	end,
	Play1104702044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 1104702044
		arg_178_1.duration_ = 4.7

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play1104702045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1047ui_story = arg_178_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_181_0 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 then
				arg_178_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_178_1.time_ - 0) / var_181_0)
				arg_178_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1047ui_story"].transform.position).z)
				arg_178_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1047ui_story"].transform.localEulerAngles = arg_178_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 then
				arg_178_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_178_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1047ui_story"].transform.position).z)
				arg_178_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1047ui_story"].transform.localEulerAngles = arg_178_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_181_1 = arg_178_1.actors_["1047ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1047ui_story == nil then
				arg_178_1.var_.characterEffect1047ui_story = var_181_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 and not isNil(var_181_1) then
				if arg_178_1.var_.characterEffect1047ui_story and not isNil(var_181_1) then
					arg_178_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1047ui_story then
				arg_178_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_181_4 = 0
			local var_181_5 = 0.55

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_6 = arg_178_1:GetWordFromCfg(1104702044)
				local var_181_7 = arg_178_1:FormatText(var_181_6.content)

				arg_178_1.text_.text = var_181_7

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_9 = 22 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 22)

				if (22 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_7) / 22)) > 0 and var_181_5 < var_181_9 then
					arg_178_1.talkMaxDuration = var_181_9

					if var_181_9 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_9 + var_181_4
					end
				end

				arg_178_1.text_.text = var_181_7
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702044", "story_v_side_new_1104702.awb") ~= 0 then
					local var_181_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702044", "story_v_side_new_1104702.awb") / 1000

					if var_181_10 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_10 + var_181_4
					end

					if var_181_6.prefab_name ~= "" and arg_178_1.actors_[var_181_6.prefab_name] ~= nil then
						local var_181_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_6.prefab_name].transform, "story_v_side_new_1104702", "1104702044", "story_v_side_new_1104702.awb")

						arg_178_1:RecordAudio("1104702044", var_181_11)
						arg_178_1:RecordAudio("1104702044", var_181_11)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702044", "story_v_side_new_1104702.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702044", "story_v_side_new_1104702.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_12 = math.max(var_181_5, arg_178_1.talkMaxDuration)

			if var_181_4 <= arg_178_1.time_ and arg_178_1.time_ < var_181_4 + var_181_12 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_4) / var_181_12

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_4 + var_181_12 and arg_178_1.time_ < var_181_4 + var_181_12 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
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

		arg_178_1:InitPlayNodeList()
	end,
	Play1104702045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1104702045
		arg_182_1.duration_ = 5.07

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1104702046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_185_0 = 0
			local var_185_1 = 0.4

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
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

				local var_185_2 = arg_182_1:GetWordFromCfg(1104702045)
				local var_185_3 = arg_182_1:FormatText(var_185_2.content)

				arg_182_1.text_.text = var_185_3

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 16 <= 0 and var_185_1 or var_185_1 * (utf8.len(var_185_3) / 16)

				if (16 <= 0 and var_185_1 or var_185_1 * (utf8.len(var_185_3) / 16)) > 0 and var_185_1 < var_185_5 then
					arg_182_1.talkMaxDuration = var_185_5

					if var_185_5 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + var_185_0
					end
				end

				arg_182_1.text_.text = var_185_3
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702045", "story_v_side_new_1104702.awb") ~= 0 then
					local var_185_6 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702045", "story_v_side_new_1104702.awb") / 1000

					if var_185_6 + var_185_0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_6 + var_185_0
					end

					if var_185_2.prefab_name ~= "" and arg_182_1.actors_[var_185_2.prefab_name] ~= nil then
						local var_185_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_2.prefab_name].transform, "story_v_side_new_1104702", "1104702045", "story_v_side_new_1104702.awb")

						arg_182_1:RecordAudio("1104702045", var_185_7)
						arg_182_1:RecordAudio("1104702045", var_185_7)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702045", "story_v_side_new_1104702.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702045", "story_v_side_new_1104702.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_8 = math.max(var_185_1, arg_182_1.talkMaxDuration)

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_8 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_0) / var_185_8

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_0 + var_185_8 and arg_182_1.time_ < var_185_0 + var_185_8 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play1104702046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1104702046
		arg_186_1.duration_ = 11.4

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1104702047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action434")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_189_0 = 0
			local var_189_1 = 1.425

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_2 = arg_186_1:GetWordFromCfg(1104702046)
				local var_189_3 = arg_186_1:FormatText(var_189_2.content)

				arg_186_1.text_.text = var_189_3

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 57 <= 0 and var_189_1 or var_189_1 * (utf8.len(var_189_3) / 57)

				if (57 <= 0 and var_189_1 or var_189_1 * (utf8.len(var_189_3) / 57)) > 0 and var_189_1 < var_189_5 then
					arg_186_1.talkMaxDuration = var_189_5

					if var_189_5 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_3
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702046", "story_v_side_new_1104702.awb") ~= 0 then
					local var_189_6 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702046", "story_v_side_new_1104702.awb") / 1000

					if var_189_6 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_6 + var_189_0
					end

					if var_189_2.prefab_name ~= "" and arg_186_1.actors_[var_189_2.prefab_name] ~= nil then
						local var_189_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_2.prefab_name].transform, "story_v_side_new_1104702", "1104702046", "story_v_side_new_1104702.awb")

						arg_186_1:RecordAudio("1104702046", var_189_7)
						arg_186_1:RecordAudio("1104702046", var_189_7)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702046", "story_v_side_new_1104702.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702046", "story_v_side_new_1104702.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_8 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_8 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_8

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_8 and arg_186_1.time_ < var_189_0 + var_189_8 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play1104702047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1104702047
		arg_190_1.duration_ = 8.7

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1104702048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_193_0 = 0
			local var_193_1 = 0.925

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_2 = arg_190_1:GetWordFromCfg(1104702047)
				local var_193_3 = arg_190_1:FormatText(var_193_2.content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 37 <= 0 and var_193_1 or var_193_1 * (utf8.len(var_193_3) / 37)

				if (37 <= 0 and var_193_1 or var_193_1 * (utf8.len(var_193_3) / 37)) > 0 and var_193_1 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_0
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702047", "story_v_side_new_1104702.awb") ~= 0 then
					local var_193_6 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702047", "story_v_side_new_1104702.awb") / 1000

					if var_193_6 + var_193_0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_6 + var_193_0
					end

					if var_193_2.prefab_name ~= "" and arg_190_1.actors_[var_193_2.prefab_name] ~= nil then
						local var_193_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_2.prefab_name].transform, "story_v_side_new_1104702", "1104702047", "story_v_side_new_1104702.awb")

						arg_190_1:RecordAudio("1104702047", var_193_7)
						arg_190_1:RecordAudio("1104702047", var_193_7)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702047", "story_v_side_new_1104702.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702047", "story_v_side_new_1104702.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_8 = math.max(var_193_1, arg_190_1.talkMaxDuration)

			if var_193_0 <= arg_190_1.time_ and arg_190_1.time_ < var_193_0 + var_193_8 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_0) / var_193_8

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_0 + var_193_8 and arg_190_1.time_ < var_193_0 + var_193_8 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play1104702048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1104702048
		arg_194_1.duration_ = 11.17

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1104702049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 1

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
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

				local var_197_1 = arg_194_1:GetWordFromCfg(1104702048)
				local var_197_2 = arg_194_1:FormatText(var_197_1.content)

				arg_194_1.text_.text = var_197_2

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 40 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 40)

				if (40 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 40)) > 0 and var_197_0 < var_197_4 then
					arg_194_1.talkMaxDuration = var_197_4

					if var_197_4 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_4 + 0
					end
				end

				arg_194_1.text_.text = var_197_2
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702048", "story_v_side_new_1104702.awb") ~= 0 then
					local var_197_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702048", "story_v_side_new_1104702.awb") / 1000

					if var_197_5 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + 0
					end

					if var_197_1.prefab_name ~= "" and arg_194_1.actors_[var_197_1.prefab_name] ~= nil then
						local var_197_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_1.prefab_name].transform, "story_v_side_new_1104702", "1104702048", "story_v_side_new_1104702.awb")

						arg_194_1:RecordAudio("1104702048", var_197_6)
						arg_194_1:RecordAudio("1104702048", var_197_6)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702048", "story_v_side_new_1104702.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702048", "story_v_side_new_1104702.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_7 = math.max(var_197_0, arg_194_1.talkMaxDuration)

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_7 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - 0) / var_197_7

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= 0 + var_197_7 and arg_194_1.time_ < 0 + var_197_7 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play1104702049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1104702049
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1104702050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1047ui_story"]) and arg_198_1.var_.characterEffect1047ui_story == nil then
				arg_198_1.var_.characterEffect1047ui_story = arg_198_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1047ui_story"]) then
				if arg_198_1.var_.characterEffect1047ui_story and not isNil(arg_198_1.actors_["1047ui_story"]) then
					arg_198_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_0)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1047ui_story"]) and arg_198_1.var_.characterEffect1047ui_story then
				arg_198_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_201_1 = arg_198_1.actors_["1047ui_story"].transform

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1047ui_story = var_201_1.localPosition
			end

			local var_201_2 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_2 then
				var_201_1.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_198_1.time_ - 0) / var_201_2)
				var_201_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_1.position).x, (manager.ui.mainCamera.transform.position - var_201_1.position).y, (manager.ui.mainCamera.transform.position - var_201_1.position).z)
				var_201_1.localEulerAngles.z = 0
				var_201_1.localEulerAngles.x = 0
				var_201_1.localEulerAngles = var_201_1.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_2 and arg_198_1.time_ < 0 + var_201_2 + arg_201_0 then
				var_201_1.localPosition = Vector3.New(0, 100, 0)
				var_201_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_201_1.position).x, (manager.ui.mainCamera.transform.position - var_201_1.position).y, (manager.ui.mainCamera.transform.position - var_201_1.position).z)
				var_201_1.localEulerAngles.z = 0
				var_201_1.localEulerAngles.x = 0
				var_201_1.localEulerAngles = var_201_1.localEulerAngles
			end

			local var_201_3 = 0
			local var_201_4 = 0.575

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_3 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_5 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(1104702049).content)

				arg_198_1.text_.text = var_201_5

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_7 = 23 <= 0 and var_201_4 or var_201_4 * (utf8.len(var_201_5) / 23)

				if (23 <= 0 and var_201_4 or var_201_4 * (utf8.len(var_201_5) / 23)) > 0 and var_201_4 < var_201_7 then
					arg_198_1.talkMaxDuration = var_201_7

					if var_201_7 + var_201_3 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_3
					end
				end

				arg_198_1.text_.text = var_201_5
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_8 = math.max(var_201_4, arg_198_1.talkMaxDuration)

			if var_201_3 <= arg_198_1.time_ and arg_198_1.time_ < var_201_3 + var_201_8 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_3) / var_201_8

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_3 + var_201_8 and arg_198_1.time_ < var_201_3 + var_201_8 + arg_201_0 then
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
	Play1104702050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1104702050
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1104702051(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.6

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
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

				local var_205_1 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(1104702050).content)

				arg_202_1.text_.text = var_205_1

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_3 = 24 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 24)

				if (24 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 24)) > 0 and var_205_0 < var_205_3 then
					arg_202_1.talkMaxDuration = var_205_3

					if var_205_3 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_3 + 0
					end
				end

				arg_202_1.text_.text = var_205_1
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_4 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_4

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play1104702051 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1104702051
		arg_206_1.duration_ = 7.1

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1104702052(arg_206_1)
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
				arg_206_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_209_4 = 0
			local var_209_5 = 0.45

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

				local var_209_6 = arg_206_1:GetWordFromCfg(1104702051)
				local var_209_7 = arg_206_1:FormatText(var_209_6.content)

				arg_206_1.text_.text = var_209_7

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_9 = 18 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 18)

				if (18 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_7) / 18)) > 0 and var_209_5 < var_209_9 then
					arg_206_1.talkMaxDuration = var_209_9

					if var_209_9 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_9 + var_209_4
					end
				end

				arg_206_1.text_.text = var_209_7
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702051", "story_v_side_new_1104702.awb") ~= 0 then
					local var_209_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702051", "story_v_side_new_1104702.awb") / 1000

					if var_209_10 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_10 + var_209_4
					end

					if var_209_6.prefab_name ~= "" and arg_206_1.actors_[var_209_6.prefab_name] ~= nil then
						local var_209_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_6.prefab_name].transform, "story_v_side_new_1104702", "1104702051", "story_v_side_new_1104702.awb")

						arg_206_1:RecordAudio("1104702051", var_209_11)
						arg_206_1:RecordAudio("1104702051", var_209_11)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702051", "story_v_side_new_1104702.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702051", "story_v_side_new_1104702.awb")
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
	Play1104702052 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1104702052
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1104702053(arg_210_1)
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

			local var_213_1 = 0
			local var_213_2 = 0.075

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_1 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_3 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(1104702052).content)

				arg_210_1.text_.text = var_213_3

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 3 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_3) / 3)

				if (3 <= 0 and var_213_2 or var_213_2 * (utf8.len(var_213_3) / 3)) > 0 and var_213_2 < var_213_5 then
					arg_210_1.talkMaxDuration = var_213_5

					if var_213_5 + var_213_1 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_5 + var_213_1
					end
				end

				arg_210_1.text_.text = var_213_3
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_6 = math.max(var_213_2, arg_210_1.talkMaxDuration)

			if var_213_1 <= arg_210_1.time_ and arg_210_1.time_ < var_213_1 + var_213_6 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_1) / var_213_6

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_1 + var_213_6 and arg_210_1.time_ < var_213_1 + var_213_6 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play1104702053 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1104702053
		arg_214_1.duration_ = 12.13

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1104702054(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1047ui_story"]) and arg_214_1.var_.characterEffect1047ui_story == nil then
				arg_214_1.var_.characterEffect1047ui_story = arg_214_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1047ui_story"]) then
				if arg_214_1.var_.characterEffect1047ui_story and not isNil(arg_214_1.actors_["1047ui_story"]) then
					arg_214_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1047ui_story"]) and arg_214_1.var_.characterEffect1047ui_story then
				arg_214_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_217_2 = 0
			local var_217_3 = 1.25

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_2 + arg_217_0 then
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

				local var_217_4 = arg_214_1:GetWordFromCfg(1104702053)
				local var_217_5 = arg_214_1:FormatText(var_217_4.content)

				arg_214_1.text_.text = var_217_5

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_7 = 50 <= 0 and var_217_3 or var_217_3 * (utf8.len(var_217_5) / 50)

				if (50 <= 0 and var_217_3 or var_217_3 * (utf8.len(var_217_5) / 50)) > 0 and var_217_3 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_2 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_2
					end
				end

				arg_214_1.text_.text = var_217_5
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702053", "story_v_side_new_1104702.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702053", "story_v_side_new_1104702.awb") / 1000

					if var_217_8 + var_217_2 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_2
					end

					if var_217_4.prefab_name ~= "" and arg_214_1.actors_[var_217_4.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_4.prefab_name].transform, "story_v_side_new_1104702", "1104702053", "story_v_side_new_1104702.awb")

						arg_214_1:RecordAudio("1104702053", var_217_9)
						arg_214_1:RecordAudio("1104702053", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702053", "story_v_side_new_1104702.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702053", "story_v_side_new_1104702.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_3, arg_214_1.talkMaxDuration)

			if var_217_2 <= arg_214_1.time_ and arg_214_1.time_ < var_217_2 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_2) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_2 + var_217_10 and arg_214_1.time_ < var_217_2 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1104702054 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1104702054
		arg_218_1.duration_ = 12.7

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1104702055(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 1.4

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
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

				local var_221_1 = arg_218_1:GetWordFromCfg(1104702054)
				local var_221_2 = arg_218_1:FormatText(var_221_1.content)

				arg_218_1.text_.text = var_221_2

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 56 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 56)

				if (56 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 56)) > 0 and var_221_0 < var_221_4 then
					arg_218_1.talkMaxDuration = var_221_4

					if var_221_4 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_4 + 0
					end
				end

				arg_218_1.text_.text = var_221_2
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702054", "story_v_side_new_1104702.awb") ~= 0 then
					local var_221_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702054", "story_v_side_new_1104702.awb") / 1000

					if var_221_5 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + 0
					end

					if var_221_1.prefab_name ~= "" and arg_218_1.actors_[var_221_1.prefab_name] ~= nil then
						local var_221_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_1.prefab_name].transform, "story_v_side_new_1104702", "1104702054", "story_v_side_new_1104702.awb")

						arg_218_1:RecordAudio("1104702054", var_221_6)
						arg_218_1:RecordAudio("1104702054", var_221_6)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702054", "story_v_side_new_1104702.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702054", "story_v_side_new_1104702.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_7 and arg_218_1.time_ < 0 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play1104702055 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1104702055
		arg_222_1.duration_ = 15.2

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1104702056(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_225_0 = 0
			local var_225_1 = 1.325

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_2 = arg_222_1:GetWordFromCfg(1104702055)
				local var_225_3 = arg_222_1:FormatText(var_225_2.content)

				arg_222_1.text_.text = var_225_3

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_5 = 53 <= 0 and var_225_1 or var_225_1 * (utf8.len(var_225_3) / 53)

				if (53 <= 0 and var_225_1 or var_225_1 * (utf8.len(var_225_3) / 53)) > 0 and var_225_1 < var_225_5 then
					arg_222_1.talkMaxDuration = var_225_5

					if var_225_5 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + var_225_0
					end
				end

				arg_222_1.text_.text = var_225_3
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702055", "story_v_side_new_1104702.awb") ~= 0 then
					local var_225_6 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702055", "story_v_side_new_1104702.awb") / 1000

					if var_225_6 + var_225_0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_6 + var_225_0
					end

					if var_225_2.prefab_name ~= "" and arg_222_1.actors_[var_225_2.prefab_name] ~= nil then
						local var_225_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_2.prefab_name].transform, "story_v_side_new_1104702", "1104702055", "story_v_side_new_1104702.awb")

						arg_222_1:RecordAudio("1104702055", var_225_7)
						arg_222_1:RecordAudio("1104702055", var_225_7)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702055", "story_v_side_new_1104702.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702055", "story_v_side_new_1104702.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_8 = math.max(var_225_1, arg_222_1.talkMaxDuration)

			if var_225_0 <= arg_222_1.time_ and arg_222_1.time_ < var_225_0 + var_225_8 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_0) / var_225_8

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_0 + var_225_8 and arg_222_1.time_ < var_225_0 + var_225_8 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1104702056 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 1104702056
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play1104702057(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1047ui_story"]) and arg_226_1.var_.characterEffect1047ui_story == nil then
				arg_226_1.var_.characterEffect1047ui_story = arg_226_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1047ui_story"]) then
				if arg_226_1.var_.characterEffect1047ui_story and not isNil(arg_226_1.actors_["1047ui_story"]) then
					arg_226_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1047ui_story"]) and arg_226_1.var_.characterEffect1047ui_story then
				arg_226_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_229_1 = arg_226_1.actors_["1047ui_story"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1047ui_story = var_229_1.localPosition
			end

			local var_229_2 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_2 then
				var_229_1.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_226_1.time_ - 0) / var_229_2)
				var_229_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_1.position).x, (manager.ui.mainCamera.transform.position - var_229_1.position).y, (manager.ui.mainCamera.transform.position - var_229_1.position).z)
				var_229_1.localEulerAngles.z = 0
				var_229_1.localEulerAngles.x = 0
				var_229_1.localEulerAngles = var_229_1.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_2 and arg_226_1.time_ < 0 + var_229_2 + arg_229_0 then
				var_229_1.localPosition = Vector3.New(0, 100, 0)
				var_229_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_1.position).x, (manager.ui.mainCamera.transform.position - var_229_1.position).y, (manager.ui.mainCamera.transform.position - var_229_1.position).z)
				var_229_1.localEulerAngles.z = 0
				var_229_1.localEulerAngles.x = 0
				var_229_1.localEulerAngles = var_229_1.localEulerAngles
			end

			if 1 < arg_226_1.time_ and arg_226_1.time_ <= 1 + arg_229_0 then
				arg_226_1:AudioAction("play", "effect", "se_story_151", "se_story_151_soda_can_throw", "")
			end

			local var_229_4 = 0
			local var_229_5 = 1.6

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_4 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_6 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(1104702056).content)

				arg_226_1.text_.text = var_229_6

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_8 = 64 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_6) / 64)

				if (64 <= 0 and var_229_5 or var_229_5 * (utf8.len(var_229_6) / 64)) > 0 and var_229_5 < var_229_8 then
					arg_226_1.talkMaxDuration = var_229_8

					if var_229_8 + var_229_4 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_8 + var_229_4
					end
				end

				arg_226_1.text_.text = var_229_6
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_9 = math.max(var_229_5, arg_226_1.talkMaxDuration)

			if var_229_4 <= arg_226_1.time_ and arg_226_1.time_ < var_229_4 + var_229_9 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_4) / var_229_9

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_4 + var_229_9 and arg_226_1.time_ < var_229_4 + var_229_9 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
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

		arg_226_1:InitPlayNodeList()
	end,
	Play1104702057 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 1104702057
		arg_230_1.duration_ = 6.2

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play1104702058(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1047ui_story = arg_230_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_233_0 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				arg_230_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_230_1.time_ - 0) / var_233_0)
				arg_230_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1047ui_story"].transform.position).z)
				arg_230_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1047ui_story"].transform.localEulerAngles = arg_230_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				arg_230_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_230_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1047ui_story"].transform.position).z)
				arg_230_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1047ui_story"].transform.localEulerAngles = arg_230_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_233_1 = arg_230_1.actors_["1047ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect1047ui_story == nil then
				arg_230_1.var_.characterEffect1047ui_story = var_233_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_2 and not isNil(var_233_1) then
				if arg_230_1.var_.characterEffect1047ui_story and not isNil(var_233_1) then
					arg_230_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_2 and arg_230_1.time_ < 0 + var_233_2 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect1047ui_story then
				arg_230_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_233_4 = 0
			local var_233_5 = 0.625

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
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

				local var_233_6 = arg_230_1:GetWordFromCfg(1104702057)
				local var_233_7 = arg_230_1:FormatText(var_233_6.content)

				arg_230_1.text_.text = var_233_7

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_9 = 25 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 25)

				if (25 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 25)) > 0 and var_233_5 < var_233_9 then
					arg_230_1.talkMaxDuration = var_233_9

					if var_233_9 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_9 + var_233_4
					end
				end

				arg_230_1.text_.text = var_233_7
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702057", "story_v_side_new_1104702.awb") ~= 0 then
					local var_233_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702057", "story_v_side_new_1104702.awb") / 1000

					if var_233_10 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_10 + var_233_4
					end

					if var_233_6.prefab_name ~= "" and arg_230_1.actors_[var_233_6.prefab_name] ~= nil then
						local var_233_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_6.prefab_name].transform, "story_v_side_new_1104702", "1104702057", "story_v_side_new_1104702.awb")

						arg_230_1:RecordAudio("1104702057", var_233_11)
						arg_230_1:RecordAudio("1104702057", var_233_11)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702057", "story_v_side_new_1104702.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702057", "story_v_side_new_1104702.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_12 = math.max(var_233_5, arg_230_1.talkMaxDuration)

			if var_233_4 <= arg_230_1.time_ and arg_230_1.time_ < var_233_4 + var_233_12 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_4) / var_233_12

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_4 + var_233_12 and arg_230_1.time_ < var_233_4 + var_233_12 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
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

		arg_230_1:InitPlayNodeList()
	end,
	Play1104702058 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 1104702058
		arg_234_1.duration_ = 7.4

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play1104702059(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_237_0 = 0
			local var_237_1 = 0.825

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_2 = arg_234_1:GetWordFromCfg(1104702058)
				local var_237_3 = arg_234_1:FormatText(var_237_2.content)

				arg_234_1.text_.text = var_237_3

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 33 <= 0 and var_237_1 or var_237_1 * (utf8.len(var_237_3) / 33)

				if (33 <= 0 and var_237_1 or var_237_1 * (utf8.len(var_237_3) / 33)) > 0 and var_237_1 < var_237_5 then
					arg_234_1.talkMaxDuration = var_237_5

					if var_237_5 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + var_237_0
					end
				end

				arg_234_1.text_.text = var_237_3
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702058", "story_v_side_new_1104702.awb") ~= 0 then
					local var_237_6 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702058", "story_v_side_new_1104702.awb") / 1000

					if var_237_6 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_6 + var_237_0
					end

					if var_237_2.prefab_name ~= "" and arg_234_1.actors_[var_237_2.prefab_name] ~= nil then
						local var_237_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_2.prefab_name].transform, "story_v_side_new_1104702", "1104702058", "story_v_side_new_1104702.awb")

						arg_234_1:RecordAudio("1104702058", var_237_7)
						arg_234_1:RecordAudio("1104702058", var_237_7)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702058", "story_v_side_new_1104702.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702058", "story_v_side_new_1104702.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_8 = math.max(var_237_1, arg_234_1.talkMaxDuration)

			if var_237_0 <= arg_234_1.time_ and arg_234_1.time_ < var_237_0 + var_237_8 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_0) / var_237_8

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_0 + var_237_8 and arg_234_1.time_ < var_237_0 + var_237_8 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play1104702059 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 1104702059
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play1104702060(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1047ui_story"]) and arg_238_1.var_.characterEffect1047ui_story == nil then
				arg_238_1.var_.characterEffect1047ui_story = arg_238_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1047ui_story"]) then
				if arg_238_1.var_.characterEffect1047ui_story and not isNil(arg_238_1.actors_["1047ui_story"]) then
					arg_238_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_0)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1047ui_story"]) and arg_238_1.var_.characterEffect1047ui_story then
				arg_238_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_241_1 = arg_238_1.actors_["1047ui_story"].transform

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1047ui_story = var_241_1.localPosition
			end

			local var_241_2 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_2 then
				var_241_1.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 0) / var_241_2)
				var_241_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_1.position).x, (manager.ui.mainCamera.transform.position - var_241_1.position).y, (manager.ui.mainCamera.transform.position - var_241_1.position).z)
				var_241_1.localEulerAngles.z = 0
				var_241_1.localEulerAngles.x = 0
				var_241_1.localEulerAngles = var_241_1.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_2 and arg_238_1.time_ < 0 + var_241_2 + arg_241_0 then
				var_241_1.localPosition = Vector3.New(0, 100, 0)
				var_241_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_1.position).x, (manager.ui.mainCamera.transform.position - var_241_1.position).y, (manager.ui.mainCamera.transform.position - var_241_1.position).z)
				var_241_1.localEulerAngles.z = 0
				var_241_1.localEulerAngles.x = 0
				var_241_1.localEulerAngles = var_241_1.localEulerAngles
			end

			local var_241_3 = 0
			local var_241_4 = 0.6

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_3 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_5 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(1104702059).content)

				arg_238_1.text_.text = var_241_5

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_7 = 24 <= 0 and var_241_4 or var_241_4 * (utf8.len(var_241_5) / 24)

				if (24 <= 0 and var_241_4 or var_241_4 * (utf8.len(var_241_5) / 24)) > 0 and var_241_4 < var_241_7 then
					arg_238_1.talkMaxDuration = var_241_7

					if var_241_7 + var_241_3 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_7 + var_241_3
					end
				end

				arg_238_1.text_.text = var_241_5
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_8 = math.max(var_241_4, arg_238_1.talkMaxDuration)

			if var_241_3 <= arg_238_1.time_ and arg_238_1.time_ < var_241_3 + var_241_8 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_3) / var_241_8

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_3 + var_241_8 and arg_238_1.time_ < var_241_3 + var_241_8 + arg_241_0 then
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
	Play1104702060 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 1104702060
		arg_242_1.duration_ = 8.4

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play1104702061(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1047ui_story = arg_242_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_245_0 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 then
				arg_242_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_242_1.time_ - 0) / var_245_0)
				arg_242_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1047ui_story"].transform.position).z)
				arg_242_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1047ui_story"].transform.localEulerAngles = arg_242_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 then
				arg_242_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_242_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1047ui_story"].transform.position).z)
				arg_242_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1047ui_story"].transform.localEulerAngles = arg_242_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_245_1 = arg_242_1.actors_["1047ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1047ui_story == nil then
				arg_242_1.var_.characterEffect1047ui_story = var_245_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_2 and not isNil(var_245_1) then
				if arg_242_1.var_.characterEffect1047ui_story and not isNil(var_245_1) then
					arg_242_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_2 and arg_242_1.time_ < 0 + var_245_2 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1047ui_story then
				arg_242_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_1")
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_245_4 = 0
			local var_245_5 = 1

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_6 = arg_242_1:GetWordFromCfg(1104702060)
				local var_245_7 = arg_242_1:FormatText(var_245_6.content)

				arg_242_1.text_.text = var_245_7

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_9 = 40 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 40)

				if (40 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_7) / 40)) > 0 and var_245_5 < var_245_9 then
					arg_242_1.talkMaxDuration = var_245_9

					if var_245_9 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_9 + var_245_4
					end
				end

				arg_242_1.text_.text = var_245_7
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702060", "story_v_side_new_1104702.awb") ~= 0 then
					local var_245_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702060", "story_v_side_new_1104702.awb") / 1000

					if var_245_10 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_10 + var_245_4
					end

					if var_245_6.prefab_name ~= "" and arg_242_1.actors_[var_245_6.prefab_name] ~= nil then
						local var_245_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_6.prefab_name].transform, "story_v_side_new_1104702", "1104702060", "story_v_side_new_1104702.awb")

						arg_242_1:RecordAudio("1104702060", var_245_11)
						arg_242_1:RecordAudio("1104702060", var_245_11)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702060", "story_v_side_new_1104702.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702060", "story_v_side_new_1104702.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_12 = math.max(var_245_5, arg_242_1.talkMaxDuration)

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_12 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_4) / var_245_12

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_4 + var_245_12 and arg_242_1.time_ < var_245_4 + var_245_12 + arg_245_0 then
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
	Play1104702061 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 1104702061
		arg_246_1.duration_ = 1

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"

			SetActive(arg_246_1.choicesGo_, true)

			for iter_247_0, iter_247_1 in ipairs(arg_246_1.choices_) do
				SetActive(iter_247_1.go, iter_247_0 <= 2)
			end

			arg_246_1.choices_[1].txt.text = arg_246_1:FormatText(StoryChoiceCfg[1653].name)
			arg_246_1.choices_[2].txt.text = arg_246_1:FormatText(StoryChoiceCfg[1654].name)
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play1104702062(arg_246_1)
			end

			if arg_248_0 == 2 then
				arg_246_0:Play1104702063(arg_246_1)
			end

			arg_246_1:RecordChoiceLog(1104702061, 1653, 1654)
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1047ui_story"]) and arg_246_1.var_.characterEffect1047ui_story == nil then
				arg_246_1.var_.characterEffect1047ui_story = arg_246_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1047ui_story"]) then
				if arg_246_1.var_.characterEffect1047ui_story and not isNil(arg_246_1.actors_["1047ui_story"]) then
					arg_246_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1047ui_story"]) and arg_246_1.var_.characterEffect1047ui_story then
				arg_246_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_249_2 = 0

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_2 + arg_249_0 then
				arg_246_1.allBtn_.enabled = false
			end

			if arg_246_1.time_ >= var_249_2 + 0.733333333333333 and arg_246_1.time_ < var_249_2 + 0.733333333333333 + arg_249_0 then
				arg_246_1.allBtn_.enabled = true
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play1104702062 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 1104702062
		arg_250_1.duration_ = 2

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play1104702064(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1047ui_story = arg_250_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_253_0 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 then
				arg_250_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_250_1.time_ - 0) / var_253_0)
				arg_250_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1047ui_story"].transform.position).z)
				arg_250_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1047ui_story"].transform.localEulerAngles = arg_250_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 then
				arg_250_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_250_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1047ui_story"].transform.position).z)
				arg_250_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1047ui_story"].transform.localEulerAngles = arg_250_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_253_1 = arg_250_1.actors_["1047ui_story"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1047ui_story == nil then
				arg_250_1.var_.characterEffect1047ui_story = var_253_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_2 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_2 and not isNil(var_253_1) then
				if arg_250_1.var_.characterEffect1047ui_story and not isNil(var_253_1) then
					arg_250_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= 0 + var_253_2 and arg_250_1.time_ < 0 + var_253_2 + arg_253_0 and not isNil(var_253_1) and arg_250_1.var_.characterEffect1047ui_story then
				arg_250_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_2")
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_253_4 = 0
			local var_253_5 = 0.175

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_4 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_6 = arg_250_1:GetWordFromCfg(1104702062)
				local var_253_7 = arg_250_1:FormatText(var_253_6.content)

				arg_250_1.text_.text = var_253_7

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_9 = 7 <= 0 and var_253_5 or var_253_5 * (utf8.len(var_253_7) / 7)

				if (7 <= 0 and var_253_5 or var_253_5 * (utf8.len(var_253_7) / 7)) > 0 and var_253_5 < var_253_9 then
					arg_250_1.talkMaxDuration = var_253_9

					if var_253_9 + var_253_4 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_9 + var_253_4
					end
				end

				arg_250_1.text_.text = var_253_7
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702062", "story_v_side_new_1104702.awb") ~= 0 then
					local var_253_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702062", "story_v_side_new_1104702.awb") / 1000

					if var_253_10 + var_253_4 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_10 + var_253_4
					end

					if var_253_6.prefab_name ~= "" and arg_250_1.actors_[var_253_6.prefab_name] ~= nil then
						local var_253_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_6.prefab_name].transform, "story_v_side_new_1104702", "1104702062", "story_v_side_new_1104702.awb")

						arg_250_1:RecordAudio("1104702062", var_253_11)
						arg_250_1:RecordAudio("1104702062", var_253_11)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702062", "story_v_side_new_1104702.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702062", "story_v_side_new_1104702.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_12 = math.max(var_253_5, arg_250_1.talkMaxDuration)

			if var_253_4 <= arg_250_1.time_ and arg_250_1.time_ < var_253_4 + var_253_12 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_4) / var_253_12

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_4 + var_253_12 and arg_250_1.time_ < var_253_4 + var_253_12 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
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

		arg_250_1:InitPlayNodeList()
	end,
	Play1104702064 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 1104702064
		arg_254_1.duration_ = 2.7

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play1104702065(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_257_0 = 0
			local var_257_1 = 0.3

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_0 + arg_257_0 then
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

				local var_257_2 = arg_254_1:GetWordFromCfg(1104702064)
				local var_257_3 = arg_254_1:FormatText(var_257_2.content)

				arg_254_1.text_.text = var_257_3

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_5 = 12 <= 0 and var_257_1 or var_257_1 * (utf8.len(var_257_3) / 12)

				if (12 <= 0 and var_257_1 or var_257_1 * (utf8.len(var_257_3) / 12)) > 0 and var_257_1 < var_257_5 then
					arg_254_1.talkMaxDuration = var_257_5

					if var_257_5 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + var_257_0
					end
				end

				arg_254_1.text_.text = var_257_3
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702064", "story_v_side_new_1104702.awb") ~= 0 then
					local var_257_6 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702064", "story_v_side_new_1104702.awb") / 1000

					if var_257_6 + var_257_0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_6 + var_257_0
					end

					if var_257_2.prefab_name ~= "" and arg_254_1.actors_[var_257_2.prefab_name] ~= nil then
						local var_257_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_2.prefab_name].transform, "story_v_side_new_1104702", "1104702064", "story_v_side_new_1104702.awb")

						arg_254_1:RecordAudio("1104702064", var_257_7)
						arg_254_1:RecordAudio("1104702064", var_257_7)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702064", "story_v_side_new_1104702.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702064", "story_v_side_new_1104702.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_8 = math.max(var_257_1, arg_254_1.talkMaxDuration)

			if var_257_0 <= arg_254_1.time_ and arg_254_1.time_ < var_257_0 + var_257_8 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_0) / var_257_8

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_0 + var_257_8 and arg_254_1.time_ < var_257_0 + var_257_8 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play1104702065 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 1104702065
		arg_258_1.duration_ = 10.03

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play1104702066(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 1.1

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_1 = arg_258_1:GetWordFromCfg(1104702065)
				local var_261_2 = arg_258_1:FormatText(var_261_1.content)

				arg_258_1.text_.text = var_261_2

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_4 = 44 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 44)

				if (44 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_2) / 44)) > 0 and var_261_0 < var_261_4 then
					arg_258_1.talkMaxDuration = var_261_4

					if var_261_4 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_4 + 0
					end
				end

				arg_258_1.text_.text = var_261_2
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702065", "story_v_side_new_1104702.awb") ~= 0 then
					local var_261_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702065", "story_v_side_new_1104702.awb") / 1000

					if var_261_5 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_5 + 0
					end

					if var_261_1.prefab_name ~= "" and arg_258_1.actors_[var_261_1.prefab_name] ~= nil then
						local var_261_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_1.prefab_name].transform, "story_v_side_new_1104702", "1104702065", "story_v_side_new_1104702.awb")

						arg_258_1:RecordAudio("1104702065", var_261_6)
						arg_258_1:RecordAudio("1104702065", var_261_6)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702065", "story_v_side_new_1104702.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702065", "story_v_side_new_1104702.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_7 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_7

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play1104702066 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 1104702066
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play1104702067(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["1047ui_story"]) and arg_262_1.var_.characterEffect1047ui_story == nil then
				arg_262_1.var_.characterEffect1047ui_story = arg_262_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["1047ui_story"]) then
				if arg_262_1.var_.characterEffect1047ui_story and not isNil(arg_262_1.actors_["1047ui_story"]) then
					arg_262_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_0)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["1047ui_story"]) and arg_262_1.var_.characterEffect1047ui_story then
				arg_262_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_265_1 = arg_262_1.actors_["1047ui_story"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1047ui_story = var_265_1.localPosition
			end

			local var_265_2 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_2 then
				var_265_1.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_262_1.time_ - 0) / var_265_2)
				var_265_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_1.position).x, (manager.ui.mainCamera.transform.position - var_265_1.position).y, (manager.ui.mainCamera.transform.position - var_265_1.position).z)
				var_265_1.localEulerAngles.z = 0
				var_265_1.localEulerAngles.x = 0
				var_265_1.localEulerAngles = var_265_1.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_2 and arg_262_1.time_ < 0 + var_265_2 + arg_265_0 then
				var_265_1.localPosition = Vector3.New(0, 100, 0)
				var_265_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_1.position).x, (manager.ui.mainCamera.transform.position - var_265_1.position).y, (manager.ui.mainCamera.transform.position - var_265_1.position).z)
				var_265_1.localEulerAngles.z = 0
				var_265_1.localEulerAngles.x = 0
				var_265_1.localEulerAngles = var_265_1.localEulerAngles
			end

			local var_265_3 = 0
			local var_265_4 = 1.05

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_3 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_5 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(1104702066).content)

				arg_262_1.text_.text = var_265_5

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_7 = 42 <= 0 and var_265_4 or var_265_4 * (utf8.len(var_265_5) / 42)

				if (42 <= 0 and var_265_4 or var_265_4 * (utf8.len(var_265_5) / 42)) > 0 and var_265_4 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_3 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_3
					end
				end

				arg_262_1.text_.text = var_265_5
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_8 = math.max(var_265_4, arg_262_1.talkMaxDuration)

			if var_265_3 <= arg_262_1.time_ and arg_262_1.time_ < var_265_3 + var_265_8 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_3) / var_265_8

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_3 + var_265_8 and arg_262_1.time_ < var_265_3 + var_265_8 + arg_265_0 then
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
	Play1104702067 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 1104702067
		arg_266_1.duration_ = 4.27

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play1104702068(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1047ui_story = arg_266_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_269_0 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 then
				arg_266_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_266_1.time_ - 0) / var_269_0)
				arg_266_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1047ui_story"].transform.position).z)
				arg_266_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1047ui_story"].transform.localEulerAngles = arg_266_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 then
				arg_266_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_266_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1047ui_story"].transform.position).z)
				arg_266_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1047ui_story"].transform.localEulerAngles = arg_266_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_269_1 = arg_266_1.actors_["1047ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1047ui_story == nil then
				arg_266_1.var_.characterEffect1047ui_story = var_269_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_2 and not isNil(var_269_1) then
				if arg_266_1.var_.characterEffect1047ui_story and not isNil(var_269_1) then
					arg_266_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_2 and arg_266_1.time_ < 0 + var_269_2 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1047ui_story then
				arg_266_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_269_4 = 0
			local var_269_5 = 0.425

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_6 = arg_266_1:GetWordFromCfg(1104702067)
				local var_269_7 = arg_266_1:FormatText(var_269_6.content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 17 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 17)

				if (17 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 17)) > 0 and var_269_5 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_4
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702067", "story_v_side_new_1104702.awb") ~= 0 then
					local var_269_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702067", "story_v_side_new_1104702.awb") / 1000

					if var_269_10 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_4
					end

					if var_269_6.prefab_name ~= "" and arg_266_1.actors_[var_269_6.prefab_name] ~= nil then
						local var_269_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_6.prefab_name].transform, "story_v_side_new_1104702", "1104702067", "story_v_side_new_1104702.awb")

						arg_266_1:RecordAudio("1104702067", var_269_11)
						arg_266_1:RecordAudio("1104702067", var_269_11)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702067", "story_v_side_new_1104702.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702067", "story_v_side_new_1104702.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_12 = math.max(var_269_5, arg_266_1.talkMaxDuration)

			if var_269_4 <= arg_266_1.time_ and arg_266_1.time_ < var_269_4 + var_269_12 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_4) / var_269_12

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_4 + var_269_12 and arg_266_1.time_ < var_269_4 + var_269_12 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play1104702068 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 1104702068
		arg_270_1.duration_ = 8.07

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play1104702069(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_273_0 = 0
			local var_273_1 = 0.9

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_2 = arg_270_1:GetWordFromCfg(1104702068)
				local var_273_3 = arg_270_1:FormatText(var_273_2.content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 36 <= 0 and var_273_1 or var_273_1 * (utf8.len(var_273_3) / 36)

				if (36 <= 0 and var_273_1 or var_273_1 * (utf8.len(var_273_3) / 36)) > 0 and var_273_1 < var_273_5 then
					arg_270_1.talkMaxDuration = var_273_5

					if var_273_5 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_3
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702068", "story_v_side_new_1104702.awb") ~= 0 then
					local var_273_6 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702068", "story_v_side_new_1104702.awb") / 1000

					if var_273_6 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_6 + var_273_0
					end

					if var_273_2.prefab_name ~= "" and arg_270_1.actors_[var_273_2.prefab_name] ~= nil then
						local var_273_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_2.prefab_name].transform, "story_v_side_new_1104702", "1104702068", "story_v_side_new_1104702.awb")

						arg_270_1:RecordAudio("1104702068", var_273_7)
						arg_270_1:RecordAudio("1104702068", var_273_7)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702068", "story_v_side_new_1104702.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702068", "story_v_side_new_1104702.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_8 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_8 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_8

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_8 and arg_270_1.time_ < var_273_0 + var_273_8 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play1104702069 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 1104702069
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play1104702070(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1047ui_story"]) and arg_274_1.var_.characterEffect1047ui_story == nil then
				arg_274_1.var_.characterEffect1047ui_story = arg_274_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1047ui_story"]) then
				if arg_274_1.var_.characterEffect1047ui_story and not isNil(arg_274_1.actors_["1047ui_story"]) then
					arg_274_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_0)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1047ui_story"]) and arg_274_1.var_.characterEffect1047ui_story then
				arg_274_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_277_1 = arg_274_1.actors_["1047ui_story"].transform

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1047ui_story = var_277_1.localPosition
			end

			local var_277_2 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_2 then
				var_277_1.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_274_1.time_ - 0) / var_277_2)
				var_277_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_1.position).x, (manager.ui.mainCamera.transform.position - var_277_1.position).y, (manager.ui.mainCamera.transform.position - var_277_1.position).z)
				var_277_1.localEulerAngles.z = 0
				var_277_1.localEulerAngles.x = 0
				var_277_1.localEulerAngles = var_277_1.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_2 and arg_274_1.time_ < 0 + var_277_2 + arg_277_0 then
				var_277_1.localPosition = Vector3.New(0, 100, 0)
				var_277_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_1.position).x, (manager.ui.mainCamera.transform.position - var_277_1.position).y, (manager.ui.mainCamera.transform.position - var_277_1.position).z)
				var_277_1.localEulerAngles.z = 0
				var_277_1.localEulerAngles.x = 0
				var_277_1.localEulerAngles = var_277_1.localEulerAngles
			end

			local var_277_3 = 0
			local var_277_4 = 1.425

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_3 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_5 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(1104702069).content)

				arg_274_1.text_.text = var_277_5

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_7 = 57 <= 0 and var_277_4 or var_277_4 * (utf8.len(var_277_5) / 57)

				if (57 <= 0 and var_277_4 or var_277_4 * (utf8.len(var_277_5) / 57)) > 0 and var_277_4 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_3 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_3
					end
				end

				arg_274_1.text_.text = var_277_5
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_8 = math.max(var_277_4, arg_274_1.talkMaxDuration)

			if var_277_3 <= arg_274_1.time_ and arg_274_1.time_ < var_277_3 + var_277_8 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_3) / var_277_8

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_3 + var_277_8 and arg_274_1.time_ < var_277_3 + var_277_8 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
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

		arg_274_1:InitPlayNodeList()
	end,
	Play1104702070 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 1104702070
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play1104702071(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.8

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_1 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(1104702070).content)

				arg_278_1.text_.text = var_281_1

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_3 = 32 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 32)

				if (32 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_1) / 32)) > 0 and var_281_0 < var_281_3 then
					arg_278_1.talkMaxDuration = var_281_3

					if var_281_3 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_3 + 0
					end
				end

				arg_278_1.text_.text = var_281_1
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_4 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_4

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play1104702071 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1104702071
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1104702072(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0.45

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
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

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_1 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(1104702071).content)

				arg_282_1.text_.text = var_285_1

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_3 = 18 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 18)

				if (18 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 18)) > 0 and var_285_0 < var_285_3 then
					arg_282_1.talkMaxDuration = var_285_3

					if var_285_3 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_3 + 0
					end
				end

				arg_282_1.text_.text = var_285_1
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_4 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_4

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play1104702072 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1104702072
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1104702073(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.15

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_1 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(1104702072).content)

				arg_286_1.text_.text = var_289_1

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_3 = 6 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 6)

				if (6 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_1) / 6)) > 0 and var_289_0 < var_289_3 then
					arg_286_1.talkMaxDuration = var_289_3

					if var_289_3 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_3 + 0
					end
				end

				arg_286_1.text_.text = var_289_1
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_4 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_4 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_4

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_4 and arg_286_1.time_ < 0 + var_289_4 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play1104702073 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1104702073
		arg_290_1.duration_ = 7.9

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1104702074(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if arg_290_1.bgs_.ST28 == nil then
				local var_293_0 = Object.Instantiate(arg_290_1.paintGo_)

				var_293_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST28")
				var_293_0.name = "ST28"
				var_293_0.transform.parent = arg_290_1.stage_.transform
				var_293_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_290_1.bgs_.ST28 = var_293_0
			end

			if 2 < arg_290_1.time_ and arg_290_1.time_ <= 2 + arg_293_0 then
				local var_293_1 = arg_290_1.bgs_.ST28

				arg_290_1.bgs_.ST28.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_293_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_293_2 = var_293_1:GetComponent("SpriteRenderer")

				if var_293_2 and var_293_2.sprite then
					local var_293_3 = 2 * (var_293_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_293_1.transform.localScale = Vector3.New(var_293_3 / var_293_2.sprite.bounds.size.y < var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x and var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x or var_293_3 / var_293_2.sprite.bounds.size.y, var_293_3 / var_293_2.sprite.bounds.size.y < var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x and var_293_3 * manager.ui.mainCameraCom_.aspect / var_293_2.sprite.bounds.size.x or var_293_3 / var_293_2.sprite.bounds.size.y, 0)
				end

				for iter_293_0, iter_293_1 in pairs(arg_290_1.bgs_) do
					if iter_293_0 ~= "ST28" then
						iter_293_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_293_4 = 4.00000000298023

			if 4.00000000298023 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1.allBtn_.enabled = false
			end

			if arg_290_1.time_ >= var_293_4 + 0.3 and arg_290_1.time_ < var_293_4 + 0.3 + arg_293_0 then
				arg_290_1.allBtn_.enabled = true
			end

			local var_293_5 = 0

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_6 = 2

			if var_293_5 <= arg_290_1.time_ and arg_290_1.time_ < var_293_5 + var_293_6 then
				local var_293_7 = Color.New(0, 0, 0)

				var_293_7.a = Mathf.Lerp(0, 1, (arg_290_1.time_ - var_293_5) / var_293_6)
				arg_290_1.mask_.color = var_293_7
			end

			if arg_290_1.time_ >= var_293_5 + var_293_6 and arg_290_1.time_ < var_293_5 + var_293_6 + arg_293_0 then
				local var_293_8 = Color.New(0, 0, 0)

				var_293_8.a = 1
				arg_290_1.mask_.color = var_293_8
			end

			local var_293_9 = 2

			if 2 < arg_290_1.time_ and arg_290_1.time_ <= var_293_9 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_10 = 2

			if var_293_9 <= arg_290_1.time_ and arg_290_1.time_ < var_293_9 + var_293_10 then
				local var_293_11 = Color.New(0, 0, 0)

				var_293_11.a = Mathf.Lerp(1, 0, (arg_290_1.time_ - var_293_9) / var_293_10)
				arg_290_1.mask_.color = var_293_11
			end

			if arg_290_1.time_ >= var_293_9 + var_293_10 and arg_290_1.time_ < var_293_9 + var_293_10 + arg_293_0 then
				local var_293_12 = Color.New(0, 0, 0)

				arg_290_1.mask_.enabled = false
				var_293_12.a = 0
				arg_290_1.mask_.color = var_293_12
			end

			local var_293_13 = arg_290_1.actors_["1047ui_story"].transform

			if 3.8 < arg_290_1.time_ and arg_290_1.time_ <= 3.8 + arg_293_0 then
				arg_290_1.var_.moveOldPos1047ui_story = var_293_13.localPosition
			end

			local var_293_14 = 0.001

			if 3.8 <= arg_290_1.time_ and arg_290_1.time_ < 3.8 + var_293_14 then
				var_293_13.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_290_1.time_ - 3.8) / var_293_14)
				var_293_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_293_13.position).x, (manager.ui.mainCamera.transform.position - var_293_13.position).y, (manager.ui.mainCamera.transform.position - var_293_13.position).z)
				var_293_13.localEulerAngles.z = 0
				var_293_13.localEulerAngles.x = 0
				var_293_13.localEulerAngles = var_293_13.localEulerAngles
			end

			if arg_290_1.time_ >= 3.8 + var_293_14 and arg_290_1.time_ < 3.8 + var_293_14 + arg_293_0 then
				var_293_13.localPosition = Vector3.New(0, -1.13, -6.2)
				var_293_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_293_13.position).x, (manager.ui.mainCamera.transform.position - var_293_13.position).y, (manager.ui.mainCamera.transform.position - var_293_13.position).z)
				var_293_13.localEulerAngles.z = 0
				var_293_13.localEulerAngles.x = 0
				var_293_13.localEulerAngles = var_293_13.localEulerAngles
			end

			local var_293_15 = arg_290_1.actors_["1047ui_story"]

			if 3.8 < arg_290_1.time_ and arg_290_1.time_ <= 3.8 + arg_293_0 and not isNil(var_293_15) and arg_290_1.var_.characterEffect1047ui_story == nil then
				arg_290_1.var_.characterEffect1047ui_story = var_293_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_16 = 0.200000002980232

			if 3.8 <= arg_290_1.time_ and arg_290_1.time_ < 3.8 + var_293_16 and not isNil(var_293_15) then
				if arg_290_1.var_.characterEffect1047ui_story and not isNil(var_293_15) then
					arg_290_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= 3.8 + var_293_16 and arg_290_1.time_ < 3.8 + var_293_16 + arg_293_0 and not isNil(var_293_15) and arg_290_1.var_.characterEffect1047ui_story then
				arg_290_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 3.8 < arg_290_1.time_ and arg_290_1.time_ <= 3.8 + arg_293_0 then
				arg_290_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 3.8 < arg_290_1.time_ and arg_290_1.time_ <= 3.8 + arg_293_0 then
				arg_290_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 1.2 < arg_290_1.time_ and arg_290_1.time_ <= 1.2 + arg_293_0 then
				arg_290_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_fountain", "")
			end

			if 0.1 < arg_290_1.time_ and arg_290_1.time_ <= 0.1 + arg_293_0 then
				arg_290_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if 1 < arg_290_1.time_ and arg_290_1.time_ <= 1 + arg_293_0 then
				arg_290_1:AudioAction("play", "music", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet.awb")

				local var_293_22 = manager.audio:GetAudioName("bgm_activity_3_0_story_daily_quiet", "bgm_activity_3_0_story_daily_quiet")

				if "" ~= "" then
					if arg_290_1.bgmTxt_.text ~= var_293_22 and arg_290_1.bgmTxt_.text ~= "" then
						if arg_290_1.bgmTxt2_.text ~= "" then
							arg_290_1.bgmTxt_.text = arg_290_1.bgmTxt2_.text
						end

						arg_290_1.bgmTxt2_.text = var_293_22

						arg_290_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_290_1.bgmTxt_.text = var_293_22
						arg_290_1.bgmTxt2_.text = var_293_22
					end

					if arg_290_1.bgmTimer then
						arg_290_1.bgmTimer:Stop()

						arg_290_1.bgmTimer = nil
					end

					if arg_290_1.settingData.show_music_name == 1 then
						arg_290_1.musicController:SetSelectedState("show")
						arg_290_1.musicAnimator_:Play("open", 0, 0)

						if arg_290_1.settingData.music_time ~= 0 then
							arg_290_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_290_1.settingData.music_time), function()
								if arg_290_1 == nil or isNil(arg_290_1.bgmTxt_) then
									return
								end

								arg_290_1.musicController:SetSelectedState("hide")
								arg_290_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_290_1.frameCnt_ <= 1 then
				arg_290_1.dialog_:SetActive(false)
			end

			local var_293_24 = 4.00000000298023
			local var_293_25 = 0.425

			if 4.00000000298023 < arg_290_1.time_ and arg_290_1.time_ <= var_293_24 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				arg_290_1.dialog_:SetActive(true)

				arg_290_1.dialogCg_.alpha = 0

				local var_293_26 = LeanTween.value(arg_290_1.dialog_, 0, 1, 0.3)

				var_293_26:setOnUpdate(LuaHelper.FloatAction(function(arg_295_0)
					arg_290_1.dialogCg_.alpha = arg_295_0
				end))
				var_293_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_290_1.dialog_)
					var_293_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_290_1.duration_ = arg_290_1.duration_ + 0.3

				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_27 = arg_290_1:GetWordFromCfg(1104702073)
				local var_293_28 = arg_290_1:FormatText(var_293_27.content)

				arg_290_1.text_.text = var_293_28

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_30 = 17 <= 0 and var_293_25 or var_293_25 * (utf8.len(var_293_28) / 17)

				if (17 <= 0 and var_293_25 or var_293_25 * (utf8.len(var_293_28) / 17)) > 0 and var_293_25 < var_293_30 then
					arg_290_1.talkMaxDuration = var_293_30
					var_293_24 = var_293_24 + 0.3

					if var_293_30 + var_293_24 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_30 + var_293_24
					end
				end

				arg_290_1.text_.text = var_293_28
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702073", "story_v_side_new_1104702.awb") ~= 0 then
					local var_293_31 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702073", "story_v_side_new_1104702.awb") / 1000

					if var_293_31 + var_293_24 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_31 + var_293_24
					end

					if var_293_27.prefab_name ~= "" and arg_290_1.actors_[var_293_27.prefab_name] ~= nil then
						local var_293_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_27.prefab_name].transform, "story_v_side_new_1104702", "1104702073", "story_v_side_new_1104702.awb")

						arg_290_1:RecordAudio("1104702073", var_293_32)
						arg_290_1:RecordAudio("1104702073", var_293_32)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702073", "story_v_side_new_1104702.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702073", "story_v_side_new_1104702.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_33 = var_293_24 + 0.3
			local var_293_34 = math.max(var_293_25, arg_290_1.talkMaxDuration)

			if var_293_24 + 0.3 <= arg_290_1.time_ and arg_290_1.time_ < var_293_33 + var_293_34 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_33) / var_293_34

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_33 + var_293_34 and arg_290_1.time_ < var_293_33 + var_293_34 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play1104702074 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1104702074
		arg_297_1.duration_ = 2.6

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1104702075(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["1047ui_story"]) and arg_297_1.var_.characterEffect1047ui_story == nil then
				arg_297_1.var_.characterEffect1047ui_story = arg_297_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["1047ui_story"]) then
				if arg_297_1.var_.characterEffect1047ui_story and not isNil(arg_297_1.actors_["1047ui_story"]) then
					arg_297_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_0)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["1047ui_story"]) and arg_297_1.var_.characterEffect1047ui_story then
				arg_297_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_300_1 = arg_297_1.actors_["1047ui_story"].transform

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1047ui_story = var_300_1.localPosition
			end

			local var_300_2 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_2 then
				var_300_1.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_297_1.time_ - 0) / var_300_2)
				var_300_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_1.position).x, (manager.ui.mainCamera.transform.position - var_300_1.position).y, (manager.ui.mainCamera.transform.position - var_300_1.position).z)
				var_300_1.localEulerAngles.z = 0
				var_300_1.localEulerAngles.x = 0
				var_300_1.localEulerAngles = var_300_1.localEulerAngles
			end

			if arg_297_1.time_ >= 0 + var_300_2 and arg_297_1.time_ < 0 + var_300_2 + arg_300_0 then
				var_300_1.localPosition = Vector3.New(0, 100, 0)
				var_300_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_300_1.position).x, (manager.ui.mainCamera.transform.position - var_300_1.position).y, (manager.ui.mainCamera.transform.position - var_300_1.position).z)
				var_300_1.localEulerAngles.z = 0
				var_300_1.localEulerAngles.x = 0
				var_300_1.localEulerAngles = var_300_1.localEulerAngles
			end

			local var_300_3 = 0
			local var_300_4 = 0.15

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_3 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_5 = arg_297_1:GetWordFromCfg(1104702074)
				local var_300_6 = arg_297_1:FormatText(var_300_5.content)

				arg_297_1.text_.text = var_300_6

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_8 = 6 <= 0 and var_300_4 or var_300_4 * (utf8.len(var_300_6) / 6)

				if (6 <= 0 and var_300_4 or var_300_4 * (utf8.len(var_300_6) / 6)) > 0 and var_300_4 < var_300_8 then
					arg_297_1.talkMaxDuration = var_300_8

					if var_300_8 + var_300_3 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_3
					end
				end

				arg_297_1.text_.text = var_300_6
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702074", "story_v_side_new_1104702.awb") ~= 0 then
					local var_300_9 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702074", "story_v_side_new_1104702.awb") / 1000

					if var_300_9 + var_300_3 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_9 + var_300_3
					end

					if var_300_5.prefab_name ~= "" and arg_297_1.actors_[var_300_5.prefab_name] ~= nil then
						local var_300_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_5.prefab_name].transform, "story_v_side_new_1104702", "1104702074", "story_v_side_new_1104702.awb")

						arg_297_1:RecordAudio("1104702074", var_300_10)
						arg_297_1:RecordAudio("1104702074", var_300_10)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702074", "story_v_side_new_1104702.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702074", "story_v_side_new_1104702.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_11 = math.max(var_300_4, arg_297_1.talkMaxDuration)

			if var_300_3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_3 + var_300_11 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_3) / var_300_11

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_3 + var_300_11 and arg_297_1.time_ < var_300_3 + var_300_11 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
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

		arg_297_1:InitPlayNodeList()
	end,
	Play1104702075 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1104702075
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1104702076(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0.5 < arg_301_1.time_ and arg_301_1.time_ <= 0.5 + arg_304_0 then
				arg_301_1:AudioAction("play", "effect", "se_story_side_1041", "se_story_side_1041_horse4", "")
			end

			local var_304_1 = 0
			local var_304_2 = 0.8

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

				local var_304_3 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(1104702075).content)

				arg_301_1.text_.text = var_304_3

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_5 = 32 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 32)

				if (32 <= 0 and var_304_2 or var_304_2 * (utf8.len(var_304_3) / 32)) > 0 and var_304_2 < var_304_5 then
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
	Play1104702076 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1104702076
		arg_305_1.duration_ = 4.5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1104702077(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = 0.4

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

				local var_308_1 = arg_305_1:GetWordFromCfg(1104702076)
				local var_308_2 = arg_305_1:FormatText(var_308_1.content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 16 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 16)

				if (16 <= 0 and var_308_0 or var_308_0 * (utf8.len(var_308_2) / 16)) > 0 and var_308_0 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + 0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702076", "story_v_side_new_1104702.awb") ~= 0 then
					local var_308_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702076", "story_v_side_new_1104702.awb") / 1000

					if var_308_5 + 0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + 0
					end

					if var_308_1.prefab_name ~= "" and arg_305_1.actors_[var_308_1.prefab_name] ~= nil then
						local var_308_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_1.prefab_name].transform, "story_v_side_new_1104702", "1104702076", "story_v_side_new_1104702.awb")

						arg_305_1:RecordAudio("1104702076", var_308_6)
						arg_305_1:RecordAudio("1104702076", var_308_6)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702076", "story_v_side_new_1104702.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702076", "story_v_side_new_1104702.awb")
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
	Play1104702077 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1104702077
		arg_309_1.duration_ = 2

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1104702078(arg_309_1)
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
				arg_309_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_312_4 = 0
			local var_312_5 = 0.15

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

				local var_312_6 = arg_309_1:GetWordFromCfg(1104702077)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 6 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 6)

				if (6 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 6)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702077", "story_v_side_new_1104702.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702077", "story_v_side_new_1104702.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_side_new_1104702", "1104702077", "story_v_side_new_1104702.awb")

						arg_309_1:RecordAudio("1104702077", var_312_11)
						arg_309_1:RecordAudio("1104702077", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702077", "story_v_side_new_1104702.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702077", "story_v_side_new_1104702.awb")
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
	Play1104702078 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1104702078
		arg_313_1.duration_ = 1.47

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1104702079(arg_313_1)
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

			local var_316_1 = arg_313_1.actors_["1047ui_story"].transform

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos1047ui_story = var_316_1.localPosition
			end

			local var_316_2 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 then
				var_316_1.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_313_1.time_ - 0) / var_316_2)
				var_316_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_1.position).x, (manager.ui.mainCamera.transform.position - var_316_1.position).y, (manager.ui.mainCamera.transform.position - var_316_1.position).z)
				var_316_1.localEulerAngles.z = 0
				var_316_1.localEulerAngles.x = 0
				var_316_1.localEulerAngles = var_316_1.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 then
				var_316_1.localPosition = Vector3.New(0, 100, 0)
				var_316_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_316_1.position).x, (manager.ui.mainCamera.transform.position - var_316_1.position).y, (manager.ui.mainCamera.transform.position - var_316_1.position).z)
				var_316_1.localEulerAngles.z = 0
				var_316_1.localEulerAngles.x = 0
				var_316_1.localEulerAngles = var_316_1.localEulerAngles
			end

			local var_316_3 = 0
			local var_316_4 = 0.075

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_3 + arg_316_0 then
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

				local var_316_5 = arg_313_1:GetWordFromCfg(1104702078)
				local var_316_6 = arg_313_1:FormatText(var_316_5.content)

				arg_313_1.text_.text = var_316_6

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_8 = 3 <= 0 and var_316_4 or var_316_4 * (utf8.len(var_316_6) / 3)

				if (3 <= 0 and var_316_4 or var_316_4 * (utf8.len(var_316_6) / 3)) > 0 and var_316_4 < var_316_8 then
					arg_313_1.talkMaxDuration = var_316_8

					if var_316_8 + var_316_3 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_3
					end
				end

				arg_313_1.text_.text = var_316_6
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702078", "story_v_side_new_1104702.awb") ~= 0 then
					local var_316_9 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702078", "story_v_side_new_1104702.awb") / 1000

					if var_316_9 + var_316_3 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_3
					end

					if var_316_5.prefab_name ~= "" and arg_313_1.actors_[var_316_5.prefab_name] ~= nil then
						local var_316_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_5.prefab_name].transform, "story_v_side_new_1104702", "1104702078", "story_v_side_new_1104702.awb")

						arg_313_1:RecordAudio("1104702078", var_316_10)
						arg_313_1:RecordAudio("1104702078", var_316_10)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702078", "story_v_side_new_1104702.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702078", "story_v_side_new_1104702.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_11 = math.max(var_316_4, arg_313_1.talkMaxDuration)

			if var_316_3 <= arg_313_1.time_ and arg_313_1.time_ < var_316_3 + var_316_11 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_3) / var_316_11

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_3 + var_316_11 and arg_313_1.time_ < var_316_3 + var_316_11 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
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

		arg_313_1:InitPlayNodeList()
	end,
	Play1104702079 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1104702079
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1104702080(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0.1 < arg_317_1.time_ and arg_317_1.time_ <= 0.1 + arg_320_0 then
				arg_317_1:AudioAction("play", "effect", "se_story_151", "se_story_151_horse01", "")
			end

			local var_320_1 = 0
			local var_320_2 = 0.475

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_3 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(1104702079).content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 19 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 19)

				if (19 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 19)) > 0 and var_320_2 < var_320_5 then
					arg_317_1.talkMaxDuration = var_320_5

					if var_320_5 + var_320_1 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_5 + var_320_1
					end
				end

				arg_317_1.text_.text = var_320_3
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_6 = math.max(var_320_2, arg_317_1.talkMaxDuration)

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_6 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_1) / var_320_6

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_1 + var_320_6 and arg_317_1.time_ < var_320_1 + var_320_6 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1104702080 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1104702080
		arg_321_1.duration_ = 3.67

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1104702081(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.375

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_1 = arg_321_1:GetWordFromCfg(1104702080)
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

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702080", "story_v_side_new_1104702.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702080", "story_v_side_new_1104702.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_side_new_1104702", "1104702080", "story_v_side_new_1104702.awb")

						arg_321_1:RecordAudio("1104702080", var_324_6)
						arg_321_1:RecordAudio("1104702080", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702080", "story_v_side_new_1104702.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702080", "story_v_side_new_1104702.awb")
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
	Play1104702081 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1104702081
		arg_325_1.duration_ = 4.13

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1104702082(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.45

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_1 = arg_325_1:GetWordFromCfg(1104702081)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 18 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 18)

				if (18 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 18)) > 0 and var_328_0 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702081", "story_v_side_new_1104702.awb") ~= 0 then
					local var_328_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702081", "story_v_side_new_1104702.awb") / 1000

					if var_328_5 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + 0
					end

					if var_328_1.prefab_name ~= "" and arg_325_1.actors_[var_328_1.prefab_name] ~= nil then
						local var_328_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_1.prefab_name].transform, "story_v_side_new_1104702", "1104702081", "story_v_side_new_1104702.awb")

						arg_325_1:RecordAudio("1104702081", var_328_6)
						arg_325_1:RecordAudio("1104702081", var_328_6)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702081", "story_v_side_new_1104702.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702081", "story_v_side_new_1104702.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1104702082 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1104702082
		arg_329_1.duration_ = 4.3

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1104702083(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.var_.moveOldPos1047ui_story = arg_329_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_332_0 = 0.001

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 then
				arg_329_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_329_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_329_1.time_ - 0) / var_332_0)
				arg_329_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1047ui_story"].transform.position).z)
				arg_329_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1047ui_story"].transform.localEulerAngles = arg_329_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 then
				arg_329_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_329_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_329_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_329_1.actors_["1047ui_story"].transform.position).z)
				arg_329_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_329_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_329_1.actors_["1047ui_story"].transform.localEulerAngles = arg_329_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_332_1 = arg_329_1.actors_["1047ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1047ui_story == nil then
				arg_329_1.var_.characterEffect1047ui_story = var_332_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_2 and not isNil(var_332_1) then
				if arg_329_1.var_.characterEffect1047ui_story and not isNil(var_332_1) then
					arg_329_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_2 and arg_329_1.time_ < 0 + var_332_2 + arg_332_0 and not isNil(var_332_1) and arg_329_1.var_.characterEffect1047ui_story then
				arg_329_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_332_4 = 0
			local var_332_5 = 0.475

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_6 = arg_329_1:GetWordFromCfg(1104702082)
				local var_332_7 = arg_329_1:FormatText(var_332_6.content)

				arg_329_1.text_.text = var_332_7

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_9 = 19 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 19)

				if (19 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_7) / 19)) > 0 and var_332_5 < var_332_9 then
					arg_329_1.talkMaxDuration = var_332_9

					if var_332_9 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_9 + var_332_4
					end
				end

				arg_329_1.text_.text = var_332_7
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702082", "story_v_side_new_1104702.awb") ~= 0 then
					local var_332_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702082", "story_v_side_new_1104702.awb") / 1000

					if var_332_10 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_10 + var_332_4
					end

					if var_332_6.prefab_name ~= "" and arg_329_1.actors_[var_332_6.prefab_name] ~= nil then
						local var_332_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_6.prefab_name].transform, "story_v_side_new_1104702", "1104702082", "story_v_side_new_1104702.awb")

						arg_329_1:RecordAudio("1104702082", var_332_11)
						arg_329_1:RecordAudio("1104702082", var_332_11)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702082", "story_v_side_new_1104702.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702082", "story_v_side_new_1104702.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_12 = math.max(var_332_5, arg_329_1.talkMaxDuration)

			if var_332_4 <= arg_329_1.time_ and arg_329_1.time_ < var_332_4 + var_332_12 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_4) / var_332_12

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_4 + var_332_12 and arg_329_1.time_ < var_332_4 + var_332_12 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {
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

		arg_329_1:InitPlayNodeList()
	end,
	Play1104702083 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1104702083
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1104702084(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1047ui_story"]) and arg_333_1.var_.characterEffect1047ui_story == nil then
				arg_333_1.var_.characterEffect1047ui_story = arg_333_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1047ui_story"]) then
				if arg_333_1.var_.characterEffect1047ui_story and not isNil(arg_333_1.actors_["1047ui_story"]) then
					arg_333_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_0)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1047ui_story"]) and arg_333_1.var_.characterEffect1047ui_story then
				arg_333_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_336_1 = 0
			local var_336_2 = 0.6

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_3 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(1104702083).content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 24 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 24)

				if (24 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 24)) > 0 and var_336_2 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_6 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_6 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_6

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_6 and arg_333_1.time_ < var_336_1 + var_336_6 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play1104702084 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1104702084
		arg_337_1.duration_ = 5.77

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1104702085(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1047ui_story"]) and arg_337_1.var_.characterEffect1047ui_story == nil then
				arg_337_1.var_.characterEffect1047ui_story = arg_337_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1047ui_story"]) then
				if arg_337_1.var_.characterEffect1047ui_story and not isNil(arg_337_1.actors_["1047ui_story"]) then
					arg_337_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1047ui_story"]) and arg_337_1.var_.characterEffect1047ui_story then
				arg_337_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_340_2 = 0
			local var_340_3 = 0.425

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_2 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_4 = arg_337_1:GetWordFromCfg(1104702084)
				local var_340_5 = arg_337_1:FormatText(var_340_4.content)

				arg_337_1.text_.text = var_340_5

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_7 = 17 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 17)

				if (17 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_5) / 17)) > 0 and var_340_3 < var_340_7 then
					arg_337_1.talkMaxDuration = var_340_7

					if var_340_7 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_7 + var_340_2
					end
				end

				arg_337_1.text_.text = var_340_5
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702084", "story_v_side_new_1104702.awb") ~= 0 then
					local var_340_8 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702084", "story_v_side_new_1104702.awb") / 1000

					if var_340_8 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_2
					end

					if var_340_4.prefab_name ~= "" and arg_337_1.actors_[var_340_4.prefab_name] ~= nil then
						local var_340_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_4.prefab_name].transform, "story_v_side_new_1104702", "1104702084", "story_v_side_new_1104702.awb")

						arg_337_1:RecordAudio("1104702084", var_340_9)
						arg_337_1:RecordAudio("1104702084", var_340_9)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702084", "story_v_side_new_1104702.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702084", "story_v_side_new_1104702.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_10 = math.max(var_340_3, arg_337_1.talkMaxDuration)

			if var_340_2 <= arg_337_1.time_ and arg_337_1.time_ < var_340_2 + var_340_10 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_2) / var_340_10

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_2 + var_340_10 and arg_337_1.time_ < var_340_2 + var_340_10 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1104702085 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1104702085
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1104702086(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["1047ui_story"]) and arg_341_1.var_.characterEffect1047ui_story == nil then
				arg_341_1.var_.characterEffect1047ui_story = arg_341_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_0 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["1047ui_story"]) then
				if arg_341_1.var_.characterEffect1047ui_story and not isNil(arg_341_1.actors_["1047ui_story"]) then
					arg_341_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_0)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["1047ui_story"]) and arg_341_1.var_.characterEffect1047ui_story then
				arg_341_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_344_1 = arg_341_1.actors_["1047ui_story"].transform

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1047ui_story = var_344_1.localPosition
			end

			local var_344_2 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 then
				var_344_1.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_341_1.time_ - 0) / var_344_2)
				var_344_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_1.position).x, (manager.ui.mainCamera.transform.position - var_344_1.position).y, (manager.ui.mainCamera.transform.position - var_344_1.position).z)
				var_344_1.localEulerAngles.z = 0
				var_344_1.localEulerAngles.x = 0
				var_344_1.localEulerAngles = var_344_1.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 then
				var_344_1.localPosition = Vector3.New(0, 100, 0)
				var_344_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_344_1.position).x, (manager.ui.mainCamera.transform.position - var_344_1.position).y, (manager.ui.mainCamera.transform.position - var_344_1.position).z)
				var_344_1.localEulerAngles.z = 0
				var_344_1.localEulerAngles.x = 0
				var_344_1.localEulerAngles = var_344_1.localEulerAngles
			end

			local var_344_3 = 0
			local var_344_4 = 0.85

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_3 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_5 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(1104702085).content)

				arg_341_1.text_.text = var_344_5

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_7 = 34 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_5) / 34)

				if (34 <= 0 and var_344_4 or var_344_4 * (utf8.len(var_344_5) / 34)) > 0 and var_344_4 < var_344_7 then
					arg_341_1.talkMaxDuration = var_344_7

					if var_344_7 + var_344_3 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_7 + var_344_3
					end
				end

				arg_341_1.text_.text = var_344_5
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_8 = math.max(var_344_4, arg_341_1.talkMaxDuration)

			if var_344_3 <= arg_341_1.time_ and arg_341_1.time_ < var_344_3 + var_344_8 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_3) / var_344_8

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_3 + var_344_8 and arg_341_1.time_ < var_344_3 + var_344_8 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
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

		arg_341_1:InitPlayNodeList()
	end,
	Play1104702086 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1104702086
		arg_345_1.duration_ = 3.97

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1104702087(arg_345_1)
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
				arg_345_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_348_4 = 0
			local var_348_5 = 0.45

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

				local var_348_6 = arg_345_1:GetWordFromCfg(1104702086)
				local var_348_7 = arg_345_1:FormatText(var_348_6.content)

				arg_345_1.text_.text = var_348_7

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_9 = 18 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 18)

				if (18 <= 0 and var_348_5 or var_348_5 * (utf8.len(var_348_7) / 18)) > 0 and var_348_5 < var_348_9 then
					arg_345_1.talkMaxDuration = var_348_9

					if var_348_9 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_9 + var_348_4
					end
				end

				arg_345_1.text_.text = var_348_7
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702086", "story_v_side_new_1104702.awb") ~= 0 then
					local var_348_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702086", "story_v_side_new_1104702.awb") / 1000

					if var_348_10 + var_348_4 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_4
					end

					if var_348_6.prefab_name ~= "" and arg_345_1.actors_[var_348_6.prefab_name] ~= nil then
						local var_348_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_6.prefab_name].transform, "story_v_side_new_1104702", "1104702086", "story_v_side_new_1104702.awb")

						arg_345_1:RecordAudio("1104702086", var_348_11)
						arg_345_1:RecordAudio("1104702086", var_348_11)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702086", "story_v_side_new_1104702.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702086", "story_v_side_new_1104702.awb")
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
	Play1104702087 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1104702087
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1104702088(arg_349_1)
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
			local var_352_4 = 0.925

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_3 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, true)
				arg_349_1.iconController_:SetSelectedState("hero")

				arg_349_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_349_1.callingController_:SetSelectedState("normal")

				arg_349_1.keyicon_.color = Color.New(1, 1, 1)
				arg_349_1.icon_.color = Color.New(1, 1, 1)

				local var_352_5 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(1104702087).content)

				arg_349_1.text_.text = var_352_5

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_7 = 37 <= 0 and var_352_4 or var_352_4 * (utf8.len(var_352_5) / 37)

				if (37 <= 0 and var_352_4 or var_352_4 * (utf8.len(var_352_5) / 37)) > 0 and var_352_4 < var_352_7 then
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
	Play1104702088 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1104702088
		arg_353_1.duration_ = 10.63

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1104702089(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1047ui_story = arg_353_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1047ui_story"].transform.position).z)
				arg_353_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1047ui_story"].transform.localEulerAngles = arg_353_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_353_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1047ui_story"].transform.position).z)
				arg_353_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1047ui_story"].transform.localEulerAngles = arg_353_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["1047ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1047ui_story == nil then
				arg_353_1.var_.characterEffect1047ui_story = var_356_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 and not isNil(var_356_1) then
				if arg_353_1.var_.characterEffect1047ui_story and not isNil(var_356_1) then
					arg_353_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1047ui_story then
				arg_353_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_356_4 = 0
			local var_356_5 = 1.125

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_4 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_6 = arg_353_1:GetWordFromCfg(1104702088)
				local var_356_7 = arg_353_1:FormatText(var_356_6.content)

				arg_353_1.text_.text = var_356_7

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_9 = 45 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 45)

				if (45 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 45)) > 0 and var_356_5 < var_356_9 then
					arg_353_1.talkMaxDuration = var_356_9

					if var_356_9 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_9 + var_356_4
					end
				end

				arg_353_1.text_.text = var_356_7
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702088", "story_v_side_new_1104702.awb") ~= 0 then
					local var_356_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702088", "story_v_side_new_1104702.awb") / 1000

					if var_356_10 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_4
					end

					if var_356_6.prefab_name ~= "" and arg_353_1.actors_[var_356_6.prefab_name] ~= nil then
						local var_356_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_6.prefab_name].transform, "story_v_side_new_1104702", "1104702088", "story_v_side_new_1104702.awb")

						arg_353_1:RecordAudio("1104702088", var_356_11)
						arg_353_1:RecordAudio("1104702088", var_356_11)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702088", "story_v_side_new_1104702.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702088", "story_v_side_new_1104702.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_12 = math.max(var_356_5, arg_353_1.talkMaxDuration)

			if var_356_4 <= arg_353_1.time_ and arg_353_1.time_ < var_356_4 + var_356_12 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_4) / var_356_12

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_4 + var_356_12 and arg_353_1.time_ < var_356_4 + var_356_12 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
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

		arg_353_1:InitPlayNodeList()
	end,
	Play1104702089 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1104702089
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1104702090(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1047ui_story"]) and arg_357_1.var_.characterEffect1047ui_story == nil then
				arg_357_1.var_.characterEffect1047ui_story = arg_357_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1047ui_story"]) then
				if arg_357_1.var_.characterEffect1047ui_story and not isNil(arg_357_1.actors_["1047ui_story"]) then
					arg_357_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_0)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1047ui_story"]) and arg_357_1.var_.characterEffect1047ui_story then
				arg_357_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_360_1 = arg_357_1.actors_["1047ui_story"].transform

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1047ui_story = var_360_1.localPosition
			end

			local var_360_2 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 then
				var_360_1.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_357_1.time_ - 0) / var_360_2)
				var_360_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_1.position).x, (manager.ui.mainCamera.transform.position - var_360_1.position).y, (manager.ui.mainCamera.transform.position - var_360_1.position).z)
				var_360_1.localEulerAngles.z = 0
				var_360_1.localEulerAngles.x = 0
				var_360_1.localEulerAngles = var_360_1.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 then
				var_360_1.localPosition = Vector3.New(0, 100, 0)
				var_360_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_360_1.position).x, (manager.ui.mainCamera.transform.position - var_360_1.position).y, (manager.ui.mainCamera.transform.position - var_360_1.position).z)
				var_360_1.localEulerAngles.z = 0
				var_360_1.localEulerAngles.x = 0
				var_360_1.localEulerAngles = var_360_1.localEulerAngles
			end

			local var_360_3 = 0
			local var_360_4 = 0.475

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_3 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, true)
				arg_357_1.iconController_:SetSelectedState("hero")

				arg_357_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_357_1.callingController_:SetSelectedState("normal")

				arg_357_1.keyicon_.color = Color.New(1, 1, 1)
				arg_357_1.icon_.color = Color.New(1, 1, 1)

				local var_360_5 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(1104702089).content)

				arg_357_1.text_.text = var_360_5

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_7 = 19 <= 0 and var_360_4 or var_360_4 * (utf8.len(var_360_5) / 19)

				if (19 <= 0 and var_360_4 or var_360_4 * (utf8.len(var_360_5) / 19)) > 0 and var_360_4 < var_360_7 then
					arg_357_1.talkMaxDuration = var_360_7

					if var_360_7 + var_360_3 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_3
					end
				end

				arg_357_1.text_.text = var_360_5
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_8 = math.max(var_360_4, arg_357_1.talkMaxDuration)

			if var_360_3 <= arg_357_1.time_ and arg_357_1.time_ < var_360_3 + var_360_8 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_3) / var_360_8

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_3 + var_360_8 and arg_357_1.time_ < var_360_3 + var_360_8 + arg_360_0 then
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
	Play1104702090 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1104702090
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1104702091(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0.4 < arg_361_1.time_ and arg_361_1.time_ <= 0.4 + arg_364_0 then
				arg_361_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_clap", "")
			end

			local var_364_1 = 0
			local var_364_2 = 0.65

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_3 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(1104702090).content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 26 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 26)

				if (26 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 26)) > 0 and var_364_2 < var_364_5 then
					arg_361_1.talkMaxDuration = var_364_5

					if var_364_5 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_3
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_6 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_6 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_6

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_6 and arg_361_1.time_ < var_364_1 + var_364_6 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1104702091 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1104702091
		arg_365_1.duration_ = 4.67

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1104702092(arg_365_1)
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
			local var_368_5 = 0.525

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

				local var_368_6 = arg_365_1:GetWordFromCfg(1104702091)
				local var_368_7 = arg_365_1:FormatText(var_368_6.content)

				arg_365_1.text_.text = var_368_7

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_9 = 21 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 21)

				if (21 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 21)) > 0 and var_368_5 < var_368_9 then
					arg_365_1.talkMaxDuration = var_368_9

					if var_368_9 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_9 + var_368_4
					end
				end

				arg_365_1.text_.text = var_368_7
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702091", "story_v_side_new_1104702.awb") ~= 0 then
					local var_368_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702091", "story_v_side_new_1104702.awb") / 1000

					if var_368_10 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_10 + var_368_4
					end

					if var_368_6.prefab_name ~= "" and arg_365_1.actors_[var_368_6.prefab_name] ~= nil then
						local var_368_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_6.prefab_name].transform, "story_v_side_new_1104702", "1104702091", "story_v_side_new_1104702.awb")

						arg_365_1:RecordAudio("1104702091", var_368_11)
						arg_365_1:RecordAudio("1104702091", var_368_11)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702091", "story_v_side_new_1104702.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702091", "story_v_side_new_1104702.awb")
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
	Play1104702092 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1104702092
		arg_369_1.duration_ = 3.63

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1104702093(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1047ui_story = arg_369_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_372_0 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 then
				arg_369_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_369_1.time_ - 0) / var_372_0)
				arg_369_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1047ui_story"].transform.position).z)
				arg_369_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1047ui_story"].transform.localEulerAngles = arg_369_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 then
				arg_369_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_369_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_369_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_369_1.actors_["1047ui_story"].transform.position).z)
				arg_369_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_369_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_369_1.actors_["1047ui_story"].transform.localEulerAngles = arg_369_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_1")
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_372_1 = 0
			local var_372_2 = 0.325

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_1 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_3 = arg_369_1:GetWordFromCfg(1104702092)
				local var_372_4 = arg_369_1:FormatText(var_372_3.content)

				arg_369_1.text_.text = var_372_4

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_6 = 13 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_4) / 13)

				if (13 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_4) / 13)) > 0 and var_372_2 < var_372_6 then
					arg_369_1.talkMaxDuration = var_372_6

					if var_372_6 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_6 + var_372_1
					end
				end

				arg_369_1.text_.text = var_372_4
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702092", "story_v_side_new_1104702.awb") ~= 0 then
					local var_372_7 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702092", "story_v_side_new_1104702.awb") / 1000

					if var_372_7 + var_372_1 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_1
					end

					if var_372_3.prefab_name ~= "" and arg_369_1.actors_[var_372_3.prefab_name] ~= nil then
						local var_372_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_3.prefab_name].transform, "story_v_side_new_1104702", "1104702092", "story_v_side_new_1104702.awb")

						arg_369_1:RecordAudio("1104702092", var_372_8)
						arg_369_1:RecordAudio("1104702092", var_372_8)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702092", "story_v_side_new_1104702.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702092", "story_v_side_new_1104702.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_9 = math.max(var_372_2, arg_369_1.talkMaxDuration)

			if var_372_1 <= arg_369_1.time_ and arg_369_1.time_ < var_372_1 + var_372_9 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_1) / var_372_9

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_1 + var_372_9 and arg_369_1.time_ < var_372_1 + var_372_9 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
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

		arg_369_1:InitPlayNodeList()
	end,
	Play1104702093 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1104702093
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1104702094(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1047ui_story"]) and arg_373_1.var_.characterEffect1047ui_story == nil then
				arg_373_1.var_.characterEffect1047ui_story = arg_373_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1047ui_story"]) then
				if arg_373_1.var_.characterEffect1047ui_story and not isNil(arg_373_1.actors_["1047ui_story"]) then
					arg_373_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_373_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_373_1.time_ - 0) / var_376_0)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1047ui_story"]) and arg_373_1.var_.characterEffect1047ui_story then
				arg_373_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_373_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_376_1 = arg_373_1.actors_["1047ui_story"].transform

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1047ui_story = var_376_1.localPosition
			end

			local var_376_2 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_2 then
				var_376_1.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_373_1.time_ - 0) / var_376_2)
				var_376_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_376_1.position).x, (manager.ui.mainCamera.transform.position - var_376_1.position).y, (manager.ui.mainCamera.transform.position - var_376_1.position).z)
				var_376_1.localEulerAngles.z = 0
				var_376_1.localEulerAngles.x = 0
				var_376_1.localEulerAngles = var_376_1.localEulerAngles
			end

			if arg_373_1.time_ >= 0 + var_376_2 and arg_373_1.time_ < 0 + var_376_2 + arg_376_0 then
				var_376_1.localPosition = Vector3.New(0, 100, 0)
				var_376_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_376_1.position).x, (manager.ui.mainCamera.transform.position - var_376_1.position).y, (manager.ui.mainCamera.transform.position - var_376_1.position).z)
				var_376_1.localEulerAngles.z = 0
				var_376_1.localEulerAngles.x = 0
				var_376_1.localEulerAngles = var_376_1.localEulerAngles
			end

			local var_376_3 = 0
			local var_376_4 = 0.3

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_3 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_5 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(1104702093).content)

				arg_373_1.text_.text = var_376_5

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_7 = 12 <= 0 and var_376_4 or var_376_4 * (utf8.len(var_376_5) / 12)

				if (12 <= 0 and var_376_4 or var_376_4 * (utf8.len(var_376_5) / 12)) > 0 and var_376_4 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_3 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_3
					end
				end

				arg_373_1.text_.text = var_376_5
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_8 = math.max(var_376_4, arg_373_1.talkMaxDuration)

			if var_376_3 <= arg_373_1.time_ and arg_373_1.time_ < var_376_3 + var_376_8 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_3) / var_376_8

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_3 + var_376_8 and arg_373_1.time_ < var_376_3 + var_376_8 + arg_376_0 then
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
	Play1104702094 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 1104702094
		arg_377_1.duration_ = 5.4

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play1104702095(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				local var_380_0 = arg_377_1.var_.effectmajiasu

				if not arg_377_1.var_.effectmajiasu then
					var_380_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_out"), manager.ui.mainCamera.transform)
					var_380_0.name = "majiasu"
					arg_377_1.var_.effectmajiasu = var_380_0
				else
					var_380_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_380_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_380_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_380_2 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_380_0.transform.localScale = Vector3.New(var_380_0.transform.localScale.x * var_380_2, var_380_0.transform.localScale.y * var_380_2, var_380_0.transform.localScale.z * var_380_2)
			end

			local var_380_3 = arg_377_1.bgs_.ST28.transform

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1.var_.moveOldPosST28 = var_380_3.localPosition
			end

			local var_380_4 = 0.7

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_4 then
				var_380_3.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPosST28, Vector3.New(0, 1, 9.5), (arg_377_1.time_ - 0) / var_380_4)
			end

			if arg_377_1.time_ >= 0 + var_380_4 and arg_377_1.time_ < 0 + var_380_4 + arg_380_0 then
				var_380_3.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_380_5 = 0

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 then
				arg_377_1.allBtn_.enabled = false
			end

			if arg_377_1.time_ >= var_380_5 + 2 and arg_377_1.time_ < var_380_5 + 2 + arg_380_0 then
				arg_377_1.allBtn_.enabled = true
			end

			if 0.1 < arg_377_1.time_ and arg_377_1.time_ <= 0.1 + arg_380_0 then
				arg_377_1:AudioAction("play", "effect", "se_story_151", "se_story_151_horse02", "")
			end

			if arg_377_1.frameCnt_ <= 1 then
				arg_377_1.dialog_:SetActive(false)
			end

			local var_380_7 = 0.4
			local var_380_8 = 1.15

			if 0.4 < arg_377_1.time_ and arg_377_1.time_ <= var_380_7 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0

				arg_377_1.dialog_:SetActive(true)

				arg_377_1.dialogCg_.alpha = 0

				local var_380_9 = LeanTween.value(arg_377_1.dialog_, 0, 1, 0.3)

				var_380_9:setOnUpdate(LuaHelper.FloatAction(function(arg_381_0)
					arg_377_1.dialogCg_.alpha = arg_381_0
				end))
				var_380_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_377_1.dialog_)
					var_380_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_377_1.duration_ = arg_377_1.duration_ + 0.3

				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_10 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(1104702094).content)

				arg_377_1.text_.text = var_380_10

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_12 = 46 <= 0 and var_380_8 or var_380_8 * (utf8.len(var_380_10) / 46)

				if (46 <= 0 and var_380_8 or var_380_8 * (utf8.len(var_380_10) / 46)) > 0 and var_380_8 < var_380_12 then
					arg_377_1.talkMaxDuration = var_380_12
					var_380_7 = var_380_7 + 0.3

					if var_380_12 + var_380_7 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_12 + var_380_7
					end
				end

				arg_377_1.text_.text = var_380_10
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_13 = var_380_7 + 0.3
			local var_380_14 = math.max(var_380_8, arg_377_1.talkMaxDuration)

			if var_380_7 + 0.3 <= arg_377_1.time_ and arg_377_1.time_ < var_380_13 + var_380_14 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_13) / var_380_14

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_13 + var_380_14 and arg_377_1.time_ < var_380_13 + var_380_14 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "ST28",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.7,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play1104702095 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1104702095
		arg_383_1.duration_ = 8.27

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1104702096(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_9000

			if arg_383_1.bgs_.H07g == nil then
				local var_386_0 = Object.Instantiate(arg_383_1.paintGo_)

				var_386_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07g")
				var_386_0.name = "H07g"
				var_386_0.transform.parent = arg_383_1.stage_.transform
				var_386_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_383_1.bgs_.H07g = var_386_0
			end

			if 0.625 < arg_383_1.time_ and arg_383_1.time_ <= 0.625 + arg_386_0 then
				local var_386_1 = arg_383_1.bgs_.H07g

				arg_383_1.bgs_.H07g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_386_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_386_2 = var_386_1:GetComponent("SpriteRenderer")

				if var_386_2 and var_386_2.sprite then
					local var_386_3 = 2 * (var_386_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_386_1.transform.localScale = Vector3.New(var_386_3 / var_386_2.sprite.bounds.size.y < var_386_3 * manager.ui.mainCameraCom_.aspect / var_386_2.sprite.bounds.size.x and var_386_3 * manager.ui.mainCameraCom_.aspect / var_386_2.sprite.bounds.size.x or var_386_3 / var_386_2.sprite.bounds.size.y, var_386_3 / var_386_2.sprite.bounds.size.y < var_386_3 * manager.ui.mainCameraCom_.aspect / var_386_2.sprite.bounds.size.x and var_386_3 * manager.ui.mainCameraCom_.aspect / var_386_2.sprite.bounds.size.x or var_386_3 / var_386_2.sprite.bounds.size.y, 0)
				end

				for iter_386_0, iter_386_1 in pairs(arg_383_1.bgs_) do
					if iter_386_0 ~= "H07g" then
						iter_386_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_386_4 = 1.674999999999

			if 1.674999999999 < arg_383_1.time_ and arg_383_1.time_ <= var_386_4 + arg_386_0 then
				arg_383_1.allBtn_.enabled = false
			end

			if arg_383_1.time_ >= var_386_4 + 0.3 and arg_383_1.time_ < var_386_4 + 0.3 + arg_386_0 then
				arg_383_1.allBtn_.enabled = true
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				local var_386_5 = arg_383_1.var_.effectzhuanchangyixia1

				if not arg_383_1.var_.effectzhuanchangyixia1 then
					var_386_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_386_5.name = "zhuanchangyixia1"
					arg_383_1.var_.effectzhuanchangyixia1 = var_386_5
				else
					var_386_5.transform:SetParent(var_386_9000)
				end

				var_386_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_386_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_386_5.transform.localScale = Vector3.New(var_386_5.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_386_5.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_386_5.transform.localScale.z)
			end

			local var_386_7 = 0

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_7 + arg_386_0 then
				arg_383_1.allBtn_.enabled = false
			end

			if arg_383_1.time_ >= var_386_7 + 1.674999999999 and arg_383_1.time_ < var_386_7 + 1.674999999999 + arg_386_0 then
				arg_383_1.allBtn_.enabled = true
			end

			if 1.2 < arg_383_1.time_ and arg_383_1.time_ <= 1.2 + arg_386_0 then
				arg_383_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_dream", "")
			end

			if 0.1 < arg_383_1.time_ and arg_383_1.time_ <= 0.1 + arg_386_0 then
				arg_383_1:AudioAction("stop", "effect", "se_story_side_1095", "se_story_side_1095_fountain", "")
			end

			if arg_383_1.frameCnt_ <= 1 then
				arg_383_1.dialog_:SetActive(false)
			end

			local var_386_10 = 1.674999999999
			local var_386_11 = 0.625

			if 1.674999999999 < arg_383_1.time_ and arg_383_1.time_ <= var_386_10 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0

				arg_383_1.dialog_:SetActive(true)

				arg_383_1.dialogCg_.alpha = 0

				local var_386_12 = LeanTween.value(arg_383_1.dialog_, 0, 1, 0.3)

				var_386_12:setOnUpdate(LuaHelper.FloatAction(function(arg_387_0)
					arg_383_1.dialogCg_.alpha = arg_387_0
				end))
				var_386_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_383_1.dialog_)
					var_386_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_383_1.duration_ = arg_383_1.duration_ + 0.3

				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_13 = arg_383_1:GetWordFromCfg(1104702095)
				local var_386_14 = arg_383_1:FormatText(var_386_13.content)

				arg_383_1.text_.text = var_386_14

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_16 = 25 <= 0 and var_386_11 or var_386_11 * (utf8.len(var_386_14) / 25)

				if (25 <= 0 and var_386_11 or var_386_11 * (utf8.len(var_386_14) / 25)) > 0 and var_386_11 < var_386_16 then
					arg_383_1.talkMaxDuration = var_386_16
					var_386_10 = var_386_10 + 0.3

					if var_386_16 + var_386_10 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_16 + var_386_10
					end
				end

				arg_383_1.text_.text = var_386_14
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702095", "story_v_side_new_1104702.awb") ~= 0 then
					local var_386_17 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702095", "story_v_side_new_1104702.awb") / 1000

					if var_386_17 + var_386_10 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_17 + var_386_10
					end

					if var_386_13.prefab_name ~= "" and arg_383_1.actors_[var_386_13.prefab_name] ~= nil then
						local var_386_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_13.prefab_name].transform, "story_v_side_new_1104702", "1104702095", "story_v_side_new_1104702.awb")

						arg_383_1:RecordAudio("1104702095", var_386_18)
						arg_383_1:RecordAudio("1104702095", var_386_18)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702095", "story_v_side_new_1104702.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702095", "story_v_side_new_1104702.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_19 = var_386_10 + 0.3
			local var_386_20 = math.max(var_386_11, arg_383_1.talkMaxDuration)

			if var_386_10 + 0.3 <= arg_383_1.time_ and arg_383_1.time_ < var_386_19 + var_386_20 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_19) / var_386_20

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_19 + var_386_20 and arg_383_1.time_ < var_386_19 + var_386_20 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1104702096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 1104702096
		arg_389_1.duration_ = 2.67

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play1104702097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0.35

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, true)
				arg_389_1.iconController_:SetSelectedState("hero")

				arg_389_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_389_1.callingController_:SetSelectedState("normal")

				arg_389_1.keyicon_.color = Color.New(1, 1, 1)
				arg_389_1.icon_.color = Color.New(1, 1, 1)

				local var_392_1 = arg_389_1:GetWordFromCfg(1104702096)
				local var_392_2 = arg_389_1:FormatText(var_392_1.content)

				arg_389_1.text_.text = var_392_2

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_4 = 13 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 13)

				if (13 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 13)) > 0 and var_392_0 < var_392_4 then
					arg_389_1.talkMaxDuration = var_392_4

					if var_392_4 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_4 + 0
					end
				end

				arg_389_1.text_.text = var_392_2
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702096", "story_v_side_new_1104702.awb") ~= 0 then
					local var_392_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702096", "story_v_side_new_1104702.awb") / 1000

					if var_392_5 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + 0
					end

					if var_392_1.prefab_name ~= "" and arg_389_1.actors_[var_392_1.prefab_name] ~= nil then
						local var_392_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_1.prefab_name].transform, "story_v_side_new_1104702", "1104702096", "story_v_side_new_1104702.awb")

						arg_389_1:RecordAudio("1104702096", var_392_6)
						arg_389_1:RecordAudio("1104702096", var_392_6)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702096", "story_v_side_new_1104702.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702096", "story_v_side_new_1104702.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_7 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_7 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_7

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_7 and arg_389_1.time_ < 0 + var_392_7 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play1104702097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 1104702097
		arg_393_1.duration_ = 3.07

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play1104702098(arg_393_1)
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
				arg_393_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_396_4 = 0
			local var_396_5 = 0.275

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

				local var_396_6 = arg_393_1:GetWordFromCfg(1104702097)
				local var_396_7 = arg_393_1:FormatText(var_396_6.content)

				arg_393_1.text_.text = var_396_7

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_9 = 11 <= 0 and var_396_5 or var_396_5 * (utf8.len(var_396_7) / 11)

				if (11 <= 0 and var_396_5 or var_396_5 * (utf8.len(var_396_7) / 11)) > 0 and var_396_5 < var_396_9 then
					arg_393_1.talkMaxDuration = var_396_9

					if var_396_9 + var_396_4 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_9 + var_396_4
					end
				end

				arg_393_1.text_.text = var_396_7
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702097", "story_v_side_new_1104702.awb") ~= 0 then
					local var_396_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702097", "story_v_side_new_1104702.awb") / 1000

					if var_396_10 + var_396_4 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_10 + var_396_4
					end

					if var_396_6.prefab_name ~= "" and arg_393_1.actors_[var_396_6.prefab_name] ~= nil then
						local var_396_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_6.prefab_name].transform, "story_v_side_new_1104702", "1104702097", "story_v_side_new_1104702.awb")

						arg_393_1:RecordAudio("1104702097", var_396_11)
						arg_393_1:RecordAudio("1104702097", var_396_11)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702097", "story_v_side_new_1104702.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702097", "story_v_side_new_1104702.awb")
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
	Play1104702098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1104702098
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1104702099(arg_397_1)
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
			local var_400_4 = 0.7

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_3 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_5 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(1104702098).content)

				arg_397_1.text_.text = var_400_5

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_7 = 28 <= 0 and var_400_4 or var_400_4 * (utf8.len(var_400_5) / 28)

				if (28 <= 0 and var_400_4 or var_400_4 * (utf8.len(var_400_5) / 28)) > 0 and var_400_4 < var_400_7 then
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
	Play1104702099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1104702099
		arg_401_1.duration_ = 2.7

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1104702100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0.275

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, true)
				arg_401_1.iconController_:SetSelectedState("hero")

				arg_401_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_401_1.callingController_:SetSelectedState("normal")

				arg_401_1.keyicon_.color = Color.New(1, 1, 1)
				arg_401_1.icon_.color = Color.New(1, 1, 1)

				local var_404_1 = arg_401_1:GetWordFromCfg(1104702099)
				local var_404_2 = arg_401_1:FormatText(var_404_1.content)

				arg_401_1.text_.text = var_404_2

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 11 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 11)

				if (11 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 11)) > 0 and var_404_0 < var_404_4 then
					arg_401_1.talkMaxDuration = var_404_4

					if var_404_4 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_4 + 0
					end
				end

				arg_401_1.text_.text = var_404_2
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702099", "story_v_side_new_1104702.awb") ~= 0 then
					local var_404_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702099", "story_v_side_new_1104702.awb") / 1000

					if var_404_5 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + 0
					end

					if var_404_1.prefab_name ~= "" and arg_401_1.actors_[var_404_1.prefab_name] ~= nil then
						local var_404_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_1.prefab_name].transform, "story_v_side_new_1104702", "1104702099", "story_v_side_new_1104702.awb")

						arg_401_1:RecordAudio("1104702099", var_404_6)
						arg_401_1:RecordAudio("1104702099", var_404_6)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702099", "story_v_side_new_1104702.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702099", "story_v_side_new_1104702.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_7 and arg_401_1.time_ < 0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play1104702100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 1104702100
		arg_405_1.duration_ = 2.87

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play1104702101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1047ui_story = arg_405_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_408_0 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 then
				arg_405_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_405_1.time_ - 0) / var_408_0)
				arg_405_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1047ui_story"].transform.position).z)
				arg_405_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1047ui_story"].transform.localEulerAngles = arg_405_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 then
				arg_405_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_405_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_405_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_405_1.actors_["1047ui_story"].transform.position).z)
				arg_405_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_405_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_405_1.actors_["1047ui_story"].transform.localEulerAngles = arg_405_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_408_1 = arg_405_1.actors_["1047ui_story"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1047ui_story == nil then
				arg_405_1.var_.characterEffect1047ui_story = var_408_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_2 and not isNil(var_408_1) then
				if arg_405_1.var_.characterEffect1047ui_story and not isNil(var_408_1) then
					arg_405_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= 0 + var_408_2 and arg_405_1.time_ < 0 + var_408_2 + arg_408_0 and not isNil(var_408_1) and arg_405_1.var_.characterEffect1047ui_story then
				arg_405_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_408_4 = 0
			local var_408_5 = 0.25

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_4 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_6 = arg_405_1:GetWordFromCfg(1104702100)
				local var_408_7 = arg_405_1:FormatText(var_408_6.content)

				arg_405_1.text_.text = var_408_7

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_9 = 10 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_7) / 10)

				if (10 <= 0 and var_408_5 or var_408_5 * (utf8.len(var_408_7) / 10)) > 0 and var_408_5 < var_408_9 then
					arg_405_1.talkMaxDuration = var_408_9

					if var_408_9 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_9 + var_408_4
					end
				end

				arg_405_1.text_.text = var_408_7
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702100", "story_v_side_new_1104702.awb") ~= 0 then
					local var_408_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702100", "story_v_side_new_1104702.awb") / 1000

					if var_408_10 + var_408_4 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_10 + var_408_4
					end

					if var_408_6.prefab_name ~= "" and arg_405_1.actors_[var_408_6.prefab_name] ~= nil then
						local var_408_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_6.prefab_name].transform, "story_v_side_new_1104702", "1104702100", "story_v_side_new_1104702.awb")

						arg_405_1:RecordAudio("1104702100", var_408_11)
						arg_405_1:RecordAudio("1104702100", var_408_11)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702100", "story_v_side_new_1104702.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702100", "story_v_side_new_1104702.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_12 = math.max(var_408_5, arg_405_1.talkMaxDuration)

			if var_408_4 <= arg_405_1.time_ and arg_405_1.time_ < var_408_4 + var_408_12 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_4) / var_408_12

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_4 + var_408_12 and arg_405_1.time_ < var_408_4 + var_408_12 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
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

		arg_405_1:InitPlayNodeList()
	end,
	Play1104702101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 1104702101
		arg_409_1.duration_ = 3.1

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play1104702102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["1047ui_story"]) and arg_409_1.var_.characterEffect1047ui_story == nil then
				arg_409_1.var_.characterEffect1047ui_story = arg_409_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["1047ui_story"]) then
				if arg_409_1.var_.characterEffect1047ui_story and not isNil(arg_409_1.actors_["1047ui_story"]) then
					arg_409_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_0)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["1047ui_story"]) and arg_409_1.var_.characterEffect1047ui_story then
				arg_409_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_412_1 = 0
			local var_412_2 = 0.2

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, true)
				arg_409_1.iconController_:SetSelectedState("hero")

				arg_409_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_409_1.callingController_:SetSelectedState("normal")

				arg_409_1.keyicon_.color = Color.New(1, 1, 1)
				arg_409_1.icon_.color = Color.New(1, 1, 1)

				local var_412_3 = arg_409_1:GetWordFromCfg(1104702101)
				local var_412_4 = arg_409_1:FormatText(var_412_3.content)

				arg_409_1.text_.text = var_412_4

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_6 = 8 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_4) / 8)

				if (8 <= 0 and var_412_2 or var_412_2 * (utf8.len(var_412_4) / 8)) > 0 and var_412_2 < var_412_6 then
					arg_409_1.talkMaxDuration = var_412_6

					if var_412_6 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_6 + var_412_1
					end
				end

				arg_409_1.text_.text = var_412_4
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702101", "story_v_side_new_1104702.awb") ~= 0 then
					local var_412_7 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702101", "story_v_side_new_1104702.awb") / 1000

					if var_412_7 + var_412_1 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_7 + var_412_1
					end

					if var_412_3.prefab_name ~= "" and arg_409_1.actors_[var_412_3.prefab_name] ~= nil then
						local var_412_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_3.prefab_name].transform, "story_v_side_new_1104702", "1104702101", "story_v_side_new_1104702.awb")

						arg_409_1:RecordAudio("1104702101", var_412_8)
						arg_409_1:RecordAudio("1104702101", var_412_8)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702101", "story_v_side_new_1104702.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702101", "story_v_side_new_1104702.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_9 = math.max(var_412_2, arg_409_1.talkMaxDuration)

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_9 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_1) / var_412_9

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_1 + var_412_9 and arg_409_1.time_ < var_412_1 + var_412_9 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play1104702102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 1104702102
		arg_413_1.duration_ = 3.57

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play1104702103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["1047ui_story"]) and arg_413_1.var_.characterEffect1047ui_story == nil then
				arg_413_1.var_.characterEffect1047ui_story = arg_413_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_0 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["1047ui_story"]) then
				if arg_413_1.var_.characterEffect1047ui_story and not isNil(arg_413_1.actors_["1047ui_story"]) then
					arg_413_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["1047ui_story"]) and arg_413_1.var_.characterEffect1047ui_story then
				arg_413_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_416_2 = 0
			local var_416_3 = 0.375

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_2 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_4 = arg_413_1:GetWordFromCfg(1104702102)
				local var_416_5 = arg_413_1:FormatText(var_416_4.content)

				arg_413_1.text_.text = var_416_5

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_7 = 15 <= 0 and var_416_3 or var_416_3 * (utf8.len(var_416_5) / 15)

				if (15 <= 0 and var_416_3 or var_416_3 * (utf8.len(var_416_5) / 15)) > 0 and var_416_3 < var_416_7 then
					arg_413_1.talkMaxDuration = var_416_7

					if var_416_7 + var_416_2 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_7 + var_416_2
					end
				end

				arg_413_1.text_.text = var_416_5
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702102", "story_v_side_new_1104702.awb") ~= 0 then
					local var_416_8 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702102", "story_v_side_new_1104702.awb") / 1000

					if var_416_8 + var_416_2 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_8 + var_416_2
					end

					if var_416_4.prefab_name ~= "" and arg_413_1.actors_[var_416_4.prefab_name] ~= nil then
						local var_416_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_4.prefab_name].transform, "story_v_side_new_1104702", "1104702102", "story_v_side_new_1104702.awb")

						arg_413_1:RecordAudio("1104702102", var_416_9)
						arg_413_1:RecordAudio("1104702102", var_416_9)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702102", "story_v_side_new_1104702.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702102", "story_v_side_new_1104702.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_10 = math.max(var_416_3, arg_413_1.talkMaxDuration)

			if var_416_2 <= arg_413_1.time_ and arg_413_1.time_ < var_416_2 + var_416_10 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_2) / var_416_10

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_2 + var_416_10 and arg_413_1.time_ < var_416_2 + var_416_10 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play1104702103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 1104702103
		arg_417_1.duration_ = 6.4

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play1104702104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1047ui_story = arg_417_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_420_0 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 then
				arg_417_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_417_1.time_ - 0) / var_420_0)
				arg_417_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1047ui_story"].transform.position).z)
				arg_417_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1047ui_story"].transform.localEulerAngles = arg_417_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 then
				arg_417_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_417_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1047ui_story"].transform.position).z)
				arg_417_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1047ui_story"].transform.localEulerAngles = arg_417_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action446")
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_420_1 = 0
			local var_420_2 = 0.775

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_1 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_3 = arg_417_1:GetWordFromCfg(1104702103)
				local var_420_4 = arg_417_1:FormatText(var_420_3.content)

				arg_417_1.text_.text = var_420_4

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_6 = 31 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_4) / 31)

				if (31 <= 0 and var_420_2 or var_420_2 * (utf8.len(var_420_4) / 31)) > 0 and var_420_2 < var_420_6 then
					arg_417_1.talkMaxDuration = var_420_6

					if var_420_6 + var_420_1 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_6 + var_420_1
					end
				end

				arg_417_1.text_.text = var_420_4
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702103", "story_v_side_new_1104702.awb") ~= 0 then
					local var_420_7 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702103", "story_v_side_new_1104702.awb") / 1000

					if var_420_7 + var_420_1 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_7 + var_420_1
					end

					if var_420_3.prefab_name ~= "" and arg_417_1.actors_[var_420_3.prefab_name] ~= nil then
						local var_420_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_3.prefab_name].transform, "story_v_side_new_1104702", "1104702103", "story_v_side_new_1104702.awb")

						arg_417_1:RecordAudio("1104702103", var_420_8)
						arg_417_1:RecordAudio("1104702103", var_420_8)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702103", "story_v_side_new_1104702.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702103", "story_v_side_new_1104702.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_9 = math.max(var_420_2, arg_417_1.talkMaxDuration)

			if var_420_1 <= arg_417_1.time_ and arg_417_1.time_ < var_420_1 + var_420_9 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_1) / var_420_9

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_1 + var_420_9 and arg_417_1.time_ < var_420_1 + var_420_9 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
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

		arg_417_1:InitPlayNodeList()
	end,
	Play1104702104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 1104702104
		arg_421_1.duration_ = 7.27

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play1104702105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 0.9

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_1 = arg_421_1:GetWordFromCfg(1104702104)
				local var_424_2 = arg_421_1:FormatText(var_424_1.content)

				arg_421_1.text_.text = var_424_2

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_4 = 36 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 36)

				if (36 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 36)) > 0 and var_424_0 < var_424_4 then
					arg_421_1.talkMaxDuration = var_424_4

					if var_424_4 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_4 + 0
					end
				end

				arg_421_1.text_.text = var_424_2
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702104", "story_v_side_new_1104702.awb") ~= 0 then
					local var_424_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702104", "story_v_side_new_1104702.awb") / 1000

					if var_424_5 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + 0
					end

					if var_424_1.prefab_name ~= "" and arg_421_1.actors_[var_424_1.prefab_name] ~= nil then
						local var_424_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_1.prefab_name].transform, "story_v_side_new_1104702", "1104702104", "story_v_side_new_1104702.awb")

						arg_421_1:RecordAudio("1104702104", var_424_6)
						arg_421_1:RecordAudio("1104702104", var_424_6)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702104", "story_v_side_new_1104702.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702104", "story_v_side_new_1104702.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_7 = math.max(var_424_0, arg_421_1.talkMaxDuration)

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_7 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - 0) / var_424_7

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= 0 + var_424_7 and arg_421_1.time_ < 0 + var_424_7 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play1104702105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 1104702105
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play1104702106(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["1047ui_story"]) and arg_425_1.var_.characterEffect1047ui_story == nil then
				arg_425_1.var_.characterEffect1047ui_story = arg_425_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_428_0 = 0.200000002980232

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["1047ui_story"]) then
				if arg_425_1.var_.characterEffect1047ui_story and not isNil(arg_425_1.actors_["1047ui_story"]) then
					arg_425_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_425_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_425_1.time_ - 0) / var_428_0)
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["1047ui_story"]) and arg_425_1.var_.characterEffect1047ui_story then
				arg_425_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_425_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_428_1 = 0
			local var_428_2 = 0.25

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_1 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_3 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(1104702105).content)

				arg_425_1.text_.text = var_428_3

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_5 = 10 <= 0 and var_428_2 or var_428_2 * (utf8.len(var_428_3) / 10)

				if (10 <= 0 and var_428_2 or var_428_2 * (utf8.len(var_428_3) / 10)) > 0 and var_428_2 < var_428_5 then
					arg_425_1.talkMaxDuration = var_428_5

					if var_428_5 + var_428_1 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_5 + var_428_1
					end
				end

				arg_425_1.text_.text = var_428_3
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_6 = math.max(var_428_2, arg_425_1.talkMaxDuration)

			if var_428_1 <= arg_425_1.time_ and arg_425_1.time_ < var_428_1 + var_428_6 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - var_428_1) / var_428_6

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= var_428_1 + var_428_6 and arg_425_1.time_ < var_428_1 + var_428_6 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play1104702106 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 1104702106
		arg_429_1.duration_ = 6.4

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play1104702107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["1047ui_story"]) and arg_429_1.var_.characterEffect1047ui_story == nil then
				arg_429_1.var_.characterEffect1047ui_story = arg_429_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_432_0 = 0.200000002980232

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["1047ui_story"]) then
				if arg_429_1.var_.characterEffect1047ui_story and not isNil(arg_429_1.actors_["1047ui_story"]) then
					arg_429_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["1047ui_story"]) and arg_429_1.var_.characterEffect1047ui_story then
				arg_429_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action469")
			end

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_432_2 = 0
			local var_432_3 = 0.7

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_2 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_4 = arg_429_1:GetWordFromCfg(1104702106)
				local var_432_5 = arg_429_1:FormatText(var_432_4.content)

				arg_429_1.text_.text = var_432_5

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_7 = 28 <= 0 and var_432_3 or var_432_3 * (utf8.len(var_432_5) / 28)

				if (28 <= 0 and var_432_3 or var_432_3 * (utf8.len(var_432_5) / 28)) > 0 and var_432_3 < var_432_7 then
					arg_429_1.talkMaxDuration = var_432_7

					if var_432_7 + var_432_2 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_7 + var_432_2
					end
				end

				arg_429_1.text_.text = var_432_5
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702106", "story_v_side_new_1104702.awb") ~= 0 then
					local var_432_8 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702106", "story_v_side_new_1104702.awb") / 1000

					if var_432_8 + var_432_2 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_8 + var_432_2
					end

					if var_432_4.prefab_name ~= "" and arg_429_1.actors_[var_432_4.prefab_name] ~= nil then
						local var_432_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_4.prefab_name].transform, "story_v_side_new_1104702", "1104702106", "story_v_side_new_1104702.awb")

						arg_429_1:RecordAudio("1104702106", var_432_9)
						arg_429_1:RecordAudio("1104702106", var_432_9)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702106", "story_v_side_new_1104702.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702106", "story_v_side_new_1104702.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_10 = math.max(var_432_3, arg_429_1.talkMaxDuration)

			if var_432_2 <= arg_429_1.time_ and arg_429_1.time_ < var_432_2 + var_432_10 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_2) / var_432_10

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_2 + var_432_10 and arg_429_1.time_ < var_432_2 + var_432_10 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play1104702107 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 1104702107
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play1104702108(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(arg_433_1.actors_["1047ui_story"]) and arg_433_1.var_.characterEffect1047ui_story == nil then
				arg_433_1.var_.characterEffect1047ui_story = arg_433_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_0 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 and not isNil(arg_433_1.actors_["1047ui_story"]) then
				if arg_433_1.var_.characterEffect1047ui_story and not isNil(arg_433_1.actors_["1047ui_story"]) then
					arg_433_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_433_1.time_ - 0) / var_436_0)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 and not isNil(arg_433_1.actors_["1047ui_story"]) and arg_433_1.var_.characterEffect1047ui_story then
				arg_433_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_436_1 = arg_433_1.actors_["1047ui_story"].transform

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1047ui_story = var_436_1.localPosition
			end

			local var_436_2 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_2 then
				var_436_1.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_433_1.time_ - 0) / var_436_2)
				var_436_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_436_1.position).x, (manager.ui.mainCamera.transform.position - var_436_1.position).y, (manager.ui.mainCamera.transform.position - var_436_1.position).z)
				var_436_1.localEulerAngles.z = 0
				var_436_1.localEulerAngles.x = 0
				var_436_1.localEulerAngles = var_436_1.localEulerAngles
			end

			if arg_433_1.time_ >= 0 + var_436_2 and arg_433_1.time_ < 0 + var_436_2 + arg_436_0 then
				var_436_1.localPosition = Vector3.New(0, 100, 0)
				var_436_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_436_1.position).x, (manager.ui.mainCamera.transform.position - var_436_1.position).y, (manager.ui.mainCamera.transform.position - var_436_1.position).z)
				var_436_1.localEulerAngles.z = 0
				var_436_1.localEulerAngles.x = 0
				var_436_1.localEulerAngles = var_436_1.localEulerAngles
			end

			local var_436_3 = 0
			local var_436_4 = 0.875

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_3 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_5 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(1104702107).content)

				arg_433_1.text_.text = var_436_5

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_7 = 35 <= 0 and var_436_4 or var_436_4 * (utf8.len(var_436_5) / 35)

				if (35 <= 0 and var_436_4 or var_436_4 * (utf8.len(var_436_5) / 35)) > 0 and var_436_4 < var_436_7 then
					arg_433_1.talkMaxDuration = var_436_7

					if var_436_7 + var_436_3 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_7 + var_436_3
					end
				end

				arg_433_1.text_.text = var_436_5
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_8 = math.max(var_436_4, arg_433_1.talkMaxDuration)

			if var_436_3 <= arg_433_1.time_ and arg_433_1.time_ < var_436_3 + var_436_8 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_3) / var_436_8

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_3 + var_436_8 and arg_433_1.time_ < var_436_3 + var_436_8 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
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

		arg_433_1:InitPlayNodeList()
	end,
	Play1104702108 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 1104702108
		arg_437_1.duration_ = 4.83

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play1104702109(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos1047ui_story = arg_437_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_440_0 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 then
				arg_437_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_437_1.time_ - 0) / var_440_0)
				arg_437_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).z)
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles = arg_437_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 then
				arg_437_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_437_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1047ui_story"].transform.position).z)
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1047ui_story"].transform.localEulerAngles = arg_437_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_440_1 = arg_437_1.actors_["1047ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1047ui_story == nil then
				arg_437_1.var_.characterEffect1047ui_story = var_440_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_2 and not isNil(var_440_1) then
				if arg_437_1.var_.characterEffect1047ui_story and not isNil(var_440_1) then
					arg_437_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_2 and arg_437_1.time_ < 0 + var_440_2 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1047ui_story then
				arg_437_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_2")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_440_4 = 0
			local var_440_5 = 0.55

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_4 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_6 = arg_437_1:GetWordFromCfg(1104702108)
				local var_440_7 = arg_437_1:FormatText(var_440_6.content)

				arg_437_1.text_.text = var_440_7

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_9 = 22 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 22)

				if (22 <= 0 and var_440_5 or var_440_5 * (utf8.len(var_440_7) / 22)) > 0 and var_440_5 < var_440_9 then
					arg_437_1.talkMaxDuration = var_440_9

					if var_440_9 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_9 + var_440_4
					end
				end

				arg_437_1.text_.text = var_440_7
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702108", "story_v_side_new_1104702.awb") ~= 0 then
					local var_440_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702108", "story_v_side_new_1104702.awb") / 1000

					if var_440_10 + var_440_4 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_10 + var_440_4
					end

					if var_440_6.prefab_name ~= "" and arg_437_1.actors_[var_440_6.prefab_name] ~= nil then
						local var_440_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_6.prefab_name].transform, "story_v_side_new_1104702", "1104702108", "story_v_side_new_1104702.awb")

						arg_437_1:RecordAudio("1104702108", var_440_11)
						arg_437_1:RecordAudio("1104702108", var_440_11)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702108", "story_v_side_new_1104702.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702108", "story_v_side_new_1104702.awb")
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
				actorName = "1047ui_story",
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
	Play1104702109 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 1104702109
		arg_441_1.duration_ = 7.9

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play1104702110(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 0.825

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_1 = arg_441_1:GetWordFromCfg(1104702109)
				local var_444_2 = arg_441_1:FormatText(var_444_1.content)

				arg_441_1.text_.text = var_444_2

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_4 = 33 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_2) / 33)

				if (33 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_2) / 33)) > 0 and var_444_0 < var_444_4 then
					arg_441_1.talkMaxDuration = var_444_4

					if var_444_4 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_4 + 0
					end
				end

				arg_441_1.text_.text = var_444_2
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702109", "story_v_side_new_1104702.awb") ~= 0 then
					local var_444_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702109", "story_v_side_new_1104702.awb") / 1000

					if var_444_5 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_5 + 0
					end

					if var_444_1.prefab_name ~= "" and arg_441_1.actors_[var_444_1.prefab_name] ~= nil then
						local var_444_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_1.prefab_name].transform, "story_v_side_new_1104702", "1104702109", "story_v_side_new_1104702.awb")

						arg_441_1:RecordAudio("1104702109", var_444_6)
						arg_441_1:RecordAudio("1104702109", var_444_6)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702109", "story_v_side_new_1104702.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702109", "story_v_side_new_1104702.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_7 = math.max(var_444_0, arg_441_1.talkMaxDuration)

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_7 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - 0) / var_444_7

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= 0 + var_444_7 and arg_441_1.time_ < 0 + var_444_7 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play1104702110 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 1104702110
		arg_445_1.duration_ = 4.4

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play1104702111(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos1047ui_story = arg_445_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_448_0 = 0.001

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 then
				arg_445_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_445_1.time_ - 0) / var_448_0)
				arg_445_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1047ui_story"].transform.position).z)
				arg_445_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["1047ui_story"].transform.localEulerAngles = arg_445_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 then
				arg_445_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_445_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_445_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_445_1.actors_["1047ui_story"].transform.position).z)
				arg_445_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_445_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_445_1.actors_["1047ui_story"].transform.localEulerAngles = arg_445_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_448_1 = 0
			local var_448_2 = 0.45

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_3 = arg_445_1:GetWordFromCfg(1104702110)
				local var_448_4 = arg_445_1:FormatText(var_448_3.content)

				arg_445_1.text_.text = var_448_4

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_6 = 18 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_4) / 18)

				if (18 <= 0 and var_448_2 or var_448_2 * (utf8.len(var_448_4) / 18)) > 0 and var_448_2 < var_448_6 then
					arg_445_1.talkMaxDuration = var_448_6

					if var_448_6 + var_448_1 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_6 + var_448_1
					end
				end

				arg_445_1.text_.text = var_448_4
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702110", "story_v_side_new_1104702.awb") ~= 0 then
					local var_448_7 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702110", "story_v_side_new_1104702.awb") / 1000

					if var_448_7 + var_448_1 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_1
					end

					if var_448_3.prefab_name ~= "" and arg_445_1.actors_[var_448_3.prefab_name] ~= nil then
						local var_448_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_3.prefab_name].transform, "story_v_side_new_1104702", "1104702110", "story_v_side_new_1104702.awb")

						arg_445_1:RecordAudio("1104702110", var_448_8)
						arg_445_1:RecordAudio("1104702110", var_448_8)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702110", "story_v_side_new_1104702.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702110", "story_v_side_new_1104702.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_9 = math.max(var_448_2, arg_445_1.talkMaxDuration)

			if var_448_1 <= arg_445_1.time_ and arg_445_1.time_ < var_448_1 + var_448_9 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_1) / var_448_9

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_1 + var_448_9 and arg_445_1.time_ < var_448_1 + var_448_9 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
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

		arg_445_1:InitPlayNodeList()
	end,
	Play1104702111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 1104702111
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play1104702112(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["1047ui_story"]) and arg_449_1.var_.characterEffect1047ui_story == nil then
				arg_449_1.var_.characterEffect1047ui_story = arg_449_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_0 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["1047ui_story"]) then
				if arg_449_1.var_.characterEffect1047ui_story and not isNil(arg_449_1.actors_["1047ui_story"]) then
					arg_449_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_449_1.time_ - 0) / var_452_0)
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["1047ui_story"]) and arg_449_1.var_.characterEffect1047ui_story then
				arg_449_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_452_1 = arg_449_1.actors_["1047ui_story"].transform

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos1047ui_story = var_452_1.localPosition
			end

			local var_452_2 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_2 then
				var_452_1.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_449_1.time_ - 0) / var_452_2)
				var_452_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_452_1.position).x, (manager.ui.mainCamera.transform.position - var_452_1.position).y, (manager.ui.mainCamera.transform.position - var_452_1.position).z)
				var_452_1.localEulerAngles.z = 0
				var_452_1.localEulerAngles.x = 0
				var_452_1.localEulerAngles = var_452_1.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_2 and arg_449_1.time_ < 0 + var_452_2 + arg_452_0 then
				var_452_1.localPosition = Vector3.New(0, 100, 0)
				var_452_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_452_1.position).x, (manager.ui.mainCamera.transform.position - var_452_1.position).y, (manager.ui.mainCamera.transform.position - var_452_1.position).z)
				var_452_1.localEulerAngles.z = 0
				var_452_1.localEulerAngles.x = 0
				var_452_1.localEulerAngles = var_452_1.localEulerAngles
			end

			local var_452_3 = 0
			local var_452_4 = 0.75

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_3 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, false)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_5 = arg_449_1:FormatText(arg_449_1:GetWordFromCfg(1104702111).content)

				arg_449_1.text_.text = var_452_5

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_7 = 30 <= 0 and var_452_4 or var_452_4 * (utf8.len(var_452_5) / 30)

				if (30 <= 0 and var_452_4 or var_452_4 * (utf8.len(var_452_5) / 30)) > 0 and var_452_4 < var_452_7 then
					arg_449_1.talkMaxDuration = var_452_7

					if var_452_7 + var_452_3 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_7 + var_452_3
					end
				end

				arg_449_1.text_.text = var_452_5
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_8 = math.max(var_452_4, arg_449_1.talkMaxDuration)

			if var_452_3 <= arg_449_1.time_ and arg_449_1.time_ < var_452_3 + var_452_8 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_3) / var_452_8

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_3 + var_452_8 and arg_449_1.time_ < var_452_3 + var_452_8 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
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

		arg_449_1:InitPlayNodeList()
	end,
	Play1104702112 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1104702112
		arg_453_1.duration_ = 2.47

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1104702113(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0.25

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_1 = arg_453_1:GetWordFromCfg(1104702112)
				local var_456_2 = arg_453_1:FormatText(var_456_1.content)

				arg_453_1.text_.text = var_456_2

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_4 = 10 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 10)

				if (10 <= 0 and var_456_0 or var_456_0 * (utf8.len(var_456_2) / 10)) > 0 and var_456_0 < var_456_4 then
					arg_453_1.talkMaxDuration = var_456_4

					if var_456_4 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_4 + 0
					end
				end

				arg_453_1.text_.text = var_456_2
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702112", "story_v_side_new_1104702.awb") ~= 0 then
					local var_456_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702112", "story_v_side_new_1104702.awb") / 1000

					if var_456_5 + 0 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_5 + 0
					end

					if var_456_1.prefab_name ~= "" and arg_453_1.actors_[var_456_1.prefab_name] ~= nil then
						local var_456_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_1.prefab_name].transform, "story_v_side_new_1104702", "1104702112", "story_v_side_new_1104702.awb")

						arg_453_1:RecordAudio("1104702112", var_456_6)
						arg_453_1:RecordAudio("1104702112", var_456_6)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702112", "story_v_side_new_1104702.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702112", "story_v_side_new_1104702.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_7 = math.max(var_456_0, arg_453_1.talkMaxDuration)

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_7 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - 0) / var_456_7

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= 0 + var_456_7 and arg_453_1.time_ < 0 + var_456_7 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play1104702113 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1104702113
		arg_457_1.duration_ = 2.03

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1104702114(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos1047ui_story = arg_457_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_460_0 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 then
				arg_457_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_457_1.time_ - 0) / var_460_0)
				arg_457_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1047ui_story"].transform.position).z)
				arg_457_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1047ui_story"].transform.localEulerAngles = arg_457_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 then
				arg_457_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_457_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["1047ui_story"].transform.position).z)
				arg_457_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["1047ui_story"].transform.localEulerAngles = arg_457_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_460_1 = arg_457_1.actors_["1047ui_story"]

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect1047ui_story == nil then
				arg_457_1.var_.characterEffect1047ui_story = var_460_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_2 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_2 and not isNil(var_460_1) then
				if arg_457_1.var_.characterEffect1047ui_story and not isNil(var_460_1) then
					arg_457_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_457_1.time_ >= 0 + var_460_2 and arg_457_1.time_ < 0 + var_460_2 + arg_460_0 and not isNil(var_460_1) and arg_457_1.var_.characterEffect1047ui_story then
				arg_457_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_2")
			end

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_460_4 = 0
			local var_460_5 = 0.25

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_4 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_6 = arg_457_1:GetWordFromCfg(1104702113)
				local var_460_7 = arg_457_1:FormatText(var_460_6.content)

				arg_457_1.text_.text = var_460_7

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_9 = 10 <= 0 and var_460_5 or var_460_5 * (utf8.len(var_460_7) / 10)

				if (10 <= 0 and var_460_5 or var_460_5 * (utf8.len(var_460_7) / 10)) > 0 and var_460_5 < var_460_9 then
					arg_457_1.talkMaxDuration = var_460_9

					if var_460_9 + var_460_4 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_9 + var_460_4
					end
				end

				arg_457_1.text_.text = var_460_7
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702113", "story_v_side_new_1104702.awb") ~= 0 then
					local var_460_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702113", "story_v_side_new_1104702.awb") / 1000

					if var_460_10 + var_460_4 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_10 + var_460_4
					end

					if var_460_6.prefab_name ~= "" and arg_457_1.actors_[var_460_6.prefab_name] ~= nil then
						local var_460_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_6.prefab_name].transform, "story_v_side_new_1104702", "1104702113", "story_v_side_new_1104702.awb")

						arg_457_1:RecordAudio("1104702113", var_460_11)
						arg_457_1:RecordAudio("1104702113", var_460_11)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702113", "story_v_side_new_1104702.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702113", "story_v_side_new_1104702.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_12 = math.max(var_460_5, arg_457_1.talkMaxDuration)

			if var_460_4 <= arg_457_1.time_ and arg_457_1.time_ < var_460_4 + var_460_12 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_4) / var_460_12

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_4 + var_460_12 and arg_457_1.time_ < var_460_4 + var_460_12 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
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

		arg_457_1:InitPlayNodeList()
	end,
	Play1104702114 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 1104702114
		arg_461_1.duration_ = 6.23

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play1104702115(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["1047ui_story"]) and arg_461_1.var_.characterEffect1047ui_story == nil then
				arg_461_1.var_.characterEffect1047ui_story = arg_461_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_0 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["1047ui_story"]) then
				if arg_461_1.var_.characterEffect1047ui_story and not isNil(arg_461_1.actors_["1047ui_story"]) then
					arg_461_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_461_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_0)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["1047ui_story"]) and arg_461_1.var_.characterEffect1047ui_story then
				arg_461_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_461_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_464_1 = 0
			local var_464_2 = 0.65

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_1 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_3 = arg_461_1:GetWordFromCfg(1104702114)
				local var_464_4 = arg_461_1:FormatText(var_464_3.content)

				arg_461_1.text_.text = var_464_4

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_6 = 26 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_4) / 26)

				if (26 <= 0 and var_464_2 or var_464_2 * (utf8.len(var_464_4) / 26)) > 0 and var_464_2 < var_464_6 then
					arg_461_1.talkMaxDuration = var_464_6

					if var_464_6 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_6 + var_464_1
					end
				end

				arg_461_1.text_.text = var_464_4
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702114", "story_v_side_new_1104702.awb") ~= 0 then
					local var_464_7 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702114", "story_v_side_new_1104702.awb") / 1000

					if var_464_7 + var_464_1 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_1
					end

					if var_464_3.prefab_name ~= "" and arg_461_1.actors_[var_464_3.prefab_name] ~= nil then
						local var_464_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_3.prefab_name].transform, "story_v_side_new_1104702", "1104702114", "story_v_side_new_1104702.awb")

						arg_461_1:RecordAudio("1104702114", var_464_8)
						arg_461_1:RecordAudio("1104702114", var_464_8)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702114", "story_v_side_new_1104702.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702114", "story_v_side_new_1104702.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_9 = math.max(var_464_2, arg_461_1.talkMaxDuration)

			if var_464_1 <= arg_461_1.time_ and arg_461_1.time_ < var_464_1 + var_464_9 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_1) / var_464_9

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_1 + var_464_9 and arg_461_1.time_ < var_464_1 + var_464_9 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play1104702115 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 1104702115
		arg_465_1.duration_ = 7.93

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play1104702116(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["1047ui_story"]) and arg_465_1.var_.characterEffect1047ui_story == nil then
				arg_465_1.var_.characterEffect1047ui_story = arg_465_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_0 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["1047ui_story"]) then
				if arg_465_1.var_.characterEffect1047ui_story and not isNil(arg_465_1.actors_["1047ui_story"]) then
					arg_465_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["1047ui_story"]) and arg_465_1.var_.characterEffect1047ui_story then
				arg_465_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_468_2 = 0
			local var_468_3 = 0.95

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_2 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_4 = arg_465_1:GetWordFromCfg(1104702115)
				local var_468_5 = arg_465_1:FormatText(var_468_4.content)

				arg_465_1.text_.text = var_468_5

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_7 = 38 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_5) / 38)

				if (38 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_5) / 38)) > 0 and var_468_3 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_2
					end
				end

				arg_465_1.text_.text = var_468_5
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702115", "story_v_side_new_1104702.awb") ~= 0 then
					local var_468_8 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702115", "story_v_side_new_1104702.awb") / 1000

					if var_468_8 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_8 + var_468_2
					end

					if var_468_4.prefab_name ~= "" and arg_465_1.actors_[var_468_4.prefab_name] ~= nil then
						local var_468_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_4.prefab_name].transform, "story_v_side_new_1104702", "1104702115", "story_v_side_new_1104702.awb")

						arg_465_1:RecordAudio("1104702115", var_468_9)
						arg_465_1:RecordAudio("1104702115", var_468_9)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702115", "story_v_side_new_1104702.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702115", "story_v_side_new_1104702.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_10 = math.max(var_468_3, arg_465_1.talkMaxDuration)

			if var_468_2 <= arg_465_1.time_ and arg_465_1.time_ < var_468_2 + var_468_10 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_2) / var_468_10

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_2 + var_468_10 and arg_465_1.time_ < var_468_2 + var_468_10 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play1104702116 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 1104702116
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play1104702117(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["1047ui_story"]) and arg_469_1.var_.characterEffect1047ui_story == nil then
				arg_469_1.var_.characterEffect1047ui_story = arg_469_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_0 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["1047ui_story"]) then
				if arg_469_1.var_.characterEffect1047ui_story and not isNil(arg_469_1.actors_["1047ui_story"]) then
					arg_469_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_469_1.time_ - 0) / var_472_0)
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["1047ui_story"]) and arg_469_1.var_.characterEffect1047ui_story then
				arg_469_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_472_1 = arg_469_1.actors_["1047ui_story"].transform

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos1047ui_story = var_472_1.localPosition
			end

			local var_472_2 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_2 then
				var_472_1.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_469_1.time_ - 0) / var_472_2)
				var_472_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_472_1.position).x, (manager.ui.mainCamera.transform.position - var_472_1.position).y, (manager.ui.mainCamera.transform.position - var_472_1.position).z)
				var_472_1.localEulerAngles.z = 0
				var_472_1.localEulerAngles.x = 0
				var_472_1.localEulerAngles = var_472_1.localEulerAngles
			end

			if arg_469_1.time_ >= 0 + var_472_2 and arg_469_1.time_ < 0 + var_472_2 + arg_472_0 then
				var_472_1.localPosition = Vector3.New(0, 100, 0)
				var_472_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_472_1.position).x, (manager.ui.mainCamera.transform.position - var_472_1.position).y, (manager.ui.mainCamera.transform.position - var_472_1.position).z)
				var_472_1.localEulerAngles.z = 0
				var_472_1.localEulerAngles.x = 0
				var_472_1.localEulerAngles = var_472_1.localEulerAngles
			end

			local var_472_3 = 0
			local var_472_4 = 1.1

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_3 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_5 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(1104702116).content)

				arg_469_1.text_.text = var_472_5

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_7 = 44 <= 0 and var_472_4 or var_472_4 * (utf8.len(var_472_5) / 44)

				if (44 <= 0 and var_472_4 or var_472_4 * (utf8.len(var_472_5) / 44)) > 0 and var_472_4 < var_472_7 then
					arg_469_1.talkMaxDuration = var_472_7

					if var_472_7 + var_472_3 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_7 + var_472_3
					end
				end

				arg_469_1.text_.text = var_472_5
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_8 = math.max(var_472_4, arg_469_1.talkMaxDuration)

			if var_472_3 <= arg_469_1.time_ and arg_469_1.time_ < var_472_3 + var_472_8 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_3) / var_472_8

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_3 + var_472_8 and arg_469_1.time_ < var_472_3 + var_472_8 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
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

		arg_469_1:InitPlayNodeList()
	end,
	Play1104702117 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 1104702117
		arg_473_1.duration_ = 6.97

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play1104702118(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPos1047ui_story = arg_473_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_476_0 = 0.001

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 then
				arg_473_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_473_1.time_ - 0) / var_476_0)
				arg_473_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1047ui_story"].transform.position).z)
				arg_473_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1047ui_story"].transform.localEulerAngles = arg_473_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 then
				arg_473_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_473_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["1047ui_story"].transform.position).z)
				arg_473_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["1047ui_story"].transform.localEulerAngles = arg_473_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_476_1 = arg_473_1.actors_["1047ui_story"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1047ui_story == nil then
				arg_473_1.var_.characterEffect1047ui_story = var_476_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_2 and not isNil(var_476_1) then
				if arg_473_1.var_.characterEffect1047ui_story and not isNil(var_476_1) then
					arg_473_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_2 and arg_473_1.time_ < 0 + var_476_2 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect1047ui_story then
				arg_473_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_476_4 = 0
			local var_476_5 = 0.825

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_4 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_6 = arg_473_1:GetWordFromCfg(1104702117)
				local var_476_7 = arg_473_1:FormatText(var_476_6.content)

				arg_473_1.text_.text = var_476_7

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_9 = 33 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 33)

				if (33 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 33)) > 0 and var_476_5 < var_476_9 then
					arg_473_1.talkMaxDuration = var_476_9

					if var_476_9 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_9 + var_476_4
					end
				end

				arg_473_1.text_.text = var_476_7
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702117", "story_v_side_new_1104702.awb") ~= 0 then
					local var_476_10 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702117", "story_v_side_new_1104702.awb") / 1000

					if var_476_10 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_10 + var_476_4
					end

					if var_476_6.prefab_name ~= "" and arg_473_1.actors_[var_476_6.prefab_name] ~= nil then
						local var_476_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_6.prefab_name].transform, "story_v_side_new_1104702", "1104702117", "story_v_side_new_1104702.awb")

						arg_473_1:RecordAudio("1104702117", var_476_11)
						arg_473_1:RecordAudio("1104702117", var_476_11)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702117", "story_v_side_new_1104702.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702117", "story_v_side_new_1104702.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_12 = math.max(var_476_5, arg_473_1.talkMaxDuration)

			if var_476_4 <= arg_473_1.time_ and arg_473_1.time_ < var_476_4 + var_476_12 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_4) / var_476_12

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_4 + var_476_12 and arg_473_1.time_ < var_476_4 + var_476_12 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
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

		arg_473_1:InitPlayNodeList()
	end,
	Play1104702118 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 1104702118
		arg_477_1.duration_ = 16.63

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play1104702119(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if arg_477_1.bgs_.H07h == nil then
				local var_480_0 = Object.Instantiate(arg_477_1.paintGo_)

				var_480_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H07h")
				var_480_0.name = "H07h"
				var_480_0.transform.parent = arg_477_1.stage_.transform
				var_480_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_477_1.bgs_.H07h = var_480_0
			end

			if 2 < arg_477_1.time_ and arg_477_1.time_ <= 2 + arg_480_0 then
				local var_480_1 = arg_477_1.bgs_.H07h

				arg_477_1.bgs_.H07h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_480_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_480_2 = var_480_1:GetComponent("SpriteRenderer")

				if var_480_2 and var_480_2.sprite then
					local var_480_3 = 2 * (var_480_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_480_1.transform.localScale = Vector3.New(var_480_3 / var_480_2.sprite.bounds.size.y < var_480_3 * manager.ui.mainCameraCom_.aspect / var_480_2.sprite.bounds.size.x and var_480_3 * manager.ui.mainCameraCom_.aspect / var_480_2.sprite.bounds.size.x or var_480_3 / var_480_2.sprite.bounds.size.y, var_480_3 / var_480_2.sprite.bounds.size.y < var_480_3 * manager.ui.mainCameraCom_.aspect / var_480_2.sprite.bounds.size.x and var_480_3 * manager.ui.mainCameraCom_.aspect / var_480_2.sprite.bounds.size.x or var_480_3 / var_480_2.sprite.bounds.size.y, 0)
				end

				for iter_480_0, iter_480_1 in pairs(arg_477_1.bgs_) do
					if iter_480_0 ~= "H07h" then
						iter_480_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_480_4 = 4

			if 4 < arg_477_1.time_ and arg_477_1.time_ <= var_480_4 + arg_480_0 then
				arg_477_1.allBtn_.enabled = false
			end

			if arg_477_1.time_ >= var_480_4 + 0.3 and arg_477_1.time_ < var_480_4 + 0.3 + arg_480_0 then
				arg_477_1.allBtn_.enabled = true
			end

			local var_480_5 = 0

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_5 + arg_480_0 then
				arg_477_1.mask_.enabled = true
				arg_477_1.mask_.raycastTarget = true

				arg_477_1:SetGaussion(false)
			end

			local var_480_6 = 2

			if var_480_5 <= arg_477_1.time_ and arg_477_1.time_ < var_480_5 + var_480_6 then
				local var_480_7 = Color.New(0, 0, 0)

				var_480_7.a = Mathf.Lerp(0, 1, (arg_477_1.time_ - var_480_5) / var_480_6)
				arg_477_1.mask_.color = var_480_7
			end

			if arg_477_1.time_ >= var_480_5 + var_480_6 and arg_477_1.time_ < var_480_5 + var_480_6 + arg_480_0 then
				local var_480_8 = Color.New(0, 0, 0)

				var_480_8.a = 1
				arg_477_1.mask_.color = var_480_8
			end

			local var_480_9 = 2

			if 2 < arg_477_1.time_ and arg_477_1.time_ <= var_480_9 + arg_480_0 then
				arg_477_1.mask_.enabled = true
				arg_477_1.mask_.raycastTarget = true

				arg_477_1:SetGaussion(false)
			end

			local var_480_10 = 2

			if var_480_9 <= arg_477_1.time_ and arg_477_1.time_ < var_480_9 + var_480_10 then
				local var_480_11 = Color.New(0, 0, 0)

				var_480_11.a = Mathf.Lerp(1, 0, (arg_477_1.time_ - var_480_9) / var_480_10)
				arg_477_1.mask_.color = var_480_11
			end

			if arg_477_1.time_ >= var_480_9 + var_480_10 and arg_477_1.time_ < var_480_9 + var_480_10 + arg_480_0 then
				local var_480_12 = Color.New(0, 0, 0)

				arg_477_1.mask_.enabled = false
				var_480_12.a = 0
				arg_477_1.mask_.color = var_480_12
			end

			local var_480_13 = arg_477_1.actors_["1047ui_story"]

			if 1.96599999815226 < arg_477_1.time_ and arg_477_1.time_ <= 1.96599999815226 + arg_480_0 and not isNil(var_480_13) and arg_477_1.var_.characterEffect1047ui_story == nil then
				arg_477_1.var_.characterEffect1047ui_story = var_480_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_14 = 0.034000001847744

			if 1.96599999815226 <= arg_477_1.time_ and arg_477_1.time_ < 1.96599999815226 + var_480_14 and not isNil(var_480_13) then
				if arg_477_1.var_.characterEffect1047ui_story and not isNil(var_480_13) then
					arg_477_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_477_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_477_1.time_ - 1.96599999815226) / var_480_14)
				end
			end

			if arg_477_1.time_ >= 1.96599999815226 + var_480_14 and arg_477_1.time_ < 1.96599999815226 + var_480_14 + arg_480_0 and not isNil(var_480_13) and arg_477_1.var_.characterEffect1047ui_story then
				arg_477_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_477_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_480_15 = arg_477_1.actors_["1047ui_story"].transform

			if 1.96599999815226 < arg_477_1.time_ and arg_477_1.time_ <= 1.96599999815226 + arg_480_0 then
				arg_477_1.var_.moveOldPos1047ui_story = var_480_15.localPosition
			end

			local var_480_16 = 0.001

			if 1.96599999815226 <= arg_477_1.time_ and arg_477_1.time_ < 1.96599999815226 + var_480_16 then
				var_480_15.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_477_1.time_ - 1.96599999815226) / var_480_16)
				var_480_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_480_15.position).x, (manager.ui.mainCamera.transform.position - var_480_15.position).y, (manager.ui.mainCamera.transform.position - var_480_15.position).z)
				var_480_15.localEulerAngles.z = 0
				var_480_15.localEulerAngles.x = 0
				var_480_15.localEulerAngles = var_480_15.localEulerAngles
			end

			if arg_477_1.time_ >= 1.96599999815226 + var_480_16 and arg_477_1.time_ < 1.96599999815226 + var_480_16 + arg_480_0 then
				var_480_15.localPosition = Vector3.New(0, 100, 0)
				var_480_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_480_15.position).x, (manager.ui.mainCamera.transform.position - var_480_15.position).y, (manager.ui.mainCamera.transform.position - var_480_15.position).z)
				var_480_15.localEulerAngles.z = 0
				var_480_15.localEulerAngles.x = 0
				var_480_15.localEulerAngles = var_480_15.localEulerAngles
			end

			if arg_477_1.frameCnt_ <= 1 then
				arg_477_1.dialog_:SetActive(false)
			end

			local var_480_17 = 4
			local var_480_18 = 1.025

			if 4 < arg_477_1.time_ and arg_477_1.time_ <= var_480_17 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0

				arg_477_1.dialog_:SetActive(true)

				arg_477_1.dialogCg_.alpha = 0

				local var_480_19 = LeanTween.value(arg_477_1.dialog_, 0, 1, 0.3)

				var_480_19:setOnUpdate(LuaHelper.FloatAction(function(arg_481_0)
					arg_477_1.dialogCg_.alpha = arg_481_0
				end))
				var_480_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_477_1.dialog_)
					var_480_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_477_1.duration_ = arg_477_1.duration_ + 0.3

				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_20 = arg_477_1:GetWordFromCfg(1104702118)
				local var_480_21 = arg_477_1:FormatText(var_480_20.content)

				arg_477_1.text_.text = var_480_21

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_23 = 42 <= 0 and var_480_18 or var_480_18 * (utf8.len(var_480_21) / 42)

				if (42 <= 0 and var_480_18 or var_480_18 * (utf8.len(var_480_21) / 42)) > 0 and var_480_18 < var_480_23 then
					arg_477_1.talkMaxDuration = var_480_23
					var_480_17 = var_480_17 + 0.3

					if var_480_23 + var_480_17 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_23 + var_480_17
					end
				end

				arg_477_1.text_.text = var_480_21
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702118", "story_v_side_new_1104702.awb") ~= 0 then
					local var_480_24 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702118", "story_v_side_new_1104702.awb") / 1000

					if var_480_24 + var_480_17 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_24 + var_480_17
					end

					if var_480_20.prefab_name ~= "" and arg_477_1.actors_[var_480_20.prefab_name] ~= nil then
						local var_480_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_20.prefab_name].transform, "story_v_side_new_1104702", "1104702118", "story_v_side_new_1104702.awb")

						arg_477_1:RecordAudio("1104702118", var_480_25)
						arg_477_1:RecordAudio("1104702118", var_480_25)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702118", "story_v_side_new_1104702.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702118", "story_v_side_new_1104702.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_26 = var_480_17 + 0.3
			local var_480_27 = math.max(var_480_18, arg_477_1.talkMaxDuration)

			if var_480_17 + 0.3 <= arg_477_1.time_ and arg_477_1.time_ < var_480_26 + var_480_27 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_26) / var_480_27

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_26 + var_480_27 and arg_477_1.time_ < var_480_26 + var_480_27 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
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

		arg_477_1:InitPlayNodeList()
	end,
	Play1104702119 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 1104702119
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play1104702120(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0.75

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_1 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(1104702119).content)

				arg_483_1.text_.text = var_486_1

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_3 = 30 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 30)

				if (30 <= 0 and var_486_0 or var_486_0 * (utf8.len(var_486_1) / 30)) > 0 and var_486_0 < var_486_3 then
					arg_483_1.talkMaxDuration = var_486_3

					if var_486_3 + 0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_3 + 0
					end
				end

				arg_483_1.text_.text = var_486_1
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_4 = math.max(var_486_0, arg_483_1.talkMaxDuration)

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_4 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - 0) / var_486_4

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= 0 + var_486_4 and arg_483_1.time_ < 0 + var_486_4 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play1104702120 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 1104702120
		arg_487_1.duration_ = 7.77

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play1104702121(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0.825

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, true)
				arg_487_1.iconController_:SetSelectedState("hero")

				arg_487_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_487_1.callingController_:SetSelectedState("normal")

				arg_487_1.keyicon_.color = Color.New(1, 1, 1)
				arg_487_1.icon_.color = Color.New(1, 1, 1)

				local var_490_1 = arg_487_1:GetWordFromCfg(1104702120)
				local var_490_2 = arg_487_1:FormatText(var_490_1.content)

				arg_487_1.text_.text = var_490_2

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_4 = 33 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 33)

				if (33 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 33)) > 0 and var_490_0 < var_490_4 then
					arg_487_1.talkMaxDuration = var_490_4

					if var_490_4 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_4 + 0
					end
				end

				arg_487_1.text_.text = var_490_2
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702120", "story_v_side_new_1104702.awb") ~= 0 then
					local var_490_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702120", "story_v_side_new_1104702.awb") / 1000

					if var_490_5 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_5 + 0
					end

					if var_490_1.prefab_name ~= "" and arg_487_1.actors_[var_490_1.prefab_name] ~= nil then
						local var_490_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_1.prefab_name].transform, "story_v_side_new_1104702", "1104702120", "story_v_side_new_1104702.awb")

						arg_487_1:RecordAudio("1104702120", var_490_6)
						arg_487_1:RecordAudio("1104702120", var_490_6)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702120", "story_v_side_new_1104702.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702120", "story_v_side_new_1104702.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_7 = math.max(var_490_0, arg_487_1.talkMaxDuration)

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_7 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - 0) / var_490_7

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= 0 + var_490_7 and arg_487_1.time_ < 0 + var_490_7 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play1104702121 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 1104702121
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play1104702122(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0.85

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, true)
				arg_491_1.iconController_:SetSelectedState("hero")

				arg_491_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_491_1.callingController_:SetSelectedState("normal")

				arg_491_1.keyicon_.color = Color.New(1, 1, 1)
				arg_491_1.icon_.color = Color.New(1, 1, 1)

				local var_494_1 = arg_491_1:FormatText(arg_491_1:GetWordFromCfg(1104702121).content)

				arg_491_1.text_.text = var_494_1

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_3 = 34 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_1) / 34)

				if (34 <= 0 and var_494_0 or var_494_0 * (utf8.len(var_494_1) / 34)) > 0 and var_494_0 < var_494_3 then
					arg_491_1.talkMaxDuration = var_494_3

					if var_494_3 + 0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_3 + 0
					end
				end

				arg_491_1.text_.text = var_494_1
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_4 = math.max(var_494_0, arg_491_1.talkMaxDuration)

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_4 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - 0) / var_494_4

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= 0 + var_494_4 and arg_491_1.time_ < 0 + var_494_4 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play1104702122 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1104702122
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1104702123(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.75

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_1 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(1104702122).content)

				arg_495_1.text_.text = var_498_1

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_3 = 30 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_1) / 30)

				if (30 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_1) / 30)) > 0 and var_498_0 < var_498_3 then
					arg_495_1.talkMaxDuration = var_498_3

					if var_498_3 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_3 + 0
					end
				end

				arg_495_1.text_.text = var_498_1
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_4 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_4 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_4

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_4 and arg_495_1.time_ < 0 + var_498_4 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play1104702123 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1104702123
		arg_499_1.duration_ = 6.43

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1104702124(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0.6

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, true)
				arg_499_1.iconController_:SetSelectedState("hero")

				arg_499_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_499_1.callingController_:SetSelectedState("normal")

				arg_499_1.keyicon_.color = Color.New(1, 1, 1)
				arg_499_1.icon_.color = Color.New(1, 1, 1)

				local var_502_1 = arg_499_1:GetWordFromCfg(1104702123)
				local var_502_2 = arg_499_1:FormatText(var_502_1.content)

				arg_499_1.text_.text = var_502_2

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_4 = 24 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 24)

				if (24 <= 0 and var_502_0 or var_502_0 * (utf8.len(var_502_2) / 24)) > 0 and var_502_0 < var_502_4 then
					arg_499_1.talkMaxDuration = var_502_4

					if var_502_4 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_4 + 0
					end
				end

				arg_499_1.text_.text = var_502_2
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702123", "story_v_side_new_1104702.awb") ~= 0 then
					local var_502_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702123", "story_v_side_new_1104702.awb") / 1000

					if var_502_5 + 0 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_5 + 0
					end

					if var_502_1.prefab_name ~= "" and arg_499_1.actors_[var_502_1.prefab_name] ~= nil then
						local var_502_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_1.prefab_name].transform, "story_v_side_new_1104702", "1104702123", "story_v_side_new_1104702.awb")

						arg_499_1:RecordAudio("1104702123", var_502_6)
						arg_499_1:RecordAudio("1104702123", var_502_6)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702123", "story_v_side_new_1104702.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702123", "story_v_side_new_1104702.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_7 = math.max(var_502_0, arg_499_1.talkMaxDuration)

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_7 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - 0) / var_502_7

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= 0 + var_502_7 and arg_499_1.time_ < 0 + var_502_7 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play1104702124 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1104702124
		arg_503_1.duration_ = 4.53

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1104702125(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0.35

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_1 = arg_503_1:GetWordFromCfg(1104702124)
				local var_506_2 = arg_503_1:FormatText(var_506_1.content)

				arg_503_1.text_.text = var_506_2

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_4 = 14 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_2) / 14)

				if (14 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_2) / 14)) > 0 and var_506_0 < var_506_4 then
					arg_503_1.talkMaxDuration = var_506_4

					if var_506_4 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_4 + 0
					end
				end

				arg_503_1.text_.text = var_506_2
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702124", "story_v_side_new_1104702.awb") ~= 0 then
					local var_506_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702124", "story_v_side_new_1104702.awb") / 1000

					if var_506_5 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_5 + 0
					end

					if var_506_1.prefab_name ~= "" and arg_503_1.actors_[var_506_1.prefab_name] ~= nil then
						local var_506_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_1.prefab_name].transform, "story_v_side_new_1104702", "1104702124", "story_v_side_new_1104702.awb")

						arg_503_1:RecordAudio("1104702124", var_506_6)
						arg_503_1:RecordAudio("1104702124", var_506_6)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702124", "story_v_side_new_1104702.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702124", "story_v_side_new_1104702.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_7 = math.max(var_506_0, arg_503_1.talkMaxDuration)

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_7 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - 0) / var_506_7

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= 0 + var_506_7 and arg_503_1.time_ < 0 + var_506_7 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play1104702125 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1104702125
		arg_507_1.duration_ = 11.53

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1104702126(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = 1.125

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_507_1.callingController_:SetSelectedState("normal")

				arg_507_1.keyicon_.color = Color.New(1, 1, 1)
				arg_507_1.icon_.color = Color.New(1, 1, 1)

				local var_510_1 = arg_507_1:GetWordFromCfg(1104702125)
				local var_510_2 = arg_507_1:FormatText(var_510_1.content)

				arg_507_1.text_.text = var_510_2

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_4 = 45 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_2) / 45)

				if (45 <= 0 and var_510_0 or var_510_0 * (utf8.len(var_510_2) / 45)) > 0 and var_510_0 < var_510_4 then
					arg_507_1.talkMaxDuration = var_510_4

					if var_510_4 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_4 + 0
					end
				end

				arg_507_1.text_.text = var_510_2
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702125", "story_v_side_new_1104702.awb") ~= 0 then
					local var_510_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702125", "story_v_side_new_1104702.awb") / 1000

					if var_510_5 + 0 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_5 + 0
					end

					if var_510_1.prefab_name ~= "" and arg_507_1.actors_[var_510_1.prefab_name] ~= nil then
						local var_510_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_1.prefab_name].transform, "story_v_side_new_1104702", "1104702125", "story_v_side_new_1104702.awb")

						arg_507_1:RecordAudio("1104702125", var_510_6)
						arg_507_1:RecordAudio("1104702125", var_510_6)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702125", "story_v_side_new_1104702.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702125", "story_v_side_new_1104702.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_7 = math.max(var_510_0, arg_507_1.talkMaxDuration)

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_7 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - 0) / var_510_7

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= 0 + var_510_7 and arg_507_1.time_ < 0 + var_510_7 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play1104702126 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1104702126
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1104702127(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0.575

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_511_1.callingController_:SetSelectedState("normal")

				arg_511_1.keyicon_.color = Color.New(1, 1, 1)
				arg_511_1.icon_.color = Color.New(1, 1, 1)

				local var_514_1 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(1104702126).content)

				arg_511_1.text_.text = var_514_1

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_3 = 23 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 23)

				if (23 <= 0 and var_514_0 or var_514_0 * (utf8.len(var_514_1) / 23)) > 0 and var_514_0 < var_514_3 then
					arg_511_1.talkMaxDuration = var_514_3

					if var_514_3 + 0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_3 + 0
					end
				end

				arg_511_1.text_.text = var_514_1
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_4 = math.max(var_514_0, arg_511_1.talkMaxDuration)

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_4 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - 0) / var_514_4

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= 0 + var_514_4 and arg_511_1.time_ < 0 + var_514_4 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play1104702127 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1104702127
		arg_515_1.duration_ = 1.97

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1104702128(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = 0.175

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, true)
				arg_515_1.iconController_:SetSelectedState("hero")

				arg_515_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_515_1.callingController_:SetSelectedState("normal")

				arg_515_1.keyicon_.color = Color.New(1, 1, 1)
				arg_515_1.icon_.color = Color.New(1, 1, 1)

				local var_518_1 = arg_515_1:GetWordFromCfg(1104702127)
				local var_518_2 = arg_515_1:FormatText(var_518_1.content)

				arg_515_1.text_.text = var_518_2

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_4 = 7 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 7)

				if (7 <= 0 and var_518_0 or var_518_0 * (utf8.len(var_518_2) / 7)) > 0 and var_518_0 < var_518_4 then
					arg_515_1.talkMaxDuration = var_518_4

					if var_518_4 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_4 + 0
					end
				end

				arg_515_1.text_.text = var_518_2
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702127", "story_v_side_new_1104702.awb") ~= 0 then
					local var_518_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702127", "story_v_side_new_1104702.awb") / 1000

					if var_518_5 + 0 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_5 + 0
					end

					if var_518_1.prefab_name ~= "" and arg_515_1.actors_[var_518_1.prefab_name] ~= nil then
						local var_518_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_1.prefab_name].transform, "story_v_side_new_1104702", "1104702127", "story_v_side_new_1104702.awb")

						arg_515_1:RecordAudio("1104702127", var_518_6)
						arg_515_1:RecordAudio("1104702127", var_518_6)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702127", "story_v_side_new_1104702.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702127", "story_v_side_new_1104702.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_7 = math.max(var_518_0, arg_515_1.talkMaxDuration)

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_7 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - 0) / var_518_7

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= 0 + var_518_7 and arg_515_1.time_ < 0 + var_518_7 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {}

		arg_515_1:InitPlayNodeList()
	end,
	Play1104702128 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1104702128
		arg_519_1.duration_ = 8.67

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1104702129(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0.9

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, true)
				arg_519_1.iconController_:SetSelectedState("hero")

				arg_519_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_519_1.callingController_:SetSelectedState("normal")

				arg_519_1.keyicon_.color = Color.New(1, 1, 1)
				arg_519_1.icon_.color = Color.New(1, 1, 1)

				local var_522_1 = arg_519_1:GetWordFromCfg(1104702128)
				local var_522_2 = arg_519_1:FormatText(var_522_1.content)

				arg_519_1.text_.text = var_522_2

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_4 = 36 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_2) / 36)

				if (36 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_2) / 36)) > 0 and var_522_0 < var_522_4 then
					arg_519_1.talkMaxDuration = var_522_4

					if var_522_4 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_4 + 0
					end
				end

				arg_519_1.text_.text = var_522_2
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702128", "story_v_side_new_1104702.awb") ~= 0 then
					local var_522_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702128", "story_v_side_new_1104702.awb") / 1000

					if var_522_5 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_5 + 0
					end

					if var_522_1.prefab_name ~= "" and arg_519_1.actors_[var_522_1.prefab_name] ~= nil then
						local var_522_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_1.prefab_name].transform, "story_v_side_new_1104702", "1104702128", "story_v_side_new_1104702.awb")

						arg_519_1:RecordAudio("1104702128", var_522_6)
						arg_519_1:RecordAudio("1104702128", var_522_6)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702128", "story_v_side_new_1104702.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702128", "story_v_side_new_1104702.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_7 = math.max(var_522_0, arg_519_1.talkMaxDuration)

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_7 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - 0) / var_522_7

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= 0 + var_522_7 and arg_519_1.time_ < 0 + var_522_7 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1104702129 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1104702129
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1104702130(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 1.025

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_1 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(1104702129).content)

				arg_523_1.text_.text = var_526_1

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_3 = 41 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 41)

				if (41 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 41)) > 0 and var_526_0 < var_526_3 then
					arg_523_1.talkMaxDuration = var_526_3

					if var_526_3 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_3 + 0
					end
				end

				arg_523_1.text_.text = var_526_1
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_4 = math.max(var_526_0, arg_523_1.talkMaxDuration)

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - 0) / var_526_4

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1104702130 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1104702130
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1104702131(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0.925

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_1 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(1104702130).content)

				arg_527_1.text_.text = var_530_1

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_3 = 37 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 37)

				if (37 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 37)) > 0 and var_530_0 < var_530_3 then
					arg_527_1.talkMaxDuration = var_530_3

					if var_530_3 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_3 + 0
					end
				end

				arg_527_1.text_.text = var_530_1
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_4 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_4 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_4

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_4 and arg_527_1.time_ < 0 + var_530_4 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1104702131 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1104702131
		arg_531_1.duration_ = 10.27

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1104702132(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 1.35

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_531_1.callingController_:SetSelectedState("normal")

				arg_531_1.keyicon_.color = Color.New(1, 1, 1)
				arg_531_1.icon_.color = Color.New(1, 1, 1)

				local var_534_1 = arg_531_1:GetWordFromCfg(1104702131)
				local var_534_2 = arg_531_1:FormatText(var_534_1.content)

				arg_531_1.text_.text = var_534_2

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_4 = 53 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_2) / 53)

				if (53 <= 0 and var_534_0 or var_534_0 * (utf8.len(var_534_2) / 53)) > 0 and var_534_0 < var_534_4 then
					arg_531_1.talkMaxDuration = var_534_4

					if var_534_4 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_4 + 0
					end
				end

				arg_531_1.text_.text = var_534_2
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702131", "story_v_side_new_1104702.awb") ~= 0 then
					local var_534_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702131", "story_v_side_new_1104702.awb") / 1000

					if var_534_5 + 0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_5 + 0
					end

					if var_534_1.prefab_name ~= "" and arg_531_1.actors_[var_534_1.prefab_name] ~= nil then
						local var_534_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_1.prefab_name].transform, "story_v_side_new_1104702", "1104702131", "story_v_side_new_1104702.awb")

						arg_531_1:RecordAudio("1104702131", var_534_6)
						arg_531_1:RecordAudio("1104702131", var_534_6)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702131", "story_v_side_new_1104702.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702131", "story_v_side_new_1104702.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_7 = math.max(var_534_0, arg_531_1.talkMaxDuration)

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_7 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - 0) / var_534_7

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= 0 + var_534_7 and arg_531_1.time_ < 0 + var_534_7 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1104702132 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1104702132
		arg_535_1.duration_ = 1.17

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1104702133(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0.05

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_1 = arg_535_1:GetWordFromCfg(1104702132)
				local var_538_2 = arg_535_1:FormatText(var_538_1.content)

				arg_535_1.text_.text = var_538_2

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_4 = 2 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_2) / 2)

				if (2 <= 0 and var_538_0 or var_538_0 * (utf8.len(var_538_2) / 2)) > 0 and var_538_0 < var_538_4 then
					arg_535_1.talkMaxDuration = var_538_4

					if var_538_4 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_4 + 0
					end
				end

				arg_535_1.text_.text = var_538_2
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702132", "story_v_side_new_1104702.awb") ~= 0 then
					local var_538_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702132", "story_v_side_new_1104702.awb") / 1000

					if var_538_5 + 0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_5 + 0
					end

					if var_538_1.prefab_name ~= "" and arg_535_1.actors_[var_538_1.prefab_name] ~= nil then
						local var_538_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_535_1.actors_[var_538_1.prefab_name].transform, "story_v_side_new_1104702", "1104702132", "story_v_side_new_1104702.awb")

						arg_535_1:RecordAudio("1104702132", var_538_6)
						arg_535_1:RecordAudio("1104702132", var_538_6)
					else
						arg_535_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702132", "story_v_side_new_1104702.awb")
					end

					arg_535_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702132", "story_v_side_new_1104702.awb")
				end

				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_7 = math.max(var_538_0, arg_535_1.talkMaxDuration)

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_7 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - 0) / var_538_7

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= 0 + var_538_7 and arg_535_1.time_ < 0 + var_538_7 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play1104702133 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1104702133
		arg_539_1.duration_ = 9.5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1104702134(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 1.175

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_1 = arg_539_1:GetWordFromCfg(1104702133)
				local var_542_2 = arg_539_1:FormatText(var_542_1.content)

				arg_539_1.text_.text = var_542_2

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_4 = 47 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_2) / 47)

				if (47 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_2) / 47)) > 0 and var_542_0 < var_542_4 then
					arg_539_1.talkMaxDuration = var_542_4

					if var_542_4 + 0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_4 + 0
					end
				end

				arg_539_1.text_.text = var_542_2
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702133", "story_v_side_new_1104702.awb") ~= 0 then
					local var_542_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702133", "story_v_side_new_1104702.awb") / 1000

					if var_542_5 + 0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_5 + 0
					end

					if var_542_1.prefab_name ~= "" and arg_539_1.actors_[var_542_1.prefab_name] ~= nil then
						local var_542_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_539_1.actors_[var_542_1.prefab_name].transform, "story_v_side_new_1104702", "1104702133", "story_v_side_new_1104702.awb")

						arg_539_1:RecordAudio("1104702133", var_542_6)
						arg_539_1:RecordAudio("1104702133", var_542_6)
					else
						arg_539_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702133", "story_v_side_new_1104702.awb")
					end

					arg_539_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702133", "story_v_side_new_1104702.awb")
				end

				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_7 = math.max(var_542_0, arg_539_1.talkMaxDuration)

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_7 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - 0) / var_542_7

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= 0 + var_542_7 and arg_539_1.time_ < 0 + var_542_7 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1104702134 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1104702134
		arg_543_1.duration_ = 5

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1104702135(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = 0.575

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

				arg_543_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_543_1.callingController_:SetSelectedState("normal")

				arg_543_1.keyicon_.color = Color.New(1, 1, 1)
				arg_543_1.icon_.color = Color.New(1, 1, 1)

				local var_546_1 = arg_543_1:FormatText(arg_543_1:GetWordFromCfg(1104702134).content)

				arg_543_1.text_.text = var_546_1

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_3 = 23 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 23)

				if (23 <= 0 and var_546_0 or var_546_0 * (utf8.len(var_546_1) / 23)) > 0 and var_546_0 < var_546_3 then
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
	Play1104702135 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1104702135
		arg_547_1.duration_ = 2.67

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1104702136(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = 0.225

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[1518].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, true)
				arg_547_1.iconController_:SetSelectedState("hero")

				arg_547_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_newcomerwa")

				arg_547_1.callingController_:SetSelectedState("normal")

				arg_547_1.keyicon_.color = Color.New(1, 1, 1)
				arg_547_1.icon_.color = Color.New(1, 1, 1)

				local var_550_1 = arg_547_1:GetWordFromCfg(1104702135)
				local var_550_2 = arg_547_1:FormatText(var_550_1.content)

				arg_547_1.text_.text = var_550_2

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_4 = 9 <= 0 and var_550_0 or var_550_0 * (utf8.len(var_550_2) / 9)

				if (9 <= 0 and var_550_0 or var_550_0 * (utf8.len(var_550_2) / 9)) > 0 and var_550_0 < var_550_4 then
					arg_547_1.talkMaxDuration = var_550_4

					if var_550_4 + 0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_4 + 0
					end
				end

				arg_547_1.text_.text = var_550_2
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702135", "story_v_side_new_1104702.awb") ~= 0 then
					local var_550_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702135", "story_v_side_new_1104702.awb") / 1000

					if var_550_5 + 0 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_5 + 0
					end

					if var_550_1.prefab_name ~= "" and arg_547_1.actors_[var_550_1.prefab_name] ~= nil then
						local var_550_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_547_1.actors_[var_550_1.prefab_name].transform, "story_v_side_new_1104702", "1104702135", "story_v_side_new_1104702.awb")

						arg_547_1:RecordAudio("1104702135", var_550_6)
						arg_547_1:RecordAudio("1104702135", var_550_6)
					else
						arg_547_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702135", "story_v_side_new_1104702.awb")
					end

					arg_547_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702135", "story_v_side_new_1104702.awb")
				end

				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_7 = math.max(var_550_0, arg_547_1.talkMaxDuration)

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_7 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - 0) / var_550_7

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= 0 + var_550_7 and arg_547_1.time_ < 0 + var_550_7 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play1104702136 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1104702136
		arg_551_1.duration_ = 8.17

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1104702137(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0.875

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				arg_551_1.leftNameTxt_.text = arg_551_1:FormatText(StoryNameCfg[1516].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_1 = arg_551_1:GetWordFromCfg(1104702136)
				local var_554_2 = arg_551_1:FormatText(var_554_1.content)

				arg_551_1.text_.text = var_554_2

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_4 = 35 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_2) / 35)

				if (35 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_2) / 35)) > 0 and var_554_0 < var_554_4 then
					arg_551_1.talkMaxDuration = var_554_4

					if var_554_4 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_4 + 0
					end
				end

				arg_551_1.text_.text = var_554_2
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702136", "story_v_side_new_1104702.awb") ~= 0 then
					local var_554_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702136", "story_v_side_new_1104702.awb") / 1000

					if var_554_5 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_5 + 0
					end

					if var_554_1.prefab_name ~= "" and arg_551_1.actors_[var_554_1.prefab_name] ~= nil then
						local var_554_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_551_1.actors_[var_554_1.prefab_name].transform, "story_v_side_new_1104702", "1104702136", "story_v_side_new_1104702.awb")

						arg_551_1:RecordAudio("1104702136", var_554_6)
						arg_551_1:RecordAudio("1104702136", var_554_6)
					else
						arg_551_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702136", "story_v_side_new_1104702.awb")
					end

					arg_551_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702136", "story_v_side_new_1104702.awb")
				end

				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_7 = math.max(var_554_0, arg_551_1.talkMaxDuration)

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_7 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - 0) / var_554_7

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= 0 + var_554_7 and arg_551_1.time_ < 0 + var_554_7 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play1104702137 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1104702137
		arg_555_1.duration_ = 2.6

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play1104702138(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = 0.275

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[1517].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, true)
				arg_555_1.iconController_:SetSelectedState("hero")

				arg_555_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterw")

				arg_555_1.callingController_:SetSelectedState("normal")

				arg_555_1.keyicon_.color = Color.New(1, 1, 1)
				arg_555_1.icon_.color = Color.New(1, 1, 1)

				local var_558_1 = arg_555_1:GetWordFromCfg(1104702137)
				local var_558_2 = arg_555_1:FormatText(var_558_1.content)

				arg_555_1.text_.text = var_558_2

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_4 = 11 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_2) / 11)

				if (11 <= 0 and var_558_0 or var_558_0 * (utf8.len(var_558_2) / 11)) > 0 and var_558_0 < var_558_4 then
					arg_555_1.talkMaxDuration = var_558_4

					if var_558_4 + 0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_4 + 0
					end
				end

				arg_555_1.text_.text = var_558_2
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702137", "story_v_side_new_1104702.awb") ~= 0 then
					local var_558_5 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702137", "story_v_side_new_1104702.awb") / 1000

					if var_558_5 + 0 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_5 + 0
					end

					if var_558_1.prefab_name ~= "" and arg_555_1.actors_[var_558_1.prefab_name] ~= nil then
						local var_558_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_1.prefab_name].transform, "story_v_side_new_1104702", "1104702137", "story_v_side_new_1104702.awb")

						arg_555_1:RecordAudio("1104702137", var_558_6)
						arg_555_1:RecordAudio("1104702137", var_558_6)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702137", "story_v_side_new_1104702.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702137", "story_v_side_new_1104702.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_7 = math.max(var_558_0, arg_555_1.talkMaxDuration)

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_7 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - 0) / var_558_7

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= 0 + var_558_7 and arg_555_1.time_ < 0 + var_558_7 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {}

		arg_555_1:InitPlayNodeList()
	end,
	Play1104702138 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 1104702138
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play1104702139(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			local var_562_0 = 1

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, false)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_559_1.iconTrs_.gameObject, false)
				arg_559_1.callingController_:SetSelectedState("normal")

				local var_562_1 = arg_559_1:FormatText(arg_559_1:GetWordFromCfg(1104702138).content)

				arg_559_1.text_.text = var_562_1

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_3 = 40 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 40)

				if (40 <= 0 and var_562_0 or var_562_0 * (utf8.len(var_562_1) / 40)) > 0 and var_562_0 < var_562_3 then
					arg_559_1.talkMaxDuration = var_562_3

					if var_562_3 + 0 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_3 + 0
					end
				end

				arg_559_1.text_.text = var_562_1
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_4 = math.max(var_562_0, arg_559_1.talkMaxDuration)

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_4 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - 0) / var_562_4

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= 0 + var_562_4 and arg_559_1.time_ < 0 + var_562_4 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play1104702139 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 1104702139
		arg_563_1.duration_ = 5

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
			arg_563_1.auto_ = false
		end

		function arg_563_1.playNext_(arg_565_0)
			arg_563_1.onStoryFinished_()
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_566_1 = 0
			local var_566_2 = 0.4

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= var_566_1 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, true)
				arg_563_1.iconController_:SetSelectedState("hero")

				arg_563_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_563_1.callingController_:SetSelectedState("normal")

				arg_563_1.keyicon_.color = Color.New(1, 1, 1)
				arg_563_1.icon_.color = Color.New(1, 1, 1)

				local var_566_3 = arg_563_1:FormatText(arg_563_1:GetWordFromCfg(1104702139).content)

				arg_563_1.text_.text = var_566_3

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_5 = 16 <= 0 and var_566_2 or var_566_2 * (utf8.len(var_566_3) / 16)

				if (16 <= 0 and var_566_2 or var_566_2 * (utf8.len(var_566_3) / 16)) > 0 and var_566_2 < var_566_5 then
					arg_563_1.talkMaxDuration = var_566_5

					if var_566_5 + var_566_1 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_5 + var_566_1
					end
				end

				arg_563_1.text_.text = var_566_3
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)
				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_6 = math.max(var_566_2, arg_563_1.talkMaxDuration)

			if var_566_1 <= arg_563_1.time_ and arg_563_1.time_ < var_566_1 + var_566_6 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - var_566_1) / var_566_6

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= var_566_1 + var_566_6 and arg_563_1.time_ < var_566_1 + var_566_6 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play1104702063 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 1104702063
		arg_567_1.duration_ = 3.9

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play1104702064(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1.var_.moveOldPos1047ui_story = arg_567_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_570_0 = 0.001

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_0 then
				arg_567_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_567_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_567_1.time_ - 0) / var_570_0)
				arg_567_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_567_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_567_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_567_1.actors_["1047ui_story"].transform.position).z)
				arg_567_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_567_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_567_1.actors_["1047ui_story"].transform.localEulerAngles = arg_567_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_567_1.time_ >= 0 + var_570_0 and arg_567_1.time_ < 0 + var_570_0 + arg_570_0 then
				arg_567_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_567_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_567_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_567_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_567_1.actors_["1047ui_story"].transform.position).z)
				arg_567_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_567_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_567_1.actors_["1047ui_story"].transform.localEulerAngles = arg_567_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_570_1 = "1047ui_story"

			if arg_567_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_570_2 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_567_1.stage_.transform)

				var_570_2.name = var_570_1
				var_570_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_567_1.actors_[var_570_1] = var_570_2

				local var_570_3 = var_570_2:GetComponentInChildren(typeof(CharacterEffect))

				var_570_3.enabled = true

				local var_570_4 = GameObjectTools.GetOrAddComponent(var_570_2, typeof(DynamicBoneHelper))

				if var_570_4 then
					var_570_4:EnableDynamicBone(false)
				end

				arg_567_1:ShowWeapon(var_570_3.transform, false)

				arg_567_1.var_[var_570_1 .. "Animator"] = var_570_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_567_1.var_[var_570_1 .. "Animator"].applyRootMotion = true
				arg_567_1.var_[var_570_1 .. "LipSync"] = var_570_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action9_2")
			end

			local var_570_5 = "1047ui_story"

			if arg_567_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_570_6 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_567_1.stage_.transform)

				var_570_6.name = var_570_5
				var_570_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_567_1.actors_[var_570_5] = var_570_6

				local var_570_7 = var_570_6:GetComponentInChildren(typeof(CharacterEffect))

				var_570_7.enabled = true

				local var_570_8 = GameObjectTools.GetOrAddComponent(var_570_6, typeof(DynamicBoneHelper))

				if var_570_8 then
					var_570_8:EnableDynamicBone(false)
				end

				arg_567_1:ShowWeapon(var_570_7.transform, false)

				arg_567_1.var_[var_570_5 .. "Animator"] = var_570_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_567_1.var_[var_570_5 .. "Animator"].applyRootMotion = true
				arg_567_1.var_[var_570_5 .. "LipSync"] = var_570_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_570_9 = 0
			local var_570_10 = 0.325

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_9 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_11 = arg_567_1:GetWordFromCfg(1104702063)
				local var_570_12 = arg_567_1:FormatText(var_570_11.content)

				arg_567_1.text_.text = var_570_12

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_14 = 13 <= 0 and var_570_10 or var_570_10 * (utf8.len(var_570_12) / 13)

				if (13 <= 0 and var_570_10 or var_570_10 * (utf8.len(var_570_12) / 13)) > 0 and var_570_10 < var_570_14 then
					arg_567_1.talkMaxDuration = var_570_14

					if var_570_14 + var_570_9 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_14 + var_570_9
					end
				end

				arg_567_1.text_.text = var_570_12
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702063", "story_v_side_new_1104702.awb") ~= 0 then
					local var_570_15 = manager.audio:GetVoiceLength("story_v_side_new_1104702", "1104702063", "story_v_side_new_1104702.awb") / 1000

					if var_570_15 + var_570_9 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_15 + var_570_9
					end

					if var_570_11.prefab_name ~= "" and arg_567_1.actors_[var_570_11.prefab_name] ~= nil then
						local var_570_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_11.prefab_name].transform, "story_v_side_new_1104702", "1104702063", "story_v_side_new_1104702.awb")

						arg_567_1:RecordAudio("1104702063", var_570_16)
						arg_567_1:RecordAudio("1104702063", var_570_16)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_side_new_1104702", "1104702063", "story_v_side_new_1104702.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_side_new_1104702", "1104702063", "story_v_side_new_1104702.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_17 = math.max(var_570_10, arg_567_1.talkMaxDuration)

			if var_570_9 <= arg_567_1.time_ and arg_567_1.time_ < var_570_9 + var_570_17 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_9) / var_570_17

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_9 + var_570_17 and arg_567_1.time_ < var_570_9 + var_570_17 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {
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

		arg_567_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST27a",
		"TextureConfig/Background/ST84a",
		"TextureConfig/Background/ST28",
		"TextureConfig/Background/H07g",
		"TextureConfig/Background/H07h"
	},
	voices = {
		"story_v_side_new_1104702.awb"
	}
}
