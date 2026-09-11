return {
	Play115032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115032001
		arg_1_1.duration_ = 7.6

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play115032002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.RO0104 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "RO0104")
				var_4_0.name = "RO0104"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.RO0104 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.RO0104

				arg_1_1.bgs_.RO0104.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "RO0104" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

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

			local var_4_8 = manager.ui.mainCamera.transform

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.999999999999 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_8.localPosition
			end

			local var_4_9 = 0.6

			if 1.999999999999 <= arg_1_1.time_ and arg_1_1.time_ < 1.999999999999 + var_4_9 then
				local var_4_10, var_4_11 = math.modf((arg_1_1.time_ - 1.999999999999) / 0.066)

				var_4_8.localPosition = Vector3.New(var_4_11 * 0.13, var_4_11 * 0.13, var_4_11 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 1.999999999999 + var_4_9 and arg_1_1.time_ < 1.999999999999 + var_4_9 + arg_4_0 then
				var_4_8.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_12 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_12 + 0.6 and arg_1_1.time_ < var_4_12 + 0.6 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_13 = arg_1_1.bgs_.RO0104.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosRO0104 = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosRO0104, Vector3.New(0, 1, 9.5), (arg_1_1.time_ - 0) / var_4_14)
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_4_15 = arg_1_1.bgs_.RO0104.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosRO0104 = var_4_15.localPosition
			end

			local var_4_16 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_16 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosRO0104, Vector3.New(0, 1, 10), (arg_1_1.time_ - 0) / var_4_16)
			end

			if arg_1_1.time_ >= 0 + var_4_16 and arg_1_1.time_ < 0 + var_4_16 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_17 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_17 + 2.299998 and arg_1_1.time_ < var_4_17 + 2.299998 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = arg_1_1.bgs_.RO0104.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosRO0104 = var_4_18.localPosition
			end

			local var_4_19 = 3

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_19 then
				var_4_18.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosRO0104, Vector3.New(0, 1, 9.5), (arg_1_1.time_ - 0) / var_4_19)
			end

			if arg_1_1.time_ >= 0 + var_4_19 and arg_1_1.time_ < 0 + var_4_19 + arg_4_0 then
				var_4_18.localPosition = Vector3.New(0, 1, 9.5)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			if 1.23333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 1.23333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_5_story_3", "bgm_activity_1_5_story_3", "bgm_activity_1_5_story_3.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_1_5_story_3", "bgm_activity_1_5_story_3")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_25 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_25

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_25
						arg_1_1.bgmTxt2_.text = var_4_25
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

			local var_4_26 = 2.599999999999
			local var_4_27 = 0.625

			if 2.599999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_28 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_28:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(115032001).content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 25 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_29) / 25)

				if (25 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_29) / 25)) > 0 and var_4_27 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_26 = var_4_26 + 0.3

					if var_4_31 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_26
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_26 + 0.3
			local var_4_33 = math.max(var_4_27, arg_1_1.talkMaxDuration)

			if var_4_26 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "RO0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "RO0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "RO0104",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play115032002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115032002
		arg_9_1.duration_ = 4.63

		local var_9_0 = {
			ja = 2.7,
			ko = 4.633,
			zh = 2.4,
			en = 2.9
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
				arg_9_0:Play115032003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.3

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(115032002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 12 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 12)

				if (12 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 12)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032002", "story_v_out_115032.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_115032", "115032002", "story_v_out_115032.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_115032", "115032002", "story_v_out_115032.awb")

						arg_9_1:RecordAudio("115032002", var_12_6)
						arg_9_1:RecordAudio("115032002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_115032", "115032002", "story_v_out_115032.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_115032", "115032002", "story_v_out_115032.awb")
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
	Play115032003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115032003
		arg_13_1.duration_ = 5.47

		local var_13_0 = {
			ja = 5.466,
			ko = 4.3,
			zh = 4.366,
			en = 3.733
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play115032004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.425

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(115032003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 17 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 17)

				if (17 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 17)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032003", "story_v_out_115032.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_115032", "115032003", "story_v_out_115032.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_115032", "115032003", "story_v_out_115032.awb")

						arg_13_1:RecordAudio("115032003", var_16_6)
						arg_13_1:RecordAudio("115032003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_115032", "115032003", "story_v_out_115032.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_115032", "115032003", "story_v_out_115032.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play115032004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115032004
		arg_17_1.duration_ = 6.87

		local var_17_0 = {
			ja = 6.866,
			ko = 5.799999999999,
			zh = 6.3,
			en = 5.799999999999
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
				arg_17_0:Play115032005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.bgs_.G03a == nil then
				local var_20_0 = Object.Instantiate(arg_17_1.paintGo_)

				var_20_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "G03a")
				var_20_0.name = "G03a"
				var_20_0.transform.parent = arg_17_1.stage_.transform
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.bgs_.G03a = var_20_0
			end

			if 2 < arg_17_1.time_ and arg_17_1.time_ <= 2 + arg_20_0 then
				local var_20_1 = arg_17_1.bgs_.G03a

				arg_17_1.bgs_.G03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_20_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_20_2 = var_20_1:GetComponent("SpriteRenderer")

				if var_20_2 and var_20_2.sprite then
					local var_20_3 = 2 * (var_20_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_20_1.transform.localScale = Vector3.New(var_20_3 / var_20_2.sprite.bounds.size.y < var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x and var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x or var_20_3 / var_20_2.sprite.bounds.size.y, var_20_3 / var_20_2.sprite.bounds.size.y < var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x and var_20_3 * manager.ui.mainCameraCom_.aspect / var_20_2.sprite.bounds.size.x or var_20_3 / var_20_2.sprite.bounds.size.y, 0)
				end

				for iter_20_0, iter_20_1 in pairs(arg_17_1.bgs_) do
					if iter_20_0 ~= "G03a" then
						iter_20_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_20_4 = 0

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_5 = 2

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_5 then
				local var_20_6 = Color.New(0, 0, 0)

				var_20_6.a = Mathf.Lerp(0, 1, (arg_17_1.time_ - var_20_4) / var_20_5)
				arg_17_1.mask_.color = var_20_6
			end

			if arg_17_1.time_ >= var_20_4 + var_20_5 and arg_17_1.time_ < var_20_4 + var_20_5 + arg_20_0 then
				local var_20_7 = Color.New(0, 0, 0)

				var_20_7.a = 1
				arg_17_1.mask_.color = var_20_7
			end

			local var_20_8 = 2

			if 2 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = true

				arg_17_1:SetGaussion(false)
			end

			local var_20_9 = 2

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_9 then
				local var_20_10 = Color.New(0, 0, 0)

				var_20_10.a = Mathf.Lerp(1, 0, (arg_17_1.time_ - var_20_8) / var_20_9)
				arg_17_1.mask_.color = var_20_10
			end

			if arg_17_1.time_ >= var_20_8 + var_20_9 and arg_17_1.time_ < var_20_8 + var_20_9 + arg_20_0 then
				local var_20_11 = Color.New(0, 0, 0)

				arg_17_1.mask_.enabled = false
				var_20_11.a = 0
				arg_17_1.mask_.color = var_20_11
			end

			local var_20_12 = "1024ui_story"

			if arg_17_1.actors_["1024ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1024ui_story"))) then
				local var_20_13 = Object.Instantiate(Asset.Load("Char/" .. "1024ui_story"), arg_17_1.stage_.transform)

				var_20_13.name = var_20_12
				var_20_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_[var_20_12] = var_20_13

				local var_20_14 = var_20_13:GetComponentInChildren(typeof(CharacterEffect))

				var_20_14.enabled = true

				local var_20_15 = GameObjectTools.GetOrAddComponent(var_20_13, typeof(DynamicBoneHelper))

				if var_20_15 then
					var_20_15:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_14.transform, false)

				arg_17_1.var_[var_20_12 .. "Animator"] = var_20_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_[var_20_12 .. "Animator"].applyRootMotion = true
				arg_17_1.var_[var_20_12 .. "LipSync"] = var_20_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_16 = arg_17_1.actors_["1024ui_story"].transform

			if 3.8 < arg_17_1.time_ and arg_17_1.time_ <= 3.8 + arg_20_0 then
				arg_17_1.var_.moveOldPos1024ui_story = var_20_16.localPosition
			end

			local var_20_17 = 0.001

			if 3.8 <= arg_17_1.time_ and arg_17_1.time_ < 3.8 + var_20_17 then
				var_20_16.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1024ui_story, Vector3.New(-0.7, -1, -6.05), (arg_17_1.time_ - 3.8) / var_20_17)
				var_20_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_16.position).x, (manager.ui.mainCamera.transform.position - var_20_16.position).y, (manager.ui.mainCamera.transform.position - var_20_16.position).z)
				var_20_16.localEulerAngles.z = 0
				var_20_16.localEulerAngles.x = 0
				var_20_16.localEulerAngles = var_20_16.localEulerAngles
			end

			if arg_17_1.time_ >= 3.8 + var_20_17 and arg_17_1.time_ < 3.8 + var_20_17 + arg_20_0 then
				var_20_16.localPosition = Vector3.New(-0.7, -1, -6.05)
				var_20_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_16.position).x, (manager.ui.mainCamera.transform.position - var_20_16.position).y, (manager.ui.mainCamera.transform.position - var_20_16.position).z)
				var_20_16.localEulerAngles.z = 0
				var_20_16.localEulerAngles.x = 0
				var_20_16.localEulerAngles = var_20_16.localEulerAngles
			end

			if 3.8 < arg_17_1.time_ and arg_17_1.time_ <= 3.8 + arg_20_0 then
				arg_17_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/story1024/story1024action/1024action1_1")
			end

			if 3.8 < arg_17_1.time_ and arg_17_1.time_ <= 3.8 + arg_20_0 then
				arg_17_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_20_18 = arg_17_1.actors_["1024ui_story"]

			if 3.8 < arg_17_1.time_ and arg_17_1.time_ <= 3.8 + arg_20_0 and not isNil(var_20_18) and arg_17_1.var_.characterEffect1024ui_story == nil then
				arg_17_1.var_.characterEffect1024ui_story = var_20_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_19 = 0.2

			if 3.8 <= arg_17_1.time_ and arg_17_1.time_ < 3.8 + var_20_19 and not isNil(var_20_18) then
				if arg_17_1.var_.characterEffect1024ui_story and not isNil(var_20_18) then
					arg_17_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 3.8 + var_20_19 and arg_17_1.time_ < 3.8 + var_20_19 + arg_20_0 and not isNil(var_20_18) and arg_17_1.var_.characterEffect1024ui_story then
				arg_17_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_21 = 4
			local var_20_22 = 0.25

			if 4 < arg_17_1.time_ and arg_17_1.time_ <= var_20_21 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_23 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_23:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_24 = arg_17_1:GetWordFromCfg(115032004)
				local var_20_25 = arg_17_1:FormatText(var_20_24.content)

				arg_17_1.text_.text = var_20_25

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_27 = 10 <= 0 and var_20_22 or var_20_22 * (utf8.len(var_20_25) / 10)

				if (10 <= 0 and var_20_22 or var_20_22 * (utf8.len(var_20_25) / 10)) > 0 and var_20_22 < var_20_27 then
					arg_17_1.talkMaxDuration = var_20_27
					var_20_21 = var_20_21 + 0.3

					if var_20_27 + var_20_21 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_27 + var_20_21
					end
				end

				arg_17_1.text_.text = var_20_25
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032004", "story_v_out_115032.awb") ~= 0 then
					local var_20_28 = manager.audio:GetVoiceLength("story_v_out_115032", "115032004", "story_v_out_115032.awb") / 1000

					if var_20_28 + var_20_21 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_28 + var_20_21
					end

					if var_20_24.prefab_name ~= "" and arg_17_1.actors_[var_20_24.prefab_name] ~= nil then
						local var_20_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_24.prefab_name].transform, "story_v_out_115032", "115032004", "story_v_out_115032.awb")

						arg_17_1:RecordAudio("115032004", var_20_29)
						arg_17_1:RecordAudio("115032004", var_20_29)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_115032", "115032004", "story_v_out_115032.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_115032", "115032004", "story_v_out_115032.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_30 = var_20_21 + 0.3
			local var_20_31 = math.max(var_20_22, arg_17_1.talkMaxDuration)

			if var_20_21 + 0.3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_31 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_30) / var_20_31

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_30 + var_20_31 and arg_17_1.time_ < var_20_30 + var_20_31 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play115032005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 115032005
		arg_23_1.duration_ = 2.97

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play115032006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1024ui_story"]) and arg_23_1.var_.characterEffect1024ui_story == nil then
				arg_23_1.var_.characterEffect1024ui_story = arg_23_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1024ui_story"]) then
				if arg_23_1.var_.characterEffect1024ui_story and not isNil(arg_23_1.actors_["1024ui_story"]) then
					arg_23_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_0)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1024ui_story"]) and arg_23_1.var_.characterEffect1024ui_story then
				arg_23_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			local var_26_1 = "10014ui_story"

			if arg_23_1.actors_["10014ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10014ui_story"))) then
				local var_26_2 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_23_1.stage_.transform)

				var_26_2.name = var_26_1
				var_26_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_[var_26_1] = var_26_2

				local var_26_3 = var_26_2:GetComponentInChildren(typeof(CharacterEffect))

				var_26_3.enabled = true

				local var_26_4 = GameObjectTools.GetOrAddComponent(var_26_2, typeof(DynamicBoneHelper))

				if var_26_4 then
					var_26_4:EnableDynamicBone(false)
				end

				arg_23_1:ShowWeapon(var_26_3.transform, false)

				arg_23_1.var_[var_26_1 .. "Animator"] = var_26_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_23_1.var_[var_26_1 .. "Animator"].applyRootMotion = true
				arg_23_1.var_[var_26_1 .. "LipSync"] = var_26_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_26_5 = arg_23_1.actors_["10014ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos10014ui_story = var_26_5.localPosition
			end

			local var_26_6 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_6 then
				var_26_5.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_23_1.time_ - 0) / var_26_6)
				var_26_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_5.position).x, (manager.ui.mainCamera.transform.position - var_26_5.position).y, (manager.ui.mainCamera.transform.position - var_26_5.position).z)
				var_26_5.localEulerAngles.z = 0
				var_26_5.localEulerAngles.x = 0
				var_26_5.localEulerAngles = var_26_5.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_6 and arg_23_1.time_ < 0 + var_26_6 + arg_26_0 then
				var_26_5.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_26_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_5.position).x, (manager.ui.mainCamera.transform.position - var_26_5.position).y, (manager.ui.mainCamera.transform.position - var_26_5.position).z)
				var_26_5.localEulerAngles.z = 0
				var_26_5.localEulerAngles.x = 0
				var_26_5.localEulerAngles = var_26_5.localEulerAngles
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				if arg_23_1.var_.characterEffect10014ui_story == nil then
					arg_23_1.var_.characterEffect10014ui_story = arg_23_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_26_7 = arg_23_1.var_.characterEffect10014ui_story

				arg_23_1.var_.characterEffect10014ui_story.imageEffect:turnOff()

				var_26_7.interferenceEffect.enabled = true
				var_26_7.interferenceEffect.noise = 0.001
				var_26_7.interferenceEffect.simTimeScale = 1
				var_26_7.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				if arg_23_1.var_.characterEffect10014ui_story == nil then
					arg_23_1.var_.characterEffect10014ui_story = arg_23_1.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_23_1.var_.characterEffect10014ui_story.imageEffect:turnOn(false)
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_26_9 = 0
			local var_26_10 = 0.125

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_9 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_11 = arg_23_1:GetWordFromCfg(115032005)
				local var_26_12 = arg_23_1:FormatText(var_26_11.content)

				arg_23_1.text_.text = var_26_12

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_14 = 5 <= 0 and var_26_10 or var_26_10 * (utf8.len(var_26_12) / 5)

				if (5 <= 0 and var_26_10 or var_26_10 * (utf8.len(var_26_12) / 5)) > 0 and var_26_10 < var_26_14 then
					arg_23_1.talkMaxDuration = var_26_14

					if var_26_14 + var_26_9 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_14 + var_26_9
					end
				end

				arg_23_1.text_.text = var_26_12
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032005", "story_v_out_115032.awb") ~= 0 then
					local var_26_15 = manager.audio:GetVoiceLength("story_v_out_115032", "115032005", "story_v_out_115032.awb") / 1000

					if var_26_15 + var_26_9 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_15 + var_26_9
					end

					if var_26_11.prefab_name ~= "" and arg_23_1.actors_[var_26_11.prefab_name] ~= nil then
						local var_26_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_11.prefab_name].transform, "story_v_out_115032", "115032005", "story_v_out_115032.awb")

						arg_23_1:RecordAudio("115032005", var_26_16)
						arg_23_1:RecordAudio("115032005", var_26_16)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_115032", "115032005", "story_v_out_115032.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_115032", "115032005", "story_v_out_115032.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_17 = math.max(var_26_10, arg_23_1.talkMaxDuration)

			if var_26_9 <= arg_23_1.time_ and arg_23_1.time_ < var_26_9 + var_26_17 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_9) / var_26_17

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_9 + var_26_17 and arg_23_1.time_ < var_26_9 + var_26_17 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play115032006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 115032006
		arg_27_1.duration_ = 4.73

		local var_27_0 = {
			ja = 4.733,
			ko = 3.966,
			zh = 3.266,
			en = 2.2
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play115032007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1024ui_story"]) and arg_27_1.var_.characterEffect1024ui_story == nil then
				arg_27_1.var_.characterEffect1024ui_story = arg_27_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_0 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1024ui_story"]) then
				if arg_27_1.var_.characterEffect1024ui_story and not isNil(arg_27_1.actors_["1024ui_story"]) then
					arg_27_1.var_.characterEffect1024ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1024ui_story"]) and arg_27_1.var_.characterEffect1024ui_story then
				arg_27_1.var_.characterEffect1024ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_30_2 = 0
			local var_30_3 = 0.375

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_2 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_4 = arg_27_1:GetWordFromCfg(115032006)
				local var_30_5 = arg_27_1:FormatText(var_30_4.content)

				arg_27_1.text_.text = var_30_5

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_7 = 15 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_5) / 15)

				if (15 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_5) / 15)) > 0 and var_30_3 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_2
					end
				end

				arg_27_1.text_.text = var_30_5
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032006", "story_v_out_115032.awb") ~= 0 then
					local var_30_8 = manager.audio:GetVoiceLength("story_v_out_115032", "115032006", "story_v_out_115032.awb") / 1000

					if var_30_8 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_2
					end

					if var_30_4.prefab_name ~= "" and arg_27_1.actors_[var_30_4.prefab_name] ~= nil then
						local var_30_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_4.prefab_name].transform, "story_v_out_115032", "115032006", "story_v_out_115032.awb")

						arg_27_1:RecordAudio("115032006", var_30_9)
						arg_27_1:RecordAudio("115032006", var_30_9)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_115032", "115032006", "story_v_out_115032.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_115032", "115032006", "story_v_out_115032.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_3, arg_27_1.talkMaxDuration)

			if var_30_2 <= arg_27_1.time_ and arg_27_1.time_ < var_30_2 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_2) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_2 + var_30_10 and arg_27_1.time_ < var_30_2 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play115032007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 115032007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play115032008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos10014ui_story = arg_31_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["10014ui_story"].transform.position).z)
				arg_31_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["10014ui_story"].transform.localEulerAngles = arg_31_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["10014ui_story"].transform.position).z)
				arg_31_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["10014ui_story"].transform.localEulerAngles = arg_31_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1024ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1024ui_story = var_34_1.localPosition
			end

			local var_34_2 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 then
				var_34_1.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1024ui_story, Vector3.New(0, 100, 0), (arg_31_1.time_ - 0) / var_34_2)
				var_34_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_1.position).x, (manager.ui.mainCamera.transform.position - var_34_1.position).y, (manager.ui.mainCamera.transform.position - var_34_1.position).z)
				var_34_1.localEulerAngles.z = 0
				var_34_1.localEulerAngles.x = 0
				var_34_1.localEulerAngles = var_34_1.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 then
				var_34_1.localPosition = Vector3.New(0, 100, 0)
				var_34_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_1.position).x, (manager.ui.mainCamera.transform.position - var_34_1.position).y, (manager.ui.mainCamera.transform.position - var_34_1.position).z)
				var_34_1.localEulerAngles.z = 0
				var_34_1.localEulerAngles.x = 0
				var_34_1.localEulerAngles = var_34_1.localEulerAngles
			end

			local var_34_3 = 0
			local var_34_4 = 0.8

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_3 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_5 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(115032007).content)

				arg_31_1.text_.text = var_34_5

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_7 = 32 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_5) / 32)

				if (32 <= 0 and var_34_4 or var_34_4 * (utf8.len(var_34_5) / 32)) > 0 and var_34_4 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_3 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_3
					end
				end

				arg_31_1.text_.text = var_34_5
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_8 = math.max(var_34_4, arg_31_1.talkMaxDuration)

			if var_34_3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_3 + var_34_8 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_3) / var_34_8

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_3 + var_34_8 and arg_31_1.time_ < var_34_3 + var_34_8 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1024ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play115032008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 115032008
		arg_35_1.duration_ = 5.7

		local var_35_0 = {
			ja = 4.066,
			ko = 4.333,
			zh = 5.3,
			en = 5.7
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play115032009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_38_0 = arg_35_1.actors_["10014ui_story"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos10014ui_story = var_38_0.localPosition
			end

			local var_38_1 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_1 then
				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (arg_35_1.time_ - 0) / var_38_1)
				var_38_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_0.position).x, (manager.ui.mainCamera.transform.position - var_38_0.position).y, (manager.ui.mainCamera.transform.position - var_38_0.position).z)
				var_38_0.localEulerAngles.z = 0
				var_38_0.localEulerAngles.x = 0
				var_38_0.localEulerAngles = var_38_0.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_1 and arg_35_1.time_ < 0 + var_38_1 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(0, -1.06, -6.2)
				var_38_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_38_0.position).x, (manager.ui.mainCamera.transform.position - var_38_0.position).y, (manager.ui.mainCamera.transform.position - var_38_0.position).z)
				var_38_0.localEulerAngles.z = 0
				var_38_0.localEulerAngles.x = 0
				var_38_0.localEulerAngles = var_38_0.localEulerAngles
			end

			local var_38_2 = 0
			local var_38_3 = 0.425

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_2 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_4 = arg_35_1:GetWordFromCfg(115032008)
				local var_38_5 = arg_35_1:FormatText(var_38_4.content)

				arg_35_1.text_.text = var_38_5

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 17 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_5) / 17)

				if (17 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_5) / 17)) > 0 and var_38_3 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_2
					end
				end

				arg_35_1.text_.text = var_38_5
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032008", "story_v_out_115032.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_115032", "115032008", "story_v_out_115032.awb") / 1000

					if var_38_8 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_2
					end

					if var_38_4.prefab_name ~= "" and arg_35_1.actors_[var_38_4.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_4.prefab_name].transform, "story_v_out_115032", "115032008", "story_v_out_115032.awb")

						arg_35_1:RecordAudio("115032008", var_38_9)
						arg_35_1:RecordAudio("115032008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_115032", "115032008", "story_v_out_115032.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_115032", "115032008", "story_v_out_115032.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_3, arg_35_1.talkMaxDuration)

			if var_38_2 <= arg_35_1.time_ and arg_35_1.time_ < var_38_2 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_2) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_2 + var_38_10 and arg_35_1.time_ < var_38_2 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play115032009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 115032009
		arg_39_1.duration_ = 2.8

		local var_39_0 = {
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 2.8,
			en = 0.999999999999
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play115032010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.05

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[265].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1024")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:GetWordFromCfg(115032009)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 2 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 2)

				if (2 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 2)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032009", "story_v_out_115032.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_115032", "115032009", "story_v_out_115032.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_115032", "115032009", "story_v_out_115032.awb")

						arg_39_1:RecordAudio("115032009", var_42_6)
						arg_39_1:RecordAudio("115032009", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_115032", "115032009", "story_v_out_115032.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_115032", "115032009", "story_v_out_115032.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play115032010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 115032010
		arg_43_1.duration_ = 3.73

		local var_43_0 = {
			ja = 3.566,
			ko = 3.166,
			zh = 3.733,
			en = 3.5
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
				arg_43_0:Play115032011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1024ui_story"]) and arg_43_1.var_.characterEffect1024ui_story == nil then
				arg_43_1.var_.characterEffect1024ui_story = arg_43_1.actors_["1024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1024ui_story"]) then
				if arg_43_1.var_.characterEffect1024ui_story and not isNil(arg_43_1.actors_["1024ui_story"]) then
					arg_43_1.var_.characterEffect1024ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_0)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1024ui_story"]) and arg_43_1.var_.characterEffect1024ui_story then
				arg_43_1.var_.characterEffect1024ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1024ui_story.fillRatio = 0.5
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_46_1 = 0
			local var_46_2 = 0.4

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_3 = arg_43_1:GetWordFromCfg(115032010)
				local var_46_4 = arg_43_1:FormatText(var_46_3.content)

				arg_43_1.text_.text = var_46_4

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_6 = 16 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_4) / 16)

				if (16 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_4) / 16)) > 0 and var_46_2 < var_46_6 then
					arg_43_1.talkMaxDuration = var_46_6

					if var_46_6 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_6 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_4
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115032", "115032010", "story_v_out_115032.awb") ~= 0 then
					local var_46_7 = manager.audio:GetVoiceLength("story_v_out_115032", "115032010", "story_v_out_115032.awb") / 1000

					if var_46_7 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_1
					end

					if var_46_3.prefab_name ~= "" and arg_43_1.actors_[var_46_3.prefab_name] ~= nil then
						local var_46_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_3.prefab_name].transform, "story_v_out_115032", "115032010", "story_v_out_115032.awb")

						arg_43_1:RecordAudio("115032010", var_46_8)
						arg_43_1:RecordAudio("115032010", var_46_8)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_115032", "115032010", "story_v_out_115032.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_115032", "115032010", "story_v_out_115032.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_9 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_9 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_9

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_9 and arg_43_1.time_ < var_46_1 + var_46_9 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play115032011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 115032011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
			arg_47_1.auto_ = false
		end

		function arg_47_1.playNext_(arg_49_0)
			arg_47_1.onStoryFinished_()
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10014ui_story = arg_47_1.actors_["10014ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["10014ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10014ui_story"].transform.position).z)
				arg_47_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10014ui_story"].transform.localEulerAngles = arg_47_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["10014ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_["10014ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10014ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10014ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10014ui_story"].transform.position).z)
				arg_47_1.actors_["10014ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10014ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10014ui_story"].transform.localEulerAngles = arg_47_1.actors_["10014ui_story"].transform.localEulerAngles
			end

			local var_50_1 = 0
			local var_50_2 = 0.575

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_3 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_3:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_4 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(115032011).content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_6 = 23 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_4) / 23)

				if (23 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_4) / 23)) > 0 and var_50_2 < var_50_6 then
					arg_47_1.talkMaxDuration = var_50_6
					var_50_1 = var_50_1 + 0.3

					if var_50_6 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_4
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = var_50_1 + 0.3
			local var_50_8 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 + 0.3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_7 + var_50_8 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_7) / var_50_8

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_7 + var_50_8 and arg_47_1.time_ < var_50_7 + var_50_8 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
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
	assets = {
		"TextureConfig/Background/RO0104",
		"TextureConfig/Background/G03a"
	},
	voices = {
		"story_v_out_115032.awb"
	}
}
