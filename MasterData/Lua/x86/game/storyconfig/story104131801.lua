return {
	Play413181001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413181001
		arg_1_1.duration_ = 8.87

		local var_1_0 = {
			zh = 6.632999999999,
			ja = 8.865999999999
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
				arg_1_0:Play413181002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F08l == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08l")
				var_4_0.name = "F08l"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F08l = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F08l

				arg_1_1.bgs_.F08l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F08l" then
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

			if 1.26666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.26666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			local var_4_15 = 1.999999999999
			local var_4_16 = 0.325

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
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

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(413181001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 13 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 13)

				if (13 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 13)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181001", "story_v_out_413181.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_413181", "413181001", "story_v_out_413181.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_413181", "413181001", "story_v_out_413181.awb")

						arg_1_1:RecordAudio("413181001", var_4_23)
						arg_1_1:RecordAudio("413181001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413181", "413181001", "story_v_out_413181.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413181", "413181001", "story_v_out_413181.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play413181002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413181002
		arg_9_1.duration_ = 10.2

		local var_9_0 = {
			zh = 7.966,
			ja = 10.2
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
				arg_9_0:Play413181003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.525

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

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(413181002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 21 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 21)

				if (21 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 21)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181002", "story_v_out_413181.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_413181", "413181002", "story_v_out_413181.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_413181", "413181002", "story_v_out_413181.awb")

						arg_9_1:RecordAudio("413181002", var_12_6)
						arg_9_1:RecordAudio("413181002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413181", "413181002", "story_v_out_413181.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413181", "413181002", "story_v_out_413181.awb")
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
	Play413181003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413181003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play413181004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.95

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(413181003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 38 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 38)

				if (38 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 38)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play413181004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413181004
		arg_17_1.duration_ = 5.7

		local var_17_0 = {
			zh = 4.333,
			ja = 5.7
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play413181005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["10097"] == nil then
				local var_20_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10097")

				if not isNil(var_20_0) then
					local var_20_1 = Object.Instantiate(var_20_0, arg_17_1.canvasGo_.transform)

					var_20_1.transform:SetSiblingIndex(1)

					var_20_1.name = "10097"
					var_20_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_["10097"] = var_20_1

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs((var_20_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_2 = arg_17_1.actors_["10097"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10097 = var_20_2.localPosition
				var_20_2.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10097", 3)

				for iter_20_2 = 0, var_20_2.childCount - 1 do
					local var_20_3 = var_20_2:GetChild(iter_20_2)

					if var_20_3.name == "split_3" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_2.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_17_1.time_ - 0) / var_20_4)
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_20_5 = arg_17_1.actors_["10097"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps10097 == nil then
				arg_17_1.var_.actorSpriteComps10097 = var_20_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_6 = 2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.actorSpriteComps10097 then
					for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_20_4 then
							if arg_17_1.isInRecall_ then
								iter_20_4.color = Color.New(Mathf.Lerp(iter_20_4.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_6), Mathf.Lerp(iter_20_4.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_6), (Mathf.Lerp(iter_20_4.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_6)))
							else
								local var_20_7 = Mathf.Lerp(iter_20_4.color.r, 1, (arg_17_1.time_ - 0) / var_20_6)

								iter_20_4.color = Color.New(var_20_7, var_20_7, var_20_7)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.actorSpriteComps10097 then
				for iter_20_5, iter_20_6 in pairs(arg_17_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_20_6 then
						iter_20_6.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10097 = nil
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				local var_20_8 = arg_17_1.actors_["10097"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_20_8 then
					arg_17_1.var_.alphaOldValue10097 = var_20_8.alpha
					arg_17_1.var_.characterEffect10097 = var_20_8
				end

				arg_17_1.var_.alphaOldValue10097 = 0
			end

			local var_20_9 = 0.5

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 then
				if arg_17_1.var_.characterEffect10097 then
					arg_17_1.var_.characterEffect10097.alpha = Mathf.Lerp(arg_17_1.var_.alphaOldValue10097, 1, (arg_17_1.time_ - 0) / var_20_9)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 and arg_17_1.var_.characterEffect10097 then
				arg_17_1.var_.characterEffect10097.alpha = 1
			end

			local var_20_10 = 0
			local var_20_11 = 0.2

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_12 = arg_17_1:GetWordFromCfg(413181004)
				local var_20_13 = arg_17_1:FormatText(var_20_12.content)

				arg_17_1.text_.text = var_20_13

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_15 = 8 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 8)

				if (8 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 8)) > 0 and var_20_11 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_13
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181004", "story_v_out_413181.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_413181", "413181004", "story_v_out_413181.awb") / 1000

					if var_20_16 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_10
					end

					if var_20_12.prefab_name ~= "" and arg_17_1.actors_[var_20_12.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_12.prefab_name].transform, "story_v_out_413181", "413181004", "story_v_out_413181.awb")

						arg_17_1:RecordAudio("413181004", var_20_17)
						arg_17_1:RecordAudio("413181004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413181", "413181004", "story_v_out_413181.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413181", "413181004", "story_v_out_413181.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_18 = math.max(var_20_11, arg_17_1.talkMaxDuration)

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_18 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_10) / var_20_18

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_10 + var_20_18 and arg_17_1.time_ < var_20_10 + var_20_18 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play413181005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413181005
		arg_21_1.duration_ = 8.9

		local var_21_0 = {
			zh = 8.9,
			ja = 7.766
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play413181006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10097"]) and arg_21_1.var_.actorSpriteComps10097 == nil then
				arg_21_1.var_.actorSpriteComps10097 = arg_21_1.actors_["10097"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10097"]) then
				if arg_21_1.var_.actorSpriteComps10097 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								iter_24_1.color = Color.New(Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_0), Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_0), (Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_0)))
							else
								local var_24_1 = Mathf.Lerp(iter_24_1.color.r, 1, (arg_21_1.time_ - 0) / var_24_0)

								iter_24_1.color = Color.New(var_24_1, var_24_1, var_24_1)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10097"]) and arg_21_1.var_.actorSpriteComps10097 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10097 = nil
			end

			local var_24_2 = 0
			local var_24_3 = 0.5

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(413181005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 20 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 20)

				if (20 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 20)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181005", "story_v_out_413181.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_413181", "413181005", "story_v_out_413181.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_413181", "413181005", "story_v_out_413181.awb")

						arg_21_1:RecordAudio("413181005", var_24_9)
						arg_21_1:RecordAudio("413181005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413181", "413181005", "story_v_out_413181.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413181", "413181005", "story_v_out_413181.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play413181006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413181006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play413181007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10097 = arg_25_1.actors_["10097"].transform.localPosition
				arg_25_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10097", 6)

				for iter_28_0 = 0, arg_25_1.actors_["10097"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["10097"].transform:GetChild(iter_28_0)

					if var_28_0.name == "" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10097, Vector3.New(1500, -350, -180), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["10097"].transform.localPosition = Vector3.New(1500, -350, -180)
			end

			local var_28_2 = arg_25_1.actors_["10097"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10097 == nil then
				arg_25_1.var_.actorSpriteComps10097 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps10097 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_28_2 then
							if arg_25_1.isInRecall_ then
								iter_28_2.color = Color.New(Mathf.Lerp(iter_28_2.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_3), Mathf.Lerp(iter_28_2.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_3), (Mathf.Lerp(iter_28_2.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_3)))
							else
								local var_28_4 = Mathf.Lerp(iter_28_2.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_3)

								iter_28_2.color = Color.New(var_28_4, var_28_4, var_28_4)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10097 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_28_4 then
						iter_28_4.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps10097 = nil
			end

			local var_28_5 = 0
			local var_28_6 = 1.25

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(413181006).content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 50 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_7) / 50)

				if (50 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_7) / 50)) > 0 and var_28_6 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_10 = math.max(var_28_6, arg_25_1.talkMaxDuration)

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_10 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_5) / var_28_10

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_5 + var_28_10 and arg_25_1.time_ < var_28_5 + var_28_10 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play413181007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413181007
		arg_29_1.duration_ = 12.43

		local var_29_0 = {
			zh = 11.2,
			ja = 12.433
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play413181008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["10095"] == nil then
				local var_32_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10095")

				if not isNil(var_32_0) then
					local var_32_1 = Object.Instantiate(var_32_0, arg_29_1.canvasGo_.transform)

					var_32_1.transform:SetSiblingIndex(1)

					var_32_1.name = "10095"
					var_32_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_29_1.actors_["10095"] = var_32_1

					if arg_29_1.isInRecall_ then
						for iter_32_0, iter_32_1 in ipairs((var_32_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_32_1.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_32_2 = arg_29_1.actors_["10095"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10095 = var_32_2.localPosition
				var_32_2.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10095", 3)

				for iter_32_2 = 0, var_32_2.childCount - 1 do
					local var_32_3 = var_32_2:GetChild(iter_32_2)

					if var_32_3.name == "split_1_1" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_2.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10095, Vector3.New(0, -405, -10), (arg_29_1.time_ - 0) / var_32_4)
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_2.localPosition = Vector3.New(0, -405, -10)
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				local var_32_5 = arg_29_1.actors_["10095"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_32_5 then
					arg_29_1.var_.alphaOldValue10095 = var_32_5.alpha
					arg_29_1.var_.characterEffect10095 = var_32_5
				end

				arg_29_1.var_.alphaOldValue10095 = 0
			end

			local var_32_6 = 0.5

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 then
				if arg_29_1.var_.characterEffect10095 then
					arg_29_1.var_.characterEffect10095.alpha = Mathf.Lerp(arg_29_1.var_.alphaOldValue10095, 1, (arg_29_1.time_ - 0) / var_32_6)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and arg_29_1.var_.characterEffect10095 then
				arg_29_1.var_.characterEffect10095.alpha = 1
			end

			local var_32_7 = 0
			local var_32_8 = 0.775

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1013].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:GetWordFromCfg(413181007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_12 = 31 <= 0 and var_32_8 or var_32_8 * (utf8.len(var_32_10) / 31)

				if (31 <= 0 and var_32_8 or var_32_8 * (utf8.len(var_32_10) / 31)) > 0 and var_32_8 < var_32_12 then
					arg_29_1.talkMaxDuration = var_32_12

					if var_32_12 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_7
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181007", "story_v_out_413181.awb") ~= 0 then
					local var_32_13 = manager.audio:GetVoiceLength("story_v_out_413181", "413181007", "story_v_out_413181.awb") / 1000

					if var_32_13 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_7
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_out_413181", "413181007", "story_v_out_413181.awb")

						arg_29_1:RecordAudio("413181007", var_32_14)
						arg_29_1:RecordAudio("413181007", var_32_14)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413181", "413181007", "story_v_out_413181.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413181", "413181007", "story_v_out_413181.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_15 = math.max(var_32_8, arg_29_1.talkMaxDuration)

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_15 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_7) / var_32_15

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_7 + var_32_15 and arg_29_1.time_ < var_32_7 + var_32_15 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play413181008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413181008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play413181009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10095 = arg_33_1.actors_["10095"].transform.localPosition
				arg_33_1.actors_["10095"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10095", 7)

				for iter_36_0 = 0, arg_33_1.actors_["10095"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["10095"].transform:GetChild(iter_36_0)

					if var_36_0.name == "split_1_1" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["10095"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10095, Vector3.New(0, -2000, 0), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["10095"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_36_2 = 0
			local var_36_3 = 0.85

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_4 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(413181008).content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 34 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 34)

				if (34 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 34)) > 0 and var_36_3 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_7 and arg_33_1.time_ < var_36_2 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play413181009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413181009
		arg_37_1.duration_ = 8.73

		local var_37_0 = {
			zh = 8,
			ja = 8.733
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play413181010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.bgs_.ST0601 == nil then
				local var_40_0 = Object.Instantiate(arg_37_1.paintGo_)

				var_40_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0601")
				var_40_0.name = "ST0601"
				var_40_0.transform.parent = arg_37_1.stage_.transform
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.bgs_.ST0601 = var_40_0
			end

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				local var_40_1 = arg_37_1.bgs_.ST0601

				arg_37_1.bgs_.ST0601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_2 = var_40_1:GetComponent("SpriteRenderer")

				if var_40_2 and var_40_2.sprite then
					local var_40_3 = 2 * (var_40_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_1.transform.localScale = Vector3.New(var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "ST0601" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_4 = 4

			if 4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			if arg_37_1.time_ >= var_40_4 + 0.3 and arg_37_1.time_ < var_40_4 + 0.3 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end

			local var_40_5 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_6 = 2

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_6 then
				local var_40_7 = Color.New(0, 0, 0)

				var_40_7.a = Mathf.Lerp(0, 1, (arg_37_1.time_ - var_40_5) / var_40_6)
				arg_37_1.mask_.color = var_40_7
			end

			if arg_37_1.time_ >= var_40_5 + var_40_6 and arg_37_1.time_ < var_40_5 + var_40_6 + arg_40_0 then
				local var_40_8 = Color.New(0, 0, 0)

				var_40_8.a = 1
				arg_37_1.mask_.color = var_40_8
			end

			local var_40_9 = 2

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_10 = 2

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_10 then
				local var_40_11 = Color.New(0, 0, 0)

				var_40_11.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_9) / var_40_10)
				arg_37_1.mask_.color = var_40_11
			end

			if arg_37_1.time_ >= var_40_9 + var_40_10 and arg_37_1.time_ < var_40_9 + var_40_10 + arg_40_0 then
				local var_40_12 = Color.New(0, 0, 0)

				arg_37_1.mask_.enabled = false
				var_40_12.a = 0
				arg_37_1.mask_.color = var_40_12
			end

			local var_40_13 = arg_37_1.actors_["10095"].transform

			if 3.675 < arg_37_1.time_ and arg_37_1.time_ <= 3.675 + arg_40_0 then
				arg_37_1.var_.moveOldPos10095 = var_40_13.localPosition
				var_40_13.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10095", 3)

				for iter_40_2 = 0, var_40_13.childCount - 1 do
					local var_40_14 = var_40_13:GetChild(iter_40_2)

					if var_40_14.name == "" or not string.find(var_40_14.name, "split") then
						var_40_14.gameObject:SetActive(true)
					else
						var_40_14.gameObject:SetActive(false)
					end
				end
			end

			local var_40_15 = 0.001

			if 3.675 <= arg_37_1.time_ and arg_37_1.time_ < 3.675 + var_40_15 then
				var_40_13.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10095, Vector3.New(0, -405, -10), (arg_37_1.time_ - 3.675) / var_40_15)
			end

			if arg_37_1.time_ >= 3.675 + var_40_15 and arg_37_1.time_ < 3.675 + var_40_15 + arg_40_0 then
				var_40_13.localPosition = Vector3.New(0, -405, -10)
			end

			local var_40_16 = arg_37_1.actors_["10095"]

			if 3.675 < arg_37_1.time_ and arg_37_1.time_ <= 3.675 + arg_40_0 and not isNil(var_40_16) and arg_37_1.var_.actorSpriteComps10095 == nil then
				arg_37_1.var_.actorSpriteComps10095 = var_40_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_17 = 2

			if 3.675 <= arg_37_1.time_ and arg_37_1.time_ < 3.675 + var_40_17 and not isNil(var_40_16) then
				if arg_37_1.var_.actorSpriteComps10095 then
					for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_40_4 then
							if arg_37_1.isInRecall_ then
								iter_40_4.color = Color.New(Mathf.Lerp(iter_40_4.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 3.675) / var_40_17), Mathf.Lerp(iter_40_4.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 3.675) / var_40_17), (Mathf.Lerp(iter_40_4.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 3.675) / var_40_17)))
							else
								local var_40_18 = Mathf.Lerp(iter_40_4.color.r, 1, (arg_37_1.time_ - 3.675) / var_40_17)

								iter_40_4.color = Color.New(var_40_18, var_40_18, var_40_18)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 3.675 + var_40_17 and arg_37_1.time_ < 3.675 + var_40_17 + arg_40_0 and not isNil(var_40_16) and arg_37_1.var_.actorSpriteComps10095 then
				for iter_40_5, iter_40_6 in pairs(arg_37_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_40_6 then
						iter_40_6.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10095 = nil
			end

			if 3.675 < arg_37_1.time_ and arg_37_1.time_ <= 3.675 + arg_40_0 then
				local var_40_19 = arg_37_1.actors_["10095"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_40_19 then
					arg_37_1.var_.alphaOldValue10095 = var_40_19.alpha
					arg_37_1.var_.characterEffect10095 = var_40_19
				end

				arg_37_1.var_.alphaOldValue10095 = 0
			end

			local var_40_20 = 0.2

			if 3.675 <= arg_37_1.time_ and arg_37_1.time_ < 3.675 + var_40_20 then
				if arg_37_1.var_.characterEffect10095 then
					arg_37_1.var_.characterEffect10095.alpha = Mathf.Lerp(arg_37_1.var_.alphaOldValue10095, 1, (arg_37_1.time_ - 3.675) / var_40_20)
				end
			end

			if arg_37_1.time_ >= 3.675 + var_40_20 and arg_37_1.time_ < 3.675 + var_40_20 + arg_40_0 and arg_37_1.var_.characterEffect10095 then
				arg_37_1.var_.characterEffect10095.alpha = 1
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_21 = 4
			local var_40_22 = 0.325

			if 4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_21 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_23 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_23:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1013].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_24 = arg_37_1:GetWordFromCfg(413181009)
				local var_40_25 = arg_37_1:FormatText(var_40_24.content)

				arg_37_1.text_.text = var_40_25

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_27 = 13 <= 0 and var_40_22 or var_40_22 * (utf8.len(var_40_25) / 13)

				if (13 <= 0 and var_40_22 or var_40_22 * (utf8.len(var_40_25) / 13)) > 0 and var_40_22 < var_40_27 then
					arg_37_1.talkMaxDuration = var_40_27
					var_40_21 = var_40_21 + 0.3

					if var_40_27 + var_40_21 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_27 + var_40_21
					end
				end

				arg_37_1.text_.text = var_40_25
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181009", "story_v_out_413181.awb") ~= 0 then
					local var_40_28 = manager.audio:GetVoiceLength("story_v_out_413181", "413181009", "story_v_out_413181.awb") / 1000

					if var_40_28 + var_40_21 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_28 + var_40_21
					end

					if var_40_24.prefab_name ~= "" and arg_37_1.actors_[var_40_24.prefab_name] ~= nil then
						local var_40_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_24.prefab_name].transform, "story_v_out_413181", "413181009", "story_v_out_413181.awb")

						arg_37_1:RecordAudio("413181009", var_40_29)
						arg_37_1:RecordAudio("413181009", var_40_29)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413181", "413181009", "story_v_out_413181.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413181", "413181009", "story_v_out_413181.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_30 = var_40_21 + 0.3
			local var_40_31 = math.max(var_40_22, arg_37_1.talkMaxDuration)

			if var_40_21 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_30 + var_40_31 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_30) / var_40_31

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_30 + var_40_31 and arg_37_1.time_ < var_40_30 + var_40_31 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.675,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play413181010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 413181010
		arg_43_1.duration_ = 20.6

		local var_43_0 = {
			zh = 16.033,
			ja = 20.6
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play413181011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["10095"]) and arg_43_1.var_.actorSpriteComps10095 == nil then
				arg_43_1.var_.actorSpriteComps10095 = arg_43_1.actors_["10095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_0 = 2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["10095"]) then
				if arg_43_1.var_.actorSpriteComps10095 then
					for iter_46_0, iter_46_1 in pairs(arg_43_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_46_1 then
							if arg_43_1.isInRecall_ then
								iter_46_1.color = Color.New(Mathf.Lerp(iter_46_1.color.r, arg_43_1.hightColor2.r, (arg_43_1.time_ - 0) / var_46_0), Mathf.Lerp(iter_46_1.color.g, arg_43_1.hightColor2.g, (arg_43_1.time_ - 0) / var_46_0), (Mathf.Lerp(iter_46_1.color.b, arg_43_1.hightColor2.b, (arg_43_1.time_ - 0) / var_46_0)))
							else
								local var_46_1 = Mathf.Lerp(iter_46_1.color.r, 0.5, (arg_43_1.time_ - 0) / var_46_0)

								iter_46_1.color = Color.New(var_46_1, var_46_1, var_46_1)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["10095"]) and arg_43_1.var_.actorSpriteComps10095 then
				for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_46_3 then
						iter_46_3.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_43_1.var_.actorSpriteComps10095 = nil
			end

			local var_46_2 = arg_43_1.actors_["10095"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10095 = var_46_2.localPosition
				var_46_2.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10095", 2)

				for iter_46_4 = 0, var_46_2.childCount - 1 do
					local var_46_3 = var_46_2:GetChild(iter_46_4)

					if var_46_3.name == "" or not string.find(var_46_3.name, "split") then
						var_46_3.gameObject:SetActive(true)
					else
						var_46_3.gameObject:SetActive(false)
					end
				end
			end

			local var_46_4 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				var_46_2.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10095, Vector3.New(-390, -405, -10), (arg_43_1.time_ - 0) / var_46_4)
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				var_46_2.localPosition = Vector3.New(-390, -405, -10)
			end

			local var_46_5 = "10096"

			if arg_43_1.actors_["10096"] == nil then
				local var_46_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10096")

				if not isNil(var_46_6) then
					local var_46_7 = Object.Instantiate(var_46_6, arg_43_1.canvasGo_.transform)

					var_46_7.transform:SetSiblingIndex(1)

					var_46_7.name = var_46_5
					var_46_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_43_1.actors_[var_46_5] = var_46_7

					if arg_43_1.isInRecall_ then
						for iter_46_5, iter_46_6 in ipairs((var_46_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_46_6.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_46_8 = arg_43_1.actors_["10096"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos10096 = var_46_8.localPosition
				var_46_8.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10096", 4)

				for iter_46_7 = 0, var_46_8.childCount - 1 do
					local var_46_9 = var_46_8:GetChild(iter_46_7)

					if var_46_9.name == "" or not string.find(var_46_9.name, "split") then
						var_46_9.gameObject:SetActive(true)
					else
						var_46_9.gameObject:SetActive(false)
					end
				end
			end

			local var_46_10 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_10 then
				var_46_8.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10096, Vector3.New(390, -350, -210), (arg_43_1.time_ - 0) / var_46_10)
			end

			if arg_43_1.time_ >= 0 + var_46_10 and arg_43_1.time_ < 0 + var_46_10 + arg_46_0 then
				var_46_8.localPosition = Vector3.New(390, -350, -210)
			end

			local var_46_11 = arg_43_1.actors_["10096"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_11) and arg_43_1.var_.actorSpriteComps10096 == nil then
				arg_43_1.var_.actorSpriteComps10096 = var_46_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_12 = 2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_12 and not isNil(var_46_11) then
				if arg_43_1.var_.actorSpriteComps10096 then
					for iter_46_8, iter_46_9 in pairs(arg_43_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_46_9 then
							if arg_43_1.isInRecall_ then
								iter_46_9.color = Color.New(Mathf.Lerp(iter_46_9.color.r, arg_43_1.hightColor1.r, (arg_43_1.time_ - 0) / var_46_12), Mathf.Lerp(iter_46_9.color.g, arg_43_1.hightColor1.g, (arg_43_1.time_ - 0) / var_46_12), (Mathf.Lerp(iter_46_9.color.b, arg_43_1.hightColor1.b, (arg_43_1.time_ - 0) / var_46_12)))
							else
								local var_46_13 = Mathf.Lerp(iter_46_9.color.r, 1, (arg_43_1.time_ - 0) / var_46_12)

								iter_46_9.color = Color.New(var_46_13, var_46_13, var_46_13)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_12 and arg_43_1.time_ < 0 + var_46_12 + arg_46_0 and not isNil(var_46_11) and arg_43_1.var_.actorSpriteComps10096 then
				for iter_46_10, iter_46_11 in pairs(arg_43_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_46_11 then
						iter_46_11.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_43_1.var_.actorSpriteComps10096 = nil
			end

			local var_46_14 = 0
			local var_46_15 = 1.1

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_14 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_16 = arg_43_1:GetWordFromCfg(413181010)
				local var_46_17 = arg_43_1:FormatText(var_46_16.content)

				arg_43_1.text_.text = var_46_17

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_19 = 44 <= 0 and var_46_15 or var_46_15 * (utf8.len(var_46_17) / 44)

				if (44 <= 0 and var_46_15 or var_46_15 * (utf8.len(var_46_17) / 44)) > 0 and var_46_15 < var_46_19 then
					arg_43_1.talkMaxDuration = var_46_19

					if var_46_19 + var_46_14 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_19 + var_46_14
					end
				end

				arg_43_1.text_.text = var_46_17
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181010", "story_v_out_413181.awb") ~= 0 then
					local var_46_20 = manager.audio:GetVoiceLength("story_v_out_413181", "413181010", "story_v_out_413181.awb") / 1000

					if var_46_20 + var_46_14 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_20 + var_46_14
					end

					if var_46_16.prefab_name ~= "" and arg_43_1.actors_[var_46_16.prefab_name] ~= nil then
						local var_46_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_16.prefab_name].transform, "story_v_out_413181", "413181010", "story_v_out_413181.awb")

						arg_43_1:RecordAudio("413181010", var_46_21)
						arg_43_1:RecordAudio("413181010", var_46_21)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_413181", "413181010", "story_v_out_413181.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_413181", "413181010", "story_v_out_413181.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_22 = math.max(var_46_15, arg_43_1.talkMaxDuration)

			if var_46_14 <= arg_43_1.time_ and arg_43_1.time_ < var_46_14 + var_46_22 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_14) / var_46_22

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_14 + var_46_22 and arg_43_1.time_ < var_46_14 + var_46_22 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play413181011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 413181011
		arg_47_1.duration_ = 6.3

		local var_47_0 = {
			zh = 6.3,
			ja = 5.466
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play413181012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10095 = arg_47_1.actors_["10095"].transform.localPosition
				arg_47_1.actors_["10095"].transform.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10095", 2)

				for iter_50_0 = 0, arg_47_1.actors_["10095"].transform.childCount - 1 do
					local var_50_0 = arg_47_1.actors_["10095"].transform:GetChild(iter_50_0)

					if var_50_0.name == "split_1_1" or not string.find(var_50_0.name, "split") then
						var_50_0.gameObject:SetActive(true)
					else
						var_50_0.gameObject:SetActive(false)
					end
				end
			end

			local var_50_1 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 then
				arg_47_1.actors_["10095"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10095, Vector3.New(-390, -405, -10), (arg_47_1.time_ - 0) / var_50_1)
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 then
				arg_47_1.actors_["10095"].transform.localPosition = Vector3.New(-390, -405, -10)
			end

			local var_50_2 = arg_47_1.actors_["10095"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps10095 == nil then
				arg_47_1.var_.actorSpriteComps10095 = var_50_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_3 = 2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.actorSpriteComps10095 then
					for iter_50_1, iter_50_2 in pairs(arg_47_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_50_2 then
							if arg_47_1.isInRecall_ then
								iter_50_2.color = Color.New(Mathf.Lerp(iter_50_2.color.r, arg_47_1.hightColor1.r, (arg_47_1.time_ - 0) / var_50_3), Mathf.Lerp(iter_50_2.color.g, arg_47_1.hightColor1.g, (arg_47_1.time_ - 0) / var_50_3), (Mathf.Lerp(iter_50_2.color.b, arg_47_1.hightColor1.b, (arg_47_1.time_ - 0) / var_50_3)))
							else
								local var_50_4 = Mathf.Lerp(iter_50_2.color.r, 1, (arg_47_1.time_ - 0) / var_50_3)

								iter_50_2.color = Color.New(var_50_4, var_50_4, var_50_4)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.actorSpriteComps10095 then
				for iter_50_3, iter_50_4 in pairs(arg_47_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_50_4 then
						iter_50_4.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_47_1.var_.actorSpriteComps10095 = nil
			end

			local var_50_5 = arg_47_1.actors_["10096"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_5) and arg_47_1.var_.actorSpriteComps10096 == nil then
				arg_47_1.var_.actorSpriteComps10096 = var_50_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_6 = 2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_6 and not isNil(var_50_5) then
				if arg_47_1.var_.actorSpriteComps10096 then
					for iter_50_5, iter_50_6 in pairs(arg_47_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_50_6 then
							if arg_47_1.isInRecall_ then
								iter_50_6.color = Color.New(Mathf.Lerp(iter_50_6.color.r, arg_47_1.hightColor2.r, (arg_47_1.time_ - 0) / var_50_6), Mathf.Lerp(iter_50_6.color.g, arg_47_1.hightColor2.g, (arg_47_1.time_ - 0) / var_50_6), (Mathf.Lerp(iter_50_6.color.b, arg_47_1.hightColor2.b, (arg_47_1.time_ - 0) / var_50_6)))
							else
								local var_50_7 = Mathf.Lerp(iter_50_6.color.r, 0.5, (arg_47_1.time_ - 0) / var_50_6)

								iter_50_6.color = Color.New(var_50_7, var_50_7, var_50_7)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_6 and arg_47_1.time_ < 0 + var_50_6 + arg_50_0 and not isNil(var_50_5) and arg_47_1.var_.actorSpriteComps10096 then
				for iter_50_7, iter_50_8 in pairs(arg_47_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_50_8 then
						iter_50_8.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_47_1.var_.actorSpriteComps10096 = nil
			end

			local var_50_8 = 0
			local var_50_9 = 0.6

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[1013].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:GetWordFromCfg(413181011)
				local var_50_11 = arg_47_1:FormatText(var_50_10.content)

				arg_47_1.text_.text = var_50_11

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 24 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 24)

				if (24 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 24)) > 0 and var_50_9 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_11
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181011", "story_v_out_413181.awb") ~= 0 then
					local var_50_14 = manager.audio:GetVoiceLength("story_v_out_413181", "413181011", "story_v_out_413181.awb") / 1000

					if var_50_14 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_8
					end

					if var_50_10.prefab_name ~= "" and arg_47_1.actors_[var_50_10.prefab_name] ~= nil then
						local var_50_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_10.prefab_name].transform, "story_v_out_413181", "413181011", "story_v_out_413181.awb")

						arg_47_1:RecordAudio("413181011", var_50_15)
						arg_47_1:RecordAudio("413181011", var_50_15)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_413181", "413181011", "story_v_out_413181.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_413181", "413181011", "story_v_out_413181.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_16 and arg_47_1.time_ < var_50_8 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play413181012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 413181012
		arg_51_1.duration_ = 24.1

		local var_51_0 = {
			zh = 13.566,
			ja = 24.1
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
				arg_51_0:Play413181013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["10095"]) and arg_51_1.var_.actorSpriteComps10095 == nil then
				arg_51_1.var_.actorSpriteComps10095 = arg_51_1.actors_["10095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_0 = 2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["10095"]) then
				if arg_51_1.var_.actorSpriteComps10095 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_54_1 then
							if arg_51_1.isInRecall_ then
								iter_54_1.color = Color.New(Mathf.Lerp(iter_54_1.color.r, arg_51_1.hightColor2.r, (arg_51_1.time_ - 0) / var_54_0), Mathf.Lerp(iter_54_1.color.g, arg_51_1.hightColor2.g, (arg_51_1.time_ - 0) / var_54_0), (Mathf.Lerp(iter_54_1.color.b, arg_51_1.hightColor2.b, (arg_51_1.time_ - 0) / var_54_0)))
							else
								local var_54_1 = Mathf.Lerp(iter_54_1.color.r, 0.5, (arg_51_1.time_ - 0) / var_54_0)

								iter_54_1.color = Color.New(var_54_1, var_54_1, var_54_1)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["10095"]) and arg_51_1.var_.actorSpriteComps10095 then
				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_54_3 then
						iter_54_3.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_51_1.var_.actorSpriteComps10095 = nil
			end

			local var_54_2 = arg_51_1.actors_["10096"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps10096 == nil then
				arg_51_1.var_.actorSpriteComps10096 = var_54_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_3 = 2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.actorSpriteComps10096 then
					for iter_54_4, iter_54_5 in pairs(arg_51_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_54_5 then
							if arg_51_1.isInRecall_ then
								iter_54_5.color = Color.New(Mathf.Lerp(iter_54_5.color.r, arg_51_1.hightColor1.r, (arg_51_1.time_ - 0) / var_54_3), Mathf.Lerp(iter_54_5.color.g, arg_51_1.hightColor1.g, (arg_51_1.time_ - 0) / var_54_3), (Mathf.Lerp(iter_54_5.color.b, arg_51_1.hightColor1.b, (arg_51_1.time_ - 0) / var_54_3)))
							else
								local var_54_4 = Mathf.Lerp(iter_54_5.color.r, 1, (arg_51_1.time_ - 0) / var_54_3)

								iter_54_5.color = Color.New(var_54_4, var_54_4, var_54_4)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps10096 then
				for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_54_7 then
						iter_54_7.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_51_1.var_.actorSpriteComps10096 = nil
			end

			local var_54_5 = 0
			local var_54_6 = 0.85

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_7 = arg_51_1:GetWordFromCfg(413181012)
				local var_54_8 = arg_51_1:FormatText(var_54_7.content)

				arg_51_1.text_.text = var_54_8

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_10 = 34 <= 0 and var_54_6 or var_54_6 * (utf8.len(var_54_8) / 34)

				if (34 <= 0 and var_54_6 or var_54_6 * (utf8.len(var_54_8) / 34)) > 0 and var_54_6 < var_54_10 then
					arg_51_1.talkMaxDuration = var_54_10

					if var_54_10 + var_54_5 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_5
					end
				end

				arg_51_1.text_.text = var_54_8
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181012", "story_v_out_413181.awb") ~= 0 then
					local var_54_11 = manager.audio:GetVoiceLength("story_v_out_413181", "413181012", "story_v_out_413181.awb") / 1000

					if var_54_11 + var_54_5 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_11 + var_54_5
					end

					if var_54_7.prefab_name ~= "" and arg_51_1.actors_[var_54_7.prefab_name] ~= nil then
						local var_54_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_7.prefab_name].transform, "story_v_out_413181", "413181012", "story_v_out_413181.awb")

						arg_51_1:RecordAudio("413181012", var_54_12)
						arg_51_1:RecordAudio("413181012", var_54_12)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_413181", "413181012", "story_v_out_413181.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_413181", "413181012", "story_v_out_413181.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_13 = math.max(var_54_6, arg_51_1.talkMaxDuration)

			if var_54_5 <= arg_51_1.time_ and arg_51_1.time_ < var_54_5 + var_54_13 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_5) / var_54_13

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_5 + var_54_13 and arg_51_1.time_ < var_54_5 + var_54_13 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play413181013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 413181013
		arg_55_1.duration_ = 5.23

		local var_55_0 = {
			zh = 4.4,
			ja = 5.233
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
				arg_55_0:Play413181014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10095 = arg_55_1.actors_["10095"].transform.localPosition
				arg_55_1.actors_["10095"].transform.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10095", 2)

				for iter_58_0 = 0, arg_55_1.actors_["10095"].transform.childCount - 1 do
					local var_58_0 = arg_55_1.actors_["10095"].transform:GetChild(iter_58_0)

					if var_58_0.name == "split_1_5" or not string.find(var_58_0.name, "split") then
						var_58_0.gameObject:SetActive(true)
					else
						var_58_0.gameObject:SetActive(false)
					end
				end
			end

			local var_58_1 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 then
				arg_55_1.actors_["10095"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10095, Vector3.New(-390, -405, -10), (arg_55_1.time_ - 0) / var_58_1)
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 then
				arg_55_1.actors_["10095"].transform.localPosition = Vector3.New(-390, -405, -10)
			end

			local var_58_2 = arg_55_1.actors_["10096"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10096 = var_58_2.localPosition
				var_58_2.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10096", 4)

				for iter_58_1 = 0, var_58_2.childCount - 1 do
					local var_58_3 = var_58_2:GetChild(iter_58_1)

					if var_58_3.name == "" or not string.find(var_58_3.name, "split") then
						var_58_3.gameObject:SetActive(true)
					else
						var_58_3.gameObject:SetActive(false)
					end
				end
			end

			local var_58_4 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				var_58_2.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10096, Vector3.New(390, -350, -210), (arg_55_1.time_ - 0) / var_58_4)
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				var_58_2.localPosition = Vector3.New(390, -350, -210)
			end

			local var_58_5 = arg_55_1.actors_["10095"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_5) and arg_55_1.var_.actorSpriteComps10095 == nil then
				arg_55_1.var_.actorSpriteComps10095 = var_58_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_6 = 2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_6 and not isNil(var_58_5) then
				if arg_55_1.var_.actorSpriteComps10095 then
					for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_58_3 then
							if arg_55_1.isInRecall_ then
								iter_58_3.color = Color.New(Mathf.Lerp(iter_58_3.color.r, arg_55_1.hightColor1.r, (arg_55_1.time_ - 0) / var_58_6), Mathf.Lerp(iter_58_3.color.g, arg_55_1.hightColor1.g, (arg_55_1.time_ - 0) / var_58_6), (Mathf.Lerp(iter_58_3.color.b, arg_55_1.hightColor1.b, (arg_55_1.time_ - 0) / var_58_6)))
							else
								local var_58_7 = Mathf.Lerp(iter_58_3.color.r, 1, (arg_55_1.time_ - 0) / var_58_6)

								iter_58_3.color = Color.New(var_58_7, var_58_7, var_58_7)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_6 and arg_55_1.time_ < 0 + var_58_6 + arg_58_0 and not isNil(var_58_5) and arg_55_1.var_.actorSpriteComps10095 then
				for iter_58_4, iter_58_5 in pairs(arg_55_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_58_5 then
						iter_58_5.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_55_1.var_.actorSpriteComps10095 = nil
			end

			local var_58_8 = arg_55_1.actors_["10096"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_8) and arg_55_1.var_.actorSpriteComps10096 == nil then
				arg_55_1.var_.actorSpriteComps10096 = var_58_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_9 = 2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_9 and not isNil(var_58_8) then
				if arg_55_1.var_.actorSpriteComps10096 then
					for iter_58_6, iter_58_7 in pairs(arg_55_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_58_7 then
							if arg_55_1.isInRecall_ then
								iter_58_7.color = Color.New(Mathf.Lerp(iter_58_7.color.r, arg_55_1.hightColor2.r, (arg_55_1.time_ - 0) / var_58_9), Mathf.Lerp(iter_58_7.color.g, arg_55_1.hightColor2.g, (arg_55_1.time_ - 0) / var_58_9), (Mathf.Lerp(iter_58_7.color.b, arg_55_1.hightColor2.b, (arg_55_1.time_ - 0) / var_58_9)))
							else
								local var_58_10 = Mathf.Lerp(iter_58_7.color.r, 0.5, (arg_55_1.time_ - 0) / var_58_9)

								iter_58_7.color = Color.New(var_58_10, var_58_10, var_58_10)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_9 and arg_55_1.time_ < 0 + var_58_9 + arg_58_0 and not isNil(var_58_8) and arg_55_1.var_.actorSpriteComps10096 then
				for iter_58_8, iter_58_9 in pairs(arg_55_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_58_9 then
						iter_58_9.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_55_1.var_.actorSpriteComps10096 = nil
			end

			local var_58_11 = 0
			local var_58_12 = 0.375

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_11 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[1013].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_13 = arg_55_1:GetWordFromCfg(413181013)
				local var_58_14 = arg_55_1:FormatText(var_58_13.content)

				arg_55_1.text_.text = var_58_14

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_16 = 15 <= 0 and var_58_12 or var_58_12 * (utf8.len(var_58_14) / 15)

				if (15 <= 0 and var_58_12 or var_58_12 * (utf8.len(var_58_14) / 15)) > 0 and var_58_12 < var_58_16 then
					arg_55_1.talkMaxDuration = var_58_16

					if var_58_16 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_16 + var_58_11
					end
				end

				arg_55_1.text_.text = var_58_14
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181013", "story_v_out_413181.awb") ~= 0 then
					local var_58_17 = manager.audio:GetVoiceLength("story_v_out_413181", "413181013", "story_v_out_413181.awb") / 1000

					if var_58_17 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_17 + var_58_11
					end

					if var_58_13.prefab_name ~= "" and arg_55_1.actors_[var_58_13.prefab_name] ~= nil then
						local var_58_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_13.prefab_name].transform, "story_v_out_413181", "413181013", "story_v_out_413181.awb")

						arg_55_1:RecordAudio("413181013", var_58_18)
						arg_55_1:RecordAudio("413181013", var_58_18)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_413181", "413181013", "story_v_out_413181.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_413181", "413181013", "story_v_out_413181.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_19 = math.max(var_58_12, arg_55_1.talkMaxDuration)

			if var_58_11 <= arg_55_1.time_ and arg_55_1.time_ < var_58_11 + var_58_19 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_11) / var_58_19

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_11 + var_58_19 and arg_55_1.time_ < var_58_11 + var_58_19 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play413181014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 413181014
		arg_59_1.duration_ = 8.77

		local var_59_0 = {
			zh = 6.5,
			ja = 8.766
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
				arg_59_0:Play413181015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["10095"]) and arg_59_1.var_.actorSpriteComps10095 == nil then
				arg_59_1.var_.actorSpriteComps10095 = arg_59_1.actors_["10095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_0 = 2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["10095"]) then
				if arg_59_1.var_.actorSpriteComps10095 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								iter_62_1.color = Color.New(Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor1.r, (arg_59_1.time_ - 0) / var_62_0), Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor1.g, (arg_59_1.time_ - 0) / var_62_0), (Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor1.b, (arg_59_1.time_ - 0) / var_62_0)))
							else
								local var_62_1 = Mathf.Lerp(iter_62_1.color.r, 1, (arg_59_1.time_ - 0) / var_62_0)

								iter_62_1.color = Color.New(var_62_1, var_62_1, var_62_1)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["10095"]) and arg_59_1.var_.actorSpriteComps10095 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_62_3 then
						iter_62_3.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_59_1.var_.actorSpriteComps10095 = nil
			end

			local var_62_2 = 0
			local var_62_3 = 0.675

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1013].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_4 = arg_59_1:GetWordFromCfg(413181014)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_7 = 27 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 27)

				if (27 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 27)) > 0 and var_62_3 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_2
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181014", "story_v_out_413181.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_413181", "413181014", "story_v_out_413181.awb") / 1000

					if var_62_8 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_2
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_out_413181", "413181014", "story_v_out_413181.awb")

						arg_59_1:RecordAudio("413181014", var_62_9)
						arg_59_1:RecordAudio("413181014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_413181", "413181014", "story_v_out_413181.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_413181", "413181014", "story_v_out_413181.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_3, arg_59_1.talkMaxDuration)

			if var_62_2 <= arg_59_1.time_ and arg_59_1.time_ < var_62_2 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_2) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_2 + var_62_10 and arg_59_1.time_ < var_62_2 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play413181015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 413181015
		arg_63_1.duration_ = 9.63

		local var_63_0 = {
			zh = 7.366,
			ja = 9.633
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play413181016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["10095"]) and arg_63_1.var_.actorSpriteComps10095 == nil then
				arg_63_1.var_.actorSpriteComps10095 = arg_63_1.actors_["10095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_0 = 2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["10095"]) then
				if arg_63_1.var_.actorSpriteComps10095 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								iter_66_1.color = Color.New(Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor2.r, (arg_63_1.time_ - 0) / var_66_0), Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor2.g, (arg_63_1.time_ - 0) / var_66_0), (Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor2.b, (arg_63_1.time_ - 0) / var_66_0)))
							else
								local var_66_1 = Mathf.Lerp(iter_66_1.color.r, 0.5, (arg_63_1.time_ - 0) / var_66_0)

								iter_66_1.color = Color.New(var_66_1, var_66_1, var_66_1)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["10095"]) and arg_63_1.var_.actorSpriteComps10095 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_66_3 then
						iter_66_3.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_63_1.var_.actorSpriteComps10095 = nil
			end

			local var_66_2 = arg_63_1.actors_["10096"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps10096 == nil then
				arg_63_1.var_.actorSpriteComps10096 = var_66_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_3 = 2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.actorSpriteComps10096 then
					for iter_66_4, iter_66_5 in pairs(arg_63_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_66_5 then
							if arg_63_1.isInRecall_ then
								iter_66_5.color = Color.New(Mathf.Lerp(iter_66_5.color.r, arg_63_1.hightColor1.r, (arg_63_1.time_ - 0) / var_66_3), Mathf.Lerp(iter_66_5.color.g, arg_63_1.hightColor1.g, (arg_63_1.time_ - 0) / var_66_3), (Mathf.Lerp(iter_66_5.color.b, arg_63_1.hightColor1.b, (arg_63_1.time_ - 0) / var_66_3)))
							else
								local var_66_4 = Mathf.Lerp(iter_66_5.color.r, 1, (arg_63_1.time_ - 0) / var_66_3)

								iter_66_5.color = Color.New(var_66_4, var_66_4, var_66_4)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps10096 then
				for iter_66_6, iter_66_7 in pairs(arg_63_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_66_7 then
						iter_66_7.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_63_1.var_.actorSpriteComps10096 = nil
			end

			local var_66_5 = 0
			local var_66_6 = 0.4

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_7 = arg_63_1:GetWordFromCfg(413181015)
				local var_66_8 = arg_63_1:FormatText(var_66_7.content)

				arg_63_1.text_.text = var_66_8

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 16 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 16)

				if (16 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 16)) > 0 and var_66_6 < var_66_10 then
					arg_63_1.talkMaxDuration = var_66_10

					if var_66_10 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_5
					end
				end

				arg_63_1.text_.text = var_66_8
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181015", "story_v_out_413181.awb") ~= 0 then
					local var_66_11 = manager.audio:GetVoiceLength("story_v_out_413181", "413181015", "story_v_out_413181.awb") / 1000

					if var_66_11 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_5
					end

					if var_66_7.prefab_name ~= "" and arg_63_1.actors_[var_66_7.prefab_name] ~= nil then
						local var_66_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_7.prefab_name].transform, "story_v_out_413181", "413181015", "story_v_out_413181.awb")

						arg_63_1:RecordAudio("413181015", var_66_12)
						arg_63_1:RecordAudio("413181015", var_66_12)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_413181", "413181015", "story_v_out_413181.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_413181", "413181015", "story_v_out_413181.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_13 = math.max(var_66_6, arg_63_1.talkMaxDuration)

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_13 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_5) / var_66_13

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_5 + var_66_13 and arg_63_1.time_ < var_66_5 + var_66_13 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play413181016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 413181016
		arg_67_1.duration_ = 15

		local var_67_0 = {
			zh = 8.09933333333333,
			ja = 14.9993333333333
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play413181017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 1 < arg_67_1.time_ and arg_67_1.time_ <= 1 + arg_70_0 then
				local var_70_0 = arg_67_1.bgs_.ST0601

				arg_67_1.bgs_.ST0601.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_70_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_70_1 = var_70_0:GetComponent("SpriteRenderer")

				if var_70_1 and var_70_1.sprite then
					local var_70_2 = 2 * (var_70_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_70_0.transform.localScale = Vector3.New(var_70_2 / var_70_1.sprite.bounds.size.y < var_70_2 * manager.ui.mainCameraCom_.aspect / var_70_1.sprite.bounds.size.x and var_70_2 * manager.ui.mainCameraCom_.aspect / var_70_1.sprite.bounds.size.x or var_70_2 / var_70_1.sprite.bounds.size.y, var_70_2 / var_70_1.sprite.bounds.size.y < var_70_2 * manager.ui.mainCameraCom_.aspect / var_70_1.sprite.bounds.size.x and var_70_2 * manager.ui.mainCameraCom_.aspect / var_70_1.sprite.bounds.size.x or var_70_2 / var_70_1.sprite.bounds.size.y, 0)
				end

				for iter_70_0, iter_70_1 in pairs(arg_67_1.bgs_) do
					if iter_70_0 ~= "ST0601" then
						iter_70_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_70_3 = 0

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_3 + arg_70_0 then
				arg_67_1.allBtn_.enabled = false
			end

			if arg_67_1.time_ >= var_70_3 + 0.3 and arg_67_1.time_ < var_70_3 + 0.3 + arg_70_0 then
				arg_67_1.allBtn_.enabled = true
			end

			local var_70_4 = 0

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.mask_.enabled = true
				arg_67_1.mask_.raycastTarget = true

				arg_67_1:SetGaussion(false)
			end

			local var_70_5 = 1

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_5 then
				local var_70_6 = Color.New(0, 0, 0)

				var_70_6.a = Mathf.Lerp(0, 1, (arg_67_1.time_ - var_70_4) / var_70_5)
				arg_67_1.mask_.color = var_70_6
			end

			if arg_67_1.time_ >= var_70_4 + var_70_5 and arg_67_1.time_ < var_70_4 + var_70_5 + arg_70_0 then
				local var_70_7 = Color.New(0, 0, 0)

				var_70_7.a = 1
				arg_67_1.mask_.color = var_70_7
			end

			local var_70_8 = 1

			if 1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
				arg_67_1.mask_.enabled = true
				arg_67_1.mask_.raycastTarget = true

				arg_67_1:SetGaussion(false)
			end

			local var_70_9 = 1.13333333333333

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_9 then
				local var_70_10 = Color.New(0, 0, 0)

				var_70_10.a = Mathf.Lerp(1, 0, (arg_67_1.time_ - var_70_8) / var_70_9)
				arg_67_1.mask_.color = var_70_10
			end

			if arg_67_1.time_ >= var_70_8 + var_70_9 and arg_67_1.time_ < var_70_8 + var_70_9 + arg_70_0 then
				local var_70_11 = Color.New(0, 0, 0)

				arg_67_1.mask_.enabled = false
				var_70_11.a = 0
				arg_67_1.mask_.color = var_70_11
			end

			local var_70_12 = arg_67_1.actors_["10095"].transform

			if 1 < arg_67_1.time_ and arg_67_1.time_ <= 1 + arg_70_0 then
				arg_67_1.var_.moveOldPos10095 = var_70_12.localPosition
				var_70_12.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("10095", 7)

				for iter_70_2 = 0, var_70_12.childCount - 1 do
					local var_70_13 = var_70_12:GetChild(iter_70_2)

					if var_70_13.name == "split_1_5" or not string.find(var_70_13.name, "split") then
						var_70_13.gameObject:SetActive(true)
					else
						var_70_13.gameObject:SetActive(false)
					end
				end
			end

			local var_70_14 = 0.001

			if 1 <= arg_67_1.time_ and arg_67_1.time_ < 1 + var_70_14 then
				var_70_12.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10095, Vector3.New(0, -2000, 0), (arg_67_1.time_ - 1) / var_70_14)
			end

			if arg_67_1.time_ >= 1 + var_70_14 and arg_67_1.time_ < 1 + var_70_14 + arg_70_0 then
				var_70_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_70_15 = arg_67_1.actors_["10096"].transform

			if 1 < arg_67_1.time_ and arg_67_1.time_ <= 1 + arg_70_0 then
				arg_67_1.var_.moveOldPos10096 = var_70_15.localPosition
				var_70_15.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("10096", 7)

				for iter_70_3 = 0, var_70_15.childCount - 1 do
					local var_70_16 = var_70_15:GetChild(iter_70_3)

					if var_70_16.name == "" or not string.find(var_70_16.name, "split") then
						var_70_16.gameObject:SetActive(true)
					else
						var_70_16.gameObject:SetActive(false)
					end
				end
			end

			local var_70_17 = 0.001

			if 1 <= arg_67_1.time_ and arg_67_1.time_ < 1 + var_70_17 then
				var_70_15.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10096, Vector3.New(0, -2000, 0), (arg_67_1.time_ - 1) / var_70_17)
			end

			if arg_67_1.time_ >= 1 + var_70_17 and arg_67_1.time_ < 1 + var_70_17 + arg_70_0 then
				var_70_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_70_18 = arg_67_1.actors_["10096"].transform

			if 2 < arg_67_1.time_ and arg_67_1.time_ <= 2 + arg_70_0 then
				arg_67_1.var_.moveOldPos10096 = var_70_18.localPosition
				var_70_18.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("10096", 3)

				for iter_70_4 = 0, var_70_18.childCount - 1 do
					local var_70_19 = var_70_18:GetChild(iter_70_4)

					if var_70_19.name == "" or not string.find(var_70_19.name, "split") then
						var_70_19.gameObject:SetActive(true)
					else
						var_70_19.gameObject:SetActive(false)
					end
				end
			end

			local var_70_20 = 0.001

			if 2 <= arg_67_1.time_ and arg_67_1.time_ < 2 + var_70_20 then
				var_70_18.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10096, Vector3.New(0, -350, -210), (arg_67_1.time_ - 2) / var_70_20)
			end

			if arg_67_1.time_ >= 2 + var_70_20 and arg_67_1.time_ < 2 + var_70_20 + arg_70_0 then
				var_70_18.localPosition = Vector3.New(0, -350, -210)
			end

			local var_70_21 = arg_67_1.actors_["10096"]

			if 2 < arg_67_1.time_ and arg_67_1.time_ <= 2 + arg_70_0 and not isNil(var_70_21) and arg_67_1.var_.actorSpriteComps10096 == nil then
				arg_67_1.var_.actorSpriteComps10096 = var_70_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_22 = 2

			if 2 <= arg_67_1.time_ and arg_67_1.time_ < 2 + var_70_22 and not isNil(var_70_21) then
				if arg_67_1.var_.actorSpriteComps10096 then
					for iter_70_5, iter_70_6 in pairs(arg_67_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_70_6 then
							if arg_67_1.isInRecall_ then
								iter_70_6.color = Color.New(Mathf.Lerp(iter_70_6.color.r, arg_67_1.hightColor1.r, (arg_67_1.time_ - 2) / var_70_22), Mathf.Lerp(iter_70_6.color.g, arg_67_1.hightColor1.g, (arg_67_1.time_ - 2) / var_70_22), (Mathf.Lerp(iter_70_6.color.b, arg_67_1.hightColor1.b, (arg_67_1.time_ - 2) / var_70_22)))
							else
								local var_70_23 = Mathf.Lerp(iter_70_6.color.r, 1, (arg_67_1.time_ - 2) / var_70_22)

								iter_70_6.color = Color.New(var_70_23, var_70_23, var_70_23)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= 2 + var_70_22 and arg_67_1.time_ < 2 + var_70_22 + arg_70_0 and not isNil(var_70_21) and arg_67_1.var_.actorSpriteComps10096 then
				for iter_70_7, iter_70_8 in pairs(arg_67_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_70_8 then
						iter_70_8.color = arg_67_1.isInRecall_ and (arg_67_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_67_1.var_.actorSpriteComps10096 = nil
			end

			if 2 < arg_67_1.time_ and arg_67_1.time_ <= 2 + arg_70_0 then
				local var_70_24 = arg_67_1.actors_["10096"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_70_24 then
					arg_67_1.var_.alphaOldValue10096 = var_70_24.alpha
					arg_67_1.var_.characterEffect10096 = var_70_24
				end

				arg_67_1.var_.alphaOldValue10096 = 0
			end

			local var_70_25 = 0.2

			if 2 <= arg_67_1.time_ and arg_67_1.time_ < 2 + var_70_25 then
				if arg_67_1.var_.characterEffect10096 then
					arg_67_1.var_.characterEffect10096.alpha = Mathf.Lerp(arg_67_1.var_.alphaOldValue10096, 1, (arg_67_1.time_ - 2) / var_70_25)
				end
			end

			if arg_67_1.time_ >= 2 + var_70_25 and arg_67_1.time_ < 2 + var_70_25 + arg_70_0 and arg_67_1.var_.characterEffect10096 then
				arg_67_1.var_.characterEffect10096.alpha = 1
			end

			if arg_67_1.frameCnt_ <= 1 then
				arg_67_1.dialog_:SetActive(false)
			end

			local var_70_26 = 2.13333333333333
			local var_70_27 = 0.525

			if 2.13333333333333 < arg_67_1.time_ and arg_67_1.time_ <= var_70_26 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				arg_67_1.dialog_:SetActive(true)

				arg_67_1.dialogCg_.alpha = 0

				local var_70_28 = LeanTween.value(arg_67_1.dialog_, 0, 1, 0.3)

				var_70_28:setOnUpdate(LuaHelper.FloatAction(function(arg_71_0)
					arg_67_1.dialogCg_.alpha = arg_71_0
				end))
				var_70_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_67_1.dialog_)
					var_70_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_67_1.duration_ = arg_67_1.duration_ + 0.3

				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_29 = arg_67_1:GetWordFromCfg(413181016)
				local var_70_30 = arg_67_1:FormatText(var_70_29.content)

				arg_67_1.text_.text = var_70_30

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_32 = 21 <= 0 and var_70_27 or var_70_27 * (utf8.len(var_70_30) / 21)

				if (21 <= 0 and var_70_27 or var_70_27 * (utf8.len(var_70_30) / 21)) > 0 and var_70_27 < var_70_32 then
					arg_67_1.talkMaxDuration = var_70_32
					var_70_26 = var_70_26 + 0.3

					if var_70_32 + var_70_26 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_32 + var_70_26
					end
				end

				arg_67_1.text_.text = var_70_30
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181016", "story_v_out_413181.awb") ~= 0 then
					local var_70_33 = manager.audio:GetVoiceLength("story_v_out_413181", "413181016", "story_v_out_413181.awb") / 1000

					if var_70_33 + var_70_26 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_33 + var_70_26
					end

					if var_70_29.prefab_name ~= "" and arg_67_1.actors_[var_70_29.prefab_name] ~= nil then
						local var_70_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_29.prefab_name].transform, "story_v_out_413181", "413181016", "story_v_out_413181.awb")

						arg_67_1:RecordAudio("413181016", var_70_34)
						arg_67_1:RecordAudio("413181016", var_70_34)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_413181", "413181016", "story_v_out_413181.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_413181", "413181016", "story_v_out_413181.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_35 = var_70_26 + 0.3
			local var_70_36 = math.max(var_70_27, arg_67_1.talkMaxDuration)

			if var_70_26 + 0.3 <= arg_67_1.time_ and arg_67_1.time_ < var_70_35 + var_70_36 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_35) / var_70_36

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_35 + var_70_36 and arg_67_1.time_ < var_70_35 + var_70_36 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play413181017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413181017
		arg_73_1.duration_ = 5.27

		local var_73_0 = {
			zh = 3.7,
			ja = 5.266
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
				arg_73_0:Play413181018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10096"]) and arg_73_1.var_.actorSpriteComps10096 == nil then
				arg_73_1.var_.actorSpriteComps10096 = arg_73_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10096"]) then
				if arg_73_1.var_.actorSpriteComps10096 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								iter_76_1.color = Color.New(Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_0), Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_0), (Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_0)))
							else
								local var_76_1 = Mathf.Lerp(iter_76_1.color.r, 1, (arg_73_1.time_ - 0) / var_76_0)

								iter_76_1.color = Color.New(var_76_1, var_76_1, var_76_1)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10096"]) and arg_73_1.var_.actorSpriteComps10096 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10096 = nil
			end

			local var_76_2 = 0
			local var_76_3 = 0.3

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(413181017)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 12 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 12)

				if (12 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 12)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181017", "story_v_out_413181.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_413181", "413181017", "story_v_out_413181.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_413181", "413181017", "story_v_out_413181.awb")

						arg_73_1:RecordAudio("413181017", var_76_9)
						arg_73_1:RecordAudio("413181017", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413181", "413181017", "story_v_out_413181.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413181", "413181017", "story_v_out_413181.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play413181018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413181018
		arg_77_1.duration_ = 6.87

		local var_77_0 = {
			zh = 3.433,
			ja = 6.866
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
				arg_77_0:Play413181019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10095 = arg_77_1.actors_["10095"].transform.localPosition
				arg_77_1.actors_["10095"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10095", 2)

				for iter_80_0 = 0, arg_77_1.actors_["10095"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["10095"].transform:GetChild(iter_80_0)

					if var_80_0.name == "split_1_1" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["10095"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10095, Vector3.New(-390, -405, -10), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["10095"].transform.localPosition = Vector3.New(-390, -405, -10)
			end

			local var_80_2 = arg_77_1.actors_["10096"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10096 = var_80_2.localPosition
				var_80_2.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10096", 4)

				for iter_80_1 = 0, var_80_2.childCount - 1 do
					local var_80_3 = var_80_2:GetChild(iter_80_1)

					if var_80_3.name == "" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				var_80_2.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10096, Vector3.New(390, -350, -210), (arg_77_1.time_ - 0) / var_80_4)
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				var_80_2.localPosition = Vector3.New(390, -350, -210)
			end

			local var_80_5 = arg_77_1.actors_["10095"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.actorSpriteComps10095 == nil then
				arg_77_1.var_.actorSpriteComps10095 = var_80_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_6 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 and not isNil(var_80_5) then
				if arg_77_1.var_.actorSpriteComps10095 then
					for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_80_3 then
							if arg_77_1.isInRecall_ then
								iter_80_3.color = Color.New(Mathf.Lerp(iter_80_3.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_6), Mathf.Lerp(iter_80_3.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_6), (Mathf.Lerp(iter_80_3.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_6)))
							else
								local var_80_7 = Mathf.Lerp(iter_80_3.color.r, 1, (arg_77_1.time_ - 0) / var_80_6)

								iter_80_3.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.actorSpriteComps10095 then
				for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_80_5 then
						iter_80_5.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10095 = nil
			end

			local var_80_8 = arg_77_1.actors_["10096"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10096 == nil then
				arg_77_1.var_.actorSpriteComps10096 = var_80_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_9 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_9 and not isNil(var_80_8) then
				if arg_77_1.var_.actorSpriteComps10096 then
					for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_80_7 then
							if arg_77_1.isInRecall_ then
								iter_80_7.color = Color.New(Mathf.Lerp(iter_80_7.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 0) / var_80_9), Mathf.Lerp(iter_80_7.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 0) / var_80_9), (Mathf.Lerp(iter_80_7.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 0) / var_80_9)))
							else
								local var_80_10 = Mathf.Lerp(iter_80_7.color.r, 0.5, (arg_77_1.time_ - 0) / var_80_9)

								iter_80_7.color = Color.New(var_80_10, var_80_10, var_80_10)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_9 and arg_77_1.time_ < 0 + var_80_9 + arg_80_0 and not isNil(var_80_8) and arg_77_1.var_.actorSpriteComps10096 then
				for iter_80_8, iter_80_9 in pairs(arg_77_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_80_9 then
						iter_80_9.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps10096 = nil
			end

			local var_80_11 = 0
			local var_80_12 = 0.3

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1013].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_13 = arg_77_1:GetWordFromCfg(413181018)
				local var_80_14 = arg_77_1:FormatText(var_80_13.content)

				arg_77_1.text_.text = var_80_14

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_16 = 12 <= 0 and var_80_12 or var_80_12 * (utf8.len(var_80_14) / 12)

				if (12 <= 0 and var_80_12 or var_80_12 * (utf8.len(var_80_14) / 12)) > 0 and var_80_12 < var_80_16 then
					arg_77_1.talkMaxDuration = var_80_16

					if var_80_16 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_11
					end
				end

				arg_77_1.text_.text = var_80_14
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181018", "story_v_out_413181.awb") ~= 0 then
					local var_80_17 = manager.audio:GetVoiceLength("story_v_out_413181", "413181018", "story_v_out_413181.awb") / 1000

					if var_80_17 + var_80_11 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_11
					end

					if var_80_13.prefab_name ~= "" and arg_77_1.actors_[var_80_13.prefab_name] ~= nil then
						local var_80_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_13.prefab_name].transform, "story_v_out_413181", "413181018", "story_v_out_413181.awb")

						arg_77_1:RecordAudio("413181018", var_80_18)
						arg_77_1:RecordAudio("413181018", var_80_18)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413181", "413181018", "story_v_out_413181.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413181", "413181018", "story_v_out_413181.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_19 = math.max(var_80_12, arg_77_1.talkMaxDuration)

			if var_80_11 <= arg_77_1.time_ and arg_77_1.time_ < var_80_11 + var_80_19 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_11) / var_80_19

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_11 + var_80_19 and arg_77_1.time_ < var_80_11 + var_80_19 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play413181019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413181019
		arg_81_1.duration_ = 13.77

		local var_81_0 = {
			zh = 5.233,
			ja = 13.766
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
				arg_81_0:Play413181020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10095"]) and arg_81_1.var_.actorSpriteComps10095 == nil then
				arg_81_1.var_.actorSpriteComps10095 = arg_81_1.actors_["10095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10095"]) then
				if arg_81_1.var_.actorSpriteComps10095 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								iter_84_1.color = Color.New(Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_0), Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_0), (Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_0)))
							else
								local var_84_1 = Mathf.Lerp(iter_84_1.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_0)

								iter_84_1.color = Color.New(var_84_1, var_84_1, var_84_1)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10095"]) and arg_81_1.var_.actorSpriteComps10095 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10095 = nil
			end

			local var_84_2 = arg_81_1.actors_["10096"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10096 == nil then
				arg_81_1.var_.actorSpriteComps10096 = var_84_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_3 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.actorSpriteComps10096 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_84_5 then
							if arg_81_1.isInRecall_ then
								iter_84_5.color = Color.New(Mathf.Lerp(iter_84_5.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_3), Mathf.Lerp(iter_84_5.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_3), (Mathf.Lerp(iter_84_5.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_3)))
							else
								local var_84_4 = Mathf.Lerp(iter_84_5.color.r, 1, (arg_81_1.time_ - 0) / var_84_3)

								iter_84_5.color = Color.New(var_84_4, var_84_4, var_84_4)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10096 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_84_7 then
						iter_84_7.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps10096 = nil
			end

			local var_84_5 = 0
			local var_84_6 = 0.45

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_7 = arg_81_1:GetWordFromCfg(413181019)
				local var_84_8 = arg_81_1:FormatText(var_84_7.content)

				arg_81_1.text_.text = var_84_8

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 18 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_8) / 18)

				if (18 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_8) / 18)) > 0 and var_84_6 < var_84_10 then
					arg_81_1.talkMaxDuration = var_84_10

					if var_84_10 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_5
					end
				end

				arg_81_1.text_.text = var_84_8
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181019", "story_v_out_413181.awb") ~= 0 then
					local var_84_11 = manager.audio:GetVoiceLength("story_v_out_413181", "413181019", "story_v_out_413181.awb") / 1000

					if var_84_11 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_5
					end

					if var_84_7.prefab_name ~= "" and arg_81_1.actors_[var_84_7.prefab_name] ~= nil then
						local var_84_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_7.prefab_name].transform, "story_v_out_413181", "413181019", "story_v_out_413181.awb")

						arg_81_1:RecordAudio("413181019", var_84_12)
						arg_81_1:RecordAudio("413181019", var_84_12)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413181", "413181019", "story_v_out_413181.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413181", "413181019", "story_v_out_413181.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_13 = math.max(var_84_6, arg_81_1.talkMaxDuration)

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_13 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_5) / var_84_13

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_5 + var_84_13 and arg_81_1.time_ < var_84_5 + var_84_13 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play413181020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413181020
		arg_85_1.duration_ = 11.13

		local var_85_0 = {
			zh = 5.6,
			ja = 11.133
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
				arg_85_0:Play413181021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["10095"]) and arg_85_1.var_.actorSpriteComps10095 == nil then
				arg_85_1.var_.actorSpriteComps10095 = arg_85_1.actors_["10095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["10095"]) then
				if arg_85_1.var_.actorSpriteComps10095 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								iter_88_1.color = Color.New(Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_0), Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_0), (Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_0)))
							else
								local var_88_1 = Mathf.Lerp(iter_88_1.color.r, 1, (arg_85_1.time_ - 0) / var_88_0)

								iter_88_1.color = Color.New(var_88_1, var_88_1, var_88_1)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["10095"]) and arg_85_1.var_.actorSpriteComps10095 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps10095 = nil
			end

			local var_88_2 = arg_85_1.actors_["10096"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10096 == nil then
				arg_85_1.var_.actorSpriteComps10096 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps10096 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								iter_88_5.color = Color.New(Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_3), Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_3), (Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_3)))
							else
								local var_88_4 = Mathf.Lerp(iter_88_5.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_3)

								iter_88_5.color = Color.New(var_88_4, var_88_4, var_88_4)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps10096 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_88_7 then
						iter_88_7.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps10096 = nil
			end

			local var_88_5 = 0
			local var_88_6 = 0.5

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1013].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_7 = arg_85_1:GetWordFromCfg(413181020)
				local var_88_8 = arg_85_1:FormatText(var_88_7.content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 20 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 20)

				if (20 <= 0 and var_88_6 or var_88_6 * (utf8.len(var_88_8) / 20)) > 0 and var_88_6 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_5
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181020", "story_v_out_413181.awb") ~= 0 then
					local var_88_11 = manager.audio:GetVoiceLength("story_v_out_413181", "413181020", "story_v_out_413181.awb") / 1000

					if var_88_11 + var_88_5 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_5
					end

					if var_88_7.prefab_name ~= "" and arg_85_1.actors_[var_88_7.prefab_name] ~= nil then
						local var_88_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_7.prefab_name].transform, "story_v_out_413181", "413181020", "story_v_out_413181.awb")

						arg_85_1:RecordAudio("413181020", var_88_12)
						arg_85_1:RecordAudio("413181020", var_88_12)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413181", "413181020", "story_v_out_413181.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413181", "413181020", "story_v_out_413181.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_13 = math.max(var_88_6, arg_85_1.talkMaxDuration)

			if var_88_5 <= arg_85_1.time_ and arg_85_1.time_ < var_88_5 + var_88_13 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_5) / var_88_13

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_5 + var_88_13 and arg_85_1.time_ < var_88_5 + var_88_13 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play413181021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413181021
		arg_89_1.duration_ = 6.6

		local var_89_0 = {
			zh = 6.6,
			ja = 4.433
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
				arg_89_0:Play413181022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.55

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1013].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(413181021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 22 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 22)

				if (22 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 22)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181021", "story_v_out_413181.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_413181", "413181021", "story_v_out_413181.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_413181", "413181021", "story_v_out_413181.awb")

						arg_89_1:RecordAudio("413181021", var_92_6)
						arg_89_1:RecordAudio("413181021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413181", "413181021", "story_v_out_413181.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413181", "413181021", "story_v_out_413181.awb")
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
	Play413181022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413181022
		arg_93_1.duration_ = 7.4

		local var_93_0 = {
			zh = 7.4,
			ja = 4.5
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
				arg_93_0:Play413181023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10095 = arg_93_1.actors_["10095"].transform.localPosition
				arg_93_1.actors_["10095"].transform.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10095", 2)

				for iter_96_0 = 0, arg_93_1.actors_["10095"].transform.childCount - 1 do
					local var_96_0 = arg_93_1.actors_["10095"].transform:GetChild(iter_96_0)

					if var_96_0.name == "split_1_3" or not string.find(var_96_0.name, "split") then
						var_96_0.gameObject:SetActive(true)
					else
						var_96_0.gameObject:SetActive(false)
					end
				end
			end

			local var_96_1 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_1 then
				arg_93_1.actors_["10095"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10095, Vector3.New(-390, -405, -10), (arg_93_1.time_ - 0) / var_96_1)
			end

			if arg_93_1.time_ >= 0 + var_96_1 and arg_93_1.time_ < 0 + var_96_1 + arg_96_0 then
				arg_93_1.actors_["10095"].transform.localPosition = Vector3.New(-390, -405, -10)
			end

			local var_96_2 = arg_93_1.actors_["10096"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10096 = var_96_2.localPosition
				var_96_2.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10096", 4)

				for iter_96_1 = 0, var_96_2.childCount - 1 do
					local var_96_3 = var_96_2:GetChild(iter_96_1)

					if var_96_3.name == "" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_2.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10096, Vector3.New(390, -350, -210), (arg_93_1.time_ - 0) / var_96_4)
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_2.localPosition = Vector3.New(390, -350, -210)
			end

			local var_96_5 = arg_93_1.actors_["10095"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps10095 == nil then
				arg_93_1.var_.actorSpriteComps10095 = var_96_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_6 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_6 and not isNil(var_96_5) then
				if arg_93_1.var_.actorSpriteComps10095 then
					for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_96_3 then
							if arg_93_1.isInRecall_ then
								iter_96_3.color = Color.New(Mathf.Lerp(iter_96_3.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_6), Mathf.Lerp(iter_96_3.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_6), (Mathf.Lerp(iter_96_3.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_6)))
							else
								local var_96_7 = Mathf.Lerp(iter_96_3.color.r, 1, (arg_93_1.time_ - 0) / var_96_6)

								iter_96_3.color = Color.New(var_96_7, var_96_7, var_96_7)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_6 and arg_93_1.time_ < 0 + var_96_6 + arg_96_0 and not isNil(var_96_5) and arg_93_1.var_.actorSpriteComps10095 then
				for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_96_5 then
						iter_96_5.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps10095 = nil
			end

			local var_96_8 = arg_93_1.actors_["10096"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10096 == nil then
				arg_93_1.var_.actorSpriteComps10096 = var_96_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_9 and not isNil(var_96_8) then
				if arg_93_1.var_.actorSpriteComps10096 then
					for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_96_7 then
							if arg_93_1.isInRecall_ then
								iter_96_7.color = Color.New(Mathf.Lerp(iter_96_7.color.r, arg_93_1.hightColor2.r, (arg_93_1.time_ - 0) / var_96_9), Mathf.Lerp(iter_96_7.color.g, arg_93_1.hightColor2.g, (arg_93_1.time_ - 0) / var_96_9), (Mathf.Lerp(iter_96_7.color.b, arg_93_1.hightColor2.b, (arg_93_1.time_ - 0) / var_96_9)))
							else
								local var_96_10 = Mathf.Lerp(iter_96_7.color.r, 0.5, (arg_93_1.time_ - 0) / var_96_9)

								iter_96_7.color = Color.New(var_96_10, var_96_10, var_96_10)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_9 and arg_93_1.time_ < 0 + var_96_9 + arg_96_0 and not isNil(var_96_8) and arg_93_1.var_.actorSpriteComps10096 then
				for iter_96_8, iter_96_9 in pairs(arg_93_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_96_9 then
						iter_96_9.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps10096 = nil
			end

			local var_96_11 = 0
			local var_96_12 = 0.675

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_11 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1013].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_13 = arg_93_1:GetWordFromCfg(413181022)
				local var_96_14 = arg_93_1:FormatText(var_96_13.content)

				arg_93_1.text_.text = var_96_14

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_16 = 27 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 27)

				if (27 <= 0 and var_96_12 or var_96_12 * (utf8.len(var_96_14) / 27)) > 0 and var_96_12 < var_96_16 then
					arg_93_1.talkMaxDuration = var_96_16

					if var_96_16 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_16 + var_96_11
					end
				end

				arg_93_1.text_.text = var_96_14
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181022", "story_v_out_413181.awb") ~= 0 then
					local var_96_17 = manager.audio:GetVoiceLength("story_v_out_413181", "413181022", "story_v_out_413181.awb") / 1000

					if var_96_17 + var_96_11 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_11
					end

					if var_96_13.prefab_name ~= "" and arg_93_1.actors_[var_96_13.prefab_name] ~= nil then
						local var_96_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_13.prefab_name].transform, "story_v_out_413181", "413181022", "story_v_out_413181.awb")

						arg_93_1:RecordAudio("413181022", var_96_18)
						arg_93_1:RecordAudio("413181022", var_96_18)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413181", "413181022", "story_v_out_413181.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413181", "413181022", "story_v_out_413181.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_19 = math.max(var_96_12, arg_93_1.talkMaxDuration)

			if var_96_11 <= arg_93_1.time_ and arg_93_1.time_ < var_96_11 + var_96_19 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_11) / var_96_19

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_11 + var_96_19 and arg_93_1.time_ < var_96_11 + var_96_19 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play413181023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413181023
		arg_97_1.duration_ = 6.6

		local var_97_0 = {
			zh = 5.033,
			ja = 6.6
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
				arg_97_0:Play413181024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10095"]) and arg_97_1.var_.actorSpriteComps10095 == nil then
				arg_97_1.var_.actorSpriteComps10095 = arg_97_1.actors_["10095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_0 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10095"]) then
				if arg_97_1.var_.actorSpriteComps10095 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								iter_100_1.color = Color.New(Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_0), Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_0), (Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_0)))
							else
								local var_100_1 = Mathf.Lerp(iter_100_1.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_0)

								iter_100_1.color = Color.New(var_100_1, var_100_1, var_100_1)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10095"]) and arg_97_1.var_.actorSpriteComps10095 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_100_3 then
						iter_100_3.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps10095 = nil
			end

			local var_100_2 = arg_97_1.actors_["10096"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10096 == nil then
				arg_97_1.var_.actorSpriteComps10096 = var_100_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_3 = 2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_3 and not isNil(var_100_2) then
				if arg_97_1.var_.actorSpriteComps10096 then
					for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_100_5 then
							if arg_97_1.isInRecall_ then
								iter_100_5.color = Color.New(Mathf.Lerp(iter_100_5.color.r, arg_97_1.hightColor1.r, (arg_97_1.time_ - 0) / var_100_3), Mathf.Lerp(iter_100_5.color.g, arg_97_1.hightColor1.g, (arg_97_1.time_ - 0) / var_100_3), (Mathf.Lerp(iter_100_5.color.b, arg_97_1.hightColor1.b, (arg_97_1.time_ - 0) / var_100_3)))
							else
								local var_100_4 = Mathf.Lerp(iter_100_5.color.r, 1, (arg_97_1.time_ - 0) / var_100_3)

								iter_100_5.color = Color.New(var_100_4, var_100_4, var_100_4)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_3 and arg_97_1.time_ < 0 + var_100_3 + arg_100_0 and not isNil(var_100_2) and arg_97_1.var_.actorSpriteComps10096 then
				for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_100_7 then
						iter_100_7.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_97_1.var_.actorSpriteComps10096 = nil
			end

			local var_100_5 = 0
			local var_100_6 = 0.5

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_7 = arg_97_1:GetWordFromCfg(413181023)
				local var_100_8 = arg_97_1:FormatText(var_100_7.content)

				arg_97_1.text_.text = var_100_8

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 20 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 20)

				if (20 <= 0 and var_100_6 or var_100_6 * (utf8.len(var_100_8) / 20)) > 0 and var_100_6 < var_100_10 then
					arg_97_1.talkMaxDuration = var_100_10

					if var_100_10 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_5
					end
				end

				arg_97_1.text_.text = var_100_8
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181023", "story_v_out_413181.awb") ~= 0 then
					local var_100_11 = manager.audio:GetVoiceLength("story_v_out_413181", "413181023", "story_v_out_413181.awb") / 1000

					if var_100_11 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_5
					end

					if var_100_7.prefab_name ~= "" and arg_97_1.actors_[var_100_7.prefab_name] ~= nil then
						local var_100_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_7.prefab_name].transform, "story_v_out_413181", "413181023", "story_v_out_413181.awb")

						arg_97_1:RecordAudio("413181023", var_100_12)
						arg_97_1:RecordAudio("413181023", var_100_12)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413181", "413181023", "story_v_out_413181.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413181", "413181023", "story_v_out_413181.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_6, arg_97_1.talkMaxDuration)

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_5) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_5 + var_100_13 and arg_97_1.time_ < var_100_5 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play413181024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413181024
		arg_101_1.duration_ = 11.53

		local var_101_0 = {
			zh = 4.433,
			ja = 11.533
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
				arg_101_0:Play413181025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10095"]) and arg_101_1.var_.actorSpriteComps10095 == nil then
				arg_101_1.var_.actorSpriteComps10095 = arg_101_1.actors_["10095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_0 = 2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10095"]) then
				if arg_101_1.var_.actorSpriteComps10095 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								iter_104_1.color = Color.New(Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_0), Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_0), (Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_0)))
							else
								local var_104_1 = Mathf.Lerp(iter_104_1.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_0)

								iter_104_1.color = Color.New(var_104_1, var_104_1, var_104_1)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10095"]) and arg_101_1.var_.actorSpriteComps10095 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_104_3 then
						iter_104_3.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps10095 = nil
			end

			local var_104_2 = 0
			local var_104_3 = 0.375

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_4 = arg_101_1:GetWordFromCfg(413181024)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 15 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 15)

				if (15 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 15)) > 0 and var_104_3 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181024", "story_v_out_413181.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_413181", "413181024", "story_v_out_413181.awb") / 1000

					if var_104_8 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_2
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_out_413181", "413181024", "story_v_out_413181.awb")

						arg_101_1:RecordAudio("413181024", var_104_9)
						arg_101_1:RecordAudio("413181024", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_413181", "413181024", "story_v_out_413181.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_413181", "413181024", "story_v_out_413181.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_3, arg_101_1.talkMaxDuration)

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_2) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_2 + var_104_10 and arg_101_1.time_ < var_104_2 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play413181025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413181025
		arg_105_1.duration_ = 6.6

		local var_105_0 = {
			zh = 4.566,
			ja = 6.6
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
				arg_105_0:Play413181026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10095 = arg_105_1.actors_["10095"].transform.localPosition
				arg_105_1.actors_["10095"].transform.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10095", 2)

				for iter_108_0 = 0, arg_105_1.actors_["10095"].transform.childCount - 1 do
					local var_108_0 = arg_105_1.actors_["10095"].transform:GetChild(iter_108_0)

					if var_108_0.name == "split_1_1" or not string.find(var_108_0.name, "split") then
						var_108_0.gameObject:SetActive(true)
					else
						var_108_0.gameObject:SetActive(false)
					end
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["10095"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10095, Vector3.New(-390, -405, -10), (arg_105_1.time_ - 0) / var_108_1)
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["10095"].transform.localPosition = Vector3.New(-390, -405, -10)
			end

			local var_108_2 = arg_105_1.actors_["10096"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10096 = var_108_2.localPosition
				var_108_2.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10096", 4)

				for iter_108_1 = 0, var_108_2.childCount - 1 do
					local var_108_3 = var_108_2:GetChild(iter_108_1)

					if var_108_3.name == "" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_2.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10096, Vector3.New(390, -350, -210), (arg_105_1.time_ - 0) / var_108_4)
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_2.localPosition = Vector3.New(390, -350, -210)
			end

			local var_108_5 = arg_105_1.actors_["10095"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.actorSpriteComps10095 == nil then
				arg_105_1.var_.actorSpriteComps10095 = var_108_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_6 = 2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_5) then
				if arg_105_1.var_.actorSpriteComps10095 then
					for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_108_3 then
							if arg_105_1.isInRecall_ then
								iter_108_3.color = Color.New(Mathf.Lerp(iter_108_3.color.r, arg_105_1.hightColor1.r, (arg_105_1.time_ - 0) / var_108_6), Mathf.Lerp(iter_108_3.color.g, arg_105_1.hightColor1.g, (arg_105_1.time_ - 0) / var_108_6), (Mathf.Lerp(iter_108_3.color.b, arg_105_1.hightColor1.b, (arg_105_1.time_ - 0) / var_108_6)))
							else
								local var_108_7 = Mathf.Lerp(iter_108_3.color.r, 1, (arg_105_1.time_ - 0) / var_108_6)

								iter_108_3.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.actorSpriteComps10095 then
				for iter_108_4, iter_108_5 in pairs(arg_105_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_108_5 then
						iter_108_5.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps10095 = nil
			end

			local var_108_8 = arg_105_1.actors_["10096"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps10096 == nil then
				arg_105_1.var_.actorSpriteComps10096 = var_108_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_9 = 2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_9 and not isNil(var_108_8) then
				if arg_105_1.var_.actorSpriteComps10096 then
					for iter_108_6, iter_108_7 in pairs(arg_105_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_108_7 then
							if arg_105_1.isInRecall_ then
								iter_108_7.color = Color.New(Mathf.Lerp(iter_108_7.color.r, arg_105_1.hightColor2.r, (arg_105_1.time_ - 0) / var_108_9), Mathf.Lerp(iter_108_7.color.g, arg_105_1.hightColor2.g, (arg_105_1.time_ - 0) / var_108_9), (Mathf.Lerp(iter_108_7.color.b, arg_105_1.hightColor2.b, (arg_105_1.time_ - 0) / var_108_9)))
							else
								local var_108_10 = Mathf.Lerp(iter_108_7.color.r, 0.5, (arg_105_1.time_ - 0) / var_108_9)

								iter_108_7.color = Color.New(var_108_10, var_108_10, var_108_10)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_9 and arg_105_1.time_ < 0 + var_108_9 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps10096 then
				for iter_108_8, iter_108_9 in pairs(arg_105_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_108_9 then
						iter_108_9.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_105_1.var_.actorSpriteComps10096 = nil
			end

			local var_108_11 = 0
			local var_108_12 = 0.45

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_11 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1013].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_13 = arg_105_1:GetWordFromCfg(413181025)
				local var_108_14 = arg_105_1:FormatText(var_108_13.content)

				arg_105_1.text_.text = var_108_14

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_16 = 18 <= 0 and var_108_12 or var_108_12 * (utf8.len(var_108_14) / 18)

				if (18 <= 0 and var_108_12 or var_108_12 * (utf8.len(var_108_14) / 18)) > 0 and var_108_12 < var_108_16 then
					arg_105_1.talkMaxDuration = var_108_16

					if var_108_16 + var_108_11 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_16 + var_108_11
					end
				end

				arg_105_1.text_.text = var_108_14
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181025", "story_v_out_413181.awb") ~= 0 then
					local var_108_17 = manager.audio:GetVoiceLength("story_v_out_413181", "413181025", "story_v_out_413181.awb") / 1000

					if var_108_17 + var_108_11 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_17 + var_108_11
					end

					if var_108_13.prefab_name ~= "" and arg_105_1.actors_[var_108_13.prefab_name] ~= nil then
						local var_108_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_13.prefab_name].transform, "story_v_out_413181", "413181025", "story_v_out_413181.awb")

						arg_105_1:RecordAudio("413181025", var_108_18)
						arg_105_1:RecordAudio("413181025", var_108_18)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413181", "413181025", "story_v_out_413181.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413181", "413181025", "story_v_out_413181.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_19 = math.max(var_108_12, arg_105_1.talkMaxDuration)

			if var_108_11 <= arg_105_1.time_ and arg_105_1.time_ < var_108_11 + var_108_19 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_11) / var_108_19

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_11 + var_108_19 and arg_105_1.time_ < var_108_11 + var_108_19 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play413181026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413181026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play413181027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10095 = arg_109_1.actors_["10095"].transform.localPosition
				arg_109_1.actors_["10095"].transform.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10095", 7)

				for iter_112_0 = 0, arg_109_1.actors_["10095"].transform.childCount - 1 do
					local var_112_0 = arg_109_1.actors_["10095"].transform:GetChild(iter_112_0)

					if var_112_0.name == "" or not string.find(var_112_0.name, "split") then
						var_112_0.gameObject:SetActive(true)
					else
						var_112_0.gameObject:SetActive(false)
					end
				end
			end

			local var_112_1 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 then
				arg_109_1.actors_["10095"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10095, Vector3.New(0, -2000, 0), (arg_109_1.time_ - 0) / var_112_1)
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["10095"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_112_2 = arg_109_1.actors_["10096"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos10096 = var_112_2.localPosition
				var_112_2.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10096", 7)

				for iter_112_1 = 0, var_112_2.childCount - 1 do
					local var_112_3 = var_112_2:GetChild(iter_112_1)

					if var_112_3.name == "" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				var_112_2.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10096, Vector3.New(0, -2000, 0), (arg_109_1.time_ - 0) / var_112_4)
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				var_112_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_112_5 = 0
			local var_112_6 = 0.95

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_7 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(413181026).content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 38 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_7) / 38)

				if (38 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_7) / 38)) > 0 and var_112_6 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_5
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_6, arg_109_1.talkMaxDuration)

			if var_112_5 <= arg_109_1.time_ and arg_109_1.time_ < var_112_5 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_5) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_5 + var_112_10 and arg_109_1.time_ < var_112_5 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play413181027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413181027
		arg_113_1.duration_ = 6.6

		local var_113_0 = {
			zh = 3.733,
			ja = 6.6
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
				arg_113_0:Play413181028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10095 = arg_113_1.actors_["10095"].transform.localPosition
				arg_113_1.actors_["10095"].transform.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10095", 2)

				for iter_116_0 = 0, arg_113_1.actors_["10095"].transform.childCount - 1 do
					local var_116_0 = arg_113_1.actors_["10095"].transform:GetChild(iter_116_0)

					if var_116_0.name == "" or not string.find(var_116_0.name, "split") then
						var_116_0.gameObject:SetActive(true)
					else
						var_116_0.gameObject:SetActive(false)
					end
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["10095"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10095, Vector3.New(-390, -405, -10), (arg_113_1.time_ - 0) / var_116_1)
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["10095"].transform.localPosition = Vector3.New(-390, -405, -10)
			end

			local var_116_2 = arg_113_1.actors_["10095"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10095 == nil then
				arg_113_1.var_.actorSpriteComps10095 = var_116_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_3 = 2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.actorSpriteComps10095 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								iter_116_2.color = Color.New(Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor1.r, (arg_113_1.time_ - 0) / var_116_3), Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor1.g, (arg_113_1.time_ - 0) / var_116_3), (Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor1.b, (arg_113_1.time_ - 0) / var_116_3)))
							else
								local var_116_4 = Mathf.Lerp(iter_116_2.color.r, 1, (arg_113_1.time_ - 0) / var_116_3)

								iter_116_2.color = Color.New(var_116_4, var_116_4, var_116_4)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10095 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_116_4 then
						iter_116_4.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps10095 = nil
			end

			local var_116_5 = 0
			local var_116_6 = 0.3

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1013].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_7 = arg_113_1:GetWordFromCfg(413181027)
				local var_116_8 = arg_113_1:FormatText(var_116_7.content)

				arg_113_1.text_.text = var_116_8

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_10 = 12 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 12)

				if (12 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 12)) > 0 and var_116_6 < var_116_10 then
					arg_113_1.talkMaxDuration = var_116_10

					if var_116_10 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_5
					end
				end

				arg_113_1.text_.text = var_116_8
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181027", "story_v_out_413181.awb") ~= 0 then
					local var_116_11 = manager.audio:GetVoiceLength("story_v_out_413181", "413181027", "story_v_out_413181.awb") / 1000

					if var_116_11 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_5
					end

					if var_116_7.prefab_name ~= "" and arg_113_1.actors_[var_116_7.prefab_name] ~= nil then
						local var_116_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_7.prefab_name].transform, "story_v_out_413181", "413181027", "story_v_out_413181.awb")

						arg_113_1:RecordAudio("413181027", var_116_12)
						arg_113_1:RecordAudio("413181027", var_116_12)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413181", "413181027", "story_v_out_413181.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413181", "413181027", "story_v_out_413181.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_13 = math.max(var_116_6, arg_113_1.talkMaxDuration)

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_13 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_5) / var_116_13

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_5 + var_116_13 and arg_113_1.time_ < var_116_5 + var_116_13 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play413181028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 413181028
		arg_117_1.duration_ = 6.1

		local var_117_0 = {
			zh = 6.1,
			ja = 4.633
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
				arg_117_0:Play413181029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10095"]) and arg_117_1.var_.actorSpriteComps10095 == nil then
				arg_117_1.var_.actorSpriteComps10095 = arg_117_1.actors_["10095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_0 = 2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10095"]) then
				if arg_117_1.var_.actorSpriteComps10095 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								iter_120_1.color = Color.New(Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_0), Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_0), (Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_0)))
							else
								local var_120_1 = Mathf.Lerp(iter_120_1.color.r, 1, (arg_117_1.time_ - 0) / var_120_0)

								iter_120_1.color = Color.New(var_120_1, var_120_1, var_120_1)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10095"]) and arg_117_1.var_.actorSpriteComps10095 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_120_3 then
						iter_120_3.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps10095 = nil
			end

			local var_120_2 = 0
			local var_120_3 = 0.5

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1013].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:GetWordFromCfg(413181028)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 20 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 20)

				if (20 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 20)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181028", "story_v_out_413181.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_413181", "413181028", "story_v_out_413181.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_out_413181", "413181028", "story_v_out_413181.awb")

						arg_117_1:RecordAudio("413181028", var_120_9)
						arg_117_1:RecordAudio("413181028", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_413181", "413181028", "story_v_out_413181.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_413181", "413181028", "story_v_out_413181.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_10 and arg_117_1.time_ < var_120_2 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play413181029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 413181029
		arg_121_1.duration_ = 6.57

		local var_121_0 = {
			zh = 4.133,
			ja = 6.566
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
				arg_121_0:Play413181030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10096 = arg_121_1.actors_["10096"].transform.localPosition
				arg_121_1.actors_["10096"].transform.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10096", 4)

				for iter_124_0 = 0, arg_121_1.actors_["10096"].transform.childCount - 1 do
					local var_124_0 = arg_121_1.actors_["10096"].transform:GetChild(iter_124_0)

					if var_124_0.name == "" or not string.find(var_124_0.name, "split") then
						var_124_0.gameObject:SetActive(true)
					else
						var_124_0.gameObject:SetActive(false)
					end
				end
			end

			local var_124_1 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 then
				arg_121_1.actors_["10096"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10096, Vector3.New(390, -350, -210), (arg_121_1.time_ - 0) / var_124_1)
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 then
				arg_121_1.actors_["10096"].transform.localPosition = Vector3.New(390, -350, -210)
			end

			local var_124_2 = arg_121_1.actors_["10095"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps10095 == nil then
				arg_121_1.var_.actorSpriteComps10095 = var_124_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_3 = 2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.actorSpriteComps10095 then
					for iter_124_1, iter_124_2 in pairs(arg_121_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_124_2 then
							if arg_121_1.isInRecall_ then
								iter_124_2.color = Color.New(Mathf.Lerp(iter_124_2.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_3), Mathf.Lerp(iter_124_2.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_3), (Mathf.Lerp(iter_124_2.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_3)))
							else
								local var_124_4 = Mathf.Lerp(iter_124_2.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_3)

								iter_124_2.color = Color.New(var_124_4, var_124_4, var_124_4)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps10095 then
				for iter_124_3, iter_124_4 in pairs(arg_121_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_124_4 then
						iter_124_4.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps10095 = nil
			end

			local var_124_5 = arg_121_1.actors_["10096"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps10096 == nil then
				arg_121_1.var_.actorSpriteComps10096 = var_124_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_6 = 2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 and not isNil(var_124_5) then
				if arg_121_1.var_.actorSpriteComps10096 then
					for iter_124_5, iter_124_6 in pairs(arg_121_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_124_6 then
							if arg_121_1.isInRecall_ then
								iter_124_6.color = Color.New(Mathf.Lerp(iter_124_6.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_6), Mathf.Lerp(iter_124_6.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_6), (Mathf.Lerp(iter_124_6.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_6)))
							else
								local var_124_7 = Mathf.Lerp(iter_124_6.color.r, 1, (arg_121_1.time_ - 0) / var_124_6)

								iter_124_6.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps10096 then
				for iter_124_7, iter_124_8 in pairs(arg_121_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_124_8 then
						iter_124_8.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps10096 = nil
			end

			local var_124_8 = 0
			local var_124_9 = 0.4

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_10 = arg_121_1:GetWordFromCfg(413181029)
				local var_124_11 = arg_121_1:FormatText(var_124_10.content)

				arg_121_1.text_.text = var_124_11

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_13 = 16 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 16)

				if (16 <= 0 and var_124_9 or var_124_9 * (utf8.len(var_124_11) / 16)) > 0 and var_124_9 < var_124_13 then
					arg_121_1.talkMaxDuration = var_124_13

					if var_124_13 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_13 + var_124_8
					end
				end

				arg_121_1.text_.text = var_124_11
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181029", "story_v_out_413181.awb") ~= 0 then
					local var_124_14 = manager.audio:GetVoiceLength("story_v_out_413181", "413181029", "story_v_out_413181.awb") / 1000

					if var_124_14 + var_124_8 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_8
					end

					if var_124_10.prefab_name ~= "" and arg_121_1.actors_[var_124_10.prefab_name] ~= nil then
						local var_124_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_10.prefab_name].transform, "story_v_out_413181", "413181029", "story_v_out_413181.awb")

						arg_121_1:RecordAudio("413181029", var_124_15)
						arg_121_1:RecordAudio("413181029", var_124_15)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_413181", "413181029", "story_v_out_413181.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_413181", "413181029", "story_v_out_413181.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_9, arg_121_1.talkMaxDuration)

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_8) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_8 + var_124_16 and arg_121_1.time_ < var_124_8 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play413181030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 413181030
		arg_125_1.duration_ = 6.3

		local var_125_0 = {
			zh = 5.633,
			ja = 6.3
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
				arg_125_0:Play413181031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10095 = arg_125_1.actors_["10095"].transform.localPosition
				arg_125_1.actors_["10095"].transform.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10095", 2)

				for iter_128_0 = 0, arg_125_1.actors_["10095"].transform.childCount - 1 do
					local var_128_0 = arg_125_1.actors_["10095"].transform:GetChild(iter_128_0)

					if var_128_0.name == "split_1_6" or not string.find(var_128_0.name, "split") then
						var_128_0.gameObject:SetActive(true)
					else
						var_128_0.gameObject:SetActive(false)
					end
				end
			end

			local var_128_1 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_1 then
				arg_125_1.actors_["10095"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10095, Vector3.New(-390, -405, -10), (arg_125_1.time_ - 0) / var_128_1)
			end

			if arg_125_1.time_ >= 0 + var_128_1 and arg_125_1.time_ < 0 + var_128_1 + arg_128_0 then
				arg_125_1.actors_["10095"].transform.localPosition = Vector3.New(-390, -405, -10)
			end

			local var_128_2 = arg_125_1.actors_["10096"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10096 = var_128_2.localPosition
				var_128_2.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10096", 4)

				for iter_128_1 = 0, var_128_2.childCount - 1 do
					local var_128_3 = var_128_2:GetChild(iter_128_1)

					if var_128_3.name == "" or not string.find(var_128_3.name, "split") then
						var_128_3.gameObject:SetActive(true)
					else
						var_128_3.gameObject:SetActive(false)
					end
				end
			end

			local var_128_4 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				var_128_2.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10096, Vector3.New(390, -350, -210), (arg_125_1.time_ - 0) / var_128_4)
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				var_128_2.localPosition = Vector3.New(390, -350, -210)
			end

			local var_128_5 = arg_125_1.actors_["10095"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.actorSpriteComps10095 == nil then
				arg_125_1.var_.actorSpriteComps10095 = var_128_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_6 = 2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_6 and not isNil(var_128_5) then
				if arg_125_1.var_.actorSpriteComps10095 then
					for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_128_3 then
							if arg_125_1.isInRecall_ then
								iter_128_3.color = Color.New(Mathf.Lerp(iter_128_3.color.r, arg_125_1.hightColor1.r, (arg_125_1.time_ - 0) / var_128_6), Mathf.Lerp(iter_128_3.color.g, arg_125_1.hightColor1.g, (arg_125_1.time_ - 0) / var_128_6), (Mathf.Lerp(iter_128_3.color.b, arg_125_1.hightColor1.b, (arg_125_1.time_ - 0) / var_128_6)))
							else
								local var_128_7 = Mathf.Lerp(iter_128_3.color.r, 1, (arg_125_1.time_ - 0) / var_128_6)

								iter_128_3.color = Color.New(var_128_7, var_128_7, var_128_7)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_6 and arg_125_1.time_ < 0 + var_128_6 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.actorSpriteComps10095 then
				for iter_128_4, iter_128_5 in pairs(arg_125_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_128_5 then
						iter_128_5.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_125_1.var_.actorSpriteComps10095 = nil
			end

			local var_128_8 = arg_125_1.actors_["10096"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps10096 == nil then
				arg_125_1.var_.actorSpriteComps10096 = var_128_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_9 = 2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_9 and not isNil(var_128_8) then
				if arg_125_1.var_.actorSpriteComps10096 then
					for iter_128_6, iter_128_7 in pairs(arg_125_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_128_7 then
							if arg_125_1.isInRecall_ then
								iter_128_7.color = Color.New(Mathf.Lerp(iter_128_7.color.r, arg_125_1.hightColor2.r, (arg_125_1.time_ - 0) / var_128_9), Mathf.Lerp(iter_128_7.color.g, arg_125_1.hightColor2.g, (arg_125_1.time_ - 0) / var_128_9), (Mathf.Lerp(iter_128_7.color.b, arg_125_1.hightColor2.b, (arg_125_1.time_ - 0) / var_128_9)))
							else
								local var_128_10 = Mathf.Lerp(iter_128_7.color.r, 0.5, (arg_125_1.time_ - 0) / var_128_9)

								iter_128_7.color = Color.New(var_128_10, var_128_10, var_128_10)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_9 and arg_125_1.time_ < 0 + var_128_9 + arg_128_0 and not isNil(var_128_8) and arg_125_1.var_.actorSpriteComps10096 then
				for iter_128_8, iter_128_9 in pairs(arg_125_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_128_9 then
						iter_128_9.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps10096 = nil
			end

			local var_128_11 = 0
			local var_128_12 = 0.325

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_11 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1013].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_13 = arg_125_1:GetWordFromCfg(413181030)
				local var_128_14 = arg_125_1:FormatText(var_128_13.content)

				arg_125_1.text_.text = var_128_14

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_16 = 13 <= 0 and var_128_12 or var_128_12 * (utf8.len(var_128_14) / 13)

				if (13 <= 0 and var_128_12 or var_128_12 * (utf8.len(var_128_14) / 13)) > 0 and var_128_12 < var_128_16 then
					arg_125_1.talkMaxDuration = var_128_16

					if var_128_16 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_16 + var_128_11
					end
				end

				arg_125_1.text_.text = var_128_14
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181030", "story_v_out_413181.awb") ~= 0 then
					local var_128_17 = manager.audio:GetVoiceLength("story_v_out_413181", "413181030", "story_v_out_413181.awb") / 1000

					if var_128_17 + var_128_11 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_17 + var_128_11
					end

					if var_128_13.prefab_name ~= "" and arg_125_1.actors_[var_128_13.prefab_name] ~= nil then
						local var_128_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_13.prefab_name].transform, "story_v_out_413181", "413181030", "story_v_out_413181.awb")

						arg_125_1:RecordAudio("413181030", var_128_18)
						arg_125_1:RecordAudio("413181030", var_128_18)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_413181", "413181030", "story_v_out_413181.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_413181", "413181030", "story_v_out_413181.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_19 = math.max(var_128_12, arg_125_1.talkMaxDuration)

			if var_128_11 <= arg_125_1.time_ and arg_125_1.time_ < var_128_11 + var_128_19 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_11) / var_128_19

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_11 + var_128_19 and arg_125_1.time_ < var_128_11 + var_128_19 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play413181031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413181031
		arg_129_1.duration_ = 11

		local var_129_0 = {
			zh = 9.2,
			ja = 11
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
				arg_129_0:Play413181032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10095"]) and arg_129_1.var_.actorSpriteComps10095 == nil then
				arg_129_1.var_.actorSpriteComps10095 = arg_129_1.actors_["10095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_0 = 2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10095"]) then
				if arg_129_1.var_.actorSpriteComps10095 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								iter_132_1.color = Color.New(Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor1.r, (arg_129_1.time_ - 0) / var_132_0), Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor1.g, (arg_129_1.time_ - 0) / var_132_0), (Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor1.b, (arg_129_1.time_ - 0) / var_132_0)))
							else
								local var_132_1 = Mathf.Lerp(iter_132_1.color.r, 1, (arg_129_1.time_ - 0) / var_132_0)

								iter_132_1.color = Color.New(var_132_1, var_132_1, var_132_1)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10095"]) and arg_129_1.var_.actorSpriteComps10095 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_132_3 then
						iter_132_3.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps10095 = nil
			end

			local var_132_2 = 0
			local var_132_3 = 0.775

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_2 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1013].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_4 = arg_129_1:GetWordFromCfg(413181031)
				local var_132_5 = arg_129_1:FormatText(var_132_4.content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_7 = 31 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 31)

				if (31 <= 0 and var_132_3 or var_132_3 * (utf8.len(var_132_5) / 31)) > 0 and var_132_3 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_2
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181031", "story_v_out_413181.awb") ~= 0 then
					local var_132_8 = manager.audio:GetVoiceLength("story_v_out_413181", "413181031", "story_v_out_413181.awb") / 1000

					if var_132_8 + var_132_2 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_2
					end

					if var_132_4.prefab_name ~= "" and arg_129_1.actors_[var_132_4.prefab_name] ~= nil then
						local var_132_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_4.prefab_name].transform, "story_v_out_413181", "413181031", "story_v_out_413181.awb")

						arg_129_1:RecordAudio("413181031", var_132_9)
						arg_129_1:RecordAudio("413181031", var_132_9)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_413181", "413181031", "story_v_out_413181.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_413181", "413181031", "story_v_out_413181.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_10 = math.max(var_132_3, arg_129_1.talkMaxDuration)

			if var_132_2 <= arg_129_1.time_ and arg_129_1.time_ < var_132_2 + var_132_10 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_2) / var_132_10

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_2 + var_132_10 and arg_129_1.time_ < var_132_2 + var_132_10 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play413181032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413181032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play413181033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10095 = arg_133_1.actors_["10095"].transform.localPosition
				arg_133_1.actors_["10095"].transform.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10095", 7)

				for iter_136_0 = 0, arg_133_1.actors_["10095"].transform.childCount - 1 do
					local var_136_0 = arg_133_1.actors_["10095"].transform:GetChild(iter_136_0)

					if var_136_0.name == "" or not string.find(var_136_0.name, "split") then
						var_136_0.gameObject:SetActive(true)
					else
						var_136_0.gameObject:SetActive(false)
					end
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["10095"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10095, Vector3.New(0, -2000, 0), (arg_133_1.time_ - 0) / var_136_1)
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["10095"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_136_2 = arg_133_1.actors_["10095"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps10095 == nil then
				arg_133_1.var_.actorSpriteComps10095 = var_136_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_3 = 2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.actorSpriteComps10095 then
					for iter_136_1, iter_136_2 in pairs(arg_133_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_136_2 then
							if arg_133_1.isInRecall_ then
								iter_136_2.color = Color.New(Mathf.Lerp(iter_136_2.color.r, arg_133_1.hightColor2.r, (arg_133_1.time_ - 0) / var_136_3), Mathf.Lerp(iter_136_2.color.g, arg_133_1.hightColor2.g, (arg_133_1.time_ - 0) / var_136_3), (Mathf.Lerp(iter_136_2.color.b, arg_133_1.hightColor2.b, (arg_133_1.time_ - 0) / var_136_3)))
							else
								local var_136_4 = Mathf.Lerp(iter_136_2.color.r, 0.5, (arg_133_1.time_ - 0) / var_136_3)

								iter_136_2.color = Color.New(var_136_4, var_136_4, var_136_4)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps10095 then
				for iter_136_3, iter_136_4 in pairs(arg_133_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_136_4 then
						iter_136_4.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_133_1.var_.actorSpriteComps10095 = nil
			end

			local var_136_5 = arg_133_1.actors_["10096"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10096 = var_136_5.localPosition
				var_136_5.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10096", 7)

				for iter_136_5 = 0, var_136_5.childCount - 1 do
					local var_136_6 = var_136_5:GetChild(iter_136_5)

					if var_136_6.name == "" or not string.find(var_136_6.name, "split") then
						var_136_6.gameObject:SetActive(true)
					else
						var_136_6.gameObject:SetActive(false)
					end
				end
			end

			local var_136_7 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				var_136_5.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10096, Vector3.New(0, -2000, 0), (arg_133_1.time_ - 0) / var_136_7)
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				var_136_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_136_8 = 0
			local var_136_9 = 0.675

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_10 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(413181032).content)

				arg_133_1.text_.text = var_136_10

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_12 = 27 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_10) / 27)

				if (27 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_10) / 27)) > 0 and var_136_9 < var_136_12 then
					arg_133_1.talkMaxDuration = var_136_12

					if var_136_12 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_10
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_13 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_13 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_13

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_13 and arg_133_1.time_ < var_136_8 + var_136_13 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play413181033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413181033
		arg_137_1.duration_ = 14

		local var_137_0 = {
			zh = 11.966,
			ja = 14
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
				arg_137_0:Play413181034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10095 = arg_137_1.actors_["10095"].transform.localPosition
				arg_137_1.actors_["10095"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10095", 3)

				for iter_140_0 = 0, arg_137_1.actors_["10095"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["10095"].transform:GetChild(iter_140_0)

					if var_140_0.name == "split_1_1" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["10095"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10095, Vector3.New(0, -405, -10), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["10095"].transform.localPosition = Vector3.New(0, -405, -10)
			end

			local var_140_2 = arg_137_1.actors_["10095"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps10095 == nil then
				arg_137_1.var_.actorSpriteComps10095 = var_140_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_3 = 2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.actorSpriteComps10095 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_140_2 then
							if arg_137_1.isInRecall_ then
								iter_140_2.color = Color.New(Mathf.Lerp(iter_140_2.color.r, arg_137_1.hightColor1.r, (arg_137_1.time_ - 0) / var_140_3), Mathf.Lerp(iter_140_2.color.g, arg_137_1.hightColor1.g, (arg_137_1.time_ - 0) / var_140_3), (Mathf.Lerp(iter_140_2.color.b, arg_137_1.hightColor1.b, (arg_137_1.time_ - 0) / var_140_3)))
							else
								local var_140_4 = Mathf.Lerp(iter_140_2.color.r, 1, (arg_137_1.time_ - 0) / var_140_3)

								iter_140_2.color = Color.New(var_140_4, var_140_4, var_140_4)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps10095 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_140_4 then
						iter_140_4.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_137_1.var_.actorSpriteComps10095 = nil
			end

			local var_140_5 = 0
			local var_140_6 = 1

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1013].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_7 = arg_137_1:GetWordFromCfg(413181033)
				local var_140_8 = arg_137_1:FormatText(var_140_7.content)

				arg_137_1.text_.text = var_140_8

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 40 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 40)

				if (40 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 40)) > 0 and var_140_6 < var_140_10 then
					arg_137_1.talkMaxDuration = var_140_10

					if var_140_10 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_8
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181033", "story_v_out_413181.awb") ~= 0 then
					local var_140_11 = manager.audio:GetVoiceLength("story_v_out_413181", "413181033", "story_v_out_413181.awb") / 1000

					if var_140_11 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_5
					end

					if var_140_7.prefab_name ~= "" and arg_137_1.actors_[var_140_7.prefab_name] ~= nil then
						local var_140_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_7.prefab_name].transform, "story_v_out_413181", "413181033", "story_v_out_413181.awb")

						arg_137_1:RecordAudio("413181033", var_140_12)
						arg_137_1:RecordAudio("413181033", var_140_12)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_413181", "413181033", "story_v_out_413181.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_413181", "413181033", "story_v_out_413181.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_13 = math.max(var_140_6, arg_137_1.talkMaxDuration)

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_13 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_5) / var_140_13

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_5 + var_140_13 and arg_137_1.time_ < var_140_5 + var_140_13 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play413181034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413181034
		arg_141_1.duration_ = 10.93

		local var_141_0 = {
			zh = 6.833,
			ja = 10.933
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
				arg_141_0:Play413181035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10095 = arg_141_1.actors_["10095"].transform.localPosition
				arg_141_1.actors_["10095"].transform.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10095", 7)

				for iter_144_0 = 0, arg_141_1.actors_["10095"].transform.childCount - 1 do
					local var_144_0 = arg_141_1.actors_["10095"].transform:GetChild(iter_144_0)

					if var_144_0.name == "" or not string.find(var_144_0.name, "split") then
						var_144_0.gameObject:SetActive(true)
					else
						var_144_0.gameObject:SetActive(false)
					end
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["10095"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10095, Vector3.New(0, -2000, 0), (arg_141_1.time_ - 0) / var_144_1)
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["10095"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_144_2 = arg_141_1.actors_["10096"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10096 = var_144_2.localPosition
				var_144_2.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10096", 3)

				for iter_144_1 = 0, var_144_2.childCount - 1 do
					local var_144_3 = var_144_2:GetChild(iter_144_1)

					if var_144_3.name == "" or not string.find(var_144_3.name, "split") then
						var_144_3.gameObject:SetActive(true)
					else
						var_144_3.gameObject:SetActive(false)
					end
				end
			end

			local var_144_4 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				var_144_2.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10096, Vector3.New(0, -350, -210), (arg_141_1.time_ - 0) / var_144_4)
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				var_144_2.localPosition = Vector3.New(0, -350, -210)
			end

			local var_144_5 = arg_141_1.actors_["10095"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.actorSpriteComps10095 == nil then
				arg_141_1.var_.actorSpriteComps10095 = var_144_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_6 = 2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_6 and not isNil(var_144_5) then
				if arg_141_1.var_.actorSpriteComps10095 then
					for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_144_3 then
							if arg_141_1.isInRecall_ then
								iter_144_3.color = Color.New(Mathf.Lerp(iter_144_3.color.r, arg_141_1.hightColor2.r, (arg_141_1.time_ - 0) / var_144_6), Mathf.Lerp(iter_144_3.color.g, arg_141_1.hightColor2.g, (arg_141_1.time_ - 0) / var_144_6), (Mathf.Lerp(iter_144_3.color.b, arg_141_1.hightColor2.b, (arg_141_1.time_ - 0) / var_144_6)))
							else
								local var_144_7 = Mathf.Lerp(iter_144_3.color.r, 0.5, (arg_141_1.time_ - 0) / var_144_6)

								iter_144_3.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_6 and arg_141_1.time_ < 0 + var_144_6 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.actorSpriteComps10095 then
				for iter_144_4, iter_144_5 in pairs(arg_141_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_144_5 then
						iter_144_5.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps10095 = nil
			end

			local var_144_8 = arg_141_1.actors_["10096"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.actorSpriteComps10096 == nil then
				arg_141_1.var_.actorSpriteComps10096 = var_144_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_9 = 2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_9 and not isNil(var_144_8) then
				if arg_141_1.var_.actorSpriteComps10096 then
					for iter_144_6, iter_144_7 in pairs(arg_141_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_144_7 then
							if arg_141_1.isInRecall_ then
								iter_144_7.color = Color.New(Mathf.Lerp(iter_144_7.color.r, arg_141_1.hightColor1.r, (arg_141_1.time_ - 0) / var_144_9), Mathf.Lerp(iter_144_7.color.g, arg_141_1.hightColor1.g, (arg_141_1.time_ - 0) / var_144_9), (Mathf.Lerp(iter_144_7.color.b, arg_141_1.hightColor1.b, (arg_141_1.time_ - 0) / var_144_9)))
							else
								local var_144_10 = Mathf.Lerp(iter_144_7.color.r, 1, (arg_141_1.time_ - 0) / var_144_9)

								iter_144_7.color = Color.New(var_144_10, var_144_10, var_144_10)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_9 and arg_141_1.time_ < 0 + var_144_9 + arg_144_0 and not isNil(var_144_8) and arg_141_1.var_.actorSpriteComps10096 then
				for iter_144_8, iter_144_9 in pairs(arg_141_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_144_9 then
						iter_144_9.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps10096 = nil
			end

			local var_144_11 = 0
			local var_144_12 = 0.625

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_11 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_13 = arg_141_1:GetWordFromCfg(413181034)
				local var_144_14 = arg_141_1:FormatText(var_144_13.content)

				arg_141_1.text_.text = var_144_14

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_16 = 25 <= 0 and var_144_12 or var_144_12 * (utf8.len(var_144_14) / 25)

				if (25 <= 0 and var_144_12 or var_144_12 * (utf8.len(var_144_14) / 25)) > 0 and var_144_12 < var_144_16 then
					arg_141_1.talkMaxDuration = var_144_16

					if var_144_16 + var_144_11 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_16 + var_144_11
					end
				end

				arg_141_1.text_.text = var_144_14
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181034", "story_v_out_413181.awb") ~= 0 then
					local var_144_17 = manager.audio:GetVoiceLength("story_v_out_413181", "413181034", "story_v_out_413181.awb") / 1000

					if var_144_17 + var_144_11 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_17 + var_144_11
					end

					if var_144_13.prefab_name ~= "" and arg_141_1.actors_[var_144_13.prefab_name] ~= nil then
						local var_144_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_13.prefab_name].transform, "story_v_out_413181", "413181034", "story_v_out_413181.awb")

						arg_141_1:RecordAudio("413181034", var_144_18)
						arg_141_1:RecordAudio("413181034", var_144_18)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_413181", "413181034", "story_v_out_413181.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_413181", "413181034", "story_v_out_413181.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_19 = math.max(var_144_12, arg_141_1.talkMaxDuration)

			if var_144_11 <= arg_141_1.time_ and arg_141_1.time_ < var_144_11 + var_144_19 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_11) / var_144_19

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_11 + var_144_19 and arg_141_1.time_ < var_144_11 + var_144_19 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play413181035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 413181035
		arg_145_1.duration_ = 5.27

		local var_145_0 = {
			zh = 3.966,
			ja = 5.266
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
			arg_145_1.auto_ = false
		end

		function arg_145_1.playNext_(arg_147_0)
			arg_145_1.onStoryFinished_()
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.3

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(413181035)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 12 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 12)

				if (12 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 12)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413181", "413181035", "story_v_out_413181.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_413181", "413181035", "story_v_out_413181.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_413181", "413181035", "story_v_out_413181.awb")

						arg_145_1:RecordAudio("413181035", var_148_6)
						arg_145_1:RecordAudio("413181035", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_413181", "413181035", "story_v_out_413181.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_413181", "413181035", "story_v_out_413181.awb")
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
	assets = {
		"TextureConfig/Background/F08l",
		"TextureConfig/Background/ST0601"
	},
	voices = {
		"story_v_out_413181.awb"
	}
}
