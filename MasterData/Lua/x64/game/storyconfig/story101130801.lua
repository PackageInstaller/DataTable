return {
	Play113081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113081001
		arg_1_1.duration_ = 19.47

		local var_1_0 = {
			ja = 10.699999999999,
			ko = 14.732999999999,
			zh = 13.365999999999,
			en = 19.465999999999
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
				arg_1_0:Play113081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.OM0108 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "OM0108")
				var_4_0.name = "OM0108"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.OM0108 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.OM0108

				arg_1_1.bgs_.OM0108.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "OM0108" then
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

			local var_4_8 = arg_1_1.bgs_.OM0108.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0108 = var_4_8.localPosition
			end

			local var_4_9 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_9 then
				var_4_8.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0108, Vector3.New(0, 1, 9), (arg_1_1.time_ - 0) / var_4_9)
			end

			if arg_1_1.time_ >= 0 + var_4_9 and arg_1_1.time_ < 0 + var_4_9 + arg_4_0 then
				var_4_8.localPosition = Vector3.New(0, 1, 9)
			end

			local var_4_10 = arg_1_1.bgs_.OM0108.transform

			if 0.034 < arg_1_1.time_ and arg_1_1.time_ <= 0.034 + arg_4_0 then
				arg_1_1.var_.moveOldPosOM0108 = var_4_10.localPosition
			end

			local var_4_11 = 3.5

			if 0.034 <= arg_1_1.time_ and arg_1_1.time_ < 0.034 + var_4_11 then
				var_4_10.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosOM0108, Vector3.New(0, 1, 10), (arg_1_1.time_ - 0.034) / var_4_11)
			end

			if arg_1_1.time_ >= 0.034 + var_4_11 and arg_1_1.time_ < 0.034 + var_4_11 + arg_4_0 then
				var_4_10.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_12 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_12 + 3.534 and arg_1_1.time_ < var_4_12 + 3.534 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			local var_4_16 = 1.999999999999
			local var_4_17 = 1.25

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:GetWordFromCfg(113081001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 50 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 50)

				if (50 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 50)) > 0 and var_4_17 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_16 = var_4_16 + 0.3

					if var_4_22 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081001", "story_v_out_113081.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_out_113081", "113081001", "story_v_out_113081.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_out_113081", "113081001", "story_v_out_113081.awb")

						arg_1_1:RecordAudio("113081001", var_4_24)
						arg_1_1:RecordAudio("113081001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113081", "113081001", "story_v_out_113081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113081", "113081001", "story_v_out_113081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_16 + 0.3
			local var_4_26 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "OM0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play113081002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 113081002
		arg_8_1.duration_ = 11.83

		local var_8_0 = {
			ja = 11.833,
			ko = 8,
			zh = 6.133,
			en = 8.766
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
				arg_8_0:Play113081003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.725

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:GetWordFromCfg(113081002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 29 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 29)

				if (29 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 29)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081002", "story_v_out_113081.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_113081", "113081002", "story_v_out_113081.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_113081", "113081002", "story_v_out_113081.awb")

						arg_8_1:RecordAudio("113081002", var_11_6)
						arg_8_1:RecordAudio("113081002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_113081", "113081002", "story_v_out_113081.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_113081", "113081002", "story_v_out_113081.awb")
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
	Play113081003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 113081003
		arg_12_1.duration_ = 17.9

		local var_12_0 = {
			ja = 13,
			ko = 16.033,
			zh = 14.566,
			en = 17.9
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
				arg_12_0:Play113081004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.6

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:GetWordFromCfg(113081003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 64 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 64)

				if (64 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 64)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081003", "story_v_out_113081.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_out_113081", "113081003", "story_v_out_113081.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_out_113081", "113081003", "story_v_out_113081.awb")

						arg_12_1:RecordAudio("113081003", var_15_6)
						arg_12_1:RecordAudio("113081003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_113081", "113081003", "story_v_out_113081.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_113081", "113081003", "story_v_out_113081.awb")
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
	Play113081004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 113081004
		arg_16_1.duration_ = 15.6

		local var_16_0 = {
			ja = 15.1,
			ko = 15.3,
			zh = 13.966,
			en = 15.6
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
				arg_16_0:Play113081005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.2

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:GetWordFromCfg(113081004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 48 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 48)

				if (48 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 48)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081004", "story_v_out_113081.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_113081", "113081004", "story_v_out_113081.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_113081", "113081004", "story_v_out_113081.awb")

						arg_16_1:RecordAudio("113081004", var_19_6)
						arg_16_1:RecordAudio("113081004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_113081", "113081004", "story_v_out_113081.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_113081", "113081004", "story_v_out_113081.awb")
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
	Play113081005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 113081005
		arg_20_1.duration_ = 0.02

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"

			SetActive(arg_20_1.choicesGo_, true)

			for iter_21_0, iter_21_1 in ipairs(arg_20_1.choices_) do
				SetActive(iter_21_1.go, iter_21_0 <= 2)
			end

			arg_20_1.choices_[1].txt.text = arg_20_1:FormatText(StoryChoiceCfg[193].name)
			arg_20_1.choices_[2].txt.text = arg_20_1:FormatText(StoryChoiceCfg[194].name)
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play113081006(arg_20_1)
			end

			if arg_22_0 == 2 then
				arg_20_0:Play113081006(arg_20_1)
			end

			arg_20_1:RecordChoiceLog(113081005, 193, 194)
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			return
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play113081006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 113081006
		arg_24_1.duration_ = 5.57

		local var_24_0 = {
			ja = 5.566,
			ko = 3.233,
			zh = 3.866,
			en = 2.533
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
				arg_24_0:Play113081007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:AudioAction("play", "music", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_27_2 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if "" ~= "" then
					if arg_24_1.bgmTxt_.text ~= var_27_2 and arg_24_1.bgmTxt_.text ~= "" then
						if arg_24_1.bgmTxt2_.text ~= "" then
							arg_24_1.bgmTxt_.text = arg_24_1.bgmTxt2_.text
						end

						arg_24_1.bgmTxt2_.text = var_27_2

						arg_24_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_24_1.bgmTxt_.text = var_27_2
						arg_24_1.bgmTxt2_.text = var_27_2
					end

					if arg_24_1.bgmTimer then
						arg_24_1.bgmTimer:Stop()

						arg_24_1.bgmTimer = nil
					end

					if arg_24_1.settingData.show_music_name == 1 then
						arg_24_1.musicController:SetSelectedState("show")
						arg_24_1.musicAnimator_:Play("open", 0, 0)

						if arg_24_1.settingData.music_time ~= 0 then
							arg_24_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_24_1.settingData.music_time), function()
								if arg_24_1 == nil or isNil(arg_24_1.bgmTxt_) then
									return
								end

								arg_24_1.musicController:SetSelectedState("hide")
								arg_24_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_27_3 = 0
			local var_27_4 = 0.35

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_3 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_5 = arg_24_1:GetWordFromCfg(113081006)
				local var_27_6 = arg_24_1:FormatText(var_27_5.content)

				arg_24_1.text_.text = var_27_6

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_8 = 14 <= 0 and var_27_4 or var_27_4 * (utf8.len(var_27_6) / 14)

				if (14 <= 0 and var_27_4 or var_27_4 * (utf8.len(var_27_6) / 14)) > 0 and var_27_4 < var_27_8 then
					arg_24_1.talkMaxDuration = var_27_8

					if var_27_8 + var_27_3 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_3
					end
				end

				arg_24_1.text_.text = var_27_6
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081006", "story_v_out_113081.awb") ~= 0 then
					local var_27_9 = manager.audio:GetVoiceLength("story_v_out_113081", "113081006", "story_v_out_113081.awb") / 1000

					if var_27_9 + var_27_3 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_3
					end

					if var_27_5.prefab_name ~= "" and arg_24_1.actors_[var_27_5.prefab_name] ~= nil then
						local var_27_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_5.prefab_name].transform, "story_v_out_113081", "113081006", "story_v_out_113081.awb")

						arg_24_1:RecordAudio("113081006", var_27_10)
						arg_24_1:RecordAudio("113081006", var_27_10)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_113081", "113081006", "story_v_out_113081.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_113081", "113081006", "story_v_out_113081.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_11 = math.max(var_27_4, arg_24_1.talkMaxDuration)

			if var_27_3 <= arg_24_1.time_ and arg_24_1.time_ < var_27_3 + var_27_11 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_3) / var_27_11

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_3 + var_27_11 and arg_24_1.time_ < var_27_3 + var_27_11 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play113081007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 113081007
		arg_29_1.duration_ = 16.7

		local var_29_0 = {
			ja = 16.7,
			ko = 16,
			zh = 16.533,
			en = 16.666
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
				arg_29_0:Play113081008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.6

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(113081007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 64 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 64)

				if (64 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 64)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081007", "story_v_out_113081.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_113081", "113081007", "story_v_out_113081.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_113081", "113081007", "story_v_out_113081.awb")

						arg_29_1:RecordAudio("113081007", var_32_6)
						arg_29_1:RecordAudio("113081007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_113081", "113081007", "story_v_out_113081.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_113081", "113081007", "story_v_out_113081.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play113081008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 113081008
		arg_33_1.duration_ = 7.13

		local var_33_0 = {
			ja = 6.433,
			ko = 7.133,
			zh = 5.766,
			en = 5.7
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play113081009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.65

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:GetWordFromCfg(113081008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 26 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 26)

				if (26 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 26)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081008", "story_v_out_113081.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_113081", "113081008", "story_v_out_113081.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_113081", "113081008", "story_v_out_113081.awb")

						arg_33_1:RecordAudio("113081008", var_36_6)
						arg_33_1:RecordAudio("113081008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_113081", "113081008", "story_v_out_113081.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_113081", "113081008", "story_v_out_113081.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play113081009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 113081009
		arg_37_1.duration_ = 9

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play113081010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_0 = 2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				local var_40_1 = Color.New(0, 0, 0)

				var_40_1.a = Mathf.Lerp(0, 1, (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.mask_.color = var_40_1
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				local var_40_2 = Color.New(0, 0, 0)

				var_40_2.a = 1
				arg_37_1.mask_.color = var_40_2
			end

			local var_40_3 = 2

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_4 = 2

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_4 then
				local var_40_5 = Color.New(0, 0, 0)

				var_40_5.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_3) / var_40_4)
				arg_37_1.mask_.color = var_40_5
			end

			if arg_37_1.time_ >= var_40_3 + var_40_4 and arg_37_1.time_ < var_40_3 + var_40_4 + arg_40_0 then
				local var_40_6 = Color.New(0, 0, 0)

				arg_37_1.mask_.enabled = false
				var_40_6.a = 0
				arg_37_1.mask_.color = var_40_6
			end

			local var_40_7 = "F01a"

			if arg_37_1.bgs_.F01a == nil then
				local var_40_8 = Object.Instantiate(arg_37_1.paintGo_)

				var_40_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_40_7)
				var_40_8.name = var_40_7
				var_40_8.transform.parent = arg_37_1.stage_.transform
				var_40_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.bgs_[var_40_7] = var_40_8
			end

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= 2 + arg_40_0 then
				local var_40_9 = arg_37_1.bgs_.F01a

				arg_37_1.bgs_.F01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_10 = var_40_9:GetComponent("SpriteRenderer")

				if var_40_10 and var_40_10.sprite then
					local var_40_11 = 2 * (var_40_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_9.transform.localScale = Vector3.New(var_40_11 / var_40_10.sprite.bounds.size.y < var_40_11 * manager.ui.mainCameraCom_.aspect / var_40_10.sprite.bounds.size.x and var_40_11 * manager.ui.mainCameraCom_.aspect / var_40_10.sprite.bounds.size.x or var_40_11 / var_40_10.sprite.bounds.size.y, var_40_11 / var_40_10.sprite.bounds.size.y < var_40_11 * manager.ui.mainCameraCom_.aspect / var_40_10.sprite.bounds.size.x and var_40_11 * manager.ui.mainCameraCom_.aspect / var_40_10.sprite.bounds.size.x or var_40_11 / var_40_10.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "F01a" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_12 = 4
			local var_40_13 = 0.725

			if 4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_14 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_14:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_15 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(113081009).content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 29 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 29)

				if (29 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 29)) > 0 and var_40_13 < var_40_17 then
					arg_37_1.talkMaxDuration = var_40_17
					var_40_12 = var_40_12 + 0.3

					if var_40_17 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_18 = var_40_12 + 0.3
			local var_40_19 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_18 + var_40_19 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_18) / var_40_19

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_18 + var_40_19 and arg_37_1.time_ < var_40_18 + var_40_19 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play113081010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 113081010
		arg_43_1.duration_ = 8.57

		local var_43_0 = {
			ja = 8.566,
			ko = 4.166,
			zh = 3.8,
			en = 3.2
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
				arg_43_0:Play113081011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.actors_["6046_story"] == nil and not isNil((Asset.Load("Char/" .. "6046_story"))) then
				local var_46_0 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_43_1.stage_.transform)

				var_46_0.name = "6046_story"
				var_46_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["6046_story"] = var_46_0

				local var_46_1 = var_46_0:GetComponentInChildren(typeof(CharacterEffect))

				var_46_1.enabled = true

				local var_46_2 = GameObjectTools.GetOrAddComponent(var_46_0, typeof(DynamicBoneHelper))

				if var_46_2 then
					var_46_2:EnableDynamicBone(false)
				end

				arg_43_1:ShowWeapon(var_46_1.transform, false)

				arg_43_1.var_["6046_story" .. "Animator"] = var_46_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_43_1.var_["6046_story" .. "Animator"].applyRootMotion = true
				arg_43_1.var_["6046_story" .. "LipSync"] = var_46_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_46_3 = arg_43_1.actors_["6046_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos6046_story = var_46_3.localPosition

				local var_46_4 = GameObjectTools.GetOrAddComponent(var_46_3.gameObject, typeof(DynamicBoneHelper))

				if var_46_4 then
					var_46_4:EnableDynamicBone(false)
				end
			end

			local var_46_5 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_5 then
				var_46_3.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos6046_story, Vector3.New(-0.7, -0.5, -6.3), (arg_43_1.time_ - 0) / var_46_5)
				var_46_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_3.position).x, (manager.ui.mainCamera.transform.position - var_46_3.position).y, (manager.ui.mainCamera.transform.position - var_46_3.position).z)
				var_46_3.localEulerAngles.z = 0
				var_46_3.localEulerAngles.x = 0
				var_46_3.localEulerAngles = var_46_3.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_5 and arg_43_1.time_ < 0 + var_46_5 + arg_46_0 then
				var_46_3.localPosition = Vector3.New(-0.7, -0.5, -6.3)
				var_46_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_3.position).x, (manager.ui.mainCamera.transform.position - var_46_3.position).y, (manager.ui.mainCamera.transform.position - var_46_3.position).z)
				var_46_3.localEulerAngles.z = 0
				var_46_3.localEulerAngles.x = 0
				var_46_3.localEulerAngles = var_46_3.localEulerAngles

				local var_46_6 = GameObjectTools.GetOrAddComponent(var_46_3.gameObject, typeof(DynamicBoneHelper))

				if var_46_6 then
					var_46_6:EnableDynamicBone(true)
				end
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_46_7 = arg_43_1.actors_["6046_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_7) and arg_43_1.var_.characterEffect6046_story == nil then
				arg_43_1.var_.characterEffect6046_story = var_46_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_8 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_8 and not isNil(var_46_7) then
				if arg_43_1.var_.characterEffect6046_story and not isNil(var_46_7) then
					arg_43_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_8 and arg_43_1.time_ < 0 + var_46_8 + arg_46_0 and not isNil(var_46_7) and arg_43_1.var_.characterEffect6046_story then
				arg_43_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_46_10 = 0
			local var_46_11 = 0.3

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_12 = arg_43_1:GetWordFromCfg(113081010)
				local var_46_13 = arg_43_1:FormatText(var_46_12.content)

				arg_43_1.text_.text = var_46_13

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_15 = 12 <= 0 and var_46_11 or var_46_11 * (utf8.len(var_46_13) / 12)

				if (12 <= 0 and var_46_11 or var_46_11 * (utf8.len(var_46_13) / 12)) > 0 and var_46_11 < var_46_15 then
					arg_43_1.talkMaxDuration = var_46_15

					if var_46_15 + var_46_10 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_15 + var_46_10
					end
				end

				arg_43_1.text_.text = var_46_13
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081010", "story_v_out_113081.awb") ~= 0 then
					local var_46_16 = manager.audio:GetVoiceLength("story_v_out_113081", "113081010", "story_v_out_113081.awb") / 1000

					if var_46_16 + var_46_10 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_16 + var_46_10
					end

					if var_46_12.prefab_name ~= "" and arg_43_1.actors_[var_46_12.prefab_name] ~= nil then
						local var_46_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_12.prefab_name].transform, "story_v_out_113081", "113081010", "story_v_out_113081.awb")

						arg_43_1:RecordAudio("113081010", var_46_17)
						arg_43_1:RecordAudio("113081010", var_46_17)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_113081", "113081010", "story_v_out_113081.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_113081", "113081010", "story_v_out_113081.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_18 = math.max(var_46_11, arg_43_1.talkMaxDuration)

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_18 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_10) / var_46_18

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_10 + var_46_18 and arg_43_1.time_ < var_46_10 + var_46_18 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play113081011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 113081011
		arg_47_1.duration_ = 15.77

		local var_47_0 = {
			ja = 15.766,
			ko = 12.433,
			zh = 12.633,
			en = 15.566
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
				arg_47_0:Play113081012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if arg_47_1.actors_["6045_story"] == nil and not isNil((Asset.Load("Char/" .. "6045_story"))) then
				local var_50_0 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_47_1.stage_.transform)

				var_50_0.name = "6045_story"
				var_50_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_["6045_story"] = var_50_0

				local var_50_1 = var_50_0:GetComponentInChildren(typeof(CharacterEffect))

				var_50_1.enabled = true

				local var_50_2 = GameObjectTools.GetOrAddComponent(var_50_0, typeof(DynamicBoneHelper))

				if var_50_2 then
					var_50_2:EnableDynamicBone(false)
				end

				arg_47_1:ShowWeapon(var_50_1.transform, false)

				arg_47_1.var_["6045_story" .. "Animator"] = var_50_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_47_1.var_["6045_story" .. "Animator"].applyRootMotion = true
				arg_47_1.var_["6045_story" .. "LipSync"] = var_50_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_50_3 = arg_47_1.actors_["6045_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos6045_story = var_50_3.localPosition

				local var_50_4 = GameObjectTools.GetOrAddComponent(var_50_3.gameObject, typeof(DynamicBoneHelper))

				if var_50_4 then
					var_50_4:EnableDynamicBone(false)
				end
			end

			local var_50_5 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 then
				var_50_3.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos6045_story, Vector3.New(0.7, -0.5, -6.3), (arg_47_1.time_ - 0) / var_50_5)
				var_50_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_3.position).x, (manager.ui.mainCamera.transform.position - var_50_3.position).y, (manager.ui.mainCamera.transform.position - var_50_3.position).z)
				var_50_3.localEulerAngles.z = 0
				var_50_3.localEulerAngles.x = 0
				var_50_3.localEulerAngles = var_50_3.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 then
				var_50_3.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_50_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_3.position).x, (manager.ui.mainCamera.transform.position - var_50_3.position).y, (manager.ui.mainCamera.transform.position - var_50_3.position).z)
				var_50_3.localEulerAngles.z = 0
				var_50_3.localEulerAngles.x = 0
				var_50_3.localEulerAngles = var_50_3.localEulerAngles

				local var_50_6 = GameObjectTools.GetOrAddComponent(var_50_3.gameObject, typeof(DynamicBoneHelper))

				if var_50_6 then
					var_50_6:EnableDynamicBone(true)
				end
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action2_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_50_7 = arg_47_1.actors_["6046_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_7) and arg_47_1.var_.characterEffect6046_story == nil then
				arg_47_1.var_.characterEffect6046_story = var_50_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_8 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_8 and not isNil(var_50_7) then
				if arg_47_1.var_.characterEffect6046_story and not isNil(var_50_7) then
					arg_47_1.var_.characterEffect6046_story.fillFlat = true
					arg_47_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_8)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_8 and arg_47_1.time_ < 0 + var_50_8 + arg_50_0 and not isNil(var_50_7) and arg_47_1.var_.characterEffect6046_story then
				arg_47_1.var_.characterEffect6046_story.fillFlat = true
				arg_47_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_50_9 = arg_47_1.actors_["6045_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_9) and arg_47_1.var_.characterEffect6045_story == nil then
				arg_47_1.var_.characterEffect6045_story = var_50_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_10 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_10 and not isNil(var_50_9) then
				if arg_47_1.var_.characterEffect6045_story and not isNil(var_50_9) then
					arg_47_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_10 and arg_47_1.time_ < 0 + var_50_10 + arg_50_0 and not isNil(var_50_9) and arg_47_1.var_.characterEffect6045_story then
				arg_47_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_50_12 = 0
			local var_50_13 = 1.2

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_12 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_14 = arg_47_1:GetWordFromCfg(113081011)
				local var_50_15 = arg_47_1:FormatText(var_50_14.content)

				arg_47_1.text_.text = var_50_15

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_17 = 48 <= 0 and var_50_13 or var_50_13 * (utf8.len(var_50_15) / 48)

				if (48 <= 0 and var_50_13 or var_50_13 * (utf8.len(var_50_15) / 48)) > 0 and var_50_13 < var_50_17 then
					arg_47_1.talkMaxDuration = var_50_17

					if var_50_17 + var_50_12 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_17 + var_50_12
					end
				end

				arg_47_1.text_.text = var_50_15
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081011", "story_v_out_113081.awb") ~= 0 then
					local var_50_18 = manager.audio:GetVoiceLength("story_v_out_113081", "113081011", "story_v_out_113081.awb") / 1000

					if var_50_18 + var_50_12 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_18 + var_50_12
					end

					if var_50_14.prefab_name ~= "" and arg_47_1.actors_[var_50_14.prefab_name] ~= nil then
						local var_50_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_14.prefab_name].transform, "story_v_out_113081", "113081011", "story_v_out_113081.awb")

						arg_47_1:RecordAudio("113081011", var_50_19)
						arg_47_1:RecordAudio("113081011", var_50_19)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_113081", "113081011", "story_v_out_113081.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_113081", "113081011", "story_v_out_113081.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_20 = math.max(var_50_13, arg_47_1.talkMaxDuration)

			if var_50_12 <= arg_47_1.time_ and arg_47_1.time_ < var_50_12 + var_50_20 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_12) / var_50_20

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_12 + var_50_20 and arg_47_1.time_ < var_50_12 + var_50_20 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play113081012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 113081012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play113081013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos6045_story = arg_51_1.actors_["6045_story"].transform.localPosition

				local var_54_0 = GameObjectTools.GetOrAddComponent(arg_51_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_54_0 then
					var_54_0:EnableDynamicBone(false)
				end
			end

			local var_54_1 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_1 then
				arg_51_1.actors_["6045_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos6045_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_1)
				arg_51_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["6045_story"].transform.position).z)
				arg_51_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["6045_story"].transform.localEulerAngles = arg_51_1.actors_["6045_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 then
				arg_51_1.actors_["6045_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["6045_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["6045_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["6045_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["6045_story"].transform.position).z)
				arg_51_1.actors_["6045_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["6045_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["6045_story"].transform.localEulerAngles = arg_51_1.actors_["6045_story"].transform.localEulerAngles

				local var_54_2 = GameObjectTools.GetOrAddComponent(arg_51_1.actors_["6045_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_54_2 then
					var_54_2:EnableDynamicBone(true)
				end
			end

			local var_54_3 = arg_51_1.actors_["6046_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos6046_story = var_54_3.localPosition

				local var_54_4 = GameObjectTools.GetOrAddComponent(var_54_3.gameObject, typeof(DynamicBoneHelper))

				if var_54_4 then
					var_54_4:EnableDynamicBone(false)
				end
			end

			local var_54_5 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_5 then
				var_54_3.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 0) / var_54_5)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_5 and arg_51_1.time_ < 0 + var_54_5 + arg_54_0 then
				var_54_3.localPosition = Vector3.New(0, 100, 0)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles

				local var_54_6 = GameObjectTools.GetOrAddComponent(var_54_3.gameObject, typeof(DynamicBoneHelper))

				if var_54_6 then
					var_54_6:EnableDynamicBone(true)
				end
			end

			local var_54_7 = 0
			local var_54_8 = 0.325

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_7 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_9 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(113081012).content)

				arg_51_1.text_.text = var_54_9

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_11 = 13 <= 0 and var_54_8 or var_54_8 * (utf8.len(var_54_9) / 13)

				if (13 <= 0 and var_54_8 or var_54_8 * (utf8.len(var_54_9) / 13)) > 0 and var_54_8 < var_54_11 then
					arg_51_1.talkMaxDuration = var_54_11

					if var_54_11 + var_54_7 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_11 + var_54_7
					end
				end

				arg_51_1.text_.text = var_54_9
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_12 = math.max(var_54_8, arg_51_1.talkMaxDuration)

			if var_54_7 <= arg_51_1.time_ and arg_51_1.time_ < var_54_7 + var_54_12 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_7) / var_54_12

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_7 + var_54_12 and arg_51_1.time_ < var_54_7 + var_54_12 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play113081013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 113081013
		arg_55_1.duration_ = 3.23

		local var_55_0 = {
			ja = 2.2,
			ko = 3.233,
			zh = 2.6,
			en = 1.999999999999
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
				arg_55_0:Play113081014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos6046_story = arg_55_1.actors_["6046_story"].transform.localPosition

				local var_58_0 = GameObjectTools.GetOrAddComponent(arg_55_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_58_0 then
					var_58_0:EnableDynamicBone(false)
				end
			end

			local var_58_1 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 then
				arg_55_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos6046_story, Vector3.New(0, -0.5, -6.3), (arg_55_1.time_ - 0) / var_58_1)
				arg_55_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["6046_story"].transform.position).z)
				arg_55_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["6046_story"].transform.localEulerAngles = arg_55_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 then
				arg_55_1.actors_["6046_story"].transform.localPosition = Vector3.New(0, -0.5, -6.3)
				arg_55_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["6046_story"].transform.position).z)
				arg_55_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["6046_story"].transform.localEulerAngles = arg_55_1.actors_["6046_story"].transform.localEulerAngles

				local var_58_2 = GameObjectTools.GetOrAddComponent(arg_55_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_58_2 then
					var_58_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_58_3 = arg_55_1.actors_["6046_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect6046_story == nil then
				arg_55_1.var_.characterEffect6046_story = var_58_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_4 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 and not isNil(var_58_3) then
				if arg_55_1.var_.characterEffect6046_story and not isNil(var_58_3) then
					arg_55_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect6046_story then
				arg_55_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_58_6 = 0
			local var_58_7 = 0.175

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_8 = arg_55_1:GetWordFromCfg(113081013)
				local var_58_9 = arg_55_1:FormatText(var_58_8.content)

				arg_55_1.text_.text = var_58_9

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_11 = 7 <= 0 and var_58_7 or var_58_7 * (utf8.len(var_58_9) / 7)

				if (7 <= 0 and var_58_7 or var_58_7 * (utf8.len(var_58_9) / 7)) > 0 and var_58_7 < var_58_11 then
					arg_55_1.talkMaxDuration = var_58_11

					if var_58_11 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_11 + var_58_6
					end
				end

				arg_55_1.text_.text = var_58_9
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081013", "story_v_out_113081.awb") ~= 0 then
					local var_58_12 = manager.audio:GetVoiceLength("story_v_out_113081", "113081013", "story_v_out_113081.awb") / 1000

					if var_58_12 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_12 + var_58_6
					end

					if var_58_8.prefab_name ~= "" and arg_55_1.actors_[var_58_8.prefab_name] ~= nil then
						local var_58_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_8.prefab_name].transform, "story_v_out_113081", "113081013", "story_v_out_113081.awb")

						arg_55_1:RecordAudio("113081013", var_58_13)
						arg_55_1:RecordAudio("113081013", var_58_13)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_113081", "113081013", "story_v_out_113081.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_113081", "113081013", "story_v_out_113081.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_14 = math.max(var_58_7, arg_55_1.talkMaxDuration)

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_14 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_6) / var_58_14

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_6 + var_58_14 and arg_55_1.time_ < var_58_6 + var_58_14 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play113081014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 113081014
		arg_59_1.duration_ = 6.43

		local var_59_0 = {
			ja = 6.433,
			ko = 3.866,
			zh = 4.133,
			en = 2.7
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
				arg_59_0:Play113081015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046actionlink/6046action442")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_62_0 = 0
			local var_62_1 = 0.375

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_2 = arg_59_1:GetWordFromCfg(113081014)
				local var_62_3 = arg_59_1:FormatText(var_62_2.content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 15 <= 0 and var_62_1 or var_62_1 * (utf8.len(var_62_3) / 15)

				if (15 <= 0 and var_62_1 or var_62_1 * (utf8.len(var_62_3) / 15)) > 0 and var_62_1 < var_62_5 then
					arg_59_1.talkMaxDuration = var_62_5

					if var_62_5 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081014", "story_v_out_113081.awb") ~= 0 then
					local var_62_6 = manager.audio:GetVoiceLength("story_v_out_113081", "113081014", "story_v_out_113081.awb") / 1000

					if var_62_6 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_0
					end

					if var_62_2.prefab_name ~= "" and arg_59_1.actors_[var_62_2.prefab_name] ~= nil then
						local var_62_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_2.prefab_name].transform, "story_v_out_113081", "113081014", "story_v_out_113081.awb")

						arg_59_1:RecordAudio("113081014", var_62_7)
						arg_59_1:RecordAudio("113081014", var_62_7)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_113081", "113081014", "story_v_out_113081.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_113081", "113081014", "story_v_out_113081.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_8 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_8 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_8

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_8 and arg_59_1.time_ < var_62_0 + var_62_8 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play113081015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 113081015
		arg_63_1.duration_ = 5.1

		local var_63_0 = {
			ja = 5.1,
			ko = 2.966,
			zh = 3.5,
			en = 3.233
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
				arg_63_0:Play113081016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos6046_story = arg_63_1.actors_["6046_story"].transform.localPosition

				local var_66_0 = GameObjectTools.GetOrAddComponent(arg_63_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_66_0 then
					var_66_0:EnableDynamicBone(false)
				end
			end

			local var_66_1 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_1 then
				arg_63_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_63_1.time_ - 0) / var_66_1)
				arg_63_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["6046_story"].transform.position).z)
				arg_63_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["6046_story"].transform.localEulerAngles = arg_63_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_1 and arg_63_1.time_ < 0 + var_66_1 + arg_66_0 then
				arg_63_1.actors_["6046_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["6046_story"].transform.position).z)
				arg_63_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["6046_story"].transform.localEulerAngles = arg_63_1.actors_["6046_story"].transform.localEulerAngles

				local var_66_2 = GameObjectTools.GetOrAddComponent(arg_63_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_66_2 then
					var_66_2:EnableDynamicBone(true)
				end
			end

			local var_66_3 = "1084ui_story"

			if arg_63_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_66_4 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_63_1.stage_.transform)

				var_66_4.name = var_66_3
				var_66_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.actors_[var_66_3] = var_66_4

				local var_66_5 = var_66_4:GetComponentInChildren(typeof(CharacterEffect))

				var_66_5.enabled = true

				local var_66_6 = GameObjectTools.GetOrAddComponent(var_66_4, typeof(DynamicBoneHelper))

				if var_66_6 then
					var_66_6:EnableDynamicBone(false)
				end

				arg_63_1:ShowWeapon(var_66_5.transform, false)

				arg_63_1.var_[var_66_3 .. "Animator"] = var_66_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_63_1.var_[var_66_3 .. "Animator"].applyRootMotion = true
				arg_63_1.var_[var_66_3 .. "LipSync"] = var_66_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_66_7 = arg_63_1.actors_["1084ui_story"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1084ui_story = var_66_7.localPosition
			end

			local var_66_8 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_8 then
				var_66_7.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_63_1.time_ - 0) / var_66_8)
				var_66_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_7.position).x, (manager.ui.mainCamera.transform.position - var_66_7.position).y, (manager.ui.mainCamera.transform.position - var_66_7.position).z)
				var_66_7.localEulerAngles.z = 0
				var_66_7.localEulerAngles.x = 0
				var_66_7.localEulerAngles = var_66_7.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_8 and arg_63_1.time_ < 0 + var_66_8 + arg_66_0 then
				var_66_7.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_66_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_7.position).x, (manager.ui.mainCamera.transform.position - var_66_7.position).y, (manager.ui.mainCamera.transform.position - var_66_7.position).z)
				var_66_7.localEulerAngles.z = 0
				var_66_7.localEulerAngles.x = 0
				var_66_7.localEulerAngles = var_66_7.localEulerAngles
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_66_9 = arg_63_1.actors_["1084ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_9) and arg_63_1.var_.characterEffect1084ui_story == nil then
				arg_63_1.var_.characterEffect1084ui_story = var_66_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_10 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_10 and not isNil(var_66_9) then
				if arg_63_1.var_.characterEffect1084ui_story and not isNil(var_66_9) then
					arg_63_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_10 and arg_63_1.time_ < 0 + var_66_10 + arg_66_0 and not isNil(var_66_9) and arg_63_1.var_.characterEffect1084ui_story then
				arg_63_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_66_12 = 0
			local var_66_13 = 0.2

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_12 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_14 = arg_63_1:GetWordFromCfg(113081015)
				local var_66_15 = arg_63_1:FormatText(var_66_14.content)

				arg_63_1.text_.text = var_66_15

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_17 = 8 <= 0 and var_66_13 or var_66_13 * (utf8.len(var_66_15) / 8)

				if (8 <= 0 and var_66_13 or var_66_13 * (utf8.len(var_66_15) / 8)) > 0 and var_66_13 < var_66_17 then
					arg_63_1.talkMaxDuration = var_66_17

					if var_66_17 + var_66_12 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_17 + var_66_12
					end
				end

				arg_63_1.text_.text = var_66_15
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081015", "story_v_out_113081.awb") ~= 0 then
					local var_66_18 = manager.audio:GetVoiceLength("story_v_out_113081", "113081015", "story_v_out_113081.awb") / 1000

					if var_66_18 + var_66_12 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_18 + var_66_12
					end

					if var_66_14.prefab_name ~= "" and arg_63_1.actors_[var_66_14.prefab_name] ~= nil then
						local var_66_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_14.prefab_name].transform, "story_v_out_113081", "113081015", "story_v_out_113081.awb")

						arg_63_1:RecordAudio("113081015", var_66_19)
						arg_63_1:RecordAudio("113081015", var_66_19)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_113081", "113081015", "story_v_out_113081.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_113081", "113081015", "story_v_out_113081.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_20 = math.max(var_66_13, arg_63_1.talkMaxDuration)

			if var_66_12 <= arg_63_1.time_ and arg_63_1.time_ < var_66_12 + var_66_20 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_12) / var_66_20

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_12 + var_66_20 and arg_63_1.time_ < var_66_12 + var_66_20 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play113081016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 113081016
		arg_67_1.duration_ = 3.4

		local var_67_0 = {
			ja = 3.4,
			ko = 2.633,
			zh = 3.066,
			en = 3.133
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
				arg_67_0:Play113081017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1084ui_story"]) and arg_67_1.var_.characterEffect1084ui_story == nil then
				arg_67_1.var_.characterEffect1084ui_story = arg_67_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1084ui_story"]) then
				if arg_67_1.var_.characterEffect1084ui_story and not isNil(arg_67_1.actors_["1084ui_story"]) then
					arg_67_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1084ui_story"]) and arg_67_1.var_.characterEffect1084ui_story then
				arg_67_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_70_1 = "1042ui_story"

			if arg_67_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_70_2 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_67_1.stage_.transform)

				var_70_2.name = var_70_1
				var_70_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_[var_70_1] = var_70_2

				local var_70_3 = var_70_2:GetComponentInChildren(typeof(CharacterEffect))

				var_70_3.enabled = true

				local var_70_4 = GameObjectTools.GetOrAddComponent(var_70_2, typeof(DynamicBoneHelper))

				if var_70_4 then
					var_70_4:EnableDynamicBone(false)
				end

				arg_67_1:ShowWeapon(var_70_3.transform, false)

				arg_67_1.var_[var_70_1 .. "Animator"] = var_70_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_67_1.var_[var_70_1 .. "Animator"].applyRootMotion = true
				arg_67_1.var_[var_70_1 .. "LipSync"] = var_70_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_70_5 = arg_67_1.actors_["1042ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect1042ui_story == nil then
				arg_67_1.var_.characterEffect1042ui_story = var_70_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_6 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_6 and not isNil(var_70_5) then
				if arg_67_1.var_.characterEffect1042ui_story and not isNil(var_70_5) then
					arg_67_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_6 and arg_67_1.time_ < 0 + var_70_6 + arg_70_0 and not isNil(var_70_5) and arg_67_1.var_.characterEffect1042ui_story then
				arg_67_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_70_8 = arg_67_1.actors_["1042ui_story"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1042ui_story = var_70_8.localPosition
			end

			local var_70_9 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_9 then
				var_70_8.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_67_1.time_ - 0) / var_70_9)
				var_70_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_8.position).x, (manager.ui.mainCamera.transform.position - var_70_8.position).y, (manager.ui.mainCamera.transform.position - var_70_8.position).z)
				var_70_8.localEulerAngles.z = 0
				var_70_8.localEulerAngles.x = 0
				var_70_8.localEulerAngles = var_70_8.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_9 and arg_67_1.time_ < 0 + var_70_9 + arg_70_0 then
				var_70_8.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_70_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_8.position).x, (manager.ui.mainCamera.transform.position - var_70_8.position).y, (manager.ui.mainCamera.transform.position - var_70_8.position).z)
				var_70_8.localEulerAngles.z = 0
				var_70_8.localEulerAngles.x = 0
				var_70_8.localEulerAngles = var_70_8.localEulerAngles
			end

			local var_70_10 = 0
			local var_70_11 = 0.3

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_12 = arg_67_1:GetWordFromCfg(113081016)
				local var_70_13 = arg_67_1:FormatText(var_70_12.content)

				arg_67_1.text_.text = var_70_13

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_15 = 12 <= 0 and var_70_11 or var_70_11 * (utf8.len(var_70_13) / 12)

				if (12 <= 0 and var_70_11 or var_70_11 * (utf8.len(var_70_13) / 12)) > 0 and var_70_11 < var_70_15 then
					arg_67_1.talkMaxDuration = var_70_15

					if var_70_15 + var_70_10 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_15 + var_70_10
					end
				end

				arg_67_1.text_.text = var_70_13
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081016", "story_v_out_113081.awb") ~= 0 then
					local var_70_16 = manager.audio:GetVoiceLength("story_v_out_113081", "113081016", "story_v_out_113081.awb") / 1000

					if var_70_16 + var_70_10 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_16 + var_70_10
					end

					if var_70_12.prefab_name ~= "" and arg_67_1.actors_[var_70_12.prefab_name] ~= nil then
						local var_70_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_12.prefab_name].transform, "story_v_out_113081", "113081016", "story_v_out_113081.awb")

						arg_67_1:RecordAudio("113081016", var_70_17)
						arg_67_1:RecordAudio("113081016", var_70_17)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_113081", "113081016", "story_v_out_113081.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_113081", "113081016", "story_v_out_113081.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_18 = math.max(var_70_11, arg_67_1.talkMaxDuration)

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_18 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_10) / var_70_18

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_10 + var_70_18 and arg_67_1.time_ < var_70_10 + var_70_18 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play113081017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 113081017
		arg_71_1.duration_ = 16.07

		local var_71_0 = {
			ja = 7.666,
			ko = 11.1,
			zh = 11.333,
			en = 16.066
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play113081018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1042ui_story = arg_71_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1042ui_story"].transform.position).z)
				arg_71_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1042ui_story"].transform.localEulerAngles = arg_71_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_71_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1042ui_story"].transform.position).z)
				arg_71_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1042ui_story"].transform.localEulerAngles = arg_71_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_74_1 = 0
			local var_74_2 = 1.325

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(113081017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_6 = 51 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_4) / 51)

				if (51 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_4) / 51)) > 0 and var_74_2 < var_74_6 then
					arg_71_1.talkMaxDuration = var_74_6

					if var_74_6 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_6 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081017", "story_v_out_113081.awb") ~= 0 then
					local var_74_7 = manager.audio:GetVoiceLength("story_v_out_113081", "113081017", "story_v_out_113081.awb") / 1000

					if var_74_7 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_1
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_113081", "113081017", "story_v_out_113081.awb")

						arg_71_1:RecordAudio("113081017", var_74_8)
						arg_71_1:RecordAudio("113081017", var_74_8)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_113081", "113081017", "story_v_out_113081.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_113081", "113081017", "story_v_out_113081.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_9 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_9 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_9

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_9 and arg_71_1.time_ < var_74_1 + var_74_9 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play113081018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 113081018
		arg_75_1.duration_ = 9.4

		local var_75_0 = {
			ja = 5.333,
			ko = 5.8,
			zh = 5.833,
			en = 9.4
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play113081019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_78_0 = 0
			local var_78_1 = 0.675

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_2 = arg_75_1:GetWordFromCfg(113081018)
				local var_78_3 = arg_75_1:FormatText(var_78_2.content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 27 <= 0 and var_78_1 or var_78_1 * (utf8.len(var_78_3) / 27)

				if (27 <= 0 and var_78_1 or var_78_1 * (utf8.len(var_78_3) / 27)) > 0 and var_78_1 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081018", "story_v_out_113081.awb") ~= 0 then
					local var_78_6 = manager.audio:GetVoiceLength("story_v_out_113081", "113081018", "story_v_out_113081.awb") / 1000

					if var_78_6 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_0
					end

					if var_78_2.prefab_name ~= "" and arg_75_1.actors_[var_78_2.prefab_name] ~= nil then
						local var_78_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_2.prefab_name].transform, "story_v_out_113081", "113081018", "story_v_out_113081.awb")

						arg_75_1:RecordAudio("113081018", var_78_7)
						arg_75_1:RecordAudio("113081018", var_78_7)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_113081", "113081018", "story_v_out_113081.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_113081", "113081018", "story_v_out_113081.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_8 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_8 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_8

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_8 and arg_75_1.time_ < var_78_0 + var_78_8 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play113081019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 113081019
		arg_79_1.duration_ = 4.07

		local var_79_0 = {
			ja = 2.766,
			ko = 2.266,
			zh = 2.3,
			en = 4.066
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play113081020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action41213")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_82_0 = arg_79_1.actors_["1084ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1084ui_story == nil then
				arg_79_1.var_.characterEffect1084ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_1 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 and not isNil(var_82_0) then
				if arg_79_1.var_.characterEffect1084ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1084ui_story then
				arg_79_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_82_3 = arg_79_1.actors_["1042ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_3) and arg_79_1.var_.characterEffect1042ui_story == nil then
				arg_79_1.var_.characterEffect1042ui_story = var_82_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_4 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 and not isNil(var_82_3) then
				if arg_79_1.var_.characterEffect1042ui_story and not isNil(var_82_3) then
					arg_79_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_4)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 and not isNil(var_82_3) and arg_79_1.var_.characterEffect1042ui_story then
				arg_79_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_82_5 = 0
			local var_82_6 = 0.175

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_7 = arg_79_1:GetWordFromCfg(113081019)
				local var_82_8 = arg_79_1:FormatText(var_82_7.content)

				arg_79_1.text_.text = var_82_8

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_10 = 7 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_8) / 7)

				if (7 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_8) / 7)) > 0 and var_82_6 < var_82_10 then
					arg_79_1.talkMaxDuration = var_82_10

					if var_82_10 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_5
					end
				end

				arg_79_1.text_.text = var_82_8
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081019", "story_v_out_113081.awb") ~= 0 then
					local var_82_11 = manager.audio:GetVoiceLength("story_v_out_113081", "113081019", "story_v_out_113081.awb") / 1000

					if var_82_11 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_11 + var_82_5
					end

					if var_82_7.prefab_name ~= "" and arg_79_1.actors_[var_82_7.prefab_name] ~= nil then
						local var_82_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_7.prefab_name].transform, "story_v_out_113081", "113081019", "story_v_out_113081.awb")

						arg_79_1:RecordAudio("113081019", var_82_12)
						arg_79_1:RecordAudio("113081019", var_82_12)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_113081", "113081019", "story_v_out_113081.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_113081", "113081019", "story_v_out_113081.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_13 = math.max(var_82_6, arg_79_1.talkMaxDuration)

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_13 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_5) / var_82_13

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_5 + var_82_13 and arg_79_1.time_ < var_82_5 + var_82_13 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play113081020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 113081020
		arg_83_1.duration_ = 17.63

		local var_83_0 = {
			ja = 13.366,
			ko = 10.166,
			zh = 11.5,
			en = 17.633
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play113081021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1084ui_story"]) and arg_83_1.var_.characterEffect1084ui_story == nil then
				arg_83_1.var_.characterEffect1084ui_story = arg_83_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1084ui_story"]) then
				if arg_83_1.var_.characterEffect1084ui_story and not isNil(arg_83_1.actors_["1084ui_story"]) then
					arg_83_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1084ui_story"]) and arg_83_1.var_.characterEffect1084ui_story then
				arg_83_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 1.4

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_3 = arg_83_1:GetWordFromCfg(113081020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 56 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 56)

				if (56 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_4) / 56)) > 0 and var_86_2 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081020", "story_v_out_113081.awb") ~= 0 then
					local var_86_7 = manager.audio:GetVoiceLength("story_v_out_113081", "113081020", "story_v_out_113081.awb") / 1000

					if var_86_7 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_1
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_113081", "113081020", "story_v_out_113081.awb")

						arg_83_1:RecordAudio("113081020", var_86_8)
						arg_83_1:RecordAudio("113081020", var_86_8)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_113081", "113081020", "story_v_out_113081.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_113081", "113081020", "story_v_out_113081.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_9 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_9 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_9

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_9 and arg_83_1.time_ < var_86_1 + var_86_9 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play113081021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 113081021
		arg_87_1.duration_ = 9.23

		local var_87_0 = {
			ja = 9.233,
			ko = 6.933,
			zh = 6.666,
			en = 8.733
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play113081022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_90_0 = arg_87_1.actors_["1042ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1042ui_story == nil then
				arg_87_1.var_.characterEffect1042ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_1 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 and not isNil(var_90_0) then
				if arg_87_1.var_.characterEffect1042ui_story and not isNil(var_90_0) then
					arg_87_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1042ui_story then
				arg_87_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_90_3 = 0
			local var_90_4 = 0.825

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_5 = arg_87_1:GetWordFromCfg(113081021)
				local var_90_6 = arg_87_1:FormatText(var_90_5.content)

				arg_87_1.text_.text = var_90_6

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_8 = 33 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_6) / 33)

				if (33 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_6) / 33)) > 0 and var_90_4 < var_90_8 then
					arg_87_1.talkMaxDuration = var_90_8

					if var_90_8 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_3
					end
				end

				arg_87_1.text_.text = var_90_6
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081021", "story_v_out_113081.awb") ~= 0 then
					local var_90_9 = manager.audio:GetVoiceLength("story_v_out_113081", "113081021", "story_v_out_113081.awb") / 1000

					if var_90_9 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_3
					end

					if var_90_5.prefab_name ~= "" and arg_87_1.actors_[var_90_5.prefab_name] ~= nil then
						local var_90_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_5.prefab_name].transform, "story_v_out_113081", "113081021", "story_v_out_113081.awb")

						arg_87_1:RecordAudio("113081021", var_90_10)
						arg_87_1:RecordAudio("113081021", var_90_10)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_113081", "113081021", "story_v_out_113081.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_113081", "113081021", "story_v_out_113081.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_11 = math.max(var_90_4, arg_87_1.talkMaxDuration)

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_11 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_3) / var_90_11

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_3 + var_90_11 and arg_87_1.time_ < var_90_3 + var_90_11 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play113081022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 113081022
		arg_91_1.duration_ = 14.7

		local var_91_0 = {
			ja = 14.133,
			ko = 9.466,
			zh = 9,
			en = 14.7
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play113081023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1042ui_story"]) and arg_91_1.var_.characterEffect1042ui_story == nil then
				arg_91_1.var_.characterEffect1042ui_story = arg_91_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1042ui_story"]) then
				if arg_91_1.var_.characterEffect1042ui_story and not isNil(arg_91_1.actors_["1042ui_story"]) then
					arg_91_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_0)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1042ui_story"]) and arg_91_1.var_.characterEffect1042ui_story then
				arg_91_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_94_1 = 0
			local var_94_2 = 1.025

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(113081022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_6 = 41 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_4) / 41)

				if (41 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_4) / 41)) > 0 and var_94_2 < var_94_6 then
					arg_91_1.talkMaxDuration = var_94_6

					if var_94_6 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081022", "story_v_out_113081.awb") ~= 0 then
					local var_94_7 = manager.audio:GetVoiceLength("story_v_out_113081", "113081022", "story_v_out_113081.awb") / 1000

					if var_94_7 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_1
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_113081", "113081022", "story_v_out_113081.awb")

						arg_91_1:RecordAudio("113081022", var_94_8)
						arg_91_1:RecordAudio("113081022", var_94_8)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_113081", "113081022", "story_v_out_113081.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_113081", "113081022", "story_v_out_113081.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_9 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_9 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_9

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_9 and arg_91_1.time_ < var_94_1 + var_94_9 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play113081023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 113081023
		arg_95_1.duration_ = 8.83

		local var_95_0 = {
			ja = 8.833,
			ko = 8.833,
			zh = 7.433,
			en = 7.9
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play113081024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			local var_98_0 = arg_95_1.actors_["1042ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1042ui_story == nil then
				arg_95_1.var_.characterEffect1042ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_1 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 and not isNil(var_98_0) then
				if arg_95_1.var_.characterEffect1042ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1042ui_story then
				arg_95_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_98_3 = 0
			local var_98_4 = 0.825

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_5 = arg_95_1:GetWordFromCfg(113081023)
				local var_98_6 = arg_95_1:FormatText(var_98_5.content)

				arg_95_1.text_.text = var_98_6

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_8 = 33 <= 0 and var_98_4 or var_98_4 * (utf8.len(var_98_6) / 33)

				if (33 <= 0 and var_98_4 or var_98_4 * (utf8.len(var_98_6) / 33)) > 0 and var_98_4 < var_98_8 then
					arg_95_1.talkMaxDuration = var_98_8

					if var_98_8 + var_98_3 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_3
					end
				end

				arg_95_1.text_.text = var_98_6
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081023", "story_v_out_113081.awb") ~= 0 then
					local var_98_9 = manager.audio:GetVoiceLength("story_v_out_113081", "113081023", "story_v_out_113081.awb") / 1000

					if var_98_9 + var_98_3 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_3
					end

					if var_98_5.prefab_name ~= "" and arg_95_1.actors_[var_98_5.prefab_name] ~= nil then
						local var_98_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_5.prefab_name].transform, "story_v_out_113081", "113081023", "story_v_out_113081.awb")

						arg_95_1:RecordAudio("113081023", var_98_10)
						arg_95_1:RecordAudio("113081023", var_98_10)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_113081", "113081023", "story_v_out_113081.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_113081", "113081023", "story_v_out_113081.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_11 = math.max(var_98_4, arg_95_1.talkMaxDuration)

			if var_98_3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_3 + var_98_11 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_3) / var_98_11

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_3 + var_98_11 and arg_95_1.time_ < var_98_3 + var_98_11 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play113081024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 113081024
		arg_99_1.duration_ = 13.87

		local var_99_0 = {
			ja = 12.633,
			ko = 11.233,
			zh = 9.7,
			en = 13.866
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play113081025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action442")
			end

			local var_102_0 = 0
			local var_102_1 = 1.25

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_2 = arg_99_1:GetWordFromCfg(113081024)
				local var_102_3 = arg_99_1:FormatText(var_102_2.content)

				arg_99_1.text_.text = var_102_3

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 50 <= 0 and var_102_1 or var_102_1 * (utf8.len(var_102_3) / 50)

				if (50 <= 0 and var_102_1 or var_102_1 * (utf8.len(var_102_3) / 50)) > 0 and var_102_1 < var_102_5 then
					arg_99_1.talkMaxDuration = var_102_5

					if var_102_5 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_3
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081024", "story_v_out_113081.awb") ~= 0 then
					local var_102_6 = manager.audio:GetVoiceLength("story_v_out_113081", "113081024", "story_v_out_113081.awb") / 1000

					if var_102_6 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_0
					end

					if var_102_2.prefab_name ~= "" and arg_99_1.actors_[var_102_2.prefab_name] ~= nil then
						local var_102_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_2.prefab_name].transform, "story_v_out_113081", "113081024", "story_v_out_113081.awb")

						arg_99_1:RecordAudio("113081024", var_102_7)
						arg_99_1:RecordAudio("113081024", var_102_7)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_113081", "113081024", "story_v_out_113081.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_113081", "113081024", "story_v_out_113081.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_8 and arg_99_1.time_ < var_102_0 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play113081025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 113081025
		arg_103_1.duration_ = 18.2

		local var_103_0 = {
			ja = 18.2,
			ko = 13.8,
			zh = 12.033,
			en = 12.566
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play113081026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_106_0 = 0
			local var_106_1 = 1.45

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_2 = arg_103_1:GetWordFromCfg(113081025)
				local var_106_3 = arg_103_1:FormatText(var_106_2.content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 58 <= 0 and var_106_1 or var_106_1 * (utf8.len(var_106_3) / 58)

				if (58 <= 0 and var_106_1 or var_106_1 * (utf8.len(var_106_3) / 58)) > 0 and var_106_1 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081025", "story_v_out_113081.awb") ~= 0 then
					local var_106_6 = manager.audio:GetVoiceLength("story_v_out_113081", "113081025", "story_v_out_113081.awb") / 1000

					if var_106_6 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_6 + var_106_0
					end

					if var_106_2.prefab_name ~= "" and arg_103_1.actors_[var_106_2.prefab_name] ~= nil then
						local var_106_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_2.prefab_name].transform, "story_v_out_113081", "113081025", "story_v_out_113081.awb")

						arg_103_1:RecordAudio("113081025", var_106_7)
						arg_103_1:RecordAudio("113081025", var_106_7)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_113081", "113081025", "story_v_out_113081.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_113081", "113081025", "story_v_out_113081.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_8 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_8 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_8

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_8 and arg_103_1.time_ < var_106_0 + var_106_8 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play113081026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 113081026
		arg_107_1.duration_ = 6.33

		local var_107_0 = {
			ja = 5.3,
			ko = 5.566,
			zh = 5.833,
			en = 6.333
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play113081027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1042ui_story"]) and arg_107_1.var_.characterEffect1042ui_story == nil then
				arg_107_1.var_.characterEffect1042ui_story = arg_107_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1042ui_story"]) then
				if arg_107_1.var_.characterEffect1042ui_story and not isNil(arg_107_1.actors_["1042ui_story"]) then
					arg_107_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1042ui_story"]) and arg_107_1.var_.characterEffect1042ui_story then
				arg_107_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4133")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_110_1 = arg_107_1.actors_["1084ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1084ui_story == nil then
				arg_107_1.var_.characterEffect1084ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect1084ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1084ui_story then
				arg_107_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_110_4 = 0
			local var_110_5 = 0.65

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(113081026)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 26 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 26)

				if (26 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 26)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081026", "story_v_out_113081.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_out_113081", "113081026", "story_v_out_113081.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_out_113081", "113081026", "story_v_out_113081.awb")

						arg_107_1:RecordAudio("113081026", var_110_11)
						arg_107_1:RecordAudio("113081026", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_113081", "113081026", "story_v_out_113081.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_113081", "113081026", "story_v_out_113081.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_12 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_12 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_12

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_12 and arg_107_1.time_ < var_110_4 + var_110_12 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play113081027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 113081027
		arg_111_1.duration_ = 14.7

		local var_111_0 = {
			ja = 14.7,
			ko = 8.366,
			zh = 8.733,
			en = 12.133
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play113081028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_114_0 = arg_111_1.actors_["1084ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1084ui_story == nil then
				arg_111_1.var_.characterEffect1084ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_1 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 and not isNil(var_114_0) then
				if arg_111_1.var_.characterEffect1084ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_1)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1084ui_story then
				arg_111_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_114_2 = arg_111_1.actors_["1042ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.characterEffect1042ui_story == nil then
				arg_111_1.var_.characterEffect1042ui_story = var_114_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_3 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.characterEffect1042ui_story and not isNil(var_114_2) then
					arg_111_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.characterEffect1042ui_story then
				arg_111_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_114_5 = 0
			local var_114_6 = 1.15

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_7 = arg_111_1:GetWordFromCfg(113081027)
				local var_114_8 = arg_111_1:FormatText(var_114_7.content)

				arg_111_1.text_.text = var_114_8

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_10 = 43 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 43)

				if (43 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 43)) > 0 and var_114_6 < var_114_10 then
					arg_111_1.talkMaxDuration = var_114_10

					if var_114_10 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_5
					end
				end

				arg_111_1.text_.text = var_114_8
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081027", "story_v_out_113081.awb") ~= 0 then
					local var_114_11 = manager.audio:GetVoiceLength("story_v_out_113081", "113081027", "story_v_out_113081.awb") / 1000

					if var_114_11 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_5
					end

					if var_114_7.prefab_name ~= "" and arg_111_1.actors_[var_114_7.prefab_name] ~= nil then
						local var_114_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_7.prefab_name].transform, "story_v_out_113081", "113081027", "story_v_out_113081.awb")

						arg_111_1:RecordAudio("113081027", var_114_12)
						arg_111_1:RecordAudio("113081027", var_114_12)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_113081", "113081027", "story_v_out_113081.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_113081", "113081027", "story_v_out_113081.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_13 = math.max(var_114_6, arg_111_1.talkMaxDuration)

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_13 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_5) / var_114_13

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_5 + var_114_13 and arg_111_1.time_ < var_114_5 + var_114_13 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play113081028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 113081028
		arg_115_1.duration_ = 2.77

		local var_115_0 = {
			ja = 2.1,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.766
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play113081029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action435")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_118_0 = arg_115_1.actors_["1084ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1084ui_story == nil then
				arg_115_1.var_.characterEffect1084ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_1 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 and not isNil(var_118_0) then
				if arg_115_1.var_.characterEffect1084ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1084ui_story then
				arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_118_3 = arg_115_1.actors_["1042ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_3) and arg_115_1.var_.characterEffect1042ui_story == nil then
				arg_115_1.var_.characterEffect1042ui_story = var_118_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_4 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 and not isNil(var_118_3) then
				if arg_115_1.var_.characterEffect1042ui_story and not isNil(var_118_3) then
					arg_115_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_115_1.time_ - 0) / var_118_4)
				end
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 and not isNil(var_118_3) and arg_115_1.var_.characterEffect1042ui_story then
				arg_115_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_118_5 = 0
			local var_118_6 = 0.125

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_7 = arg_115_1:GetWordFromCfg(113081028)
				local var_118_8 = arg_115_1:FormatText(var_118_7.content)

				arg_115_1.text_.text = var_118_8

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_10 = 5 <= 0 and var_118_6 or var_118_6 * (utf8.len(var_118_8) / 5)

				if (5 <= 0 and var_118_6 or var_118_6 * (utf8.len(var_118_8) / 5)) > 0 and var_118_6 < var_118_10 then
					arg_115_1.talkMaxDuration = var_118_10

					if var_118_10 + var_118_5 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_5
					end
				end

				arg_115_1.text_.text = var_118_8
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081028", "story_v_out_113081.awb") ~= 0 then
					local var_118_11 = manager.audio:GetVoiceLength("story_v_out_113081", "113081028", "story_v_out_113081.awb") / 1000

					if var_118_11 + var_118_5 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_11 + var_118_5
					end

					if var_118_7.prefab_name ~= "" and arg_115_1.actors_[var_118_7.prefab_name] ~= nil then
						local var_118_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_7.prefab_name].transform, "story_v_out_113081", "113081028", "story_v_out_113081.awb")

						arg_115_1:RecordAudio("113081028", var_118_12)
						arg_115_1:RecordAudio("113081028", var_118_12)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_113081", "113081028", "story_v_out_113081.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_113081", "113081028", "story_v_out_113081.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_13 = math.max(var_118_6, arg_115_1.talkMaxDuration)

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_13 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_5) / var_118_13

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_5 + var_118_13 and arg_115_1.time_ < var_118_5 + var_118_13 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play113081029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 113081029
		arg_119_1.duration_ = 9

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play113081030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_0 = 2

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				local var_122_1 = Color.New(0, 0, 0)

				var_122_1.a = Mathf.Lerp(0, 1, (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.mask_.color = var_122_1
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				local var_122_2 = Color.New(0, 0, 0)

				var_122_2.a = 1
				arg_119_1.mask_.color = var_122_2
			end

			local var_122_3 = 2

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= var_122_3 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_4 = 2

			if var_122_3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_3 + var_122_4 then
				local var_122_5 = Color.New(0, 0, 0)

				var_122_5.a = Mathf.Lerp(1, 0, (arg_119_1.time_ - var_122_3) / var_122_4)
				arg_119_1.mask_.color = var_122_5
			end

			if arg_119_1.time_ >= var_122_3 + var_122_4 and arg_119_1.time_ < var_122_3 + var_122_4 + arg_122_0 then
				local var_122_6 = Color.New(0, 0, 0)

				arg_119_1.mask_.enabled = false
				var_122_6.a = 0
				arg_119_1.mask_.color = var_122_6
			end

			local var_122_7 = arg_119_1.actors_["1042ui_story"].transform

			if 1.966 < arg_119_1.time_ and arg_119_1.time_ <= 1.966 + arg_122_0 then
				arg_119_1.var_.moveOldPos1042ui_story = var_122_7.localPosition
			end

			local var_122_8 = 0.001

			if 1.966 <= arg_119_1.time_ and arg_119_1.time_ < 1.966 + var_122_8 then
				var_122_7.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 1.966) / var_122_8)
				var_122_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_7.position).x, (manager.ui.mainCamera.transform.position - var_122_7.position).y, (manager.ui.mainCamera.transform.position - var_122_7.position).z)
				var_122_7.localEulerAngles.z = 0
				var_122_7.localEulerAngles.x = 0
				var_122_7.localEulerAngles = var_122_7.localEulerAngles
			end

			if arg_119_1.time_ >= 1.966 + var_122_8 and arg_119_1.time_ < 1.966 + var_122_8 + arg_122_0 then
				var_122_7.localPosition = Vector3.New(0, 100, 0)
				var_122_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_7.position).x, (manager.ui.mainCamera.transform.position - var_122_7.position).y, (manager.ui.mainCamera.transform.position - var_122_7.position).z)
				var_122_7.localEulerAngles.z = 0
				var_122_7.localEulerAngles.x = 0
				var_122_7.localEulerAngles = var_122_7.localEulerAngles
			end

			local var_122_9 = arg_119_1.actors_["1084ui_story"].transform

			if 1.966 < arg_119_1.time_ and arg_119_1.time_ <= 1.966 + arg_122_0 then
				arg_119_1.var_.moveOldPos1084ui_story = var_122_9.localPosition
			end

			local var_122_10 = 0.001

			if 1.966 <= arg_119_1.time_ and arg_119_1.time_ < 1.966 + var_122_10 then
				var_122_9.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 1.966) / var_122_10)
				var_122_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_9.position).x, (manager.ui.mainCamera.transform.position - var_122_9.position).y, (manager.ui.mainCamera.transform.position - var_122_9.position).z)
				var_122_9.localEulerAngles.z = 0
				var_122_9.localEulerAngles.x = 0
				var_122_9.localEulerAngles = var_122_9.localEulerAngles
			end

			if arg_119_1.time_ >= 1.966 + var_122_10 and arg_119_1.time_ < 1.966 + var_122_10 + arg_122_0 then
				var_122_9.localPosition = Vector3.New(0, 100, 0)
				var_122_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_9.position).x, (manager.ui.mainCamera.transform.position - var_122_9.position).y, (manager.ui.mainCamera.transform.position - var_122_9.position).z)
				var_122_9.localEulerAngles.z = 0
				var_122_9.localEulerAngles.x = 0
				var_122_9.localEulerAngles = var_122_9.localEulerAngles
			end

			local var_122_11 = "F03"

			if arg_119_1.bgs_.F03 == nil then
				local var_122_12 = Object.Instantiate(arg_119_1.paintGo_)

				var_122_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_122_11)
				var_122_12.name = var_122_11
				var_122_12.transform.parent = arg_119_1.stage_.transform
				var_122_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.bgs_[var_122_11] = var_122_12
			end

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= 2 + arg_122_0 then
				local var_122_13 = arg_119_1.bgs_.F03

				arg_119_1.bgs_.F03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_122_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_122_14 = var_122_13:GetComponent("SpriteRenderer")

				if var_122_14 and var_122_14.sprite then
					local var_122_15 = 2 * (var_122_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_122_13.transform.localScale = Vector3.New(var_122_15 / var_122_14.sprite.bounds.size.y < var_122_15 * manager.ui.mainCameraCom_.aspect / var_122_14.sprite.bounds.size.x and var_122_15 * manager.ui.mainCameraCom_.aspect / var_122_14.sprite.bounds.size.x or var_122_15 / var_122_14.sprite.bounds.size.y, var_122_15 / var_122_14.sprite.bounds.size.y < var_122_15 * manager.ui.mainCameraCom_.aspect / var_122_14.sprite.bounds.size.x and var_122_15 * manager.ui.mainCameraCom_.aspect / var_122_14.sprite.bounds.size.x or var_122_15 / var_122_14.sprite.bounds.size.y, 0)
				end

				for iter_122_0, iter_122_1 in pairs(arg_119_1.bgs_) do
					if iter_122_0 ~= "F03" then
						iter_122_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_16 = 4
			local var_122_17 = 0.25

			if 4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_16 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_18 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_18:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_19 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(113081029).content)

				arg_119_1.text_.text = var_122_19

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_21 = 10 <= 0 and var_122_17 or var_122_17 * (utf8.len(var_122_19) / 10)

				if (10 <= 0 and var_122_17 or var_122_17 * (utf8.len(var_122_19) / 10)) > 0 and var_122_17 < var_122_21 then
					arg_119_1.talkMaxDuration = var_122_21
					var_122_16 = var_122_16 + 0.3

					if var_122_21 + var_122_16 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_21 + var_122_16
					end
				end

				arg_119_1.text_.text = var_122_19
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_22 = var_122_16 + 0.3
			local var_122_23 = math.max(var_122_17, arg_119_1.talkMaxDuration)

			if var_122_16 + 0.3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_22 + var_122_23 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_22) / var_122_23

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_22 + var_122_23 and arg_119_1.time_ < var_122_22 + var_122_23 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play113081030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 113081030
		arg_125_1.duration_ = 5.73

		local var_125_0 = {
			ja = 3.766,
			ko = 5.733,
			zh = 5.1,
			en = 4.533
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
				arg_125_0:Play113081031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1084ui_story = arg_125_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).z)
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles = arg_125_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_125_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).z)
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles = arg_125_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_128_1 = arg_125_1.actors_["1084ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1084ui_story == nil then
				arg_125_1.var_.characterEffect1084ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1084ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1084ui_story then
				arg_125_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_128_4 = 0
			local var_128_5 = 0.45

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_6 = arg_125_1:GetWordFromCfg(113081030)
				local var_128_7 = arg_125_1:FormatText(var_128_6.content)

				arg_125_1.text_.text = var_128_7

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_9 = 18 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 18)

				if (18 <= 0 and var_128_5 or var_128_5 * (utf8.len(var_128_7) / 18)) > 0 and var_128_5 < var_128_9 then
					arg_125_1.talkMaxDuration = var_128_9

					if var_128_9 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_4
					end
				end

				arg_125_1.text_.text = var_128_7
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081030", "story_v_out_113081.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_113081", "113081030", "story_v_out_113081.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_113081", "113081030", "story_v_out_113081.awb")

						arg_125_1:RecordAudio("113081030", var_128_11)
						arg_125_1:RecordAudio("113081030", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_113081", "113081030", "story_v_out_113081.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_113081", "113081030", "story_v_out_113081.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_12 = math.max(var_128_5, arg_125_1.talkMaxDuration)

			if var_128_4 <= arg_125_1.time_ and arg_125_1.time_ < var_128_4 + var_128_12 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_4) / var_128_12

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_4 + var_128_12 and arg_125_1.time_ < var_128_4 + var_128_12 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play113081031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 113081031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play113081032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1084ui_story"]) and arg_129_1.var_.characterEffect1084ui_story == nil then
				arg_129_1.var_.characterEffect1084ui_story = arg_129_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1084ui_story"]) then
				if arg_129_1.var_.characterEffect1084ui_story and not isNil(arg_129_1.actors_["1084ui_story"]) then
					arg_129_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1084ui_story"]) and arg_129_1.var_.characterEffect1084ui_story then
				arg_129_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 1.45

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(113081031).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 58 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 58)

				if (58 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 58)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play113081032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 113081032
		arg_133_1.duration_ = 7.87

		local var_133_0 = {
			ja = 6.6,
			ko = 6.233,
			zh = 5.266,
			en = 7.866
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
				arg_133_0:Play113081033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1084ui_story"]) and arg_133_1.var_.characterEffect1084ui_story == nil then
				arg_133_1.var_.characterEffect1084ui_story = arg_133_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1084ui_story"]) then
				if arg_133_1.var_.characterEffect1084ui_story and not isNil(arg_133_1.actors_["1084ui_story"]) then
					arg_133_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1084ui_story"]) and arg_133_1.var_.characterEffect1084ui_story then
				arg_133_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_136_1 = arg_133_1.actors_["1042ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1042ui_story == nil then
				arg_133_1.var_.characterEffect1042ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1042ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1042ui_story then
				arg_133_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_136_4 = arg_133_1.actors_["1042ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1042ui_story = var_136_4.localPosition
			end

			local var_136_5 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_5 then
				var_136_4.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_133_1.time_ - 0) / var_136_5)
				var_136_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_4.position).x, (manager.ui.mainCamera.transform.position - var_136_4.position).y, (manager.ui.mainCamera.transform.position - var_136_4.position).z)
				var_136_4.localEulerAngles.z = 0
				var_136_4.localEulerAngles.x = 0
				var_136_4.localEulerAngles = var_136_4.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_5 and arg_133_1.time_ < 0 + var_136_5 + arg_136_0 then
				var_136_4.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_136_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_4.position).x, (manager.ui.mainCamera.transform.position - var_136_4.position).y, (manager.ui.mainCamera.transform.position - var_136_4.position).z)
				var_136_4.localEulerAngles.z = 0
				var_136_4.localEulerAngles.x = 0
				var_136_4.localEulerAngles = var_136_4.localEulerAngles
			end

			local var_136_6 = 0
			local var_136_7 = 0.625

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:GetWordFromCfg(113081032)
				local var_136_9 = arg_133_1:FormatText(var_136_8.content)

				arg_133_1.text_.text = var_136_9

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 25 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 25)

				if (25 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 25)) > 0 and var_136_7 < var_136_11 then
					arg_133_1.talkMaxDuration = var_136_11

					if var_136_11 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_9
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081032", "story_v_out_113081.awb") ~= 0 then
					local var_136_12 = manager.audio:GetVoiceLength("story_v_out_113081", "113081032", "story_v_out_113081.awb") / 1000

					if var_136_12 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_6
					end

					if var_136_8.prefab_name ~= "" and arg_133_1.actors_[var_136_8.prefab_name] ~= nil then
						local var_136_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_8.prefab_name].transform, "story_v_out_113081", "113081032", "story_v_out_113081.awb")

						arg_133_1:RecordAudio("113081032", var_136_13)
						arg_133_1:RecordAudio("113081032", var_136_13)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_113081", "113081032", "story_v_out_113081.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_113081", "113081032", "story_v_out_113081.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_14 and arg_133_1.time_ < var_136_6 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play113081033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 113081033
		arg_137_1.duration_ = 13

		local var_137_0 = {
			ja = 13,
			ko = 6,
			zh = 6.8,
			en = 8.233
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
				arg_137_0:Play113081034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_140_0 = 0
			local var_140_1 = 0.775

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_2 = arg_137_1:GetWordFromCfg(113081033)
				local var_140_3 = arg_137_1:FormatText(var_140_2.content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 31 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 31)

				if (31 <= 0 and var_140_1 or var_140_1 * (utf8.len(var_140_3) / 31)) > 0 and var_140_1 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081033", "story_v_out_113081.awb") ~= 0 then
					local var_140_6 = manager.audio:GetVoiceLength("story_v_out_113081", "113081033", "story_v_out_113081.awb") / 1000

					if var_140_6 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_0
					end

					if var_140_2.prefab_name ~= "" and arg_137_1.actors_[var_140_2.prefab_name] ~= nil then
						local var_140_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_2.prefab_name].transform, "story_v_out_113081", "113081033", "story_v_out_113081.awb")

						arg_137_1:RecordAudio("113081033", var_140_7)
						arg_137_1:RecordAudio("113081033", var_140_7)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_113081", "113081033", "story_v_out_113081.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_113081", "113081033", "story_v_out_113081.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_8 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_8 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_8

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_8 and arg_137_1.time_ < var_140_0 + var_140_8 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play113081034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 113081034
		arg_141_1.duration_ = 7.2

		local var_141_0 = {
			ja = 7.2,
			ko = 6.533,
			zh = 6.566,
			en = 7.2
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
				arg_141_0:Play113081035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4136")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_144_0 = arg_141_1.actors_["1084ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1084ui_story == nil then
				arg_141_1.var_.characterEffect1084ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_1 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 and not isNil(var_144_0) then
				if arg_141_1.var_.characterEffect1084ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1084ui_story then
				arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_144_3 = arg_141_1.actors_["1042ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect1042ui_story == nil then
				arg_141_1.var_.characterEffect1042ui_story = var_144_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_4 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 and not isNil(var_144_3) then
				if arg_141_1.var_.characterEffect1042ui_story and not isNil(var_144_3) then
					arg_141_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_4)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 and not isNil(var_144_3) and arg_141_1.var_.characterEffect1042ui_story then
				arg_141_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_144_5 = 0
			local var_144_6 = 0.625

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:GetWordFromCfg(113081034)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 25 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 25)

				if (25 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 25)) > 0 and var_144_6 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081034", "story_v_out_113081.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_113081", "113081034", "story_v_out_113081.awb") / 1000

					if var_144_11 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_5
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_113081", "113081034", "story_v_out_113081.awb")

						arg_141_1:RecordAudio("113081034", var_144_12)
						arg_141_1:RecordAudio("113081034", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_113081", "113081034", "story_v_out_113081.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_113081", "113081034", "story_v_out_113081.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_13 = math.max(var_144_6, arg_141_1.talkMaxDuration)

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_13 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_5) / var_144_13

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_5 + var_144_13 and arg_141_1.time_ < var_144_5 + var_144_13 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play113081035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 113081035
		arg_145_1.duration_ = 0.2

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"

			SetActive(arg_145_1.choicesGo_, true)

			for iter_146_0, iter_146_1 in ipairs(arg_145_1.choices_) do
				SetActive(iter_146_1.go, iter_146_0 <= 2)
			end

			arg_145_1.choices_[1].txt.text = arg_145_1:FormatText(StoryChoiceCfg[195].name)
			arg_145_1.choices_[2].txt.text = arg_145_1:FormatText(StoryChoiceCfg[196].name)
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play113081036(arg_145_1)
			end

			if arg_147_0 == 2 then
				arg_145_0:Play113081036(arg_145_1)
			end

			arg_145_1:RecordChoiceLog(113081035, 195, 196)
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1084ui_story"]) and arg_145_1.var_.characterEffect1084ui_story == nil then
				arg_145_1.var_.characterEffect1084ui_story = arg_145_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1084ui_story"]) then
				if arg_145_1.var_.characterEffect1084ui_story and not isNil(arg_145_1.actors_["1084ui_story"]) then
					arg_145_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1084ui_story"]) and arg_145_1.var_.characterEffect1084ui_story then
				arg_145_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play113081036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 113081036
		arg_149_1.duration_ = 9.7

		local var_149_0 = {
			ja = 9.5,
			ko = 7.433,
			zh = 6.5,
			en = 9.7
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
				arg_149_0:Play113081037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if arg_149_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_152_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_149_1.stage_.transform)

				var_152_0.name = "1084ui_story"
				var_152_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.actors_["1084ui_story"] = var_152_0

				local var_152_1 = var_152_0:GetComponentInChildren(typeof(CharacterEffect))

				var_152_1.enabled = true

				local var_152_2 = GameObjectTools.GetOrAddComponent(var_152_0, typeof(DynamicBoneHelper))

				if var_152_2 then
					var_152_2:EnableDynamicBone(false)
				end

				arg_149_1:ShowWeapon(var_152_1.transform, false)

				arg_149_1.var_["1084ui_story" .. "Animator"] = var_152_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_149_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_149_1.var_["1084ui_story" .. "LipSync"] = var_152_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_152_3 = "1084ui_story"

			if arg_149_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_152_4 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_149_1.stage_.transform)

				var_152_4.name = var_152_3
				var_152_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.actors_[var_152_3] = var_152_4

				local var_152_5 = var_152_4:GetComponentInChildren(typeof(CharacterEffect))

				var_152_5.enabled = true

				local var_152_6 = GameObjectTools.GetOrAddComponent(var_152_4, typeof(DynamicBoneHelper))

				if var_152_6 then
					var_152_6:EnableDynamicBone(false)
				end

				arg_149_1:ShowWeapon(var_152_5.transform, false)

				arg_149_1.var_[var_152_3 .. "Animator"] = var_152_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_149_1.var_[var_152_3 .. "Animator"].applyRootMotion = true
				arg_149_1.var_[var_152_3 .. "LipSync"] = var_152_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_152_7 = arg_149_1.actors_["1084ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_7) and arg_149_1.var_.characterEffect1084ui_story == nil then
				arg_149_1.var_.characterEffect1084ui_story = var_152_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_8 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_8 and not isNil(var_152_7) then
				if arg_149_1.var_.characterEffect1084ui_story and not isNil(var_152_7) then
					arg_149_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_8 and arg_149_1.time_ < 0 + var_152_8 + arg_152_0 and not isNil(var_152_7) and arg_149_1.var_.characterEffect1084ui_story then
				arg_149_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_152_10 = 0
			local var_152_11 = 0.75

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_12 = arg_149_1:GetWordFromCfg(113081036)
				local var_152_13 = arg_149_1:FormatText(var_152_12.content)

				arg_149_1.text_.text = var_152_13

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_15 = 30 <= 0 and var_152_11 or var_152_11 * (utf8.len(var_152_13) / 30)

				if (30 <= 0 and var_152_11 or var_152_11 * (utf8.len(var_152_13) / 30)) > 0 and var_152_11 < var_152_15 then
					arg_149_1.talkMaxDuration = var_152_15

					if var_152_15 + var_152_10 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_15 + var_152_10
					end
				end

				arg_149_1.text_.text = var_152_13
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081036", "story_v_out_113081.awb") ~= 0 then
					local var_152_16 = manager.audio:GetVoiceLength("story_v_out_113081", "113081036", "story_v_out_113081.awb") / 1000

					if var_152_16 + var_152_10 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_16 + var_152_10
					end

					if var_152_12.prefab_name ~= "" and arg_149_1.actors_[var_152_12.prefab_name] ~= nil then
						local var_152_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_12.prefab_name].transform, "story_v_out_113081", "113081036", "story_v_out_113081.awb")

						arg_149_1:RecordAudio("113081036", var_152_17)
						arg_149_1:RecordAudio("113081036", var_152_17)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_113081", "113081036", "story_v_out_113081.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_113081", "113081036", "story_v_out_113081.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_18 = math.max(var_152_11, arg_149_1.talkMaxDuration)

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_18 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_10) / var_152_18

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_10 + var_152_18 and arg_149_1.time_ < var_152_10 + var_152_18 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play113081037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 113081037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play113081038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1084ui_story"]) and arg_153_1.var_.characterEffect1084ui_story == nil then
				arg_153_1.var_.characterEffect1084ui_story = arg_153_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1084ui_story"]) then
				if arg_153_1.var_.characterEffect1084ui_story and not isNil(arg_153_1.actors_["1084ui_story"]) then
					arg_153_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1084ui_story"]) and arg_153_1.var_.characterEffect1084ui_story then
				arg_153_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 0.65

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(113081037).content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 26 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 26)

				if (26 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 26)) > 0 and var_156_2 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_6 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_6 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_6

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_6 and arg_153_1.time_ < var_156_1 + var_156_6 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play113081038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 113081038
		arg_157_1.duration_ = 11.4

		local var_157_0 = {
			ja = 10.6,
			ko = 11.4,
			zh = 11.033,
			en = 10.866
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play113081039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 1.275

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1067")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_1 = arg_157_1:GetWordFromCfg(113081038)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 51 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 51)

				if (51 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 51)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081038", "story_v_out_113081.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_113081", "113081038", "story_v_out_113081.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_113081", "113081038", "story_v_out_113081.awb")

						arg_157_1:RecordAudio("113081038", var_160_6)
						arg_157_1:RecordAudio("113081038", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_113081", "113081038", "story_v_out_113081.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_113081", "113081038", "story_v_out_113081.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play113081039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 113081039
		arg_161_1.duration_ = 4.2

		local var_161_0 = {
			ja = 3.966,
			ko = 3.9,
			zh = 4.2,
			en = 4.2
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
				arg_161_0:Play113081040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_164_0 = arg_161_1.actors_["1042ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1042ui_story == nil then
				arg_161_1.var_.characterEffect1042ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_1 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 and not isNil(var_164_0) then
				if arg_161_1.var_.characterEffect1042ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1042ui_story then
				arg_161_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_164_3 = 0
			local var_164_4 = 0.35

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_5 = arg_161_1:GetWordFromCfg(113081039)
				local var_164_6 = arg_161_1:FormatText(var_164_5.content)

				arg_161_1.text_.text = var_164_6

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_8 = 14 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_6) / 14)

				if (14 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_6) / 14)) > 0 and var_164_4 < var_164_8 then
					arg_161_1.talkMaxDuration = var_164_8

					if var_164_8 + var_164_3 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_3
					end
				end

				arg_161_1.text_.text = var_164_6
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081039", "story_v_out_113081.awb") ~= 0 then
					local var_164_9 = manager.audio:GetVoiceLength("story_v_out_113081", "113081039", "story_v_out_113081.awb") / 1000

					if var_164_9 + var_164_3 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_3
					end

					if var_164_5.prefab_name ~= "" and arg_161_1.actors_[var_164_5.prefab_name] ~= nil then
						local var_164_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_5.prefab_name].transform, "story_v_out_113081", "113081039", "story_v_out_113081.awb")

						arg_161_1:RecordAudio("113081039", var_164_10)
						arg_161_1:RecordAudio("113081039", var_164_10)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_113081", "113081039", "story_v_out_113081.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_113081", "113081039", "story_v_out_113081.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_11 = math.max(var_164_4, arg_161_1.talkMaxDuration)

			if var_164_3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_3 + var_164_11 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_3) / var_164_11

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_3 + var_164_11 and arg_161_1.time_ < var_164_3 + var_164_11 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play113081040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 113081040
		arg_165_1.duration_ = 8.13

		local var_165_0 = {
			ja = 8.133,
			ko = 7.633,
			zh = 5.9,
			en = 6.833
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
				arg_165_0:Play113081041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1042ui_story = arg_165_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1042ui_story"].transform.position).z)
				arg_165_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1042ui_story"].transform.localEulerAngles = arg_165_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1042ui_story"].transform.position).z)
				arg_165_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1042ui_story"].transform.localEulerAngles = arg_165_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1084ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1084ui_story = var_168_1.localPosition
			end

			local var_168_2 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 then
				var_168_1.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_2)
				var_168_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_1.position).x, (manager.ui.mainCamera.transform.position - var_168_1.position).y, (manager.ui.mainCamera.transform.position - var_168_1.position).z)
				var_168_1.localEulerAngles.z = 0
				var_168_1.localEulerAngles.x = 0
				var_168_1.localEulerAngles = var_168_1.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 then
				var_168_1.localPosition = Vector3.New(0, 100, 0)
				var_168_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_1.position).x, (manager.ui.mainCamera.transform.position - var_168_1.position).y, (manager.ui.mainCamera.transform.position - var_168_1.position).z)
				var_168_1.localEulerAngles.z = 0
				var_168_1.localEulerAngles.x = 0
				var_168_1.localEulerAngles = var_168_1.localEulerAngles
			end

			local var_168_3 = "1067ui_story"

			if arg_165_1.actors_["1067ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1067ui_story"))) then
				local var_168_4 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_165_1.stage_.transform)

				var_168_4.name = var_168_3
				var_168_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_[var_168_3] = var_168_4

				local var_168_5 = var_168_4:GetComponentInChildren(typeof(CharacterEffect))

				var_168_5.enabled = true

				local var_168_6 = GameObjectTools.GetOrAddComponent(var_168_4, typeof(DynamicBoneHelper))

				if var_168_6 then
					var_168_6:EnableDynamicBone(false)
				end

				arg_165_1:ShowWeapon(var_168_5.transform, false)

				arg_165_1.var_[var_168_3 .. "Animator"] = var_168_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_165_1.var_[var_168_3 .. "Animator"].applyRootMotion = true
				arg_165_1.var_[var_168_3 .. "LipSync"] = var_168_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_168_7 = arg_165_1.actors_["1067ui_story"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1067ui_story = var_168_7.localPosition
			end

			local var_168_8 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_8 then
				var_168_7.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1067ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_165_1.time_ - 0) / var_168_8)
				var_168_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_7.position).x, (manager.ui.mainCamera.transform.position - var_168_7.position).y, (manager.ui.mainCamera.transform.position - var_168_7.position).z)
				var_168_7.localEulerAngles.z = 0
				var_168_7.localEulerAngles.x = 0
				var_168_7.localEulerAngles = var_168_7.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_8 and arg_165_1.time_ < 0 + var_168_8 + arg_168_0 then
				var_168_7.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_168_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_7.position).x, (manager.ui.mainCamera.transform.position - var_168_7.position).y, (manager.ui.mainCamera.transform.position - var_168_7.position).z)
				var_168_7.localEulerAngles.z = 0
				var_168_7.localEulerAngles.x = 0
				var_168_7.localEulerAngles = var_168_7.localEulerAngles
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_168_9 = arg_165_1.actors_["1067ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1067ui_story == nil then
				arg_165_1.var_.characterEffect1067ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_10 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_10 and not isNil(var_168_9) then
				if arg_165_1.var_.characterEffect1067ui_story and not isNil(var_168_9) then
					arg_165_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_10 and arg_165_1.time_ < 0 + var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect1067ui_story then
				arg_165_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_168_12 = 0
			local var_168_13 = 0.575

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_12 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_14 = arg_165_1:GetWordFromCfg(113081040)
				local var_168_15 = arg_165_1:FormatText(var_168_14.content)

				arg_165_1.text_.text = var_168_15

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_17 = 23 <= 0 and var_168_13 or var_168_13 * (utf8.len(var_168_15) / 23)

				if (23 <= 0 and var_168_13 or var_168_13 * (utf8.len(var_168_15) / 23)) > 0 and var_168_13 < var_168_17 then
					arg_165_1.talkMaxDuration = var_168_17

					if var_168_17 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_17 + var_168_12
					end
				end

				arg_165_1.text_.text = var_168_15
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081040", "story_v_out_113081.awb") ~= 0 then
					local var_168_18 = manager.audio:GetVoiceLength("story_v_out_113081", "113081040", "story_v_out_113081.awb") / 1000

					if var_168_18 + var_168_12 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_18 + var_168_12
					end

					if var_168_14.prefab_name ~= "" and arg_165_1.actors_[var_168_14.prefab_name] ~= nil then
						local var_168_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_14.prefab_name].transform, "story_v_out_113081", "113081040", "story_v_out_113081.awb")

						arg_165_1:RecordAudio("113081040", var_168_19)
						arg_165_1:RecordAudio("113081040", var_168_19)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_113081", "113081040", "story_v_out_113081.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_113081", "113081040", "story_v_out_113081.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_20 = math.max(var_168_13, arg_165_1.talkMaxDuration)

			if var_168_12 <= arg_165_1.time_ and arg_165_1.time_ < var_168_12 + var_168_20 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_12) / var_168_20

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_12 + var_168_20 and arg_165_1.time_ < var_168_12 + var_168_20 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play113081041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 113081041
		arg_169_1.duration_ = 12.6

		local var_169_0 = {
			ja = 11.133,
			ko = 11.366,
			zh = 12.6,
			en = 10.033
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
				arg_169_0:Play113081042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_172_0 = 0
			local var_172_1 = 1.325

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_2 = arg_169_1:GetWordFromCfg(113081041)
				local var_172_3 = arg_169_1:FormatText(var_172_2.content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 53 <= 0 and var_172_1 or var_172_1 * (utf8.len(var_172_3) / 53)

				if (53 <= 0 and var_172_1 or var_172_1 * (utf8.len(var_172_3) / 53)) > 0 and var_172_1 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081041", "story_v_out_113081.awb") ~= 0 then
					local var_172_6 = manager.audio:GetVoiceLength("story_v_out_113081", "113081041", "story_v_out_113081.awb") / 1000

					if var_172_6 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_0
					end

					if var_172_2.prefab_name ~= "" and arg_169_1.actors_[var_172_2.prefab_name] ~= nil then
						local var_172_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_2.prefab_name].transform, "story_v_out_113081", "113081041", "story_v_out_113081.awb")

						arg_169_1:RecordAudio("113081041", var_172_7)
						arg_169_1:RecordAudio("113081041", var_172_7)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_113081", "113081041", "story_v_out_113081.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_113081", "113081041", "story_v_out_113081.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_8 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_8 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_8

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_8 and arg_169_1.time_ < var_172_0 + var_172_8 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play113081042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 113081042
		arg_173_1.duration_ = 4.83

		local var_173_0 = {
			ja = 4.833,
			ko = 1.999999999999,
			zh = 2.533,
			en = 3.5
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
				arg_173_0:Play113081043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if arg_173_1.actors_["1068ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1068ui_story"))) then
				local var_176_0 = Object.Instantiate(Asset.Load("Char/" .. "1068ui_story"), arg_173_1.stage_.transform)

				var_176_0.name = "1068ui_story"
				var_176_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_173_1.actors_["1068ui_story"] = var_176_0

				local var_176_1 = var_176_0:GetComponentInChildren(typeof(CharacterEffect))

				var_176_1.enabled = true

				local var_176_2 = GameObjectTools.GetOrAddComponent(var_176_0, typeof(DynamicBoneHelper))

				if var_176_2 then
					var_176_2:EnableDynamicBone(false)
				end

				arg_173_1:ShowWeapon(var_176_1.transform, false)

				arg_173_1.var_["1068ui_story" .. "Animator"] = var_176_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_173_1.var_["1068ui_story" .. "Animator"].applyRootMotion = true
				arg_173_1.var_["1068ui_story" .. "LipSync"] = var_176_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_176_3 = arg_173_1.actors_["1068ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1068ui_story = var_176_3.localPosition
			end

			local var_176_4 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				var_176_3.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1068ui_story, Vector3.New(0.7, -0.95, -5.88), (arg_173_1.time_ - 0) / var_176_4)
				var_176_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_3.position).x, (manager.ui.mainCamera.transform.position - var_176_3.position).y, (manager.ui.mainCamera.transform.position - var_176_3.position).z)
				var_176_3.localEulerAngles.z = 0
				var_176_3.localEulerAngles.x = 0
				var_176_3.localEulerAngles = var_176_3.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				var_176_3.localPosition = Vector3.New(0.7, -0.95, -5.88)
				var_176_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_3.position).x, (manager.ui.mainCamera.transform.position - var_176_3.position).y, (manager.ui.mainCamera.transform.position - var_176_3.position).z)
				var_176_3.localEulerAngles.z = 0
				var_176_3.localEulerAngles.x = 0
				var_176_3.localEulerAngles = var_176_3.localEulerAngles
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_176_5 = arg_173_1.actors_["1067ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.characterEffect1067ui_story == nil then
				arg_173_1.var_.characterEffect1067ui_story = var_176_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_6 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_6 and not isNil(var_176_5) then
				if arg_173_1.var_.characterEffect1067ui_story and not isNil(var_176_5) then
					arg_173_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_6)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_6 and arg_173_1.time_ < 0 + var_176_6 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.characterEffect1067ui_story then
				arg_173_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_176_7 = arg_173_1.actors_["1068ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.characterEffect1068ui_story == nil then
				arg_173_1.var_.characterEffect1068ui_story = var_176_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_8 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_8 and not isNil(var_176_7) then
				if arg_173_1.var_.characterEffect1068ui_story and not isNil(var_176_7) then
					arg_173_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_8 and arg_173_1.time_ < 0 + var_176_8 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.characterEffect1068ui_story then
				arg_173_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_176_10 = 0
			local var_176_11 = 0.25

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_12 = arg_173_1:GetWordFromCfg(113081042)
				local var_176_13 = arg_173_1:FormatText(var_176_12.content)

				arg_173_1.text_.text = var_176_13

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_15 = 10 <= 0 and var_176_11 or var_176_11 * (utf8.len(var_176_13) / 10)

				if (10 <= 0 and var_176_11 or var_176_11 * (utf8.len(var_176_13) / 10)) > 0 and var_176_11 < var_176_15 then
					arg_173_1.talkMaxDuration = var_176_15

					if var_176_15 + var_176_10 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_15 + var_176_10
					end
				end

				arg_173_1.text_.text = var_176_13
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081042", "story_v_out_113081.awb") ~= 0 then
					local var_176_16 = manager.audio:GetVoiceLength("story_v_out_113081", "113081042", "story_v_out_113081.awb") / 1000

					if var_176_16 + var_176_10 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_16 + var_176_10
					end

					if var_176_12.prefab_name ~= "" and arg_173_1.actors_[var_176_12.prefab_name] ~= nil then
						local var_176_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_12.prefab_name].transform, "story_v_out_113081", "113081042", "story_v_out_113081.awb")

						arg_173_1:RecordAudio("113081042", var_176_17)
						arg_173_1:RecordAudio("113081042", var_176_17)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_113081", "113081042", "story_v_out_113081.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_113081", "113081042", "story_v_out_113081.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_18 = math.max(var_176_11, arg_173_1.talkMaxDuration)

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_18 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_10) / var_176_18

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_10 + var_176_18 and arg_173_1.time_ < var_176_10 + var_176_18 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play113081043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 113081043
		arg_177_1.duration_ = 12.6

		local var_177_0 = {
			ja = 12.6,
			ko = 8.1,
			zh = 8.933,
			en = 8.1
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
				arg_177_0:Play113081044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_180_0 = 0
			local var_180_1 = 0.875

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_2 = arg_177_1:GetWordFromCfg(113081043)
				local var_180_3 = arg_177_1:FormatText(var_180_2.content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 35 <= 0 and var_180_1 or var_180_1 * (utf8.len(var_180_3) / 35)

				if (35 <= 0 and var_180_1 or var_180_1 * (utf8.len(var_180_3) / 35)) > 0 and var_180_1 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081043", "story_v_out_113081.awb") ~= 0 then
					local var_180_6 = manager.audio:GetVoiceLength("story_v_out_113081", "113081043", "story_v_out_113081.awb") / 1000

					if var_180_6 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_0
					end

					if var_180_2.prefab_name ~= "" and arg_177_1.actors_[var_180_2.prefab_name] ~= nil then
						local var_180_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_2.prefab_name].transform, "story_v_out_113081", "113081043", "story_v_out_113081.awb")

						arg_177_1:RecordAudio("113081043", var_180_7)
						arg_177_1:RecordAudio("113081043", var_180_7)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_113081", "113081043", "story_v_out_113081.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_113081", "113081043", "story_v_out_113081.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_8 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_8 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_8

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_8 and arg_177_1.time_ < var_180_0 + var_180_8 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play113081044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 113081044
		arg_181_1.duration_ = 5.2

		local var_181_0 = {
			ja = 5.2,
			ko = 2.066,
			zh = 2.533,
			en = 2.966
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
				arg_181_0:Play113081045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1067ui_story = arg_181_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1067ui_story"].transform.position).z)
				arg_181_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1067ui_story"].transform.localEulerAngles = arg_181_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1067ui_story"].transform.position).z)
				arg_181_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1067ui_story"].transform.localEulerAngles = arg_181_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_184_1 = arg_181_1.actors_["1042ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1042ui_story == nil then
				arg_181_1.var_.characterEffect1042ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1042ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1042ui_story then
				arg_181_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_184_4 = arg_181_1.actors_["1042ui_story"].transform

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1042ui_story = var_184_4.localPosition
			end

			local var_184_5 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_5 then
				var_184_4.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_181_1.time_ - 0) / var_184_5)
				var_184_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_4.position).x, (manager.ui.mainCamera.transform.position - var_184_4.position).y, (manager.ui.mainCamera.transform.position - var_184_4.position).z)
				var_184_4.localEulerAngles.z = 0
				var_184_4.localEulerAngles.x = 0
				var_184_4.localEulerAngles = var_184_4.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_5 and arg_181_1.time_ < 0 + var_184_5 + arg_184_0 then
				var_184_4.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_184_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_184_4.position).x, (manager.ui.mainCamera.transform.position - var_184_4.position).y, (manager.ui.mainCamera.transform.position - var_184_4.position).z)
				var_184_4.localEulerAngles.z = 0
				var_184_4.localEulerAngles.x = 0
				var_184_4.localEulerAngles = var_184_4.localEulerAngles
			end

			local var_184_6 = 0
			local var_184_7 = 0.175

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:GetWordFromCfg(113081044)
				local var_184_9 = arg_181_1:FormatText(var_184_8.content)

				arg_181_1.text_.text = var_184_9

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 7 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 7)

				if (7 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 7)) > 0 and var_184_7 < var_184_11 then
					arg_181_1.talkMaxDuration = var_184_11

					if var_184_11 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_9
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081044", "story_v_out_113081.awb") ~= 0 then
					local var_184_12 = manager.audio:GetVoiceLength("story_v_out_113081", "113081044", "story_v_out_113081.awb") / 1000

					if var_184_12 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_6
					end

					if var_184_8.prefab_name ~= "" and arg_181_1.actors_[var_184_8.prefab_name] ~= nil then
						local var_184_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_8.prefab_name].transform, "story_v_out_113081", "113081044", "story_v_out_113081.awb")

						arg_181_1:RecordAudio("113081044", var_184_13)
						arg_181_1:RecordAudio("113081044", var_184_13)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_113081", "113081044", "story_v_out_113081.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_113081", "113081044", "story_v_out_113081.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play113081045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 113081045
		arg_185_1.duration_ = 10.7

		local var_185_0 = {
			ja = 10.7,
			ko = 9.633,
			zh = 8.633,
			en = 9.533
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
				arg_185_0:Play113081046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1067ui_story = arg_185_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1067ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1067ui_story"].transform.position).z)
				arg_185_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1067ui_story"].transform.localEulerAngles = arg_185_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_185_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1067ui_story"].transform.position).z)
				arg_185_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1067ui_story"].transform.localEulerAngles = arg_185_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_1")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			local var_188_1 = arg_185_1.actors_["1067ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1067ui_story == nil then
				arg_185_1.var_.characterEffect1067ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1067ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1067ui_story then
				arg_185_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_188_4 = arg_185_1.actors_["1068ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1068ui_story = var_188_4.localPosition
			end

			local var_188_5 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_5 then
				var_188_4.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_5)
				var_188_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_4.position).x, (manager.ui.mainCamera.transform.position - var_188_4.position).y, (manager.ui.mainCamera.transform.position - var_188_4.position).z)
				var_188_4.localEulerAngles.z = 0
				var_188_4.localEulerAngles.x = 0
				var_188_4.localEulerAngles = var_188_4.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_5 and arg_185_1.time_ < 0 + var_188_5 + arg_188_0 then
				var_188_4.localPosition = Vector3.New(0, 100, 0)
				var_188_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_4.position).x, (manager.ui.mainCamera.transform.position - var_188_4.position).y, (manager.ui.mainCamera.transform.position - var_188_4.position).z)
				var_188_4.localEulerAngles.z = 0
				var_188_4.localEulerAngles.x = 0
				var_188_4.localEulerAngles = var_188_4.localEulerAngles
			end

			local var_188_6 = arg_185_1.actors_["1042ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect1042ui_story == nil then
				arg_185_1.var_.characterEffect1042ui_story = var_188_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_7 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 and not isNil(var_188_6) then
				if arg_185_1.var_.characterEffect1042ui_story and not isNil(var_188_6) then
					arg_185_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_7)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect1042ui_story then
				arg_185_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_188_8 = 0
			local var_188_9 = 0.65

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(113081045)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 26 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 26)

				if (26 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 26)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081045", "story_v_out_113081.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_113081", "113081045", "story_v_out_113081.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_113081", "113081045", "story_v_out_113081.awb")

						arg_185_1:RecordAudio("113081045", var_188_15)
						arg_185_1:RecordAudio("113081045", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_113081", "113081045", "story_v_out_113081.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_113081", "113081045", "story_v_out_113081.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_16 and arg_185_1.time_ < var_188_8 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play113081046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 113081046
		arg_189_1.duration_ = 3.63

		local var_189_0 = {
			ja = 3.633,
			ko = 1.999999999999,
			zh = 2.2,
			en = 1.999999999999
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
				arg_189_0:Play113081047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action4_2")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_192_0 = 0
			local var_192_1 = 0.2

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_2 = arg_189_1:GetWordFromCfg(113081046)
				local var_192_3 = arg_189_1:FormatText(var_192_2.content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 8 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_3) / 8)

				if (8 <= 0 and var_192_1 or var_192_1 * (utf8.len(var_192_3) / 8)) > 0 and var_192_1 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081046", "story_v_out_113081.awb") ~= 0 then
					local var_192_6 = manager.audio:GetVoiceLength("story_v_out_113081", "113081046", "story_v_out_113081.awb") / 1000

					if var_192_6 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_0
					end

					if var_192_2.prefab_name ~= "" and arg_189_1.actors_[var_192_2.prefab_name] ~= nil then
						local var_192_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_2.prefab_name].transform, "story_v_out_113081", "113081046", "story_v_out_113081.awb")

						arg_189_1:RecordAudio("113081046", var_192_7)
						arg_189_1:RecordAudio("113081046", var_192_7)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_113081", "113081046", "story_v_out_113081.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_113081", "113081046", "story_v_out_113081.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_8 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_8 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_8

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_8 and arg_189_1.time_ < var_192_0 + var_192_8 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play113081047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 113081047
		arg_193_1.duration_ = 4.63

		local var_193_0 = {
			ja = 3.2,
			ko = 4.633,
			zh = 4.6,
			en = 3
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
				arg_193_0:Play113081048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1067ui_story = arg_193_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1067ui_story"].transform.position).z)
				arg_193_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1067ui_story"].transform.localEulerAngles = arg_193_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1067ui_story"].transform.position).z)
				arg_193_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1067ui_story"].transform.localEulerAngles = arg_193_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1042ui_story"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1042ui_story = var_196_1.localPosition
			end

			local var_196_2 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 then
				var_196_1.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_193_1.time_ - 0) / var_196_2)
				var_196_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_1.position).x, (manager.ui.mainCamera.transform.position - var_196_1.position).y, (manager.ui.mainCamera.transform.position - var_196_1.position).z)
				var_196_1.localEulerAngles.z = 0
				var_196_1.localEulerAngles.x = 0
				var_196_1.localEulerAngles = var_196_1.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 then
				var_196_1.localPosition = Vector3.New(0, 100, 0)
				var_196_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_1.position).x, (manager.ui.mainCamera.transform.position - var_196_1.position).y, (manager.ui.mainCamera.transform.position - var_196_1.position).z)
				var_196_1.localEulerAngles.z = 0
				var_196_1.localEulerAngles.x = 0
				var_196_1.localEulerAngles = var_196_1.localEulerAngles
			end

			local var_196_3 = arg_193_1.actors_["1084ui_story"].transform

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1084ui_story = var_196_3.localPosition
			end

			local var_196_4 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				var_196_3.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_193_1.time_ - 0) / var_196_4)
				var_196_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_3.position).x, (manager.ui.mainCamera.transform.position - var_196_3.position).y, (manager.ui.mainCamera.transform.position - var_196_3.position).z)
				var_196_3.localEulerAngles.z = 0
				var_196_3.localEulerAngles.x = 0
				var_196_3.localEulerAngles = var_196_3.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				var_196_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_196_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_196_3.position).x, (manager.ui.mainCamera.transform.position - var_196_3.position).y, (manager.ui.mainCamera.transform.position - var_196_3.position).z)
				var_196_3.localEulerAngles.z = 0
				var_196_3.localEulerAngles.x = 0
				var_196_3.localEulerAngles = var_196_3.localEulerAngles
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_196_5 = arg_193_1.actors_["1084ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.characterEffect1084ui_story == nil then
				arg_193_1.var_.characterEffect1084ui_story = var_196_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_6 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_6 and not isNil(var_196_5) then
				if arg_193_1.var_.characterEffect1084ui_story and not isNil(var_196_5) then
					arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_6 and arg_193_1.time_ < 0 + var_196_6 + arg_196_0 and not isNil(var_196_5) and arg_193_1.var_.characterEffect1084ui_story then
				arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_196_8 = 0
			local var_196_9 = 0.35

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_10 = arg_193_1:GetWordFromCfg(113081047)
				local var_196_11 = arg_193_1:FormatText(var_196_10.content)

				arg_193_1.text_.text = var_196_11

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_13 = 14 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 14)

				if (14 <= 0 and var_196_9 or var_196_9 * (utf8.len(var_196_11) / 14)) > 0 and var_196_9 < var_196_13 then
					arg_193_1.talkMaxDuration = var_196_13

					if var_196_13 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_13 + var_196_8
					end
				end

				arg_193_1.text_.text = var_196_11
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081047", "story_v_out_113081.awb") ~= 0 then
					local var_196_14 = manager.audio:GetVoiceLength("story_v_out_113081", "113081047", "story_v_out_113081.awb") / 1000

					if var_196_14 + var_196_8 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_14 + var_196_8
					end

					if var_196_10.prefab_name ~= "" and arg_193_1.actors_[var_196_10.prefab_name] ~= nil then
						local var_196_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_10.prefab_name].transform, "story_v_out_113081", "113081047", "story_v_out_113081.awb")

						arg_193_1:RecordAudio("113081047", var_196_15)
						arg_193_1:RecordAudio("113081047", var_196_15)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_113081", "113081047", "story_v_out_113081.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_113081", "113081047", "story_v_out_113081.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_16 = math.max(var_196_9, arg_193_1.talkMaxDuration)

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_16 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_8) / var_196_16

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_8 + var_196_16 and arg_193_1.time_ < var_196_8 + var_196_16 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play113081048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 113081048
		arg_197_1.duration_ = 19.83

		local var_197_0 = {
			ja = 19.833,
			ko = 11.066,
			zh = 9.833,
			en = 11.133
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
				arg_197_0:Play113081049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1084ui_story"]) and arg_197_1.var_.characterEffect1084ui_story == nil then
				arg_197_1.var_.characterEffect1084ui_story = arg_197_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1084ui_story"]) then
				if arg_197_1.var_.characterEffect1084ui_story and not isNil(arg_197_1.actors_["1084ui_story"]) then
					arg_197_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1084ui_story"]) and arg_197_1.var_.characterEffect1084ui_story then
				arg_197_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_200_1 = arg_197_1.actors_["1042ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1042ui_story == nil then
				arg_197_1.var_.characterEffect1042ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect1042ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect1042ui_story then
				arg_197_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_200_4 = arg_197_1.actors_["1042ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1042ui_story = var_200_4.localPosition
			end

			local var_200_5 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_5 then
				var_200_4.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_197_1.time_ - 0) / var_200_5)
				var_200_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_4.position).x, (manager.ui.mainCamera.transform.position - var_200_4.position).y, (manager.ui.mainCamera.transform.position - var_200_4.position).z)
				var_200_4.localEulerAngles.z = 0
				var_200_4.localEulerAngles.x = 0
				var_200_4.localEulerAngles = var_200_4.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_5 and arg_197_1.time_ < 0 + var_200_5 + arg_200_0 then
				var_200_4.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_200_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_4.position).x, (manager.ui.mainCamera.transform.position - var_200_4.position).y, (manager.ui.mainCamera.transform.position - var_200_4.position).z)
				var_200_4.localEulerAngles.z = 0
				var_200_4.localEulerAngles.x = 0
				var_200_4.localEulerAngles = var_200_4.localEulerAngles
			end

			local var_200_6 = 0
			local var_200_7 = 1.05

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_8 = arg_197_1:GetWordFromCfg(113081048)
				local var_200_9 = arg_197_1:FormatText(var_200_8.content)

				arg_197_1.text_.text = var_200_9

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 42 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 42)

				if (42 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 42)) > 0 and var_200_7 < var_200_11 then
					arg_197_1.talkMaxDuration = var_200_11

					if var_200_11 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_9
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081048", "story_v_out_113081.awb") ~= 0 then
					local var_200_12 = manager.audio:GetVoiceLength("story_v_out_113081", "113081048", "story_v_out_113081.awb") / 1000

					if var_200_12 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_12 + var_200_6
					end

					if var_200_8.prefab_name ~= "" and arg_197_1.actors_[var_200_8.prefab_name] ~= nil then
						local var_200_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_8.prefab_name].transform, "story_v_out_113081", "113081048", "story_v_out_113081.awb")

						arg_197_1:RecordAudio("113081048", var_200_13)
						arg_197_1:RecordAudio("113081048", var_200_13)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_113081", "113081048", "story_v_out_113081.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_113081", "113081048", "story_v_out_113081.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_14 and arg_197_1.time_ < var_200_6 + var_200_14 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play113081049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 113081049
		arg_201_1.duration_ = 2.53

		local var_201_0 = {
			ja = 2.133,
			ko = 1.966,
			zh = 2.533,
			en = 2.233
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
				arg_201_0:Play113081050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1042ui_story"]) and arg_201_1.var_.characterEffect1042ui_story == nil then
				arg_201_1.var_.characterEffect1042ui_story = arg_201_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1042ui_story"]) then
				if arg_201_1.var_.characterEffect1042ui_story and not isNil(arg_201_1.actors_["1042ui_story"]) then
					arg_201_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_0)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1042ui_story"]) and arg_201_1.var_.characterEffect1042ui_story then
				arg_201_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_204_1 = 0
			local var_204_2 = 0.225

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(113081049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_6 = 9 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_4) / 9)

				if (9 <= 0 and var_204_2 or var_204_2 * (utf8.len(var_204_4) / 9)) > 0 and var_204_2 < var_204_6 then
					arg_201_1.talkMaxDuration = var_204_6

					if var_204_6 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_6 + var_204_1
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081049", "story_v_out_113081.awb") ~= 0 then
					local var_204_7 = manager.audio:GetVoiceLength("story_v_out_113081", "113081049", "story_v_out_113081.awb") / 1000

					if var_204_7 + var_204_1 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_1
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_113081", "113081049", "story_v_out_113081.awb")

						arg_201_1:RecordAudio("113081049", var_204_8)
						arg_201_1:RecordAudio("113081049", var_204_8)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_113081", "113081049", "story_v_out_113081.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_113081", "113081049", "story_v_out_113081.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_9 = math.max(var_204_2, arg_201_1.talkMaxDuration)

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_9 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_1) / var_204_9

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_1 + var_204_9 and arg_201_1.time_ < var_204_1 + var_204_9 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play113081050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 113081050
		arg_205_1.duration_ = 7.03

		local var_205_0 = {
			ja = 7.033,
			ko = 4.666,
			zh = 3.766,
			en = 5.266
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
				arg_205_0:Play113081051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_208_0 = arg_205_1.actors_["1042ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1042ui_story == nil then
				arg_205_1.var_.characterEffect1042ui_story = var_208_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_1 = 0.2

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_1 and not isNil(var_208_0) then
				if arg_205_1.var_.characterEffect1042ui_story and not isNil(var_208_0) then
					arg_205_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_1 and arg_205_1.time_ < 0 + var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1042ui_story then
				arg_205_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_208_3 = 0
			local var_208_4 = 0.375

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_3 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_5 = arg_205_1:GetWordFromCfg(113081050)
				local var_208_6 = arg_205_1:FormatText(var_208_5.content)

				arg_205_1.text_.text = var_208_6

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_8 = 15 <= 0 and var_208_4 or var_208_4 * (utf8.len(var_208_6) / 15)

				if (15 <= 0 and var_208_4 or var_208_4 * (utf8.len(var_208_6) / 15)) > 0 and var_208_4 < var_208_8 then
					arg_205_1.talkMaxDuration = var_208_8

					if var_208_8 + var_208_3 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_3
					end
				end

				arg_205_1.text_.text = var_208_6
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081050", "story_v_out_113081.awb") ~= 0 then
					local var_208_9 = manager.audio:GetVoiceLength("story_v_out_113081", "113081050", "story_v_out_113081.awb") / 1000

					if var_208_9 + var_208_3 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_3
					end

					if var_208_5.prefab_name ~= "" and arg_205_1.actors_[var_208_5.prefab_name] ~= nil then
						local var_208_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_5.prefab_name].transform, "story_v_out_113081", "113081050", "story_v_out_113081.awb")

						arg_205_1:RecordAudio("113081050", var_208_10)
						arg_205_1:RecordAudio("113081050", var_208_10)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_113081", "113081050", "story_v_out_113081.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_113081", "113081050", "story_v_out_113081.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_11 = math.max(var_208_4, arg_205_1.talkMaxDuration)

			if var_208_3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_3 + var_208_11 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_3) / var_208_11

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_3 + var_208_11 and arg_205_1.time_ < var_208_3 + var_208_11 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play113081051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 113081051
		arg_209_1.duration_ = 8.27

		local var_209_0 = {
			ja = 8.266,
			ko = 7.433,
			zh = 7.6,
			en = 7.033
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
				arg_209_0:Play113081052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1084ui_story = arg_209_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1084ui_story"].transform.position).z)
				arg_209_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1084ui_story"].transform.localEulerAngles = arg_209_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_209_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1084ui_story"].transform.position).z)
				arg_209_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1084ui_story"].transform.localEulerAngles = arg_209_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1042ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1042ui_story = var_212_1.localPosition
			end

			local var_212_2 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 then
				var_212_1.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_209_1.time_ - 0) / var_212_2)
				var_212_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_1.position).x, (manager.ui.mainCamera.transform.position - var_212_1.position).y, (manager.ui.mainCamera.transform.position - var_212_1.position).z)
				var_212_1.localEulerAngles.z = 0
				var_212_1.localEulerAngles.x = 0
				var_212_1.localEulerAngles = var_212_1.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 then
				var_212_1.localPosition = Vector3.New(0, 100, 0)
				var_212_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_1.position).x, (manager.ui.mainCamera.transform.position - var_212_1.position).y, (manager.ui.mainCamera.transform.position - var_212_1.position).z)
				var_212_1.localEulerAngles.z = 0
				var_212_1.localEulerAngles.x = 0
				var_212_1.localEulerAngles = var_212_1.localEulerAngles
			end

			local var_212_3 = arg_209_1.actors_["1068ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1068ui_story = var_212_3.localPosition
			end

			local var_212_4 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				var_212_3.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1068ui_story, Vector3.New(-0.7, -0.95, -5.88), (arg_209_1.time_ - 0) / var_212_4)
				var_212_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_3.position).x, (manager.ui.mainCamera.transform.position - var_212_3.position).y, (manager.ui.mainCamera.transform.position - var_212_3.position).z)
				var_212_3.localEulerAngles.z = 0
				var_212_3.localEulerAngles.x = 0
				var_212_3.localEulerAngles = var_212_3.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				var_212_3.localPosition = Vector3.New(-0.7, -0.95, -5.88)
				var_212_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_3.position).x, (manager.ui.mainCamera.transform.position - var_212_3.position).y, (manager.ui.mainCamera.transform.position - var_212_3.position).z)
				var_212_3.localEulerAngles.z = 0
				var_212_3.localEulerAngles.x = 0
				var_212_3.localEulerAngles = var_212_3.localEulerAngles
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_212_5 = arg_209_1.actors_["1068ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.characterEffect1068ui_story == nil then
				arg_209_1.var_.characterEffect1068ui_story = var_212_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_6 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_6 and not isNil(var_212_5) then
				if arg_209_1.var_.characterEffect1068ui_story and not isNil(var_212_5) then
					arg_209_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_6 and arg_209_1.time_ < 0 + var_212_6 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.characterEffect1068ui_story then
				arg_209_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_212_8 = 0
			local var_212_9 = 0.875

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_10 = arg_209_1:GetWordFromCfg(113081051)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 35 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 35)

				if (35 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 35)) > 0 and var_212_9 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081051", "story_v_out_113081.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_out_113081", "113081051", "story_v_out_113081.awb") / 1000

					if var_212_14 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_8
					end

					if var_212_10.prefab_name ~= "" and arg_209_1.actors_[var_212_10.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_10.prefab_name].transform, "story_v_out_113081", "113081051", "story_v_out_113081.awb")

						arg_209_1:RecordAudio("113081051", var_212_15)
						arg_209_1:RecordAudio("113081051", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_113081", "113081051", "story_v_out_113081.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_113081", "113081051", "story_v_out_113081.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_9, arg_209_1.talkMaxDuration)

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_8) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_8 + var_212_16 and arg_209_1.time_ < var_212_8 + var_212_16 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play113081052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 113081052
		arg_213_1.duration_ = 15.13

		local var_213_0 = {
			ja = 13,
			ko = 10.8,
			zh = 12.1,
			en = 15.133
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
				arg_213_0:Play113081053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1067ui_story = arg_213_1.actors_["1067ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1067ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1067ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1067ui_story"].transform.position).z)
				arg_213_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1067ui_story"].transform.localEulerAngles = arg_213_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1067ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_213_1.actors_["1067ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1067ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1067ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1067ui_story"].transform.position).z)
				arg_213_1.actors_["1067ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1067ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1067ui_story"].transform.localEulerAngles = arg_213_1.actors_["1067ui_story"].transform.localEulerAngles
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_216_1 = arg_213_1.actors_["1067ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1067ui_story == nil then
				arg_213_1.var_.characterEffect1067ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1067ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1067ui_story then
				arg_213_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_216_4 = arg_213_1.actors_["1068ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_4) and arg_213_1.var_.characterEffect1068ui_story == nil then
				arg_213_1.var_.characterEffect1068ui_story = var_216_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_5 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_5 and not isNil(var_216_4) then
				if arg_213_1.var_.characterEffect1068ui_story and not isNil(var_216_4) then
					arg_213_1.var_.characterEffect1068ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_5)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_5 and arg_213_1.time_ < 0 + var_216_5 + arg_216_0 and not isNil(var_216_4) and arg_213_1.var_.characterEffect1068ui_story then
				arg_213_1.var_.characterEffect1068ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1068ui_story.fillRatio = 0.5
			end

			local var_216_6 = 0
			local var_216_7 = 1.325

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_8 = arg_213_1:GetWordFromCfg(113081052)
				local var_216_9 = arg_213_1:FormatText(var_216_8.content)

				arg_213_1.text_.text = var_216_9

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_11 = 53 <= 0 and var_216_7 or var_216_7 * (utf8.len(var_216_9) / 53)

				if (53 <= 0 and var_216_7 or var_216_7 * (utf8.len(var_216_9) / 53)) > 0 and var_216_7 < var_216_11 then
					arg_213_1.talkMaxDuration = var_216_11

					if var_216_11 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_11 + var_216_6
					end
				end

				arg_213_1.text_.text = var_216_9
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081052", "story_v_out_113081.awb") ~= 0 then
					local var_216_12 = manager.audio:GetVoiceLength("story_v_out_113081", "113081052", "story_v_out_113081.awb") / 1000

					if var_216_12 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_12 + var_216_6
					end

					if var_216_8.prefab_name ~= "" and arg_213_1.actors_[var_216_8.prefab_name] ~= nil then
						local var_216_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_8.prefab_name].transform, "story_v_out_113081", "113081052", "story_v_out_113081.awb")

						arg_213_1:RecordAudio("113081052", var_216_13)
						arg_213_1:RecordAudio("113081052", var_216_13)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_113081", "113081052", "story_v_out_113081.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_113081", "113081052", "story_v_out_113081.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_14 = math.max(var_216_7, arg_213_1.talkMaxDuration)

			if var_216_6 <= arg_213_1.time_ and arg_213_1.time_ < var_216_6 + var_216_14 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_6) / var_216_14

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_6 + var_216_14 and arg_213_1.time_ < var_216_6 + var_216_14 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play113081053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 113081053
		arg_217_1.duration_ = 2.87

		local var_217_0 = {
			ja = 2.033,
			ko = 1.999999999999,
			zh = 2.866,
			en = 2.833
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
				arg_217_0:Play113081054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1068ui_story = arg_217_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1068ui_story"].transform.position).z)
				arg_217_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1068ui_story"].transform.localEulerAngles = arg_217_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_217_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1068ui_story"].transform.position).z)
				arg_217_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1068ui_story"].transform.localEulerAngles = arg_217_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_220_1 = arg_217_1.actors_["1042ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1042ui_story == nil then
				arg_217_1.var_.characterEffect1042ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect1042ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1042ui_story then
				arg_217_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_220_4 = arg_217_1.actors_["1042ui_story"].transform

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1042ui_story = var_220_4.localPosition
			end

			local var_220_5 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_5 then
				var_220_4.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_217_1.time_ - 0) / var_220_5)
				var_220_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_4.position).x, (manager.ui.mainCamera.transform.position - var_220_4.position).y, (manager.ui.mainCamera.transform.position - var_220_4.position).z)
				var_220_4.localEulerAngles.z = 0
				var_220_4.localEulerAngles.x = 0
				var_220_4.localEulerAngles = var_220_4.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_5 and arg_217_1.time_ < 0 + var_220_5 + arg_220_0 then
				var_220_4.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				var_220_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_4.position).x, (manager.ui.mainCamera.transform.position - var_220_4.position).y, (manager.ui.mainCamera.transform.position - var_220_4.position).z)
				var_220_4.localEulerAngles.z = 0
				var_220_4.localEulerAngles.x = 0
				var_220_4.localEulerAngles = var_220_4.localEulerAngles
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			local var_220_6 = 0
			local var_220_7 = 0.2

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_8 = arg_217_1:GetWordFromCfg(113081053)
				local var_220_9 = arg_217_1:FormatText(var_220_8.content)

				arg_217_1.text_.text = var_220_9

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_11 = 8 <= 0 and var_220_7 or var_220_7 * (utf8.len(var_220_9) / 8)

				if (8 <= 0 and var_220_7 or var_220_7 * (utf8.len(var_220_9) / 8)) > 0 and var_220_7 < var_220_11 then
					arg_217_1.talkMaxDuration = var_220_11

					if var_220_11 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_11 + var_220_6
					end
				end

				arg_217_1.text_.text = var_220_9
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081053", "story_v_out_113081.awb") ~= 0 then
					local var_220_12 = manager.audio:GetVoiceLength("story_v_out_113081", "113081053", "story_v_out_113081.awb") / 1000

					if var_220_12 + var_220_6 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_12 + var_220_6
					end

					if var_220_8.prefab_name ~= "" and arg_217_1.actors_[var_220_8.prefab_name] ~= nil then
						local var_220_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_8.prefab_name].transform, "story_v_out_113081", "113081053", "story_v_out_113081.awb")

						arg_217_1:RecordAudio("113081053", var_220_13)
						arg_217_1:RecordAudio("113081053", var_220_13)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_113081", "113081053", "story_v_out_113081.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_113081", "113081053", "story_v_out_113081.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_14 = math.max(var_220_7, arg_217_1.talkMaxDuration)

			if var_220_6 <= arg_217_1.time_ and arg_217_1.time_ < var_220_6 + var_220_14 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_6) / var_220_14

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_6 + var_220_14 and arg_217_1.time_ < var_220_6 + var_220_14 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play113081054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 113081054
		arg_221_1.duration_ = 15.87

		local var_221_0 = {
			ja = 12.2,
			ko = 14.1,
			zh = 15.866,
			en = 12.033
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play113081055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1042ui_story"]) and arg_221_1.var_.characterEffect1042ui_story == nil then
				arg_221_1.var_.characterEffect1042ui_story = arg_221_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1042ui_story"]) then
				if arg_221_1.var_.characterEffect1042ui_story and not isNil(arg_221_1.actors_["1042ui_story"]) then
					arg_221_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_0)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1042ui_story"]) and arg_221_1.var_.characterEffect1042ui_story then
				arg_221_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action3_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_224_1 = arg_221_1.actors_["1067ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1067ui_story == nil then
				arg_221_1.var_.characterEffect1067ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1067ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1067ui_story then
				arg_221_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_224_4 = 0
			local var_224_5 = 1.725

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(113081054)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 69 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 69)

				if (69 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 69)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081054", "story_v_out_113081.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_out_113081", "113081054", "story_v_out_113081.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_out_113081", "113081054", "story_v_out_113081.awb")

						arg_221_1:RecordAudio("113081054", var_224_11)
						arg_221_1:RecordAudio("113081054", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_113081", "113081054", "story_v_out_113081.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_113081", "113081054", "story_v_out_113081.awb")
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

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play113081055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 113081055
		arg_225_1.duration_ = 2.7

		local var_225_0 = {
			ja = 1.999999999999,
			ko = 2,
			zh = 2.7,
			en = 2.6
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
				arg_225_0:Play113081056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1067ui_story"]) and arg_225_1.var_.characterEffect1067ui_story == nil then
				arg_225_1.var_.characterEffect1067ui_story = arg_225_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1067ui_story"]) then
				if arg_225_1.var_.characterEffect1067ui_story and not isNil(arg_225_1.actors_["1067ui_story"]) then
					arg_225_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1067ui_story"]) and arg_225_1.var_.characterEffect1067ui_story then
				arg_225_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_228_1 = arg_225_1.actors_["1042ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1042ui_story == nil then
				arg_225_1.var_.characterEffect1042ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect1042ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1042ui_story then
				arg_225_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_228_4 = 0
			local var_228_5 = 0.15

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_6 = arg_225_1:GetWordFromCfg(113081055)
				local var_228_7 = arg_225_1:FormatText(var_228_6.content)

				arg_225_1.text_.text = var_228_7

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 6 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 6)

				if (6 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 6)) > 0 and var_228_5 < var_228_9 then
					arg_225_1.talkMaxDuration = var_228_9

					if var_228_9 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_7
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081055", "story_v_out_113081.awb") ~= 0 then
					local var_228_10 = manager.audio:GetVoiceLength("story_v_out_113081", "113081055", "story_v_out_113081.awb") / 1000

					if var_228_10 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_4
					end

					if var_228_6.prefab_name ~= "" and arg_225_1.actors_[var_228_6.prefab_name] ~= nil then
						local var_228_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_6.prefab_name].transform, "story_v_out_113081", "113081055", "story_v_out_113081.awb")

						arg_225_1:RecordAudio("113081055", var_228_11)
						arg_225_1:RecordAudio("113081055", var_228_11)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_113081", "113081055", "story_v_out_113081.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_113081", "113081055", "story_v_out_113081.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_12 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_12 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_12

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_12 and arg_225_1.time_ < var_228_4 + var_228_12 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play113081056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 113081056
		arg_229_1.duration_ = 10.8

		local var_229_0 = {
			ja = 9.9,
			ko = 9.7,
			zh = 9.133,
			en = 10.8
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
				arg_229_0:Play113081057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1042ui_story"]) and arg_229_1.var_.characterEffect1042ui_story == nil then
				arg_229_1.var_.characterEffect1042ui_story = arg_229_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1042ui_story"]) then
				if arg_229_1.var_.characterEffect1042ui_story and not isNil(arg_229_1.actors_["1042ui_story"]) then
					arg_229_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1042ui_story"]) and arg_229_1.var_.characterEffect1042ui_story then
				arg_229_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_232_1 = arg_229_1.actors_["1067ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1067ui_story == nil then
				arg_229_1.var_.characterEffect1067ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect1067ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1067ui_story then
				arg_229_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067actionlink/1067action437")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_232_4 = 0
			local var_232_5 = 0.95

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(113081056)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 38 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 38)

				if (38 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 38)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081056", "story_v_out_113081.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_out_113081", "113081056", "story_v_out_113081.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_out_113081", "113081056", "story_v_out_113081.awb")

						arg_229_1:RecordAudio("113081056", var_232_11)
						arg_229_1:RecordAudio("113081056", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_113081", "113081056", "story_v_out_113081.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_113081", "113081056", "story_v_out_113081.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_12 and arg_229_1.time_ < var_232_4 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play113081057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 113081057
		arg_233_1.duration_ = 2.4

		local var_233_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.4,
			en = 2.3
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
				arg_233_0:Play113081058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_236_0 = 0
			local var_236_1 = 0.175

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[206].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_2 = arg_233_1:GetWordFromCfg(113081057)
				local var_236_3 = arg_233_1:FormatText(var_236_2.content)

				arg_233_1.text_.text = var_236_3

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 7 <= 0 and var_236_1 or var_236_1 * (utf8.len(var_236_3) / 7)

				if (7 <= 0 and var_236_1 or var_236_1 * (utf8.len(var_236_3) / 7)) > 0 and var_236_1 < var_236_5 then
					arg_233_1.talkMaxDuration = var_236_5

					if var_236_5 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_3
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081057", "story_v_out_113081.awb") ~= 0 then
					local var_236_6 = manager.audio:GetVoiceLength("story_v_out_113081", "113081057", "story_v_out_113081.awb") / 1000

					if var_236_6 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_6 + var_236_0
					end

					if var_236_2.prefab_name ~= "" and arg_233_1.actors_[var_236_2.prefab_name] ~= nil then
						local var_236_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_2.prefab_name].transform, "story_v_out_113081", "113081057", "story_v_out_113081.awb")

						arg_233_1:RecordAudio("113081057", var_236_7)
						arg_233_1:RecordAudio("113081057", var_236_7)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_113081", "113081057", "story_v_out_113081.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_113081", "113081057", "story_v_out_113081.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_8 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_8 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_8

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_8 and arg_233_1.time_ < var_236_0 + var_236_8 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play113081058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 113081058
		arg_237_1.duration_ = 2.1

		local var_237_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.1,
			en = 1.999999999999
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
				arg_237_0:Play113081059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1042ui_story = arg_237_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1042ui_story"].transform.position).z)
				arg_237_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1042ui_story"].transform.localEulerAngles = arg_237_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_237_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["1042ui_story"].transform.position).z)
				arg_237_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["1042ui_story"].transform.localEulerAngles = arg_237_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["1068ui_story"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos1068ui_story = var_240_1.localPosition
			end

			local var_240_2 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 then
				var_240_1.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos1068ui_story, Vector3.New(-0.7, -0.95, -5.88), (arg_237_1.time_ - 0) / var_240_2)
				var_240_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_1.position).x, (manager.ui.mainCamera.transform.position - var_240_1.position).y, (manager.ui.mainCamera.transform.position - var_240_1.position).z)
				var_240_1.localEulerAngles.z = 0
				var_240_1.localEulerAngles.x = 0
				var_240_1.localEulerAngles = var_240_1.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 then
				var_240_1.localPosition = Vector3.New(-0.7, -0.95, -5.88)
				var_240_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_240_1.position).x, (manager.ui.mainCamera.transform.position - var_240_1.position).y, (manager.ui.mainCamera.transform.position - var_240_1.position).z)
				var_240_1.localEulerAngles.z = 0
				var_240_1.localEulerAngles.x = 0
				var_240_1.localEulerAngles = var_240_1.localEulerAngles
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/story1068/story1068action/1068action1_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_240_3 = arg_237_1.actors_["1068ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_3) and arg_237_1.var_.characterEffect1068ui_story == nil then
				arg_237_1.var_.characterEffect1068ui_story = var_240_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_4 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_4 and not isNil(var_240_3) then
				if arg_237_1.var_.characterEffect1068ui_story and not isNil(var_240_3) then
					arg_237_1.var_.characterEffect1068ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_4 and arg_237_1.time_ < 0 + var_240_4 + arg_240_0 and not isNil(var_240_3) and arg_237_1.var_.characterEffect1068ui_story then
				arg_237_1.var_.characterEffect1068ui_story.fillFlat = false
			end

			local var_240_6 = arg_237_1.actors_["1067ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_6) and arg_237_1.var_.characterEffect1067ui_story == nil then
				arg_237_1.var_.characterEffect1067ui_story = var_240_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_7 = 0.2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_7 and not isNil(var_240_6) then
				if arg_237_1.var_.characterEffect1067ui_story and not isNil(var_240_6) then
					arg_237_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_7)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_7 and arg_237_1.time_ < 0 + var_240_7 + arg_240_0 and not isNil(var_240_6) and arg_237_1.var_.characterEffect1067ui_story then
				arg_237_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_240_8 = 0
			local var_240_9 = 0.1

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_10 = arg_237_1:GetWordFromCfg(113081058)
				local var_240_11 = arg_237_1:FormatText(var_240_10.content)

				arg_237_1.text_.text = var_240_11

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_13 = 4 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 4)

				if (4 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 4)) > 0 and var_240_9 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_8
					end
				end

				arg_237_1.text_.text = var_240_11
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081058", "story_v_out_113081.awb") ~= 0 then
					local var_240_14 = manager.audio:GetVoiceLength("story_v_out_113081", "113081058", "story_v_out_113081.awb") / 1000

					if var_240_14 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_8
					end

					if var_240_10.prefab_name ~= "" and arg_237_1.actors_[var_240_10.prefab_name] ~= nil then
						local var_240_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_10.prefab_name].transform, "story_v_out_113081", "113081058", "story_v_out_113081.awb")

						arg_237_1:RecordAudio("113081058", var_240_15)
						arg_237_1:RecordAudio("113081058", var_240_15)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_113081", "113081058", "story_v_out_113081.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_113081", "113081058", "story_v_out_113081.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_16 = math.max(var_240_9, arg_237_1.talkMaxDuration)

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_16 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_8) / var_240_16

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_8 + var_240_16 and arg_237_1.time_ < var_240_8 + var_240_16 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play113081059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 113081059
		arg_241_1.duration_ = 13

		local var_241_0 = {
			ja = 13,
			ko = 6.6,
			zh = 5.9,
			en = 6.1
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
				arg_241_0:Play113081060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_244_0 = 0
			local var_244_1 = 0.7

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[218].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_2 = arg_241_1:GetWordFromCfg(113081059)
				local var_244_3 = arg_241_1:FormatText(var_244_2.content)

				arg_241_1.text_.text = var_244_3

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 28 <= 0 and var_244_1 or var_244_1 * (utf8.len(var_244_3) / 28)

				if (28 <= 0 and var_244_1 or var_244_1 * (utf8.len(var_244_3) / 28)) > 0 and var_244_1 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_3
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081059", "story_v_out_113081.awb") ~= 0 then
					local var_244_6 = manager.audio:GetVoiceLength("story_v_out_113081", "113081059", "story_v_out_113081.awb") / 1000

					if var_244_6 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_0
					end

					if var_244_2.prefab_name ~= "" and arg_241_1.actors_[var_244_2.prefab_name] ~= nil then
						local var_244_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_2.prefab_name].transform, "story_v_out_113081", "113081059", "story_v_out_113081.awb")

						arg_241_1:RecordAudio("113081059", var_244_7)
						arg_241_1:RecordAudio("113081059", var_244_7)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_113081", "113081059", "story_v_out_113081.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_113081", "113081059", "story_v_out_113081.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_8 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_8 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_8

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_8 and arg_241_1.time_ < var_244_0 + var_244_8 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play113081060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 113081060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play113081061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1068ui_story = arg_245_1.actors_["1068ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1068ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1068ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1068ui_story"].transform.position).z)
				arg_245_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1068ui_story"].transform.localEulerAngles = arg_245_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1068ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_245_1.actors_["1068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1068ui_story"].transform.position).z)
				arg_245_1.actors_["1068ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1068ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1068ui_story"].transform.localEulerAngles = arg_245_1.actors_["1068ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["1067ui_story"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1067ui_story = var_248_1.localPosition
			end

			local var_248_2 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 then
				var_248_1.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1067ui_story, Vector3.New(0, 100, 0), (arg_245_1.time_ - 0) / var_248_2)
				var_248_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_1.position).x, (manager.ui.mainCamera.transform.position - var_248_1.position).y, (manager.ui.mainCamera.transform.position - var_248_1.position).z)
				var_248_1.localEulerAngles.z = 0
				var_248_1.localEulerAngles.x = 0
				var_248_1.localEulerAngles = var_248_1.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 then
				var_248_1.localPosition = Vector3.New(0, 100, 0)
				var_248_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_1.position).x, (manager.ui.mainCamera.transform.position - var_248_1.position).y, (manager.ui.mainCamera.transform.position - var_248_1.position).z)
				var_248_1.localEulerAngles.z = 0
				var_248_1.localEulerAngles.x = 0
				var_248_1.localEulerAngles = var_248_1.localEulerAngles
			end

			local var_248_3 = 0
			local var_248_4 = 0.825

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_3 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_5 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(113081060).content)

				arg_245_1.text_.text = var_248_5

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_7 = 33 <= 0 and var_248_4 or var_248_4 * (utf8.len(var_248_5) / 33)

				if (33 <= 0 and var_248_4 or var_248_4 * (utf8.len(var_248_5) / 33)) > 0 and var_248_4 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_3 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_3
					end
				end

				arg_245_1.text_.text = var_248_5
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_8 = math.max(var_248_4, arg_245_1.talkMaxDuration)

			if var_248_3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_3 + var_248_8 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_3) / var_248_8

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_3 + var_248_8 and arg_245_1.time_ < var_248_3 + var_248_8 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play113081061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 113081061
		arg_249_1.duration_ = 3.43

		local var_249_0 = {
			ja = 3.433,
			ko = 2.233,
			zh = 2.3,
			en = 3.266
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
			arg_249_1.auto_ = false
		end

		function arg_249_1.playNext_(arg_251_0)
			arg_249_1.onStoryFinished_()
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1042ui_story"]) and arg_249_1.var_.characterEffect1042ui_story == nil then
				arg_249_1.var_.characterEffect1042ui_story = arg_249_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1042ui_story"]) then
				if arg_249_1.var_.characterEffect1042ui_story and not isNil(arg_249_1.actors_["1042ui_story"]) then
					arg_249_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1042ui_story"]) and arg_249_1.var_.characterEffect1042ui_story then
				arg_249_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_252_2 = arg_249_1.actors_["1042ui_story"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1042ui_story = var_252_2.localPosition
			end

			local var_252_3 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_3 then
				var_252_2.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_249_1.time_ - 0) / var_252_3)
				var_252_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_2.position).x, (manager.ui.mainCamera.transform.position - var_252_2.position).y, (manager.ui.mainCamera.transform.position - var_252_2.position).z)
				var_252_2.localEulerAngles.z = 0
				var_252_2.localEulerAngles.x = 0
				var_252_2.localEulerAngles = var_252_2.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_3 and arg_249_1.time_ < 0 + var_252_3 + arg_252_0 then
				var_252_2.localPosition = Vector3.New(0, -1.06, -6.2)
				var_252_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_2.position).x, (manager.ui.mainCamera.transform.position - var_252_2.position).y, (manager.ui.mainCamera.transform.position - var_252_2.position).z)
				var_252_2.localEulerAngles.z = 0
				var_252_2.localEulerAngles.x = 0
				var_252_2.localEulerAngles = var_252_2.localEulerAngles
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action8_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_252_4 = 0
			local var_252_5 = 0.25

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(113081061)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 10 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 10)

				if (10 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 10)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113081", "113081061", "story_v_out_113081.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_113081", "113081061", "story_v_out_113081.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_113081", "113081061", "story_v_out_113081.awb")

						arg_249_1:RecordAudio("113081061", var_252_11)
						arg_249_1:RecordAudio("113081061", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_113081", "113081061", "story_v_out_113081.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_113081", "113081061", "story_v_out_113081.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_12 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_12 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_12

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_12 and arg_249_1.time_ < var_252_4 + var_252_12 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/OM0108",
		"TextureConfig/Background/F01a",
		"TextureConfig/Background/F03"
	},
	voices = {
		"story_v_out_113081.awb"
	}
}
