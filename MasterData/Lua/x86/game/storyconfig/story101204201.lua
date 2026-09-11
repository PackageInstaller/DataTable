return {
	Play120421001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 120421001
		arg_1_1.duration_ = 6.57

		local var_1_0 = {
			zh = 5.033999999999,
			ja = 6.566
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
				arg_1_0:Play120421002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.XH0204 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0204")
				var_4_0.name = "XH0204"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.XH0204 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.XH0204

				arg_1_1.bgs_.XH0204.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "XH0204" then
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
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			local var_4_11 = arg_1_1.bgs_.XH0204.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0204 = var_4_11.localPosition
			end

			local var_4_12 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_12 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0204, Vector3.New(0, 2, 1), (arg_1_1.time_ - 0) / var_4_12)
			end

			if arg_1_1.time_ >= 0 + var_4_12 and arg_1_1.time_ < 0 + var_4_12 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(0, 2, 1)
			end

			local var_4_13 = arg_1_1.bgs_.XH0204.transform

			if 0.034 < arg_1_1.time_ and arg_1_1.time_ <= 0.034 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0204 = var_4_13.localPosition
			end

			local var_4_14 = 5

			if 0.034 <= arg_1_1.time_ and arg_1_1.time_ < 0.034 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0204, Vector3.New(0, 2.5, 1), (arg_1_1.time_ - 0.034) / var_4_14)
			end

			if arg_1_1.time_ >= 0.034 + var_4_14 and arg_1_1.time_ < 0.034 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, 2.5, 1)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.1

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:GetWordFromCfg(120421001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 4 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 4)

				if (4 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 4)) > 0 and var_4_16 < var_4_21 then
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421001", "story_v_out_120421.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_120421", "120421001", "story_v_out_120421.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_120421", "120421001", "story_v_out_120421.awb")

						arg_1_1:RecordAudio("120421001", var_4_23)
						arg_1_1:RecordAudio("120421001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_120421", "120421001", "story_v_out_120421.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_120421", "120421001", "story_v_out_120421.awb")
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

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play120421002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 120421002
		arg_8_1.duration_ = 4.47

		local var_8_0 = {
			zh = 2.6,
			ja = 4.466
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
				arg_8_0:Play120421003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.25

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:GetWordFromCfg(120421002)
				local var_11_2 = arg_8_1:FormatText(var_11_1.content)

				arg_8_1.text_.text = var_11_2

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 10 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 10)

				if (10 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_2) / 10)) > 0 and var_11_0 < var_11_4 then
					arg_8_1.talkMaxDuration = var_11_4

					if var_11_4 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_4 + 0
					end
				end

				arg_8_1.text_.text = var_11_2
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421002", "story_v_out_120421.awb") ~= 0 then
					local var_11_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421002", "story_v_out_120421.awb") / 1000

					if var_11_5 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + 0
					end

					if var_11_1.prefab_name ~= "" and arg_8_1.actors_[var_11_1.prefab_name] ~= nil then
						local var_11_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_1.prefab_name].transform, "story_v_out_120421", "120421002", "story_v_out_120421.awb")

						arg_8_1:RecordAudio("120421002", var_11_6)
						arg_8_1:RecordAudio("120421002", var_11_6)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_120421", "120421002", "story_v_out_120421.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_120421", "120421002", "story_v_out_120421.awb")
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
	Play120421003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 120421003
		arg_12_1.duration_ = 8.87

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play120421004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPosXH0204 = arg_12_1.bgs_.XH0204.transform.localPosition
			end

			local var_15_0 = 8

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 then
				arg_12_1.bgs_.XH0204.transform.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPosXH0204, Vector3.New(0, 2.5, 2.5), (arg_12_1.time_ - 0) / var_15_0)
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 then
				arg_12_1.bgs_.XH0204.transform.localPosition = Vector3.New(0, 2.5, 2.5)
			end

			local var_15_1 = 0

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			if arg_12_1.time_ >= var_15_1 + 8 and arg_12_1.time_ < var_15_1 + 8 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_2 = 0
			local var_15_3 = 0.3

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_4 = arg_12_1:GetWordFromCfg(120421003)
				local var_15_5 = arg_12_1:FormatText(var_15_4.content)

				arg_12_1.text_.text = var_15_5

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_7 = 12 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_5) / 12)

				if (12 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_5) / 12)) > 0 and var_15_3 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_2
					end
				end

				arg_12_1.text_.text = var_15_5
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421003", "story_v_out_120421.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421003", "story_v_out_120421.awb") / 1000

					if var_15_8 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_2
					end

					if var_15_4.prefab_name ~= "" and arg_12_1.actors_[var_15_4.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_4.prefab_name].transform, "story_v_out_120421", "120421003", "story_v_out_120421.awb")

						arg_12_1:RecordAudio("120421003", var_15_9)
						arg_12_1:RecordAudio("120421003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_120421", "120421003", "story_v_out_120421.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_120421", "120421003", "story_v_out_120421.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_3, arg_12_1.talkMaxDuration)

			if var_15_2 <= arg_12_1.time_ and arg_12_1.time_ < var_15_2 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_2) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_2 + var_15_10 and arg_12_1.time_ < var_15_2 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 8,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play120421004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 120421004
		arg_16_1.duration_ = 7.8

		local var_16_0 = {
			zh = 4.6,
			ja = 7.8
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
				arg_16_0:Play120421005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.325

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:GetWordFromCfg(120421004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 13 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 13)

				if (13 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 13)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421004", "story_v_out_120421.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421004", "story_v_out_120421.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_out_120421", "120421004", "story_v_out_120421.awb")

						arg_16_1:RecordAudio("120421004", var_19_6)
						arg_16_1:RecordAudio("120421004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_120421", "120421004", "story_v_out_120421.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_120421", "120421004", "story_v_out_120421.awb")
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
	Play120421005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 120421005
		arg_20_1.duration_ = 2.63

		local var_20_0 = {
			zh = 2.633,
			ja = 2.1
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
				arg_20_0:Play120421006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.15

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:GetWordFromCfg(120421005)
				local var_23_2 = arg_20_1:FormatText(var_23_1.content)

				arg_20_1.text_.text = var_23_2

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_4 = 6 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 6)

				if (6 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_2) / 6)) > 0 and var_23_0 < var_23_4 then
					arg_20_1.talkMaxDuration = var_23_4

					if var_23_4 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_4 + 0
					end
				end

				arg_20_1.text_.text = var_23_2
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421005", "story_v_out_120421.awb") ~= 0 then
					local var_23_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421005", "story_v_out_120421.awb") / 1000

					if var_23_5 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + 0
					end

					if var_23_1.prefab_name ~= "" and arg_20_1.actors_[var_23_1.prefab_name] ~= nil then
						local var_23_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_1.prefab_name].transform, "story_v_out_120421", "120421005", "story_v_out_120421.awb")

						arg_20_1:RecordAudio("120421005", var_23_6)
						arg_20_1:RecordAudio("120421005", var_23_6)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_120421", "120421005", "story_v_out_120421.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_120421", "120421005", "story_v_out_120421.awb")
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
	Play120421006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 120421006
		arg_24_1.duration_ = 4.77

		local var_24_0 = {
			zh = 3.4,
			ja = 4.766
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
				arg_24_0:Play120421007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.125

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_1 = arg_24_1:GetWordFromCfg(120421006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 5 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 5)

				if (5 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 5)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421006", "story_v_out_120421.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421006", "story_v_out_120421.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_120421", "120421006", "story_v_out_120421.awb")

						arg_24_1:RecordAudio("120421006", var_27_6)
						arg_24_1:RecordAudio("120421006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_120421", "120421006", "story_v_out_120421.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_120421", "120421006", "story_v_out_120421.awb")
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
	Play120421007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 120421007
		arg_28_1.duration_ = 3.83

		local var_28_0 = {
			zh = 2.966,
			ja = 3.833
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
				arg_28_0:Play120421008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.2

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:GetWordFromCfg(120421007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 8 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 8)

				if (8 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 8)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421007", "story_v_out_120421.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421007", "story_v_out_120421.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_out_120421", "120421007", "story_v_out_120421.awb")

						arg_28_1:RecordAudio("120421007", var_31_6)
						arg_28_1:RecordAudio("120421007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_120421", "120421007", "story_v_out_120421.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_120421", "120421007", "story_v_out_120421.awb")
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
	Play120421008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 120421008
		arg_32_1.duration_ = 9.37

		local var_32_0 = {
			zh = 7.866,
			ja = 9.366
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
				arg_32_0:Play120421009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.5

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:GetWordFromCfg(120421008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 20 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 20)

				if (20 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 20)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421008", "story_v_out_120421.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421008", "story_v_out_120421.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_120421", "120421008", "story_v_out_120421.awb")

						arg_32_1:RecordAudio("120421008", var_35_6)
						arg_32_1:RecordAudio("120421008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_120421", "120421008", "story_v_out_120421.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_120421", "120421008", "story_v_out_120421.awb")
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
	Play120421009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 120421009
		arg_36_1.duration_ = 9.77

		local var_36_0 = {
			zh = 9.766,
			ja = 7.5
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
				arg_36_0:Play120421010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.5

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:GetWordFromCfg(120421009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 20 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 20)

				if (20 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 20)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421009", "story_v_out_120421.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421009", "story_v_out_120421.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_120421", "120421009", "story_v_out_120421.awb")

						arg_36_1:RecordAudio("120421009", var_39_6)
						arg_36_1:RecordAudio("120421009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_120421", "120421009", "story_v_out_120421.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_120421", "120421009", "story_v_out_120421.awb")
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
	Play120421010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 120421010
		arg_40_1.duration_ = 7.43

		local var_40_0 = {
			zh = 4.2,
			ja = 7.433
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
				arg_40_0:Play120421011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.3

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:GetWordFromCfg(120421010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 12 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 12)

				if (12 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 12)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421010", "story_v_out_120421.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421010", "story_v_out_120421.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_120421", "120421010", "story_v_out_120421.awb")

						arg_40_1:RecordAudio("120421010", var_43_6)
						arg_40_1:RecordAudio("120421010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_120421", "120421010", "story_v_out_120421.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_120421", "120421010", "story_v_out_120421.awb")
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
	Play120421011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 120421011
		arg_44_1.duration_ = 2.67

		local var_44_0 = {
			zh = 1.5,
			ja = 2.666
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
				arg_44_0:Play120421012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.05

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:GetWordFromCfg(120421011)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 2 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 2)

				if (2 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 2)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421011", "story_v_out_120421.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421011", "story_v_out_120421.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_120421", "120421011", "story_v_out_120421.awb")

						arg_44_1:RecordAudio("120421011", var_47_6)
						arg_44_1:RecordAudio("120421011", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_120421", "120421011", "story_v_out_120421.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_120421", "120421011", "story_v_out_120421.awb")
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
	Play120421012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 120421012
		arg_48_1.duration_ = 4.37

		local var_48_0 = {
			zh = 4.366,
			ja = 4.233
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
				arg_48_0:Play120421013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.225

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:GetWordFromCfg(120421012)
				local var_51_2 = arg_48_1:FormatText(var_51_1.content)

				arg_48_1.text_.text = var_51_2

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 9 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 9)

				if (9 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 9)) > 0 and var_51_0 < var_51_4 then
					arg_48_1.talkMaxDuration = var_51_4

					if var_51_4 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_4 + 0
					end
				end

				arg_48_1.text_.text = var_51_2
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421012", "story_v_out_120421.awb") ~= 0 then
					local var_51_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421012", "story_v_out_120421.awb") / 1000

					if var_51_5 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + 0
					end

					if var_51_1.prefab_name ~= "" and arg_48_1.actors_[var_51_1.prefab_name] ~= nil then
						local var_51_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_1.prefab_name].transform, "story_v_out_120421", "120421012", "story_v_out_120421.awb")

						arg_48_1:RecordAudio("120421012", var_51_6)
						arg_48_1:RecordAudio("120421012", var_51_6)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_120421", "120421012", "story_v_out_120421.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_120421", "120421012", "story_v_out_120421.awb")
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
	Play120421013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 120421013
		arg_52_1.duration_ = 2.8

		local var_52_0 = {
			zh = 1.366,
			ja = 2.8
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
				arg_52_0:Play120421014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.125

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:GetWordFromCfg(120421013)
				local var_55_2 = arg_52_1:FormatText(var_55_1.content)

				arg_52_1.text_.text = var_55_2

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 5 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 5)

				if (5 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 5)) > 0 and var_55_0 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end

				arg_52_1.text_.text = var_55_2
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421013", "story_v_out_120421.awb") ~= 0 then
					local var_55_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421013", "story_v_out_120421.awb") / 1000

					if var_55_5 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + 0
					end

					if var_55_1.prefab_name ~= "" and arg_52_1.actors_[var_55_1.prefab_name] ~= nil then
						local var_55_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_1.prefab_name].transform, "story_v_out_120421", "120421013", "story_v_out_120421.awb")

						arg_52_1:RecordAudio("120421013", var_55_6)
						arg_52_1:RecordAudio("120421013", var_55_6)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_120421", "120421013", "story_v_out_120421.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_120421", "120421013", "story_v_out_120421.awb")
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
	Play120421014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 120421014
		arg_56_1.duration_ = 9.43

		local var_56_0 = {
			zh = 6.866,
			ja = 9.433
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play120421015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPosXH0204 = arg_56_1.bgs_.XH0204.transform.localPosition
			end

			local var_59_0 = 5

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				arg_56_1.bgs_.XH0204.transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPosXH0204, Vector3.New(0, 2.5, 3.5), (arg_56_1.time_ - 0) / var_59_0)
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				arg_56_1.bgs_.XH0204.transform.localPosition = Vector3.New(0, 2.5, 3.5)
			end

			local var_59_1 = 0
			local var_59_2 = 0.45

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_3 = arg_56_1:GetWordFromCfg(120421014)
				local var_59_4 = arg_56_1:FormatText(var_59_3.content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_6 = 18 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 18)

				if (18 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_4) / 18)) > 0 and var_59_2 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421014", "story_v_out_120421.awb") ~= 0 then
					local var_59_7 = manager.audio:GetVoiceLength("story_v_out_120421", "120421014", "story_v_out_120421.awb") / 1000

					if var_59_7 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_1
					end

					if var_59_3.prefab_name ~= "" and arg_56_1.actors_[var_59_3.prefab_name] ~= nil then
						local var_59_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_3.prefab_name].transform, "story_v_out_120421", "120421014", "story_v_out_120421.awb")

						arg_56_1:RecordAudio("120421014", var_59_8)
						arg_56_1:RecordAudio("120421014", var_59_8)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_120421", "120421014", "story_v_out_120421.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_120421", "120421014", "story_v_out_120421.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_9 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_9 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_9

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_9 and arg_56_1.time_ < var_59_1 + var_59_9 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0204",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play120421015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 120421015
		arg_60_1.duration_ = 4.53

		local var_60_0 = {
			zh = 4.533,
			ja = 3.033
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
				arg_60_0:Play120421016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.3

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_1 = arg_60_1:GetWordFromCfg(120421015)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 12 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 12)

				if (12 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 12)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421015", "story_v_out_120421.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421015", "story_v_out_120421.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_120421", "120421015", "story_v_out_120421.awb")

						arg_60_1:RecordAudio("120421015", var_63_6)
						arg_60_1:RecordAudio("120421015", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_120421", "120421015", "story_v_out_120421.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_120421", "120421015", "story_v_out_120421.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play120421016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 120421016
		arg_64_1.duration_ = 8.03

		local var_64_0 = {
			zh = 8.033,
			ja = 7.7
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play120421017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 2 < arg_64_1.time_ and arg_64_1.time_ <= 2 + arg_67_0 then
				local var_67_0 = arg_64_1.bgs_.XH0204

				arg_64_1.bgs_.XH0204.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_67_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_67_1 = var_67_0:GetComponent("SpriteRenderer")

				if var_67_1 and var_67_1.sprite then
					local var_67_2 = 2 * (var_67_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_67_0.transform.localScale = Vector3.New(var_67_2 / var_67_1.sprite.bounds.size.y < var_67_2 * manager.ui.mainCameraCom_.aspect / var_67_1.sprite.bounds.size.x and var_67_2 * manager.ui.mainCameraCom_.aspect / var_67_1.sprite.bounds.size.x or var_67_2 / var_67_1.sprite.bounds.size.y, var_67_2 / var_67_1.sprite.bounds.size.y < var_67_2 * manager.ui.mainCameraCom_.aspect / var_67_1.sprite.bounds.size.x and var_67_2 * manager.ui.mainCameraCom_.aspect / var_67_1.sprite.bounds.size.x or var_67_2 / var_67_1.sprite.bounds.size.y, 0)
				end

				for iter_67_0, iter_67_1 in pairs(arg_64_1.bgs_) do
					if iter_67_0 ~= "XH0204" then
						iter_67_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_67_3 = 0

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_3 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_4 = 2

			if var_67_3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_3 + var_67_4 then
				local var_67_5 = Color.New(0, 0, 0)

				var_67_5.a = Mathf.Lerp(0, 1, (arg_64_1.time_ - var_67_3) / var_67_4)
				arg_64_1.mask_.color = var_67_5
			end

			if arg_64_1.time_ >= var_67_3 + var_67_4 and arg_64_1.time_ < var_67_3 + var_67_4 + arg_67_0 then
				local var_67_6 = Color.New(0, 0, 0)

				var_67_6.a = 1
				arg_64_1.mask_.color = var_67_6
			end

			local var_67_7 = 2

			if 2 < arg_64_1.time_ and arg_64_1.time_ <= var_67_7 + arg_67_0 then
				arg_64_1.mask_.enabled = true
				arg_64_1.mask_.raycastTarget = true

				arg_64_1:SetGaussion(false)
			end

			local var_67_8 = 2

			if var_67_7 <= arg_64_1.time_ and arg_64_1.time_ < var_67_7 + var_67_8 then
				local var_67_9 = Color.New(0, 0, 0)

				var_67_9.a = Mathf.Lerp(1, 0, (arg_64_1.time_ - var_67_7) / var_67_8)
				arg_64_1.mask_.color = var_67_9
			end

			if arg_64_1.time_ >= var_67_7 + var_67_8 and arg_64_1.time_ < var_67_7 + var_67_8 + arg_67_0 then
				local var_67_10 = Color.New(0, 0, 0)

				arg_64_1.mask_.enabled = false
				var_67_10.a = 0
				arg_64_1.mask_.color = var_67_10
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_11 = 4
			local var_67_12 = 0.25

			if 4 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_13 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_13:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[399].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_14 = arg_64_1:GetWordFromCfg(120421016)
				local var_67_15 = arg_64_1:FormatText(var_67_14.content)

				arg_64_1.text_.text = var_67_15

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_17 = 10 <= 0 and var_67_12 or var_67_12 * (utf8.len(var_67_15) / 10)

				if (10 <= 0 and var_67_12 or var_67_12 * (utf8.len(var_67_15) / 10)) > 0 and var_67_12 < var_67_17 then
					arg_64_1.talkMaxDuration = var_67_17
					var_67_11 = var_67_11 + 0.3

					if var_67_17 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_17 + var_67_11
					end
				end

				arg_64_1.text_.text = var_67_15
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421016", "story_v_out_120421.awb") ~= 0 then
					local var_67_18 = manager.audio:GetVoiceLength("story_v_out_120421", "120421016", "story_v_out_120421.awb") / 1000

					if var_67_18 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_18 + var_67_11
					end

					if var_67_14.prefab_name ~= "" and arg_64_1.actors_[var_67_14.prefab_name] ~= nil then
						local var_67_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_14.prefab_name].transform, "story_v_out_120421", "120421016", "story_v_out_120421.awb")

						arg_64_1:RecordAudio("120421016", var_67_19)
						arg_64_1:RecordAudio("120421016", var_67_19)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_120421", "120421016", "story_v_out_120421.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_120421", "120421016", "story_v_out_120421.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_20 = var_67_11 + 0.3
			local var_67_21 = math.max(var_67_12, arg_64_1.talkMaxDuration)

			if var_67_11 + 0.3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_20 + var_67_21 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_20) / var_67_21

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_20 + var_67_21 and arg_64_1.time_ < var_67_20 + var_67_21 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play120421017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 120421017
		arg_70_1.duration_ = 6.57

		local var_70_0 = {
			zh = 6.566,
			ja = 5.133
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
				arg_70_0:Play120421018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if arg_70_1.bgs_.ST37 == nil then
				local var_73_0 = Object.Instantiate(arg_70_1.paintGo_)

				var_73_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST37")
				var_73_0.name = "ST37"
				var_73_0.transform.parent = arg_70_1.stage_.transform
				var_73_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.bgs_.ST37 = var_73_0
			end

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= 2 + arg_73_0 then
				local var_73_1 = arg_70_1.bgs_.ST37

				arg_70_1.bgs_.ST37.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_73_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_2 = var_73_1:GetComponent("SpriteRenderer")

				if var_73_2 and var_73_2.sprite then
					local var_73_3 = 2 * (var_73_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_73_1.transform.localScale = Vector3.New(var_73_3 / var_73_2.sprite.bounds.size.y < var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x and var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x or var_73_3 / var_73_2.sprite.bounds.size.y, var_73_3 / var_73_2.sprite.bounds.size.y < var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x and var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x or var_73_3 / var_73_2.sprite.bounds.size.y, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "ST37" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_73_4 = 0

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_5 = 2

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_5 then
				local var_73_6 = Color.New(0, 0, 0)

				var_73_6.a = Mathf.Lerp(0, 1, (arg_70_1.time_ - var_73_4) / var_73_5)
				arg_70_1.mask_.color = var_73_6
			end

			if arg_70_1.time_ >= var_73_4 + var_73_5 and arg_70_1.time_ < var_73_4 + var_73_5 + arg_73_0 then
				local var_73_7 = Color.New(0, 0, 0)

				var_73_7.a = 1
				arg_70_1.mask_.color = var_73_7
			end

			local var_73_8 = 2

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= var_73_8 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_9 = 2

			if var_73_8 <= arg_70_1.time_ and arg_70_1.time_ < var_73_8 + var_73_9 then
				local var_73_10 = Color.New(0, 0, 0)

				var_73_10.a = Mathf.Lerp(1, 0, (arg_70_1.time_ - var_73_8) / var_73_9)
				arg_70_1.mask_.color = var_73_10
			end

			if arg_70_1.time_ >= var_73_8 + var_73_9 and arg_70_1.time_ < var_73_8 + var_73_9 + arg_73_0 then
				local var_73_11 = Color.New(0, 0, 0)

				arg_70_1.mask_.enabled = false
				var_73_11.a = 0
				arg_70_1.mask_.color = var_73_11
			end

			if 0.133333333333333 < arg_70_1.time_ and arg_70_1.time_ <= 0.133333333333333 + arg_73_0 then
				arg_70_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_73_14 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_70_1.bgmTxt_.text ~= var_73_14 and arg_70_1.bgmTxt_.text ~= "" then
						if arg_70_1.bgmTxt2_.text ~= "" then
							arg_70_1.bgmTxt_.text = arg_70_1.bgmTxt2_.text
						end

						arg_70_1.bgmTxt2_.text = var_73_14

						arg_70_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_70_1.bgmTxt_.text = var_73_14
						arg_70_1.bgmTxt2_.text = var_73_14
					end

					if arg_70_1.bgmTimer then
						arg_70_1.bgmTimer:Stop()

						arg_70_1.bgmTimer = nil
					end

					if arg_70_1.settingData.show_music_name == 1 then
						arg_70_1.musicController:SetSelectedState("show")
						arg_70_1.musicAnimator_:Play("open", 0, 0)

						if arg_70_1.settingData.music_time ~= 0 then
							arg_70_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_70_1.settingData.music_time), function()
								if arg_70_1 == nil or isNil(arg_70_1.bgmTxt_) then
									return
								end

								arg_70_1.musicController:SetSelectedState("hide")
								arg_70_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_15 = 4
			local var_73_16 = 0.075

			if 4 < arg_70_1.time_ and arg_70_1.time_ <= var_73_15 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_17 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_17:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_70_1.dialogCg_.alpha = arg_75_0
				end))
				var_73_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_18 = arg_70_1:GetWordFromCfg(120421017)
				local var_73_19 = arg_70_1:FormatText(var_73_18.content)

				arg_70_1.text_.text = var_73_19

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_21 = 3 <= 0 and var_73_16 or var_73_16 * (utf8.len(var_73_19) / 3)

				if (3 <= 0 and var_73_16 or var_73_16 * (utf8.len(var_73_19) / 3)) > 0 and var_73_16 < var_73_21 then
					arg_70_1.talkMaxDuration = var_73_21
					var_73_15 = var_73_15 + 0.3

					if var_73_21 + var_73_15 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_21 + var_73_15
					end
				end

				arg_70_1.text_.text = var_73_19
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421017", "story_v_out_120421.awb") ~= 0 then
					local var_73_22 = manager.audio:GetVoiceLength("story_v_out_120421", "120421017", "story_v_out_120421.awb") / 1000

					if var_73_22 + var_73_15 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_22 + var_73_15
					end

					if var_73_18.prefab_name ~= "" and arg_70_1.actors_[var_73_18.prefab_name] ~= nil then
						local var_73_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_18.prefab_name].transform, "story_v_out_120421", "120421017", "story_v_out_120421.awb")

						arg_70_1:RecordAudio("120421017", var_73_23)
						arg_70_1:RecordAudio("120421017", var_73_23)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_120421", "120421017", "story_v_out_120421.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_120421", "120421017", "story_v_out_120421.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_24 = var_73_15 + 0.3
			local var_73_25 = math.max(var_73_16, arg_70_1.talkMaxDuration)

			if var_73_15 + 0.3 <= arg_70_1.time_ and arg_70_1.time_ < var_73_24 + var_73_25 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_24) / var_73_25

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_24 + var_73_25 and arg_70_1.time_ < var_73_24 + var_73_25 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play120421018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 120421018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play120421019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 1.55

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(120421018).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 62 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 62)

				if (62 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 62)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play120421019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 120421019
		arg_81_1.duration_ = 8.43

		local var_81_0 = {
			zh = 3.5,
			ja = 8.433
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
				arg_81_0:Play120421020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if arg_81_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_84_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_81_1.stage_.transform)

				var_84_0.name = "1084ui_story"
				var_84_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["1084ui_story"] = var_84_0

				local var_84_1 = var_84_0:GetComponentInChildren(typeof(CharacterEffect))

				var_84_1.enabled = true

				local var_84_2 = GameObjectTools.GetOrAddComponent(var_84_0, typeof(DynamicBoneHelper))

				if var_84_2 then
					var_84_2:EnableDynamicBone(false)
				end

				arg_81_1:ShowWeapon(var_84_1.transform, false)

				arg_81_1.var_["1084ui_story" .. "Animator"] = var_84_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_81_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_81_1.var_["1084ui_story" .. "LipSync"] = var_84_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_84_3 = arg_81_1.actors_["1084ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1084ui_story = var_84_3.localPosition
			end

			local var_84_4 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				var_84_3.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_81_1.time_ - 0) / var_84_4)
				var_84_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_3.position).x, (manager.ui.mainCamera.transform.position - var_84_3.position).y, (manager.ui.mainCamera.transform.position - var_84_3.position).z)
				var_84_3.localEulerAngles.z = 0
				var_84_3.localEulerAngles.x = 0
				var_84_3.localEulerAngles = var_84_3.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_3.localPosition = Vector3.New(0, -0.97, -6)
				var_84_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_3.position).x, (manager.ui.mainCamera.transform.position - var_84_3.position).y, (manager.ui.mainCamera.transform.position - var_84_3.position).z)
				var_84_3.localEulerAngles.z = 0
				var_84_3.localEulerAngles.x = 0
				var_84_3.localEulerAngles = var_84_3.localEulerAngles
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_84_5 = arg_81_1.actors_["1084ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = var_84_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_6 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 and not isNil(var_84_5) then
				if arg_81_1.var_.characterEffect1084ui_story and not isNil(var_84_5) then
					arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1084ui_story then
				arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_84_8 = 0
			local var_84_9 = 0.225

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(120421019)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 9 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 9)

				if (9 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 9)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421019", "story_v_out_120421.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_120421", "120421019", "story_v_out_120421.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_120421", "120421019", "story_v_out_120421.awb")

						arg_81_1:RecordAudio("120421019", var_84_15)
						arg_81_1:RecordAudio("120421019", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_120421", "120421019", "story_v_out_120421.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_120421", "120421019", "story_v_out_120421.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
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

		arg_81_1:InitPlayNodeList()
	end,
	Play120421020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 120421020
		arg_85_1.duration_ = 5.3

		local var_85_0 = {
			zh = 5.3,
			ja = 3.9
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
				arg_85_0:Play120421021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.2

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(120421020)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 8 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 8)

				if (8 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 8)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421020", "story_v_out_120421.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421020", "story_v_out_120421.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_120421", "120421020", "story_v_out_120421.awb")

						arg_85_1:RecordAudio("120421020", var_88_6)
						arg_85_1:RecordAudio("120421020", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_120421", "120421020", "story_v_out_120421.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_120421", "120421020", "story_v_out_120421.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play120421021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 120421021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play120421022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1084ui_story = arg_89_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1084ui_story"].transform.position).z)
				arg_89_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1084ui_story"].transform.localEulerAngles = arg_89_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1084ui_story"].transform.position).z)
				arg_89_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1084ui_story"].transform.localEulerAngles = arg_89_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:AudioAction("play", "effect", "se_story_16", "se_story_16_door06", "")
			end

			local var_92_2 = 0
			local var_92_3 = 1.075

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_2 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_4 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(120421021).content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_6 = 43 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_4) / 43)

				if (43 <= 0 and var_92_3 or var_92_3 * (utf8.len(var_92_4) / 43)) > 0 and var_92_3 < var_92_6 then
					arg_89_1.talkMaxDuration = var_92_6

					if var_92_6 + var_92_2 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_6 + var_92_2
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_3, arg_89_1.talkMaxDuration)

			if var_92_2 <= arg_89_1.time_ and arg_89_1.time_ < var_92_2 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_2) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_2 + var_92_7 and arg_89_1.time_ < var_92_2 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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

		arg_89_1:InitPlayNodeList()
	end,
	Play120421022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 120421022
		arg_93_1.duration_ = 5.73

		local var_93_0 = {
			zh = 3.766,
			ja = 5.733
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
				arg_93_0:Play120421023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1084ui_story = arg_93_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).z)
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles = arg_93_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_93_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1084ui_story"].transform.position).z)
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1084ui_story"].transform.localEulerAngles = arg_93_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_96_1 = arg_93_1.actors_["1084ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1084ui_story == nil then
				arg_93_1.var_.characterEffect1084ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1084ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1084ui_story then
				arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_96_4 = 0
			local var_96_5 = 0.35

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(120421022)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 14 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 14)

				if (14 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 14)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421022", "story_v_out_120421.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421022", "story_v_out_120421.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_120421", "120421022", "story_v_out_120421.awb")

						arg_93_1:RecordAudio("120421022", var_96_11)
						arg_93_1:RecordAudio("120421022", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_120421", "120421022", "story_v_out_120421.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_120421", "120421022", "story_v_out_120421.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play120421023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 120421023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play120421024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1084ui_story = arg_97_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1084ui_story"].transform.position).z)
				arg_97_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1084ui_story"].transform.localEulerAngles = arg_97_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["1084ui_story"].transform.position).z)
				arg_97_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["1084ui_story"].transform.localEulerAngles = arg_97_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_100_1 = 0
			local var_100_2 = 1.525

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(120421023).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 61 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 61)

				if (61 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 61)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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

		arg_97_1:InitPlayNodeList()
	end,
	Play120421024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 120421024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play120421025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.325

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(120421024).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 13 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 13)

				if (13 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 13)) > 0 and var_104_0 < var_104_3 then
					arg_101_1.talkMaxDuration = var_104_3

					if var_104_3 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_3 + 0
					end
				end

				arg_101_1.text_.text = var_104_1
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_4 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_4

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play120421025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 120421025
		arg_105_1.duration_ = 2

		local var_105_0 = {
			zh = 1.3,
			ja = 2
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
				arg_105_0:Play120421026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.125

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:GetWordFromCfg(120421025)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 5 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 5)

				if (5 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 5)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421025", "story_v_out_120421.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421025", "story_v_out_120421.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_120421", "120421025", "story_v_out_120421.awb")

						arg_105_1:RecordAudio("120421025", var_108_6)
						arg_105_1:RecordAudio("120421025", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_120421", "120421025", "story_v_out_120421.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_120421", "120421025", "story_v_out_120421.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play120421026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 120421026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play120421027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(120421026).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 40 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 40)

				if (40 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 40)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play120421027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 120421027
		arg_113_1.duration_ = 3.03

		local var_113_0 = {
			zh = 2.866,
			ja = 3.033
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
				arg_113_0:Play120421028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1084ui_story = arg_113_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1084ui_story"].transform.position).z)
				arg_113_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1084ui_story"].transform.localEulerAngles = arg_113_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_113_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1084ui_story"].transform.position).z)
				arg_113_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1084ui_story"].transform.localEulerAngles = arg_113_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_116_1 = "1075ui_story"

			if arg_113_1.actors_["1075ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1075ui_story"))) then
				local var_116_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_113_1.stage_.transform)

				var_116_2.name = var_116_1
				var_116_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_[var_116_1] = var_116_2

				local var_116_3 = var_116_2:GetComponentInChildren(typeof(CharacterEffect))

				var_116_3.enabled = true

				local var_116_4 = GameObjectTools.GetOrAddComponent(var_116_2, typeof(DynamicBoneHelper))

				if var_116_4 then
					var_116_4:EnableDynamicBone(false)
				end

				arg_113_1:ShowWeapon(var_116_3.transform, false)

				arg_113_1.var_[var_116_1 .. "Animator"] = var_116_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_113_1.var_[var_116_1 .. "Animator"].applyRootMotion = true
				arg_113_1.var_[var_116_1 .. "LipSync"] = var_116_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_116_5 = arg_113_1.actors_["1075ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1075ui_story = var_116_5.localPosition
			end

			local var_116_6 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_6 then
				var_116_5.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_113_1.time_ - 0) / var_116_6)
				var_116_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_5.position).x, (manager.ui.mainCamera.transform.position - var_116_5.position).y, (manager.ui.mainCamera.transform.position - var_116_5.position).z)
				var_116_5.localEulerAngles.z = 0
				var_116_5.localEulerAngles.x = 0
				var_116_5.localEulerAngles = var_116_5.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_6 and arg_113_1.time_ < 0 + var_116_6 + arg_116_0 then
				var_116_5.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_116_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_5.position).x, (manager.ui.mainCamera.transform.position - var_116_5.position).y, (manager.ui.mainCamera.transform.position - var_116_5.position).z)
				var_116_5.localEulerAngles.z = 0
				var_116_5.localEulerAngles.x = 0
				var_116_5.localEulerAngles = var_116_5.localEulerAngles
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_116_7 = arg_113_1.actors_["1075ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.characterEffect1075ui_story == nil then
				arg_113_1.var_.characterEffect1075ui_story = var_116_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_8 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_8 and not isNil(var_116_7) then
				if arg_113_1.var_.characterEffect1075ui_story and not isNil(var_116_7) then
					arg_113_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_8 and arg_113_1.time_ < 0 + var_116_8 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.characterEffect1075ui_story then
				arg_113_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_116_10 = arg_113_1.actors_["1084ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_10) and arg_113_1.var_.characterEffect1084ui_story == nil then
				arg_113_1.var_.characterEffect1084ui_story = var_116_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_11 and not isNil(var_116_10) then
				if arg_113_1.var_.characterEffect1084ui_story and not isNil(var_116_10) then
					arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_11)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_11 and arg_113_1.time_ < 0 + var_116_11 + arg_116_0 and not isNil(var_116_10) and arg_113_1.var_.characterEffect1084ui_story then
				arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_116_12 = 0
			local var_116_13 = 0.4

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_14 = arg_113_1:GetWordFromCfg(120421027)
				local var_116_15 = arg_113_1:FormatText(var_116_14.content)

				arg_113_1.text_.text = var_116_15

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_17 = 16 <= 0 and var_116_13 or var_116_13 * (utf8.len(var_116_15) / 16)

				if (16 <= 0 and var_116_13 or var_116_13 * (utf8.len(var_116_15) / 16)) > 0 and var_116_13 < var_116_17 then
					arg_113_1.talkMaxDuration = var_116_17

					if var_116_17 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_17 + var_116_12
					end
				end

				arg_113_1.text_.text = var_116_15
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421027", "story_v_out_120421.awb") ~= 0 then
					local var_116_18 = manager.audio:GetVoiceLength("story_v_out_120421", "120421027", "story_v_out_120421.awb") / 1000

					if var_116_18 + var_116_12 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_18 + var_116_12
					end

					if var_116_14.prefab_name ~= "" and arg_113_1.actors_[var_116_14.prefab_name] ~= nil then
						local var_116_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_14.prefab_name].transform, "story_v_out_120421", "120421027", "story_v_out_120421.awb")

						arg_113_1:RecordAudio("120421027", var_116_19)
						arg_113_1:RecordAudio("120421027", var_116_19)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_120421", "120421027", "story_v_out_120421.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_120421", "120421027", "story_v_out_120421.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_20 = math.max(var_116_13, arg_113_1.talkMaxDuration)

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_20 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_12) / var_116_20

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_12 + var_116_20 and arg_113_1.time_ < var_116_12 + var_116_20 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play120421028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 120421028
		arg_117_1.duration_ = 11.93

		local var_117_0 = {
			zh = 7.4,
			ja = 11.933
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
				arg_117_0:Play120421029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_120_0 = arg_117_1.actors_["1075ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1075ui_story == nil then
				arg_117_1.var_.characterEffect1075ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_1 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 and not isNil(var_120_0) then
				if arg_117_1.var_.characterEffect1075ui_story and not isNil(var_120_0) then
					arg_117_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_1)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1075ui_story then
				arg_117_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_120_2 = arg_117_1.actors_["1084ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1084ui_story == nil then
				arg_117_1.var_.characterEffect1084ui_story = var_120_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_3 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.characterEffect1084ui_story and not isNil(var_120_2) then
					arg_117_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.characterEffect1084ui_story then
				arg_117_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_120_5 = 0
			local var_120_6 = 0.9

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_7 = arg_117_1:GetWordFromCfg(120421028)
				local var_120_8 = arg_117_1:FormatText(var_120_7.content)

				arg_117_1.text_.text = var_120_8

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 36 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 36)

				if (36 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 36)) > 0 and var_120_6 < var_120_10 then
					arg_117_1.talkMaxDuration = var_120_10

					if var_120_10 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_5
					end
				end

				arg_117_1.text_.text = var_120_8
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421028", "story_v_out_120421.awb") ~= 0 then
					local var_120_11 = manager.audio:GetVoiceLength("story_v_out_120421", "120421028", "story_v_out_120421.awb") / 1000

					if var_120_11 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_5
					end

					if var_120_7.prefab_name ~= "" and arg_117_1.actors_[var_120_7.prefab_name] ~= nil then
						local var_120_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_7.prefab_name].transform, "story_v_out_120421", "120421028", "story_v_out_120421.awb")

						arg_117_1:RecordAudio("120421028", var_120_12)
						arg_117_1:RecordAudio("120421028", var_120_12)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_120421", "120421028", "story_v_out_120421.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_120421", "120421028", "story_v_out_120421.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_13 = math.max(var_120_6, arg_117_1.talkMaxDuration)

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_13 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_5) / var_120_13

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_5 + var_120_13 and arg_117_1.time_ < var_120_5 + var_120_13 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play120421029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 120421029
		arg_121_1.duration_ = 9.27

		local var_121_0 = {
			zh = 4.3,
			ja = 9.266
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
				arg_121_0:Play120421030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1075ui_story"]) and arg_121_1.var_.characterEffect1075ui_story == nil then
				arg_121_1.var_.characterEffect1075ui_story = arg_121_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1075ui_story"]) then
				if arg_121_1.var_.characterEffect1075ui_story and not isNil(arg_121_1.actors_["1075ui_story"]) then
					arg_121_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1075ui_story"]) and arg_121_1.var_.characterEffect1075ui_story then
				arg_121_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_124_2 = arg_121_1.actors_["1084ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1084ui_story == nil then
				arg_121_1.var_.characterEffect1084ui_story = var_124_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_3 = 0.2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.characterEffect1084ui_story and not isNil(var_124_2) then
					arg_121_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_3)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect1084ui_story then
				arg_121_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_124_4 = 0
			local var_124_5 = 0.45

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(120421029)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 18 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 18)

				if (18 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 18)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421029", "story_v_out_120421.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421029", "story_v_out_120421.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_120421", "120421029", "story_v_out_120421.awb")

						arg_121_1:RecordAudio("120421029", var_124_11)
						arg_121_1:RecordAudio("120421029", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_120421", "120421029", "story_v_out_120421.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_120421", "120421029", "story_v_out_120421.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play120421030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 120421030
		arg_125_1.duration_ = 7.27

		local var_125_0 = {
			zh = 4.2,
			ja = 7.266
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
				arg_125_0:Play120421031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1075ui_story"]) and arg_125_1.var_.characterEffect1075ui_story == nil then
				arg_125_1.var_.characterEffect1075ui_story = arg_125_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.2

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1075ui_story"]) then
				if arg_125_1.var_.characterEffect1075ui_story and not isNil(arg_125_1.actors_["1075ui_story"]) then
					arg_125_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1075ui_story"]) and arg_125_1.var_.characterEffect1075ui_story then
				arg_125_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1075ui_story.fillRatio = 0.5
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

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
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

				local var_128_6 = arg_125_1:GetWordFromCfg(120421030)
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

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421030", "story_v_out_120421.awb") ~= 0 then
					local var_128_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421030", "story_v_out_120421.awb") / 1000

					if var_128_10 + var_128_4 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_4
					end

					if var_128_6.prefab_name ~= "" and arg_125_1.actors_[var_128_6.prefab_name] ~= nil then
						local var_128_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_6.prefab_name].transform, "story_v_out_120421", "120421030", "story_v_out_120421.awb")

						arg_125_1:RecordAudio("120421030", var_128_11)
						arg_125_1:RecordAudio("120421030", var_128_11)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_120421", "120421030", "story_v_out_120421.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_120421", "120421030", "story_v_out_120421.awb")
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

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play120421031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 120421031
		arg_129_1.duration_ = 6.8

		local var_129_0 = {
			zh = 5.933,
			ja = 6.8
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
				arg_129_0:Play120421032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_132_0 = 0
			local var_132_1 = 0.6

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_2 = arg_129_1:GetWordFromCfg(120421031)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 24 <= 0 and var_132_1 or var_132_1 * (utf8.len(var_132_3) / 24)

				if (24 <= 0 and var_132_1 or var_132_1 * (utf8.len(var_132_3) / 24)) > 0 and var_132_1 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421031", "story_v_out_120421.awb") ~= 0 then
					local var_132_6 = manager.audio:GetVoiceLength("story_v_out_120421", "120421031", "story_v_out_120421.awb") / 1000

					if var_132_6 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_0
					end

					if var_132_2.prefab_name ~= "" and arg_129_1.actors_[var_132_2.prefab_name] ~= nil then
						local var_132_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_2.prefab_name].transform, "story_v_out_120421", "120421031", "story_v_out_120421.awb")

						arg_129_1:RecordAudio("120421031", var_132_7)
						arg_129_1:RecordAudio("120421031", var_132_7)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_120421", "120421031", "story_v_out_120421.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_120421", "120421031", "story_v_out_120421.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_8 and arg_129_1.time_ < var_132_0 + var_132_8 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play120421032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 120421032
		arg_133_1.duration_ = 8.77

		local var_133_0 = {
			zh = 5.333,
			ja = 8.766
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
				arg_133_0:Play120421033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_136_0 = 0
			local var_136_1 = 0.7

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_2 = arg_133_1:GetWordFromCfg(120421032)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 28 <= 0 and var_136_1 or var_136_1 * (utf8.len(var_136_3) / 28)

				if (28 <= 0 and var_136_1 or var_136_1 * (utf8.len(var_136_3) / 28)) > 0 and var_136_1 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421032", "story_v_out_120421.awb") ~= 0 then
					local var_136_6 = manager.audio:GetVoiceLength("story_v_out_120421", "120421032", "story_v_out_120421.awb") / 1000

					if var_136_6 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_0
					end

					if var_136_2.prefab_name ~= "" and arg_133_1.actors_[var_136_2.prefab_name] ~= nil then
						local var_136_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_2.prefab_name].transform, "story_v_out_120421", "120421032", "story_v_out_120421.awb")

						arg_133_1:RecordAudio("120421032", var_136_7)
						arg_133_1:RecordAudio("120421032", var_136_7)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_120421", "120421032", "story_v_out_120421.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_120421", "120421032", "story_v_out_120421.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_8 and arg_133_1.time_ < var_136_0 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play120421033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 120421033
		arg_137_1.duration_ = 9.7

		local var_137_0 = {
			zh = 6.633,
			ja = 9.7
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
				arg_137_0:Play120421034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["1084ui_story"]) and arg_137_1.var_.characterEffect1084ui_story == nil then
				arg_137_1.var_.characterEffect1084ui_story = arg_137_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_0 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["1084ui_story"]) then
				if arg_137_1.var_.characterEffect1084ui_story and not isNil(arg_137_1.actors_["1084ui_story"]) then
					arg_137_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_137_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_0)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["1084ui_story"]) and arg_137_1.var_.characterEffect1084ui_story then
				arg_137_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_137_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_140_1 = arg_137_1.actors_["1075ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1075ui_story == nil then
				arg_137_1.var_.characterEffect1075ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect1075ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1075ui_story then
				arg_137_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_140_4 = 0
			local var_140_5 = 0.7

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(120421033)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 28 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 28)

				if (28 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 28)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421033", "story_v_out_120421.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421033", "story_v_out_120421.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_out_120421", "120421033", "story_v_out_120421.awb")

						arg_137_1:RecordAudio("120421033", var_140_11)
						arg_137_1:RecordAudio("120421033", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_120421", "120421033", "story_v_out_120421.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_120421", "120421033", "story_v_out_120421.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play120421034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 120421034
		arg_141_1.duration_ = 8.13

		local var_141_0 = {
			zh = 8.133,
			ja = 7.5
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
				arg_141_0:Play120421035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_144_0 = arg_141_1.actors_["1075ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1075ui_story == nil then
				arg_141_1.var_.characterEffect1075ui_story = var_144_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_1 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 and not isNil(var_144_0) then
				if arg_141_1.var_.characterEffect1075ui_story and not isNil(var_144_0) then
					arg_141_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_1)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 and not isNil(var_144_0) and arg_141_1.var_.characterEffect1075ui_story then
				arg_141_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_144_2 = arg_141_1.actors_["1084ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1084ui_story == nil then
				arg_141_1.var_.characterEffect1084ui_story = var_144_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_3 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.characterEffect1084ui_story and not isNil(var_144_2) then
					arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.characterEffect1084ui_story then
				arg_141_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_144_5 = 0
			local var_144_6 = 0.8

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

				local var_144_7 = arg_141_1:GetWordFromCfg(120421034)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 32 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 32)

				if (32 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 32)) > 0 and var_144_6 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421034", "story_v_out_120421.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_120421", "120421034", "story_v_out_120421.awb") / 1000

					if var_144_11 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_5
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_120421", "120421034", "story_v_out_120421.awb")

						arg_141_1:RecordAudio("120421034", var_144_12)
						arg_141_1:RecordAudio("120421034", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_120421", "120421034", "story_v_out_120421.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_120421", "120421034", "story_v_out_120421.awb")
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
	Play120421035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 120421035
		arg_145_1.duration_ = 15.8

		local var_145_0 = {
			zh = 9.5,
			ja = 15.8
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
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play120421036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.95

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(120421035)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 38 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 38)

				if (38 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 38)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421035", "story_v_out_120421.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421035", "story_v_out_120421.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_120421", "120421035", "story_v_out_120421.awb")

						arg_145_1:RecordAudio("120421035", var_148_6)
						arg_145_1:RecordAudio("120421035", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_120421", "120421035", "story_v_out_120421.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_120421", "120421035", "story_v_out_120421.awb")
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
	Play120421036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 120421036
		arg_149_1.duration_ = 10.3

		local var_149_0 = {
			zh = 6.133,
			ja = 10.3
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
				arg_149_0:Play120421037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_152_0 = arg_149_1.actors_["1075ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1075ui_story == nil then
				arg_149_1.var_.characterEffect1075ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_1 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 and not isNil(var_152_0) then
				if arg_149_1.var_.characterEffect1075ui_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1075ui_story then
				arg_149_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_152_3 = arg_149_1.actors_["1084ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_3) and arg_149_1.var_.characterEffect1084ui_story == nil then
				arg_149_1.var_.characterEffect1084ui_story = var_152_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_4 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 and not isNil(var_152_3) then
				if arg_149_1.var_.characterEffect1084ui_story and not isNil(var_152_3) then
					arg_149_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_4)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 and not isNil(var_152_3) and arg_149_1.var_.characterEffect1084ui_story then
				arg_149_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_152_5 = 0
			local var_152_6 = 0.825

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_7 = arg_149_1:GetWordFromCfg(120421036)
				local var_152_8 = arg_149_1:FormatText(var_152_7.content)

				arg_149_1.text_.text = var_152_8

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_10 = 33 <= 0 and var_152_6 or var_152_6 * (utf8.len(var_152_8) / 33)

				if (33 <= 0 and var_152_6 or var_152_6 * (utf8.len(var_152_8) / 33)) > 0 and var_152_6 < var_152_10 then
					arg_149_1.talkMaxDuration = var_152_10

					if var_152_10 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_5
					end
				end

				arg_149_1.text_.text = var_152_8
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421036", "story_v_out_120421.awb") ~= 0 then
					local var_152_11 = manager.audio:GetVoiceLength("story_v_out_120421", "120421036", "story_v_out_120421.awb") / 1000

					if var_152_11 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_5
					end

					if var_152_7.prefab_name ~= "" and arg_149_1.actors_[var_152_7.prefab_name] ~= nil then
						local var_152_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_7.prefab_name].transform, "story_v_out_120421", "120421036", "story_v_out_120421.awb")

						arg_149_1:RecordAudio("120421036", var_152_12)
						arg_149_1:RecordAudio("120421036", var_152_12)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_120421", "120421036", "story_v_out_120421.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_120421", "120421036", "story_v_out_120421.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_13 = math.max(var_152_6, arg_149_1.talkMaxDuration)

			if var_152_5 <= arg_149_1.time_ and arg_149_1.time_ < var_152_5 + var_152_13 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_5) / var_152_13

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_5 + var_152_13 and arg_149_1.time_ < var_152_5 + var_152_13 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play120421037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 120421037
		arg_153_1.duration_ = 4.77

		local var_153_0 = {
			zh = 3.233,
			ja = 4.766
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play120421038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.325

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(120421037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 13 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 13)

				if (13 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 13)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421037", "story_v_out_120421.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421037", "story_v_out_120421.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_120421", "120421037", "story_v_out_120421.awb")

						arg_153_1:RecordAudio("120421037", var_156_6)
						arg_153_1:RecordAudio("120421037", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_120421", "120421037", "story_v_out_120421.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_120421", "120421037", "story_v_out_120421.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play120421038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 120421038
		arg_157_1.duration_ = 12.7

		local var_157_0 = {
			zh = 7.066,
			ja = 12.7
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
				arg_157_0:Play120421039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1075ui_story"]) and arg_157_1.var_.characterEffect1075ui_story == nil then
				arg_157_1.var_.characterEffect1075ui_story = arg_157_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1075ui_story"]) then
				if arg_157_1.var_.characterEffect1075ui_story and not isNil(arg_157_1.actors_["1075ui_story"]) then
					arg_157_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1075ui_story"]) and arg_157_1.var_.characterEffect1075ui_story then
				arg_157_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_160_1 = arg_157_1.actors_["1084ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1084ui_story == nil then
				arg_157_1.var_.characterEffect1084ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1084ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1084ui_story then
				arg_157_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_160_4 = 0
			local var_160_5 = 0.875

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:GetWordFromCfg(120421038)
				local var_160_7 = arg_157_1:FormatText(var_160_6.content)

				arg_157_1.text_.text = var_160_7

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_9 = 35 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 35)

				if (35 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_7) / 35)) > 0 and var_160_5 < var_160_9 then
					arg_157_1.talkMaxDuration = var_160_9

					if var_160_9 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_9 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_7
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421038", "story_v_out_120421.awb") ~= 0 then
					local var_160_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421038", "story_v_out_120421.awb") / 1000

					if var_160_10 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_4
					end

					if var_160_6.prefab_name ~= "" and arg_157_1.actors_[var_160_6.prefab_name] ~= nil then
						local var_160_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_6.prefab_name].transform, "story_v_out_120421", "120421038", "story_v_out_120421.awb")

						arg_157_1:RecordAudio("120421038", var_160_11)
						arg_157_1:RecordAudio("120421038", var_160_11)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_120421", "120421038", "story_v_out_120421.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_120421", "120421038", "story_v_out_120421.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_12 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_12 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_12

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_12 and arg_157_1.time_ < var_160_4 + var_160_12 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play120421039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 120421039
		arg_161_1.duration_ = 5.47

		local var_161_0 = {
			zh = 5.466,
			ja = 3.433
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
				arg_161_0:Play120421040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_1")
			end

			local var_164_0 = arg_161_1.actors_["1075ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1075ui_story == nil then
				arg_161_1.var_.characterEffect1075ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_1 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 and not isNil(var_164_0) then
				if arg_161_1.var_.characterEffect1075ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1075ui_story then
				arg_161_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_164_3 = arg_161_1.actors_["1084ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_3) and arg_161_1.var_.characterEffect1084ui_story == nil then
				arg_161_1.var_.characterEffect1084ui_story = var_164_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_4 = 0.2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 and not isNil(var_164_3) then
				if arg_161_1.var_.characterEffect1084ui_story and not isNil(var_164_3) then
					arg_161_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_4)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 and not isNil(var_164_3) and arg_161_1.var_.characterEffect1084ui_story then
				arg_161_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_164_5 = 0
			local var_164_6 = 0.75

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_7 = arg_161_1:GetWordFromCfg(120421039)
				local var_164_8 = arg_161_1:FormatText(var_164_7.content)

				arg_161_1.text_.text = var_164_8

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_10 = 30 <= 0 and var_164_6 or var_164_6 * (utf8.len(var_164_8) / 30)

				if (30 <= 0 and var_164_6 or var_164_6 * (utf8.len(var_164_8) / 30)) > 0 and var_164_6 < var_164_10 then
					arg_161_1.talkMaxDuration = var_164_10

					if var_164_10 + var_164_5 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_5
					end
				end

				arg_161_1.text_.text = var_164_8
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421039", "story_v_out_120421.awb") ~= 0 then
					local var_164_11 = manager.audio:GetVoiceLength("story_v_out_120421", "120421039", "story_v_out_120421.awb") / 1000

					if var_164_11 + var_164_5 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_11 + var_164_5
					end

					if var_164_7.prefab_name ~= "" and arg_161_1.actors_[var_164_7.prefab_name] ~= nil then
						local var_164_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_7.prefab_name].transform, "story_v_out_120421", "120421039", "story_v_out_120421.awb")

						arg_161_1:RecordAudio("120421039", var_164_12)
						arg_161_1:RecordAudio("120421039", var_164_12)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_120421", "120421039", "story_v_out_120421.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_120421", "120421039", "story_v_out_120421.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_13 = math.max(var_164_6, arg_161_1.talkMaxDuration)

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_13 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_5) / var_164_13

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_5 + var_164_13 and arg_161_1.time_ < var_164_5 + var_164_13 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play120421040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 120421040
		arg_165_1.duration_ = 7

		local var_165_0 = {
			zh = 4.2,
			ja = 7
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
				arg_165_0:Play120421041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1075ui_story"]) and arg_165_1.var_.characterEffect1075ui_story == nil then
				arg_165_1.var_.characterEffect1075ui_story = arg_165_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1075ui_story"]) then
				if arg_165_1.var_.characterEffect1075ui_story and not isNil(arg_165_1.actors_["1075ui_story"]) then
					arg_165_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_0)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1075ui_story"]) and arg_165_1.var_.characterEffect1075ui_story then
				arg_165_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_168_1 = arg_165_1.actors_["1084ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1084ui_story == nil then
				arg_165_1.var_.characterEffect1084ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.2

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1084ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1084ui_story then
				arg_165_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_168_4 = 0
			local var_168_5 = 0.55

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(120421040)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 22 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 22)

				if (22 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 22)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421040", "story_v_out_120421.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421040", "story_v_out_120421.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_120421", "120421040", "story_v_out_120421.awb")

						arg_165_1:RecordAudio("120421040", var_168_11)
						arg_165_1:RecordAudio("120421040", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_120421", "120421040", "story_v_out_120421.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_120421", "120421040", "story_v_out_120421.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play120421041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 120421041
		arg_169_1.duration_ = 7.4

		local var_169_0 = {
			zh = 7,
			ja = 7.4
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
				arg_169_0:Play120421042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action478")
			end

			local var_172_0 = 0
			local var_172_1 = 0.95

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_2 = arg_169_1:GetWordFromCfg(120421041)
				local var_172_3 = arg_169_1:FormatText(var_172_2.content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 38 <= 0 and var_172_1 or var_172_1 * (utf8.len(var_172_3) / 38)

				if (38 <= 0 and var_172_1 or var_172_1 * (utf8.len(var_172_3) / 38)) > 0 and var_172_1 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421041", "story_v_out_120421.awb") ~= 0 then
					local var_172_6 = manager.audio:GetVoiceLength("story_v_out_120421", "120421041", "story_v_out_120421.awb") / 1000

					if var_172_6 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_0
					end

					if var_172_2.prefab_name ~= "" and arg_169_1.actors_[var_172_2.prefab_name] ~= nil then
						local var_172_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_2.prefab_name].transform, "story_v_out_120421", "120421041", "story_v_out_120421.awb")

						arg_169_1:RecordAudio("120421041", var_172_7)
						arg_169_1:RecordAudio("120421041", var_172_7)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_120421", "120421041", "story_v_out_120421.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_120421", "120421041", "story_v_out_120421.awb")
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
	Play120421042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 120421042
		arg_173_1.duration_ = 15.2

		local var_173_0 = {
			zh = 6.5,
			ja = 15.2
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
				arg_173_0:Play120421043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["1075ui_story"]) and arg_173_1.var_.characterEffect1075ui_story == nil then
				arg_173_1.var_.characterEffect1075ui_story = arg_173_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_0 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["1075ui_story"]) then
				if arg_173_1.var_.characterEffect1075ui_story and not isNil(arg_173_1.actors_["1075ui_story"]) then
					arg_173_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["1075ui_story"]) and arg_173_1.var_.characterEffect1075ui_story then
				arg_173_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_176_2 = arg_173_1.actors_["1084ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect1084ui_story == nil then
				arg_173_1.var_.characterEffect1084ui_story = var_176_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_3 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.characterEffect1084ui_story and not isNil(var_176_2) then
					arg_173_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_3)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.characterEffect1084ui_story then
				arg_173_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action5_2")
			end

			local var_176_4 = 0
			local var_176_5 = 0.75

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(120421042)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 30 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 30)

				if (30 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 30)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421042", "story_v_out_120421.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421042", "story_v_out_120421.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_120421", "120421042", "story_v_out_120421.awb")

						arg_173_1:RecordAudio("120421042", var_176_11)
						arg_173_1:RecordAudio("120421042", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_120421", "120421042", "story_v_out_120421.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_120421", "120421042", "story_v_out_120421.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play120421043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 120421043
		arg_177_1.duration_ = 8.87

		local var_177_0 = {
			zh = 8.766,
			ja = 8.866
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
				arg_177_0:Play120421044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.8

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(120421043)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 32 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 32)

				if (32 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 32)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421043", "story_v_out_120421.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421043", "story_v_out_120421.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_120421", "120421043", "story_v_out_120421.awb")

						arg_177_1:RecordAudio("120421043", var_180_6)
						arg_177_1:RecordAudio("120421043", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_120421", "120421043", "story_v_out_120421.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_120421", "120421043", "story_v_out_120421.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play120421044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 120421044
		arg_181_1.duration_ = 12.6

		local var_181_0 = {
			zh = 11.466,
			ja = 12.6
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
				arg_181_0:Play120421045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1075ui_story"]) and arg_181_1.var_.characterEffect1075ui_story == nil then
				arg_181_1.var_.characterEffect1075ui_story = arg_181_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1075ui_story"]) then
				if arg_181_1.var_.characterEffect1075ui_story and not isNil(arg_181_1.actors_["1075ui_story"]) then
					arg_181_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1075ui_story"]) and arg_181_1.var_.characterEffect1075ui_story then
				arg_181_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_184_1 = arg_181_1.actors_["1084ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1084ui_story == nil then
				arg_181_1.var_.characterEffect1084ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.2

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1084ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1084ui_story then
				arg_181_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action486")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_184_4 = 0
			local var_184_5 = 0.75

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(120421044)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 30 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 30)

				if (30 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 30)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421044", "story_v_out_120421.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421044", "story_v_out_120421.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_out_120421", "120421044", "story_v_out_120421.awb")

						arg_181_1:RecordAudio("120421044", var_184_11)
						arg_181_1:RecordAudio("120421044", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_120421", "120421044", "story_v_out_120421.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_120421", "120421044", "story_v_out_120421.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_5, arg_181_1.talkMaxDuration)

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_4) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_4 + var_184_12 and arg_181_1.time_ < var_184_4 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play120421045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 120421045
		arg_185_1.duration_ = 6.93

		local var_185_0 = {
			zh = 6.633,
			ja = 6.933
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
				arg_185_0:Play120421046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(arg_185_1.actors_["1075ui_story"]) and arg_185_1.var_.characterEffect1075ui_story == nil then
				arg_185_1.var_.characterEffect1075ui_story = arg_185_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_0 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 and not isNil(arg_185_1.actors_["1075ui_story"]) then
				if arg_185_1.var_.characterEffect1075ui_story and not isNil(arg_185_1.actors_["1075ui_story"]) then
					arg_185_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_0)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 and not isNil(arg_185_1.actors_["1075ui_story"]) and arg_185_1.var_.characterEffect1075ui_story then
				arg_185_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_188_1 = arg_185_1.actors_["1084ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1084ui_story == nil then
				arg_185_1.var_.characterEffect1084ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1084ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1084ui_story then
				arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_188_4 = 0
			local var_188_5 = 0.725

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:GetWordFromCfg(120421045)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 29 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 29)

				if (29 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 29)) > 0 and var_188_5 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421045", "story_v_out_120421.awb") ~= 0 then
					local var_188_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421045", "story_v_out_120421.awb") / 1000

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end

					if var_188_6.prefab_name ~= "" and arg_185_1.actors_[var_188_6.prefab_name] ~= nil then
						local var_188_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_6.prefab_name].transform, "story_v_out_120421", "120421045", "story_v_out_120421.awb")

						arg_185_1:RecordAudio("120421045", var_188_11)
						arg_185_1:RecordAudio("120421045", var_188_11)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_120421", "120421045", "story_v_out_120421.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_120421", "120421045", "story_v_out_120421.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_12 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_12 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_12

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_12 and arg_185_1.time_ < var_188_4 + var_188_12 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play120421046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 120421046
		arg_189_1.duration_ = 3.13

		local var_189_0 = {
			zh = 2,
			ja = 3.133
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
				arg_189_0:Play120421047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1075ui_story"]) and arg_189_1.var_.characterEffect1075ui_story == nil then
				arg_189_1.var_.characterEffect1075ui_story = arg_189_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1075ui_story"]) then
				if arg_189_1.var_.characterEffect1075ui_story and not isNil(arg_189_1.actors_["1075ui_story"]) then
					arg_189_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1075ui_story"]) and arg_189_1.var_.characterEffect1075ui_story then
				arg_189_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_192_2 = arg_189_1.actors_["1084ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1084ui_story == nil then
				arg_189_1.var_.characterEffect1084ui_story = var_192_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_3 = 0.2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.characterEffect1084ui_story and not isNil(var_192_2) then
					arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_3)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.characterEffect1084ui_story then
				arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_192_4 = 0
			local var_192_5 = 0.25

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_6 = arg_189_1:GetWordFromCfg(120421046)
				local var_192_7 = arg_189_1:FormatText(var_192_6.content)

				arg_189_1.text_.text = var_192_7

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 10 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 10)

				if (10 <= 0 and var_192_5 or var_192_5 * (utf8.len(var_192_7) / 10)) > 0 and var_192_5 < var_192_9 then
					arg_189_1.talkMaxDuration = var_192_9

					if var_192_9 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_9 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_7
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421046", "story_v_out_120421.awb") ~= 0 then
					local var_192_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421046", "story_v_out_120421.awb") / 1000

					if var_192_10 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_4
					end

					if var_192_6.prefab_name ~= "" and arg_189_1.actors_[var_192_6.prefab_name] ~= nil then
						local var_192_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_6.prefab_name].transform, "story_v_out_120421", "120421046", "story_v_out_120421.awb")

						arg_189_1:RecordAudio("120421046", var_192_11)
						arg_189_1:RecordAudio("120421046", var_192_11)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_120421", "120421046", "story_v_out_120421.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_120421", "120421046", "story_v_out_120421.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_12 and arg_189_1.time_ < var_192_4 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play120421047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 120421047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play120421048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["1075ui_story"]) and arg_193_1.var_.characterEffect1075ui_story == nil then
				arg_193_1.var_.characterEffect1075ui_story = arg_193_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_0 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["1075ui_story"]) then
				if arg_193_1.var_.characterEffect1075ui_story and not isNil(arg_193_1.actors_["1075ui_story"]) then
					arg_193_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_0)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["1075ui_story"]) and arg_193_1.var_.characterEffect1075ui_story then
				arg_193_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_196_1 = arg_193_1.actors_["1084ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1084ui_story == nil then
				arg_193_1.var_.characterEffect1084ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1084ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1084ui_story then
				arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_196_4 = 0
			local var_196_5 = 0.825

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(120421047).content)

				arg_193_1.text_.text = var_196_6

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_8 = 33 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_6) / 33)

				if (33 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_6) / 33)) > 0 and var_196_5 < var_196_8 then
					arg_193_1.talkMaxDuration = var_196_8

					if var_196_8 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_6
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_9 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_9 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_9

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_9 and arg_193_1.time_ < var_196_4 + var_196_9 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play120421048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 120421048
		arg_197_1.duration_ = 6.93

		local var_197_0 = {
			zh = 5.966,
			ja = 6.933
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
				arg_197_0:Play120421049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_200_0 = 0
			local var_200_1 = 0.45

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_2 = arg_197_1:GetWordFromCfg(120421048)
				local var_200_3 = arg_197_1:FormatText(var_200_2.content)

				arg_197_1.text_.text = var_200_3

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 18 <= 0 and var_200_1 or var_200_1 * (utf8.len(var_200_3) / 18)

				if (18 <= 0 and var_200_1 or var_200_1 * (utf8.len(var_200_3) / 18)) > 0 and var_200_1 < var_200_5 then
					arg_197_1.talkMaxDuration = var_200_5

					if var_200_5 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_3
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421048", "story_v_out_120421.awb") ~= 0 then
					local var_200_6 = manager.audio:GetVoiceLength("story_v_out_120421", "120421048", "story_v_out_120421.awb") / 1000

					if var_200_6 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_6 + var_200_0
					end

					if var_200_2.prefab_name ~= "" and arg_197_1.actors_[var_200_2.prefab_name] ~= nil then
						local var_200_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_2.prefab_name].transform, "story_v_out_120421", "120421048", "story_v_out_120421.awb")

						arg_197_1:RecordAudio("120421048", var_200_7)
						arg_197_1:RecordAudio("120421048", var_200_7)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_120421", "120421048", "story_v_out_120421.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_120421", "120421048", "story_v_out_120421.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_8 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_8 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_8

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_8 and arg_197_1.time_ < var_200_0 + var_200_8 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play120421049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 120421049
		arg_201_1.duration_ = 14.57

		local var_201_0 = {
			zh = 12.3,
			ja = 14.566
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
				arg_201_0:Play120421050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 1.35

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
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

				local var_204_1 = arg_201_1:GetWordFromCfg(120421049)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 54 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 54)

				if (54 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 54)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421049", "story_v_out_120421.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421049", "story_v_out_120421.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_120421", "120421049", "story_v_out_120421.awb")

						arg_201_1:RecordAudio("120421049", var_204_6)
						arg_201_1:RecordAudio("120421049", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_120421", "120421049", "story_v_out_120421.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_120421", "120421049", "story_v_out_120421.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_7 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_7

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play120421050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 120421050
		arg_205_1.duration_ = 7.8

		local var_205_0 = {
			zh = 6.566,
			ja = 7.8
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
				arg_205_0:Play120421051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.6

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(120421050)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 24 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 24)

				if (24 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 24)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421050", "story_v_out_120421.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421050", "story_v_out_120421.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_120421", "120421050", "story_v_out_120421.awb")

						arg_205_1:RecordAudio("120421050", var_208_6)
						arg_205_1:RecordAudio("120421050", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_120421", "120421050", "story_v_out_120421.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_120421", "120421050", "story_v_out_120421.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play120421051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 120421051
		arg_209_1.duration_ = 4.8

		local var_209_0 = {
			zh = 3.7,
			ja = 4.8
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
				arg_209_0:Play120421052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1075ui_story"]) and arg_209_1.var_.characterEffect1075ui_story == nil then
				arg_209_1.var_.characterEffect1075ui_story = arg_209_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1075ui_story"]) then
				if arg_209_1.var_.characterEffect1075ui_story and not isNil(arg_209_1.actors_["1075ui_story"]) then
					arg_209_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1075ui_story"]) and arg_209_1.var_.characterEffect1075ui_story then
				arg_209_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_212_2 = arg_209_1.actors_["1084ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.characterEffect1084ui_story == nil then
				arg_209_1.var_.characterEffect1084ui_story = var_212_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_3 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 and not isNil(var_212_2) then
				if arg_209_1.var_.characterEffect1084ui_story and not isNil(var_212_2) then
					arg_209_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_3)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.characterEffect1084ui_story then
				arg_209_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_212_4 = 0
			local var_212_5 = 0.45

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:GetWordFromCfg(120421051)
				local var_212_7 = arg_209_1:FormatText(var_212_6.content)

				arg_209_1.text_.text = var_212_7

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_9 = 18 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 18)

				if (18 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_7) / 18)) > 0 and var_212_5 < var_212_9 then
					arg_209_1.talkMaxDuration = var_212_9

					if var_212_9 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_9 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_7
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421051", "story_v_out_120421.awb") ~= 0 then
					local var_212_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421051", "story_v_out_120421.awb") / 1000

					if var_212_10 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_4
					end

					if var_212_6.prefab_name ~= "" and arg_209_1.actors_[var_212_6.prefab_name] ~= nil then
						local var_212_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_6.prefab_name].transform, "story_v_out_120421", "120421051", "story_v_out_120421.awb")

						arg_209_1:RecordAudio("120421051", var_212_11)
						arg_209_1:RecordAudio("120421051", var_212_11)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_120421", "120421051", "story_v_out_120421.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_120421", "120421051", "story_v_out_120421.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_12 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_12 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_12

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_12 and arg_209_1.time_ < var_212_4 + var_212_12 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play120421052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 120421052
		arg_213_1.duration_ = 5.37

		local var_213_0 = {
			zh = 5.366,
			ja = 4.866
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
				arg_213_0:Play120421053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1075ui_story"]) and arg_213_1.var_.characterEffect1075ui_story == nil then
				arg_213_1.var_.characterEffect1075ui_story = arg_213_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1075ui_story"]) then
				if arg_213_1.var_.characterEffect1075ui_story and not isNil(arg_213_1.actors_["1075ui_story"]) then
					arg_213_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_0)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1075ui_story"]) and arg_213_1.var_.characterEffect1075ui_story then
				arg_213_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_216_1 = arg_213_1.actors_["1084ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1084ui_story == nil then
				arg_213_1.var_.characterEffect1084ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1084ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1084ui_story then
				arg_213_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_216_4 = 0
			local var_216_5 = 0.7

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(120421052)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 28 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 28)

				if (28 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 28)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421052", "story_v_out_120421.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421052", "story_v_out_120421.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_out_120421", "120421052", "story_v_out_120421.awb")

						arg_213_1:RecordAudio("120421052", var_216_11)
						arg_213_1:RecordAudio("120421052", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_120421", "120421052", "story_v_out_120421.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_120421", "120421052", "story_v_out_120421.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play120421053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 120421053
		arg_217_1.duration_ = 13.03

		local var_217_0 = {
			zh = 10.1,
			ja = 13.033
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
				arg_217_0:Play120421054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_220_0 = 0
			local var_220_1 = 1.175

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_2 = arg_217_1:GetWordFromCfg(120421053)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 47 <= 0 and var_220_1 or var_220_1 * (utf8.len(var_220_3) / 47)

				if (47 <= 0 and var_220_1 or var_220_1 * (utf8.len(var_220_3) / 47)) > 0 and var_220_1 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421053", "story_v_out_120421.awb") ~= 0 then
					local var_220_6 = manager.audio:GetVoiceLength("story_v_out_120421", "120421053", "story_v_out_120421.awb") / 1000

					if var_220_6 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_0
					end

					if var_220_2.prefab_name ~= "" and arg_217_1.actors_[var_220_2.prefab_name] ~= nil then
						local var_220_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_2.prefab_name].transform, "story_v_out_120421", "120421053", "story_v_out_120421.awb")

						arg_217_1:RecordAudio("120421053", var_220_7)
						arg_217_1:RecordAudio("120421053", var_220_7)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_120421", "120421053", "story_v_out_120421.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_120421", "120421053", "story_v_out_120421.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_8 and arg_217_1.time_ < var_220_0 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play120421054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 120421054
		arg_221_1.duration_ = 12.83

		local var_221_0 = {
			zh = 7.8,
			ja = 12.833
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
				arg_221_0:Play120421055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 1.025

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:GetWordFromCfg(120421054)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 41 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 41)

				if (41 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 41)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421054", "story_v_out_120421.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421054", "story_v_out_120421.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_120421", "120421054", "story_v_out_120421.awb")

						arg_221_1:RecordAudio("120421054", var_224_6)
						arg_221_1:RecordAudio("120421054", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_120421", "120421054", "story_v_out_120421.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_120421", "120421054", "story_v_out_120421.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play120421055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 120421055
		arg_225_1.duration_ = 4.9

		local var_225_0 = {
			zh = 2.6,
			ja = 4.9
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
				arg_225_0:Play120421056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1075ui_story"]) and arg_225_1.var_.characterEffect1075ui_story == nil then
				arg_225_1.var_.characterEffect1075ui_story = arg_225_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1075ui_story"]) then
				if arg_225_1.var_.characterEffect1075ui_story and not isNil(arg_225_1.actors_["1075ui_story"]) then
					arg_225_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1075ui_story"]) and arg_225_1.var_.characterEffect1075ui_story then
				arg_225_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_228_2 = arg_225_1.actors_["1084ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.characterEffect1084ui_story == nil then
				arg_225_1.var_.characterEffect1084ui_story = var_228_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_3 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_3 and not isNil(var_228_2) then
				if arg_225_1.var_.characterEffect1084ui_story and not isNil(var_228_2) then
					arg_225_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_3)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_3 and arg_225_1.time_ < 0 + var_228_3 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.characterEffect1084ui_story then
				arg_225_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_228_4 = 0
			local var_228_5 = 0.325

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_6 = arg_225_1:GetWordFromCfg(120421055)
				local var_228_7 = arg_225_1:FormatText(var_228_6.content)

				arg_225_1.text_.text = var_228_7

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_9 = 13 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 13)

				if (13 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_7) / 13)) > 0 and var_228_5 < var_228_9 then
					arg_225_1.talkMaxDuration = var_228_9

					if var_228_9 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_9 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_7
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421055", "story_v_out_120421.awb") ~= 0 then
					local var_228_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421055", "story_v_out_120421.awb") / 1000

					if var_228_10 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_4
					end

					if var_228_6.prefab_name ~= "" and arg_225_1.actors_[var_228_6.prefab_name] ~= nil then
						local var_228_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_6.prefab_name].transform, "story_v_out_120421", "120421055", "story_v_out_120421.awb")

						arg_225_1:RecordAudio("120421055", var_228_11)
						arg_225_1:RecordAudio("120421055", var_228_11)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_120421", "120421055", "story_v_out_120421.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_120421", "120421055", "story_v_out_120421.awb")
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
	Play120421056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 120421056
		arg_229_1.duration_ = 8.7

		local var_229_0 = {
			zh = 5.7,
			ja = 8.7
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
				arg_229_0:Play120421057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1075ui_story"]) and arg_229_1.var_.characterEffect1075ui_story == nil then
				arg_229_1.var_.characterEffect1075ui_story = arg_229_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1075ui_story"]) then
				if arg_229_1.var_.characterEffect1075ui_story and not isNil(arg_229_1.actors_["1075ui_story"]) then
					arg_229_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1075ui_story"]) and arg_229_1.var_.characterEffect1075ui_story then
				arg_229_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_232_1 = arg_229_1.actors_["1084ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1084ui_story == nil then
				arg_229_1.var_.characterEffect1084ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect1084ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1084ui_story then
				arg_229_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action41312")
			end

			local var_232_4 = 0
			local var_232_5 = 0.75

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(120421056)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 30 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 30)

				if (30 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 30)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421056", "story_v_out_120421.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421056", "story_v_out_120421.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_out_120421", "120421056", "story_v_out_120421.awb")

						arg_229_1:RecordAudio("120421056", var_232_11)
						arg_229_1:RecordAudio("120421056", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_120421", "120421056", "story_v_out_120421.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_120421", "120421056", "story_v_out_120421.awb")
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
	Play120421057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 120421057
		arg_233_1.duration_ = 9

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play120421058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if arg_233_1.bgs_.ST29 == nil then
				local var_236_0 = Object.Instantiate(arg_233_1.paintGo_)

				var_236_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST29")
				var_236_0.name = "ST29"
				var_236_0.transform.parent = arg_233_1.stage_.transform
				var_236_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.bgs_.ST29 = var_236_0
			end

			if 2 < arg_233_1.time_ and arg_233_1.time_ <= 2 + arg_236_0 then
				local var_236_1 = arg_233_1.bgs_.ST29

				arg_233_1.bgs_.ST29.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_236_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_2 = var_236_1:GetComponent("SpriteRenderer")

				if var_236_2 and var_236_2.sprite then
					local var_236_3 = 2 * (var_236_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_236_1.transform.localScale = Vector3.New(var_236_3 / var_236_2.sprite.bounds.size.y < var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x and var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x or var_236_3 / var_236_2.sprite.bounds.size.y, var_236_3 / var_236_2.sprite.bounds.size.y < var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x and var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x or var_236_3 / var_236_2.sprite.bounds.size.y, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "ST29" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_4 = 0

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_5 = 2

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_5 then
				local var_236_6 = Color.New(0, 0, 0)

				var_236_6.a = Mathf.Lerp(0, 1, (arg_233_1.time_ - var_236_4) / var_236_5)
				arg_233_1.mask_.color = var_236_6
			end

			if arg_233_1.time_ >= var_236_4 + var_236_5 and arg_233_1.time_ < var_236_4 + var_236_5 + arg_236_0 then
				local var_236_7 = Color.New(0, 0, 0)

				var_236_7.a = 1
				arg_233_1.mask_.color = var_236_7
			end

			local var_236_8 = 2

			if 2 < arg_233_1.time_ and arg_233_1.time_ <= var_236_8 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_9 = 2

			if var_236_8 <= arg_233_1.time_ and arg_233_1.time_ < var_236_8 + var_236_9 then
				local var_236_10 = Color.New(0, 0, 0)

				var_236_10.a = Mathf.Lerp(1, 0, (arg_233_1.time_ - var_236_8) / var_236_9)
				arg_233_1.mask_.color = var_236_10
			end

			if arg_233_1.time_ >= var_236_8 + var_236_9 and arg_233_1.time_ < var_236_8 + var_236_9 + arg_236_0 then
				local var_236_11 = Color.New(0, 0, 0)

				arg_233_1.mask_.enabled = false
				var_236_11.a = 0
				arg_233_1.mask_.color = var_236_11
			end

			local var_236_12 = arg_233_1.actors_["1084ui_story"].transform

			if 1.966 < arg_233_1.time_ and arg_233_1.time_ <= 1.966 + arg_236_0 then
				arg_233_1.var_.moveOldPos1084ui_story = var_236_12.localPosition
			end

			local var_236_13 = 0.001

			if 1.966 <= arg_233_1.time_ and arg_233_1.time_ < 1.966 + var_236_13 then
				var_236_12.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 1.966) / var_236_13)
				var_236_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_12.position).x, (manager.ui.mainCamera.transform.position - var_236_12.position).y, (manager.ui.mainCamera.transform.position - var_236_12.position).z)
				var_236_12.localEulerAngles.z = 0
				var_236_12.localEulerAngles.x = 0
				var_236_12.localEulerAngles = var_236_12.localEulerAngles
			end

			if arg_233_1.time_ >= 1.966 + var_236_13 and arg_233_1.time_ < 1.966 + var_236_13 + arg_236_0 then
				var_236_12.localPosition = Vector3.New(0, 100, 0)
				var_236_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_12.position).x, (manager.ui.mainCamera.transform.position - var_236_12.position).y, (manager.ui.mainCamera.transform.position - var_236_12.position).z)
				var_236_12.localEulerAngles.z = 0
				var_236_12.localEulerAngles.x = 0
				var_236_12.localEulerAngles = var_236_12.localEulerAngles
			end

			local var_236_14 = arg_233_1.actors_["1075ui_story"].transform

			if 1.966 < arg_233_1.time_ and arg_233_1.time_ <= 1.966 + arg_236_0 then
				arg_233_1.var_.moveOldPos1075ui_story = var_236_14.localPosition
			end

			local var_236_15 = 0.001

			if 1.966 <= arg_233_1.time_ and arg_233_1.time_ < 1.966 + var_236_15 then
				var_236_14.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 1.966) / var_236_15)
				var_236_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_14.position).x, (manager.ui.mainCamera.transform.position - var_236_14.position).y, (manager.ui.mainCamera.transform.position - var_236_14.position).z)
				var_236_14.localEulerAngles.z = 0
				var_236_14.localEulerAngles.x = 0
				var_236_14.localEulerAngles = var_236_14.localEulerAngles
			end

			if arg_233_1.time_ >= 1.966 + var_236_15 and arg_233_1.time_ < 1.966 + var_236_15 + arg_236_0 then
				var_236_14.localPosition = Vector3.New(0, 100, 0)
				var_236_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_14.position).x, (manager.ui.mainCamera.transform.position - var_236_14.position).y, (manager.ui.mainCamera.transform.position - var_236_14.position).z)
				var_236_14.localEulerAngles.z = 0
				var_236_14.localEulerAngles.x = 0
				var_236_14.localEulerAngles = var_236_14.localEulerAngles
			end

			if 0.8 < arg_233_1.time_ and arg_233_1.time_ <= 0.8 + arg_236_0 then
				arg_233_1:AudioAction("play", "music", "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu.awb")

				local var_236_18 = manager.audio:GetAudioName("bgm_activity_2_0_story_tianlu", "bgm_activity_2_0_story_tianlu")

				if "" ~= "" then
					if arg_233_1.bgmTxt_.text ~= var_236_18 and arg_233_1.bgmTxt_.text ~= "" then
						if arg_233_1.bgmTxt2_.text ~= "" then
							arg_233_1.bgmTxt_.text = arg_233_1.bgmTxt2_.text
						end

						arg_233_1.bgmTxt2_.text = var_236_18

						arg_233_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_233_1.bgmTxt_.text = var_236_18
						arg_233_1.bgmTxt2_.text = var_236_18
					end

					if arg_233_1.bgmTimer then
						arg_233_1.bgmTimer:Stop()

						arg_233_1.bgmTimer = nil
					end

					if arg_233_1.settingData.show_music_name == 1 then
						arg_233_1.musicController:SetSelectedState("show")
						arg_233_1.musicAnimator_:Play("open", 0, 0)

						if arg_233_1.settingData.music_time ~= 0 then
							arg_233_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_233_1.settingData.music_time), function()
								if arg_233_1 == nil or isNil(arg_233_1.bgmTxt_) then
									return
								end

								arg_233_1.musicController:SetSelectedState("hide")
								arg_233_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_236_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_233_1.bgmTxt_.text ~= var_236_21 and arg_233_1.bgmTxt_.text ~= "" then
						if arg_233_1.bgmTxt2_.text ~= "" then
							arg_233_1.bgmTxt_.text = arg_233_1.bgmTxt2_.text
						end

						arg_233_1.bgmTxt2_.text = var_236_21

						arg_233_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_233_1.bgmTxt_.text = var_236_21
						arg_233_1.bgmTxt2_.text = var_236_21
					end

					if arg_233_1.bgmTimer then
						arg_233_1.bgmTimer:Stop()

						arg_233_1.bgmTimer = nil
					end

					if arg_233_1.settingData.show_music_name == 1 then
						arg_233_1.musicController:SetSelectedState("show")
						arg_233_1.musicAnimator_:Play("open", 0, 0)

						if arg_233_1.settingData.music_time ~= 0 then
							arg_233_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_233_1.settingData.music_time), function()
								if arg_233_1 == nil or isNil(arg_233_1.bgmTxt_) then
									return
								end

								arg_233_1.musicController:SetSelectedState("hide")
								arg_233_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_22 = 4
			local var_236_23 = 0.675

			if 4 < arg_233_1.time_ and arg_233_1.time_ <= var_236_22 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_24 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_24:setOnUpdate(LuaHelper.FloatAction(function(arg_239_0)
					arg_233_1.dialogCg_.alpha = arg_239_0
				end))
				var_236_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_25 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(120421057).content)

				arg_233_1.text_.text = var_236_25

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_27 = 27 <= 0 and var_236_23 or var_236_23 * (utf8.len(var_236_25) / 27)

				if (27 <= 0 and var_236_23 or var_236_23 * (utf8.len(var_236_25) / 27)) > 0 and var_236_23 < var_236_27 then
					arg_233_1.talkMaxDuration = var_236_27
					var_236_22 = var_236_22 + 0.3

					if var_236_27 + var_236_22 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_27 + var_236_22
					end
				end

				arg_233_1.text_.text = var_236_25
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_28 = var_236_22 + 0.3
			local var_236_29 = math.max(var_236_23, arg_233_1.talkMaxDuration)

			if var_236_22 + 0.3 <= arg_233_1.time_ and arg_233_1.time_ < var_236_28 + var_236_29 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_28) / var_236_29

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_28 + var_236_29 and arg_233_1.time_ < var_236_28 + var_236_29 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play120421058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 120421058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play120421059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.575

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_1 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(120421058).content)

				arg_241_1.text_.text = var_244_1

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_3 = 23 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 23)

				if (23 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_1) / 23)) > 0 and var_244_0 < var_244_3 then
					arg_241_1.talkMaxDuration = var_244_3

					if var_244_3 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_3 + 0
					end
				end

				arg_241_1.text_.text = var_244_1
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_4 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_4 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_4

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_4 and arg_241_1.time_ < 0 + var_244_4 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play120421059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 120421059
		arg_245_1.duration_ = 7.27

		local var_245_0 = {
			zh = 4.766,
			ja = 7.266
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play120421060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1075ui_story = arg_245_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1075ui_story, Vector3.New(-0.7, -1.055, -6.16), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1075ui_story"].transform.position).z)
				arg_245_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1075ui_story"].transform.localEulerAngles = arg_245_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.16)
				arg_245_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["1075ui_story"].transform.position).z)
				arg_245_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["1075ui_story"].transform.localEulerAngles = arg_245_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_248_1 = arg_245_1.actors_["1084ui_story"].transform

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos1084ui_story = var_248_1.localPosition
			end

			local var_248_2 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_2 then
				var_248_1.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_245_1.time_ - 0) / var_248_2)
				var_248_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_1.position).x, (manager.ui.mainCamera.transform.position - var_248_1.position).y, (manager.ui.mainCamera.transform.position - var_248_1.position).z)
				var_248_1.localEulerAngles.z = 0
				var_248_1.localEulerAngles.x = 0
				var_248_1.localEulerAngles = var_248_1.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_2 and arg_245_1.time_ < 0 + var_248_2 + arg_248_0 then
				var_248_1.localPosition = Vector3.New(0.7, -0.97, -6)
				var_248_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_1.position).x, (manager.ui.mainCamera.transform.position - var_248_1.position).y, (manager.ui.mainCamera.transform.position - var_248_1.position).z)
				var_248_1.localEulerAngles.z = 0
				var_248_1.localEulerAngles.x = 0
				var_248_1.localEulerAngles = var_248_1.localEulerAngles
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_248_3 = arg_245_1.actors_["1084ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_3) and arg_245_1.var_.characterEffect1084ui_story == nil then
				arg_245_1.var_.characterEffect1084ui_story = var_248_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_4 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 and not isNil(var_248_3) then
				if arg_245_1.var_.characterEffect1084ui_story and not isNil(var_248_3) then
					arg_245_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_4)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 and not isNil(var_248_3) and arg_245_1.var_.characterEffect1084ui_story then
				arg_245_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_248_5 = arg_245_1.actors_["1075ui_story"]

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(var_248_5) and arg_245_1.var_.characterEffect1075ui_story == nil then
				arg_245_1.var_.characterEffect1075ui_story = var_248_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_6 = 0.2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_6 and not isNil(var_248_5) then
				if arg_245_1.var_.characterEffect1075ui_story and not isNil(var_248_5) then
					arg_245_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 0 + var_248_6 and arg_245_1.time_ < 0 + var_248_6 + arg_248_0 and not isNil(var_248_5) and arg_245_1.var_.characterEffect1075ui_story then
				arg_245_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_248_8 = 0
			local var_248_9 = 0.65

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_8 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_10 = arg_245_1:GetWordFromCfg(120421059)
				local var_248_11 = arg_245_1:FormatText(var_248_10.content)

				arg_245_1.text_.text = var_248_11

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_13 = 26 <= 0 and var_248_9 or var_248_9 * (utf8.len(var_248_11) / 26)

				if (26 <= 0 and var_248_9 or var_248_9 * (utf8.len(var_248_11) / 26)) > 0 and var_248_9 < var_248_13 then
					arg_245_1.talkMaxDuration = var_248_13

					if var_248_13 + var_248_8 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_13 + var_248_8
					end
				end

				arg_245_1.text_.text = var_248_11
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421059", "story_v_out_120421.awb") ~= 0 then
					local var_248_14 = manager.audio:GetVoiceLength("story_v_out_120421", "120421059", "story_v_out_120421.awb") / 1000

					if var_248_14 + var_248_8 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_14 + var_248_8
					end

					if var_248_10.prefab_name ~= "" and arg_245_1.actors_[var_248_10.prefab_name] ~= nil then
						local var_248_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_10.prefab_name].transform, "story_v_out_120421", "120421059", "story_v_out_120421.awb")

						arg_245_1:RecordAudio("120421059", var_248_15)
						arg_245_1:RecordAudio("120421059", var_248_15)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_120421", "120421059", "story_v_out_120421.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_120421", "120421059", "story_v_out_120421.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_16 = math.max(var_248_9, arg_245_1.talkMaxDuration)

			if var_248_8 <= arg_245_1.time_ and arg_245_1.time_ < var_248_8 + var_248_16 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_8) / var_248_16

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_8 + var_248_16 and arg_245_1.time_ < var_248_8 + var_248_16 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
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

		arg_245_1:InitPlayNodeList()
	end,
	Play120421060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 120421060
		arg_249_1.duration_ = 9.97

		local var_249_0 = {
			zh = 5.7,
			ja = 9.966
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
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play120421061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_252_0 = arg_249_1.actors_["1084ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1084ui_story == nil then
				arg_249_1.var_.characterEffect1084ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_1 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_1 and not isNil(var_252_0) then
				if arg_249_1.var_.characterEffect1084ui_story and not isNil(var_252_0) then
					arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_1 and arg_249_1.time_ < 0 + var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1084ui_story then
				arg_249_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_252_3 = arg_249_1.actors_["1075ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_3) and arg_249_1.var_.characterEffect1075ui_story == nil then
				arg_249_1.var_.characterEffect1075ui_story = var_252_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_4 = 0.2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 and not isNil(var_252_3) then
				if arg_249_1.var_.characterEffect1075ui_story and not isNil(var_252_3) then
					arg_249_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_4)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 and not isNil(var_252_3) and arg_249_1.var_.characterEffect1075ui_story then
				arg_249_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_252_5 = 0
			local var_252_6 = 0.8

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_5 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_7 = arg_249_1:GetWordFromCfg(120421060)
				local var_252_8 = arg_249_1:FormatText(var_252_7.content)

				arg_249_1.text_.text = var_252_8

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_10 = 32 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 32)

				if (32 <= 0 and var_252_6 or var_252_6 * (utf8.len(var_252_8) / 32)) > 0 and var_252_6 < var_252_10 then
					arg_249_1.talkMaxDuration = var_252_10

					if var_252_10 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_5
					end
				end

				arg_249_1.text_.text = var_252_8
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421060", "story_v_out_120421.awb") ~= 0 then
					local var_252_11 = manager.audio:GetVoiceLength("story_v_out_120421", "120421060", "story_v_out_120421.awb") / 1000

					if var_252_11 + var_252_5 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_11 + var_252_5
					end

					if var_252_7.prefab_name ~= "" and arg_249_1.actors_[var_252_7.prefab_name] ~= nil then
						local var_252_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_7.prefab_name].transform, "story_v_out_120421", "120421060", "story_v_out_120421.awb")

						arg_249_1:RecordAudio("120421060", var_252_12)
						arg_249_1:RecordAudio("120421060", var_252_12)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_120421", "120421060", "story_v_out_120421.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_120421", "120421060", "story_v_out_120421.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_13 = math.max(var_252_6, arg_249_1.talkMaxDuration)

			if var_252_5 <= arg_249_1.time_ and arg_249_1.time_ < var_252_5 + var_252_13 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_5) / var_252_13

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_5 + var_252_13 and arg_249_1.time_ < var_252_5 + var_252_13 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play120421061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 120421061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play120421062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1084ui_story"]) and arg_253_1.var_.characterEffect1084ui_story == nil then
				arg_253_1.var_.characterEffect1084ui_story = arg_253_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.2

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1084ui_story"]) then
				if arg_253_1.var_.characterEffect1084ui_story and not isNil(arg_253_1.actors_["1084ui_story"]) then
					arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1084ui_story"]) and arg_253_1.var_.characterEffect1084ui_story then
				arg_253_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 0.5

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

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(120421061).content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 20 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 20)

				if (20 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 20)) > 0 and var_256_2 < var_256_5 then
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
	Play120421062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 120421062
		arg_257_1.duration_ = 15.9

		local var_257_0 = {
			zh = 12.066,
			ja = 15.9
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play120421063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1075ui_story"]) and arg_257_1.var_.characterEffect1075ui_story == nil then
				arg_257_1.var_.characterEffect1075ui_story = arg_257_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.2

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1075ui_story"]) then
				if arg_257_1.var_.characterEffect1075ui_story and not isNil(arg_257_1.actors_["1075ui_story"]) then
					arg_257_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1075ui_story"]) and arg_257_1.var_.characterEffect1075ui_story then
				arg_257_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_260_2 = 0
			local var_260_3 = 1.175

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_4 = arg_257_1:GetWordFromCfg(120421062)
				local var_260_5 = arg_257_1:FormatText(var_260_4.content)

				arg_257_1.text_.text = var_260_5

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_7 = 47 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_5) / 47)

				if (47 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_5) / 47)) > 0 and var_260_3 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_2
					end
				end

				arg_257_1.text_.text = var_260_5
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421062", "story_v_out_120421.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421062", "story_v_out_120421.awb") / 1000

					if var_260_8 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_2
					end

					if var_260_4.prefab_name ~= "" and arg_257_1.actors_[var_260_4.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_4.prefab_name].transform, "story_v_out_120421", "120421062", "story_v_out_120421.awb")

						arg_257_1:RecordAudio("120421062", var_260_9)
						arg_257_1:RecordAudio("120421062", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_120421", "120421062", "story_v_out_120421.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_120421", "120421062", "story_v_out_120421.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_3, arg_257_1.talkMaxDuration)

			if var_260_2 <= arg_257_1.time_ and arg_257_1.time_ < var_260_2 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_2) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_2 + var_260_10 and arg_257_1.time_ < var_260_2 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play120421063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 120421063
		arg_261_1.duration_ = 10.97

		local var_261_0 = {
			zh = 7.1,
			ja = 10.966
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play120421064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.85

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:GetWordFromCfg(120421063)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 34 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 34)

				if (34 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 34)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421063", "story_v_out_120421.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421063", "story_v_out_120421.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_120421", "120421063", "story_v_out_120421.awb")

						arg_261_1:RecordAudio("120421063", var_264_6)
						arg_261_1:RecordAudio("120421063", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_120421", "120421063", "story_v_out_120421.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_120421", "120421063", "story_v_out_120421.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play120421064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 120421064
		arg_265_1.duration_ = 8.83

		local var_265_0 = {
			zh = 5.6,
			ja = 8.833
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play120421065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1084ui_story"]) and arg_265_1.var_.characterEffect1084ui_story == nil then
				arg_265_1.var_.characterEffect1084ui_story = arg_265_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1084ui_story"]) then
				if arg_265_1.var_.characterEffect1084ui_story and not isNil(arg_265_1.actors_["1084ui_story"]) then
					arg_265_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1084ui_story"]) and arg_265_1.var_.characterEffect1084ui_story then
				arg_265_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_268_2 = arg_265_1.actors_["1075ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect1075ui_story == nil then
				arg_265_1.var_.characterEffect1075ui_story = var_268_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_3 = 0.2

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.characterEffect1075ui_story and not isNil(var_268_2) then
					arg_265_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_3)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.characterEffect1075ui_story then
				arg_265_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_268_4 = 0
			local var_268_5 = 0.625

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(120421064)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 25 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 25)

				if (25 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 25)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421064", "story_v_out_120421.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421064", "story_v_out_120421.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_out_120421", "120421064", "story_v_out_120421.awb")

						arg_265_1:RecordAudio("120421064", var_268_11)
						arg_265_1:RecordAudio("120421064", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_120421", "120421064", "story_v_out_120421.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_120421", "120421064", "story_v_out_120421.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play120421065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 120421065
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play120421066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1084ui_story"]) and arg_269_1.var_.characterEffect1084ui_story == nil then
				arg_269_1.var_.characterEffect1084ui_story = arg_269_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1084ui_story"]) then
				if arg_269_1.var_.characterEffect1084ui_story and not isNil(arg_269_1.actors_["1084ui_story"]) then
					arg_269_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_0)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1084ui_story"]) and arg_269_1.var_.characterEffect1084ui_story then
				arg_269_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_272_1 = arg_269_1.actors_["1075ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1075ui_story == nil then
				arg_269_1.var_.characterEffect1075ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect1075ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_2)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect1075ui_story then
				arg_269_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_272_3 = 0
			local var_272_4 = 0.225

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_3 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_5 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(120421065).content)

				arg_269_1.text_.text = var_272_5

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_7 = 9 <= 0 and var_272_4 or var_272_4 * (utf8.len(var_272_5) / 9)

				if (9 <= 0 and var_272_4 or var_272_4 * (utf8.len(var_272_5) / 9)) > 0 and var_272_4 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_3 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_3
					end
				end

				arg_269_1.text_.text = var_272_5
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_8 = math.max(var_272_4, arg_269_1.talkMaxDuration)

			if var_272_3 <= arg_269_1.time_ and arg_269_1.time_ < var_272_3 + var_272_8 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_3) / var_272_8

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_3 + var_272_8 and arg_269_1.time_ < var_272_3 + var_272_8 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play120421066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 120421066
		arg_273_1.duration_ = 7.43

		local var_273_0 = {
			zh = 6.966,
			ja = 7.433
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play120421067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["1084ui_story"]) and arg_273_1.var_.characterEffect1084ui_story == nil then
				arg_273_1.var_.characterEffect1084ui_story = arg_273_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["1084ui_story"]) then
				if arg_273_1.var_.characterEffect1084ui_story and not isNil(arg_273_1.actors_["1084ui_story"]) then
					arg_273_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["1084ui_story"]) and arg_273_1.var_.characterEffect1084ui_story then
				arg_273_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_276_1 = arg_273_1.actors_["1075ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1075ui_story == nil then
				arg_273_1.var_.characterEffect1075ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect1075ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect1075ui_story then
				arg_273_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_276_4 = 0
			local var_276_5 = 0.75

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(120421066)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 30 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 30)

				if (30 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 30)) > 0 and var_276_5 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421066", "story_v_out_120421.awb") ~= 0 then
					local var_276_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421066", "story_v_out_120421.awb") / 1000

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end

					if var_276_6.prefab_name ~= "" and arg_273_1.actors_[var_276_6.prefab_name] ~= nil then
						local var_276_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_6.prefab_name].transform, "story_v_out_120421", "120421066", "story_v_out_120421.awb")

						arg_273_1:RecordAudio("120421066", var_276_11)
						arg_273_1:RecordAudio("120421066", var_276_11)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_120421", "120421066", "story_v_out_120421.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_120421", "120421066", "story_v_out_120421.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_12 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_12 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_12

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_12 and arg_273_1.time_ < var_276_4 + var_276_12 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play120421067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 120421067
		arg_277_1.duration_ = 11.8

		local var_277_0 = {
			zh = 9.9,
			ja = 11.8
		}
		local var_277_1 = manager.audio:GetLocalizationFlag()

		if var_277_0[var_277_1] ~= nil then
			arg_277_1.duration_ = var_277_0[var_277_1]
		end

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play120421068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 1.225

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_1 = arg_277_1:GetWordFromCfg(120421067)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 49 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 49)

				if (49 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 49)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421067", "story_v_out_120421.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421067", "story_v_out_120421.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_120421", "120421067", "story_v_out_120421.awb")

						arg_277_1:RecordAudio("120421067", var_280_6)
						arg_277_1:RecordAudio("120421067", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_120421", "120421067", "story_v_out_120421.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_120421", "120421067", "story_v_out_120421.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_7 and arg_277_1.time_ < 0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play120421068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 120421068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play120421069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["1075ui_story"]) and arg_281_1.var_.characterEffect1075ui_story == nil then
				arg_281_1.var_.characterEffect1075ui_story = arg_281_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["1075ui_story"]) then
				if arg_281_1.var_.characterEffect1075ui_story and not isNil(arg_281_1.actors_["1075ui_story"]) then
					arg_281_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_0)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["1075ui_story"]) and arg_281_1.var_.characterEffect1075ui_story then
				arg_281_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_284_1 = 0
			local var_284_2 = 0.475

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_3 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(120421068).content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 19 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 19)

				if (19 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 19)) > 0 and var_284_2 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_1 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_1
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_6 = math.max(var_284_2, arg_281_1.talkMaxDuration)

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_6 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_1) / var_284_6

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_1 + var_284_6 and arg_281_1.time_ < var_284_1 + var_284_6 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play120421069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 120421069
		arg_285_1.duration_ = 4.3

		local var_285_0 = {
			zh = 2.466,
			ja = 4.3
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play120421070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1075ui_story"]) and arg_285_1.var_.characterEffect1075ui_story == nil then
				arg_285_1.var_.characterEffect1075ui_story = arg_285_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1075ui_story"]) then
				if arg_285_1.var_.characterEffect1075ui_story and not isNil(arg_285_1.actors_["1075ui_story"]) then
					arg_285_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1075ui_story"]) and arg_285_1.var_.characterEffect1075ui_story then
				arg_285_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_288_2 = 0
			local var_288_3 = 0.25

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_4 = arg_285_1:GetWordFromCfg(120421069)
				local var_288_5 = arg_285_1:FormatText(var_288_4.content)

				arg_285_1.text_.text = var_288_5

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_7 = 10 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 10)

				if (10 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_5) / 10)) > 0 and var_288_3 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_2
					end
				end

				arg_285_1.text_.text = var_288_5
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421069", "story_v_out_120421.awb") ~= 0 then
					local var_288_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421069", "story_v_out_120421.awb") / 1000

					if var_288_8 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_2
					end

					if var_288_4.prefab_name ~= "" and arg_285_1.actors_[var_288_4.prefab_name] ~= nil then
						local var_288_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_4.prefab_name].transform, "story_v_out_120421", "120421069", "story_v_out_120421.awb")

						arg_285_1:RecordAudio("120421069", var_288_9)
						arg_285_1:RecordAudio("120421069", var_288_9)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_120421", "120421069", "story_v_out_120421.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_120421", "120421069", "story_v_out_120421.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_3, arg_285_1.talkMaxDuration)

			if var_288_2 <= arg_285_1.time_ and arg_285_1.time_ < var_288_2 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_2) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_2 + var_288_10 and arg_285_1.time_ < var_288_2 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play120421070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 120421070
		arg_289_1.duration_ = 9

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play120421071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if arg_289_1.bgs_.ST31 == nil then
				local var_292_0 = Object.Instantiate(arg_289_1.paintGo_)

				var_292_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST31")
				var_292_0.name = "ST31"
				var_292_0.transform.parent = arg_289_1.stage_.transform
				var_292_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.bgs_.ST31 = var_292_0
			end

			if 2 < arg_289_1.time_ and arg_289_1.time_ <= 2 + arg_292_0 then
				local var_292_1 = arg_289_1.bgs_.ST31

				arg_289_1.bgs_.ST31.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_292_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_292_2 = var_292_1:GetComponent("SpriteRenderer")

				if var_292_2 and var_292_2.sprite then
					local var_292_3 = 2 * (var_292_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_292_1.transform.localScale = Vector3.New(var_292_3 / var_292_2.sprite.bounds.size.y < var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x and var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x or var_292_3 / var_292_2.sprite.bounds.size.y, var_292_3 / var_292_2.sprite.bounds.size.y < var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x and var_292_3 * manager.ui.mainCameraCom_.aspect / var_292_2.sprite.bounds.size.x or var_292_3 / var_292_2.sprite.bounds.size.y, 0)
				end

				for iter_292_0, iter_292_1 in pairs(arg_289_1.bgs_) do
					if iter_292_0 ~= "ST31" then
						iter_292_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_292_4 = 0

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_5 = 2

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_5 then
				local var_292_6 = Color.New(0, 0, 0)

				var_292_6.a = Mathf.Lerp(0, 1, (arg_289_1.time_ - var_292_4) / var_292_5)
				arg_289_1.mask_.color = var_292_6
			end

			if arg_289_1.time_ >= var_292_4 + var_292_5 and arg_289_1.time_ < var_292_4 + var_292_5 + arg_292_0 then
				local var_292_7 = Color.New(0, 0, 0)

				var_292_7.a = 1
				arg_289_1.mask_.color = var_292_7
			end

			local var_292_8 = 2

			if 2 < arg_289_1.time_ and arg_289_1.time_ <= var_292_8 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_9 = 2

			if var_292_8 <= arg_289_1.time_ and arg_289_1.time_ < var_292_8 + var_292_9 then
				local var_292_10 = Color.New(0, 0, 0)

				var_292_10.a = Mathf.Lerp(1, 0, (arg_289_1.time_ - var_292_8) / var_292_9)
				arg_289_1.mask_.color = var_292_10
			end

			if arg_289_1.time_ >= var_292_8 + var_292_9 and arg_289_1.time_ < var_292_8 + var_292_9 + arg_292_0 then
				local var_292_11 = Color.New(0, 0, 0)

				arg_289_1.mask_.enabled = false
				var_292_11.a = 0
				arg_289_1.mask_.color = var_292_11
			end

			if 2 < arg_289_1.time_ and arg_289_1.time_ <= 2 + arg_292_0 then
				arg_289_1:AudioAction("play", "effect", "se_story_1", "se_story_1_count", "")
			end

			local var_292_13 = arg_289_1.actors_["1075ui_story"].transform

			if 1.966 < arg_289_1.time_ and arg_289_1.time_ <= 1.966 + arg_292_0 then
				arg_289_1.var_.moveOldPos1075ui_story = var_292_13.localPosition
			end

			local var_292_14 = 0.001

			if 1.966 <= arg_289_1.time_ and arg_289_1.time_ < 1.966 + var_292_14 then
				var_292_13.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_289_1.time_ - 1.966) / var_292_14)
				var_292_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_13.position).x, (manager.ui.mainCamera.transform.position - var_292_13.position).y, (manager.ui.mainCamera.transform.position - var_292_13.position).z)
				var_292_13.localEulerAngles.z = 0
				var_292_13.localEulerAngles.x = 0
				var_292_13.localEulerAngles = var_292_13.localEulerAngles
			end

			if arg_289_1.time_ >= 1.966 + var_292_14 and arg_289_1.time_ < 1.966 + var_292_14 + arg_292_0 then
				var_292_13.localPosition = Vector3.New(0, 100, 0)
				var_292_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_13.position).x, (manager.ui.mainCamera.transform.position - var_292_13.position).y, (manager.ui.mainCamera.transform.position - var_292_13.position).z)
				var_292_13.localEulerAngles.z = 0
				var_292_13.localEulerAngles.x = 0
				var_292_13.localEulerAngles = var_292_13.localEulerAngles
			end

			local var_292_15 = arg_289_1.actors_["1084ui_story"].transform

			if 1.966 < arg_289_1.time_ and arg_289_1.time_ <= 1.966 + arg_292_0 then
				arg_289_1.var_.moveOldPos1084ui_story = var_292_15.localPosition
			end

			local var_292_16 = 0.001

			if 1.966 <= arg_289_1.time_ and arg_289_1.time_ < 1.966 + var_292_16 then
				var_292_15.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_289_1.time_ - 1.966) / var_292_16)
				var_292_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_15.position).x, (manager.ui.mainCamera.transform.position - var_292_15.position).y, (manager.ui.mainCamera.transform.position - var_292_15.position).z)
				var_292_15.localEulerAngles.z = 0
				var_292_15.localEulerAngles.x = 0
				var_292_15.localEulerAngles = var_292_15.localEulerAngles
			end

			if arg_289_1.time_ >= 1.966 + var_292_16 and arg_289_1.time_ < 1.966 + var_292_16 + arg_292_0 then
				var_292_15.localPosition = Vector3.New(0, 100, 0)
				var_292_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_292_15.position).x, (manager.ui.mainCamera.transform.position - var_292_15.position).y, (manager.ui.mainCamera.transform.position - var_292_15.position).z)
				var_292_15.localEulerAngles.z = 0
				var_292_15.localEulerAngles.x = 0
				var_292_15.localEulerAngles = var_292_15.localEulerAngles
			end

			if arg_289_1.frameCnt_ <= 1 then
				arg_289_1.dialog_:SetActive(false)
			end

			local var_292_17 = 4
			local var_292_18 = 0.05

			if 4 < arg_289_1.time_ and arg_289_1.time_ <= var_292_17 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				arg_289_1.dialog_:SetActive(true)

				arg_289_1.dialogCg_.alpha = 0

				local var_292_19 = LeanTween.value(arg_289_1.dialog_, 0, 1, 0.3)

				var_292_19:setOnUpdate(LuaHelper.FloatAction(function(arg_293_0)
					arg_289_1.dialogCg_.alpha = arg_293_0
				end))
				var_292_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_289_1.dialog_)
					var_292_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_289_1.duration_ = arg_289_1.duration_ + 0.3

				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_20 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(120421070).content)

				arg_289_1.text_.text = var_292_20

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_22 = 2 <= 0 and var_292_18 or var_292_18 * (utf8.len(var_292_20) / 2)

				if (2 <= 0 and var_292_18 or var_292_18 * (utf8.len(var_292_20) / 2)) > 0 and var_292_18 < var_292_22 then
					arg_289_1.talkMaxDuration = var_292_22
					var_292_17 = var_292_17 + 0.3

					if var_292_22 + var_292_17 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_22 + var_292_17
					end
				end

				arg_289_1.text_.text = var_292_20
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_23 = var_292_17 + 0.3
			local var_292_24 = math.max(var_292_18, arg_289_1.talkMaxDuration)

			if var_292_17 + 0.3 <= arg_289_1.time_ and arg_289_1.time_ < var_292_23 + var_292_24 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_23) / var_292_24

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_23 + var_292_24 and arg_289_1.time_ < var_292_23 + var_292_24 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
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

		arg_289_1:InitPlayNodeList()
	end,
	Play120421071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 120421071
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play120421072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.125

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_1 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(120421071).content)

				arg_295_1.text_.text = var_298_1

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_3 = 5 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 5)

				if (5 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_1) / 5)) > 0 and var_298_0 < var_298_3 then
					arg_295_1.talkMaxDuration = var_298_3

					if var_298_3 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_3 + 0
					end
				end

				arg_295_1.text_.text = var_298_1
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_4 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_4

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play120421072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 120421072
		arg_299_1.duration_ = 8.07

		local var_299_0 = {
			zh = 8.066,
			ja = 7.166
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play120421073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if arg_299_1.actors_["1074ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1074ui_story"))) then
				local var_302_0 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_299_1.stage_.transform)

				var_302_0.name = "1074ui_story"
				var_302_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_299_1.actors_["1074ui_story"] = var_302_0

				local var_302_1 = var_302_0:GetComponentInChildren(typeof(CharacterEffect))

				var_302_1.enabled = true

				local var_302_2 = GameObjectTools.GetOrAddComponent(var_302_0, typeof(DynamicBoneHelper))

				if var_302_2 then
					var_302_2:EnableDynamicBone(false)
				end

				arg_299_1:ShowWeapon(var_302_1.transform, false)

				arg_299_1.var_["1074ui_story" .. "Animator"] = var_302_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_299_1.var_["1074ui_story" .. "Animator"].applyRootMotion = true
				arg_299_1.var_["1074ui_story" .. "LipSync"] = var_302_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_302_3 = arg_299_1.actors_["1074ui_story"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1074ui_story = var_302_3.localPosition
			end

			local var_302_4 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				var_302_3.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_299_1.time_ - 0) / var_302_4)
				var_302_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_3.position).x, (manager.ui.mainCamera.transform.position - var_302_3.position).y, (manager.ui.mainCamera.transform.position - var_302_3.position).z)
				var_302_3.localEulerAngles.z = 0
				var_302_3.localEulerAngles.x = 0
				var_302_3.localEulerAngles = var_302_3.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				var_302_3.localPosition = Vector3.New(0, -1.055, -6.12)
				var_302_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_3.position).x, (manager.ui.mainCamera.transform.position - var_302_3.position).y, (manager.ui.mainCamera.transform.position - var_302_3.position).z)
				var_302_3.localEulerAngles.z = 0
				var_302_3.localEulerAngles.x = 0
				var_302_3.localEulerAngles = var_302_3.localEulerAngles
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_302_5 = arg_299_1.actors_["1074ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_5) and arg_299_1.var_.characterEffect1074ui_story == nil then
				arg_299_1.var_.characterEffect1074ui_story = var_302_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_6 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_6 and not isNil(var_302_5) then
				if arg_299_1.var_.characterEffect1074ui_story and not isNil(var_302_5) then
					arg_299_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_6 and arg_299_1.time_ < 0 + var_302_6 + arg_302_0 and not isNil(var_302_5) and arg_299_1.var_.characterEffect1074ui_story then
				arg_299_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_302_8 = 0
			local var_302_9 = 0.6

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_8 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_10 = arg_299_1:GetWordFromCfg(120421072)
				local var_302_11 = arg_299_1:FormatText(var_302_10.content)

				arg_299_1.text_.text = var_302_11

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_13 = 24 <= 0 and var_302_9 or var_302_9 * (utf8.len(var_302_11) / 24)

				if (24 <= 0 and var_302_9 or var_302_9 * (utf8.len(var_302_11) / 24)) > 0 and var_302_9 < var_302_13 then
					arg_299_1.talkMaxDuration = var_302_13

					if var_302_13 + var_302_8 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_13 + var_302_8
					end
				end

				arg_299_1.text_.text = var_302_11
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421072", "story_v_out_120421.awb") ~= 0 then
					local var_302_14 = manager.audio:GetVoiceLength("story_v_out_120421", "120421072", "story_v_out_120421.awb") / 1000

					if var_302_14 + var_302_8 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_14 + var_302_8
					end

					if var_302_10.prefab_name ~= "" and arg_299_1.actors_[var_302_10.prefab_name] ~= nil then
						local var_302_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_10.prefab_name].transform, "story_v_out_120421", "120421072", "story_v_out_120421.awb")

						arg_299_1:RecordAudio("120421072", var_302_15)
						arg_299_1:RecordAudio("120421072", var_302_15)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_120421", "120421072", "story_v_out_120421.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_120421", "120421072", "story_v_out_120421.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_16 = math.max(var_302_9, arg_299_1.talkMaxDuration)

			if var_302_8 <= arg_299_1.time_ and arg_299_1.time_ < var_302_8 + var_302_16 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_8) / var_302_16

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_8 + var_302_16 and arg_299_1.time_ < var_302_8 + var_302_16 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play120421073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 120421073
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play120421074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1074ui_story"]) and arg_303_1.var_.characterEffect1074ui_story == nil then
				arg_303_1.var_.characterEffect1074ui_story = arg_303_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_0 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1074ui_story"]) then
				if arg_303_1.var_.characterEffect1074ui_story and not isNil(arg_303_1.actors_["1074ui_story"]) then
					arg_303_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_0)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1074ui_story"]) and arg_303_1.var_.characterEffect1074ui_story then
				arg_303_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_306_1 = 0
			local var_306_2 = 1.025

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(120421073).content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 38 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 38)

				if (38 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 38)) > 0 and var_306_2 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_6 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_6 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_6

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_6 and arg_303_1.time_ < var_306_1 + var_306_6 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play120421074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 120421074
		arg_307_1.duration_ = 8

		local var_307_0 = {
			zh = 4.5,
			ja = 8
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play120421075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if arg_307_1.actors_["1072ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1072ui_story"))) then
				local var_310_0 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_307_1.stage_.transform)

				var_310_0.name = "1072ui_story"
				var_310_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_307_1.actors_["1072ui_story"] = var_310_0

				local var_310_1 = var_310_0:GetComponentInChildren(typeof(CharacterEffect))

				var_310_1.enabled = true

				local var_310_2 = GameObjectTools.GetOrAddComponent(var_310_0, typeof(DynamicBoneHelper))

				if var_310_2 then
					var_310_2:EnableDynamicBone(false)
				end

				arg_307_1:ShowWeapon(var_310_1.transform, false)

				arg_307_1.var_["1072ui_story" .. "Animator"] = var_310_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_307_1.var_["1072ui_story" .. "Animator"].applyRootMotion = true
				arg_307_1.var_["1072ui_story" .. "LipSync"] = var_310_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_310_3 = arg_307_1.actors_["1072ui_story"].transform

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1072ui_story = var_310_3.localPosition
			end

			local var_310_4 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				var_310_3.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_307_1.time_ - 0) / var_310_4)
				var_310_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_3.position).x, (manager.ui.mainCamera.transform.position - var_310_3.position).y, (manager.ui.mainCamera.transform.position - var_310_3.position).z)
				var_310_3.localEulerAngles.z = 0
				var_310_3.localEulerAngles.x = 0
				var_310_3.localEulerAngles = var_310_3.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				var_310_3.localPosition = Vector3.New(0, -0.71, -6)
				var_310_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_3.position).x, (manager.ui.mainCamera.transform.position - var_310_3.position).y, (manager.ui.mainCamera.transform.position - var_310_3.position).z)
				var_310_3.localEulerAngles.z = 0
				var_310_3.localEulerAngles.x = 0
				var_310_3.localEulerAngles = var_310_3.localEulerAngles
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_310_5 = arg_307_1.actors_["1072ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_5) and arg_307_1.var_.characterEffect1072ui_story == nil then
				arg_307_1.var_.characterEffect1072ui_story = var_310_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_6 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_6 and not isNil(var_310_5) then
				if arg_307_1.var_.characterEffect1072ui_story and not isNil(var_310_5) then
					arg_307_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_6 and arg_307_1.time_ < 0 + var_310_6 + arg_310_0 and not isNil(var_310_5) and arg_307_1.var_.characterEffect1072ui_story then
				arg_307_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_310_8 = arg_307_1.actors_["1074ui_story"].transform

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1074ui_story = var_310_8.localPosition
			end

			local var_310_9 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_9 then
				var_310_8.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_307_1.time_ - 0) / var_310_9)
				var_310_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_8.position).x, (manager.ui.mainCamera.transform.position - var_310_8.position).y, (manager.ui.mainCamera.transform.position - var_310_8.position).z)
				var_310_8.localEulerAngles.z = 0
				var_310_8.localEulerAngles.x = 0
				var_310_8.localEulerAngles = var_310_8.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_9 and arg_307_1.time_ < 0 + var_310_9 + arg_310_0 then
				var_310_8.localPosition = Vector3.New(0, 100, 0)
				var_310_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_310_8.position).x, (manager.ui.mainCamera.transform.position - var_310_8.position).y, (manager.ui.mainCamera.transform.position - var_310_8.position).z)
				var_310_8.localEulerAngles.z = 0
				var_310_8.localEulerAngles.x = 0
				var_310_8.localEulerAngles = var_310_8.localEulerAngles
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				if arg_307_1.var_.characterEffect1072ui_story == nil then
					arg_307_1.var_.characterEffect1072ui_story = arg_307_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_310_10 = arg_307_1.var_.characterEffect1072ui_story

				arg_307_1.var_.characterEffect1072ui_story.imageEffect:turnOff()

				var_310_10.interferenceEffect.enabled = true
				var_310_10.interferenceEffect.noise = 0.001
				var_310_10.interferenceEffect.simTimeScale = 1
				var_310_10.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_310_11 = 0
			local var_310_12 = 0.575

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_11 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_13 = arg_307_1:GetWordFromCfg(120421074)
				local var_310_14 = arg_307_1:FormatText(var_310_13.content)

				arg_307_1.text_.text = var_310_14

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_16 = 23 <= 0 and var_310_12 or var_310_12 * (utf8.len(var_310_14) / 23)

				if (23 <= 0 and var_310_12 or var_310_12 * (utf8.len(var_310_14) / 23)) > 0 and var_310_12 < var_310_16 then
					arg_307_1.talkMaxDuration = var_310_16

					if var_310_16 + var_310_11 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_16 + var_310_11
					end
				end

				arg_307_1.text_.text = var_310_14
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421074", "story_v_out_120421.awb") ~= 0 then
					local var_310_17 = manager.audio:GetVoiceLength("story_v_out_120421", "120421074", "story_v_out_120421.awb") / 1000

					if var_310_17 + var_310_11 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_17 + var_310_11
					end

					if var_310_13.prefab_name ~= "" and arg_307_1.actors_[var_310_13.prefab_name] ~= nil then
						local var_310_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_13.prefab_name].transform, "story_v_out_120421", "120421074", "story_v_out_120421.awb")

						arg_307_1:RecordAudio("120421074", var_310_18)
						arg_307_1:RecordAudio("120421074", var_310_18)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_120421", "120421074", "story_v_out_120421.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_120421", "120421074", "story_v_out_120421.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_19 = math.max(var_310_12, arg_307_1.talkMaxDuration)

			if var_310_11 <= arg_307_1.time_ and arg_307_1.time_ < var_310_11 + var_310_19 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_11) / var_310_19

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_11 + var_310_19 and arg_307_1.time_ < var_310_11 + var_310_19 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play120421075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 120421075
		arg_311_1.duration_ = 10.83

		local var_311_0 = {
			zh = 5.633,
			ja = 10.833
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play120421076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos1072ui_story = arg_311_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1072ui_story"].transform.position).z)
				arg_311_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1072ui_story"].transform.localEulerAngles = arg_311_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_311_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["1072ui_story"].transform.position).z)
				arg_311_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["1072ui_story"].transform.localEulerAngles = arg_311_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_314_1 = arg_311_1.actors_["1072ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1072ui_story == nil then
				arg_311_1.var_.characterEffect1072ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect1072ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1072ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_2)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect1072ui_story then
				arg_311_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1072ui_story.fillRatio = 0.5
			end

			local var_314_3 = 0
			local var_314_4 = 0.725

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_3 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_5 = arg_311_1:GetWordFromCfg(120421075)
				local var_314_6 = arg_311_1:FormatText(var_314_5.content)

				arg_311_1.text_.text = var_314_6

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_8 = 29 <= 0 and var_314_4 or var_314_4 * (utf8.len(var_314_6) / 29)

				if (29 <= 0 and var_314_4 or var_314_4 * (utf8.len(var_314_6) / 29)) > 0 and var_314_4 < var_314_8 then
					arg_311_1.talkMaxDuration = var_314_8

					if var_314_8 + var_314_3 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_8 + var_314_3
					end
				end

				arg_311_1.text_.text = var_314_6
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421075", "story_v_out_120421.awb") ~= 0 then
					local var_314_9 = manager.audio:GetVoiceLength("story_v_out_120421", "120421075", "story_v_out_120421.awb") / 1000

					if var_314_9 + var_314_3 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_9 + var_314_3
					end

					if var_314_5.prefab_name ~= "" and arg_311_1.actors_[var_314_5.prefab_name] ~= nil then
						local var_314_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_5.prefab_name].transform, "story_v_out_120421", "120421075", "story_v_out_120421.awb")

						arg_311_1:RecordAudio("120421075", var_314_10)
						arg_311_1:RecordAudio("120421075", var_314_10)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_120421", "120421075", "story_v_out_120421.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_120421", "120421075", "story_v_out_120421.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_11 = math.max(var_314_4, arg_311_1.talkMaxDuration)

			if var_314_3 <= arg_311_1.time_ and arg_311_1.time_ < var_314_3 + var_314_11 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_3) / var_314_11

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_3 + var_314_11 and arg_311_1.time_ < var_314_3 + var_314_11 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play120421076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 120421076
		arg_315_1.duration_ = 6.7

		local var_315_0 = {
			zh = 2.8,
			ja = 6.7
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play120421077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1074ui_story"]) and arg_315_1.var_.characterEffect1074ui_story == nil then
				arg_315_1.var_.characterEffect1074ui_story = arg_315_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1074ui_story"]) then
				if arg_315_1.var_.characterEffect1074ui_story and not isNil(arg_315_1.actors_["1074ui_story"]) then
					arg_315_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1074ui_story"]) and arg_315_1.var_.characterEffect1074ui_story then
				arg_315_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_318_2 = arg_315_1.actors_["1072ui_story"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1072ui_story = var_318_2.localPosition
			end

			local var_318_3 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_3 then
				var_318_2.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_315_1.time_ - 0) / var_318_3)
				var_318_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_2.position).x, (manager.ui.mainCamera.transform.position - var_318_2.position).y, (manager.ui.mainCamera.transform.position - var_318_2.position).z)
				var_318_2.localEulerAngles.z = 0
				var_318_2.localEulerAngles.x = 0
				var_318_2.localEulerAngles = var_318_2.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_3 and arg_315_1.time_ < 0 + var_318_3 + arg_318_0 then
				var_318_2.localPosition = Vector3.New(0, 100, 0)
				var_318_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_2.position).x, (manager.ui.mainCamera.transform.position - var_318_2.position).y, (manager.ui.mainCamera.transform.position - var_318_2.position).z)
				var_318_2.localEulerAngles.z = 0
				var_318_2.localEulerAngles.x = 0
				var_318_2.localEulerAngles = var_318_2.localEulerAngles
			end

			local var_318_4 = arg_315_1.actors_["1074ui_story"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1074ui_story = var_318_4.localPosition
			end

			local var_318_5 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_5 then
				var_318_4.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_315_1.time_ - 0) / var_318_5)
				var_318_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_4.position).x, (manager.ui.mainCamera.transform.position - var_318_4.position).y, (manager.ui.mainCamera.transform.position - var_318_4.position).z)
				var_318_4.localEulerAngles.z = 0
				var_318_4.localEulerAngles.x = 0
				var_318_4.localEulerAngles = var_318_4.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_5 and arg_315_1.time_ < 0 + var_318_5 + arg_318_0 then
				var_318_4.localPosition = Vector3.New(0, -1.055, -6.12)
				var_318_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_4.position).x, (manager.ui.mainCamera.transform.position - var_318_4.position).y, (manager.ui.mainCamera.transform.position - var_318_4.position).z)
				var_318_4.localEulerAngles.z = 0
				var_318_4.localEulerAngles.x = 0
				var_318_4.localEulerAngles = var_318_4.localEulerAngles
			end

			local var_318_6 = 0
			local var_318_7 = 0.275

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_6 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_8 = arg_315_1:GetWordFromCfg(120421076)
				local var_318_9 = arg_315_1:FormatText(var_318_8.content)

				arg_315_1.text_.text = var_318_9

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_11 = 11 <= 0 and var_318_7 or var_318_7 * (utf8.len(var_318_9) / 11)

				if (11 <= 0 and var_318_7 or var_318_7 * (utf8.len(var_318_9) / 11)) > 0 and var_318_7 < var_318_11 then
					arg_315_1.talkMaxDuration = var_318_11

					if var_318_11 + var_318_6 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_11 + var_318_6
					end
				end

				arg_315_1.text_.text = var_318_9
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421076", "story_v_out_120421.awb") ~= 0 then
					local var_318_12 = manager.audio:GetVoiceLength("story_v_out_120421", "120421076", "story_v_out_120421.awb") / 1000

					if var_318_12 + var_318_6 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_12 + var_318_6
					end

					if var_318_8.prefab_name ~= "" and arg_315_1.actors_[var_318_8.prefab_name] ~= nil then
						local var_318_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_8.prefab_name].transform, "story_v_out_120421", "120421076", "story_v_out_120421.awb")

						arg_315_1:RecordAudio("120421076", var_318_13)
						arg_315_1:RecordAudio("120421076", var_318_13)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_120421", "120421076", "story_v_out_120421.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_120421", "120421076", "story_v_out_120421.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_14 = math.max(var_318_7, arg_315_1.talkMaxDuration)

			if var_318_6 <= arg_315_1.time_ and arg_315_1.time_ < var_318_6 + var_318_14 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_6) / var_318_14

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_6 + var_318_14 and arg_315_1.time_ < var_318_6 + var_318_14 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play120421077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 120421077
		arg_319_1.duration_ = 10.73

		local var_319_0 = {
			zh = 4.433,
			ja = 10.733
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play120421078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["1074ui_story"]) and arg_319_1.var_.characterEffect1074ui_story == nil then
				arg_319_1.var_.characterEffect1074ui_story = arg_319_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["1074ui_story"]) then
				if arg_319_1.var_.characterEffect1074ui_story and not isNil(arg_319_1.actors_["1074ui_story"]) then
					arg_319_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_0)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["1074ui_story"]) and arg_319_1.var_.characterEffect1074ui_story then
				arg_319_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_322_1 = arg_319_1.actors_["1072ui_story"].transform

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1072ui_story = var_322_1.localPosition
			end

			local var_322_2 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_2 then
				var_322_1.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_319_1.time_ - 0) / var_322_2)
				var_322_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_1.position).x, (manager.ui.mainCamera.transform.position - var_322_1.position).y, (manager.ui.mainCamera.transform.position - var_322_1.position).z)
				var_322_1.localEulerAngles.z = 0
				var_322_1.localEulerAngles.x = 0
				var_322_1.localEulerAngles = var_322_1.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_2 and arg_319_1.time_ < 0 + var_322_2 + arg_322_0 then
				var_322_1.localPosition = Vector3.New(0, -0.71, -6)
				var_322_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_1.position).x, (manager.ui.mainCamera.transform.position - var_322_1.position).y, (manager.ui.mainCamera.transform.position - var_322_1.position).z)
				var_322_1.localEulerAngles.z = 0
				var_322_1.localEulerAngles.x = 0
				var_322_1.localEulerAngles = var_322_1.localEulerAngles
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action8_1")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_322_3 = arg_319_1.actors_["1072ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_3) and arg_319_1.var_.characterEffect1072ui_story == nil then
				arg_319_1.var_.characterEffect1072ui_story = var_322_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_4 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 and not isNil(var_322_3) then
				if arg_319_1.var_.characterEffect1072ui_story and not isNil(var_322_3) then
					arg_319_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 and not isNil(var_322_3) and arg_319_1.var_.characterEffect1072ui_story then
				arg_319_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_322_6 = arg_319_1.actors_["1074ui_story"].transform

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1074ui_story = var_322_6.localPosition
			end

			local var_322_7 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_7 then
				var_322_6.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_319_1.time_ - 0) / var_322_7)
				var_322_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_6.position).x, (manager.ui.mainCamera.transform.position - var_322_6.position).y, (manager.ui.mainCamera.transform.position - var_322_6.position).z)
				var_322_6.localEulerAngles.z = 0
				var_322_6.localEulerAngles.x = 0
				var_322_6.localEulerAngles = var_322_6.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_7 and arg_319_1.time_ < 0 + var_322_7 + arg_322_0 then
				var_322_6.localPosition = Vector3.New(0, 100, 0)
				var_322_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_6.position).x, (manager.ui.mainCamera.transform.position - var_322_6.position).y, (manager.ui.mainCamera.transform.position - var_322_6.position).z)
				var_322_6.localEulerAngles.z = 0
				var_322_6.localEulerAngles.x = 0
				var_322_6.localEulerAngles = var_322_6.localEulerAngles
			end

			local var_322_8 = 0
			local var_322_9 = 0.5

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_10 = arg_319_1:GetWordFromCfg(120421077)
				local var_322_11 = arg_319_1:FormatText(var_322_10.content)

				arg_319_1.text_.text = var_322_11

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_13 = 20 <= 0 and var_322_9 or var_322_9 * (utf8.len(var_322_11) / 20)

				if (20 <= 0 and var_322_9 or var_322_9 * (utf8.len(var_322_11) / 20)) > 0 and var_322_9 < var_322_13 then
					arg_319_1.talkMaxDuration = var_322_13

					if var_322_13 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_13 + var_322_8
					end
				end

				arg_319_1.text_.text = var_322_11
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421077", "story_v_out_120421.awb") ~= 0 then
					local var_322_14 = manager.audio:GetVoiceLength("story_v_out_120421", "120421077", "story_v_out_120421.awb") / 1000

					if var_322_14 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_14 + var_322_8
					end

					if var_322_10.prefab_name ~= "" and arg_319_1.actors_[var_322_10.prefab_name] ~= nil then
						local var_322_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_10.prefab_name].transform, "story_v_out_120421", "120421077", "story_v_out_120421.awb")

						arg_319_1:RecordAudio("120421077", var_322_15)
						arg_319_1:RecordAudio("120421077", var_322_15)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_120421", "120421077", "story_v_out_120421.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_120421", "120421077", "story_v_out_120421.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_16 = math.max(var_322_9, arg_319_1.talkMaxDuration)

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_16 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_8) / var_322_16

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_8 + var_322_16 and arg_319_1.time_ < var_322_8 + var_322_16 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play120421078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 120421078
		arg_323_1.duration_ = 10.67

		local var_323_0 = {
			zh = 10.666,
			ja = 10.4
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play120421079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1074ui_story"]) and arg_323_1.var_.characterEffect1074ui_story == nil then
				arg_323_1.var_.characterEffect1074ui_story = arg_323_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1074ui_story"]) then
				if arg_323_1.var_.characterEffect1074ui_story and not isNil(arg_323_1.actors_["1074ui_story"]) then
					arg_323_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1074ui_story"]) and arg_323_1.var_.characterEffect1074ui_story then
				arg_323_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_326_2 = arg_323_1.actors_["1074ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1074ui_story = var_326_2.localPosition
			end

			local var_326_3 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_3 then
				var_326_2.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_323_1.time_ - 0) / var_326_3)
				var_326_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_2.position).x, (manager.ui.mainCamera.transform.position - var_326_2.position).y, (manager.ui.mainCamera.transform.position - var_326_2.position).z)
				var_326_2.localEulerAngles.z = 0
				var_326_2.localEulerAngles.x = 0
				var_326_2.localEulerAngles = var_326_2.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_3 and arg_323_1.time_ < 0 + var_326_3 + arg_326_0 then
				var_326_2.localPosition = Vector3.New(0, -1.055, -6.12)
				var_326_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_2.position).x, (manager.ui.mainCamera.transform.position - var_326_2.position).y, (manager.ui.mainCamera.transform.position - var_326_2.position).z)
				var_326_2.localEulerAngles.z = 0
				var_326_2.localEulerAngles.x = 0
				var_326_2.localEulerAngles = var_326_2.localEulerAngles
			end

			local var_326_4 = arg_323_1.actors_["1072ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1072ui_story = var_326_4.localPosition
			end

			local var_326_5 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_5 then
				var_326_4.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 0) / var_326_5)
				var_326_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_4.position).x, (manager.ui.mainCamera.transform.position - var_326_4.position).y, (manager.ui.mainCamera.transform.position - var_326_4.position).z)
				var_326_4.localEulerAngles.z = 0
				var_326_4.localEulerAngles.x = 0
				var_326_4.localEulerAngles = var_326_4.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_5 and arg_323_1.time_ < 0 + var_326_5 + arg_326_0 then
				var_326_4.localPosition = Vector3.New(0, 100, 0)
				var_326_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_4.position).x, (manager.ui.mainCamera.transform.position - var_326_4.position).y, (manager.ui.mainCamera.transform.position - var_326_4.position).z)
				var_326_4.localEulerAngles.z = 0
				var_326_4.localEulerAngles.x = 0
				var_326_4.localEulerAngles = var_326_4.localEulerAngles
			end

			local var_326_6 = 0
			local var_326_7 = 0.875

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_6 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_8 = arg_323_1:GetWordFromCfg(120421078)
				local var_326_9 = arg_323_1:FormatText(var_326_8.content)

				arg_323_1.text_.text = var_326_9

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_11 = 35 <= 0 and var_326_7 or var_326_7 * (utf8.len(var_326_9) / 35)

				if (35 <= 0 and var_326_7 or var_326_7 * (utf8.len(var_326_9) / 35)) > 0 and var_326_7 < var_326_11 then
					arg_323_1.talkMaxDuration = var_326_11

					if var_326_11 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_11 + var_326_6
					end
				end

				arg_323_1.text_.text = var_326_9
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421078", "story_v_out_120421.awb") ~= 0 then
					local var_326_12 = manager.audio:GetVoiceLength("story_v_out_120421", "120421078", "story_v_out_120421.awb") / 1000

					if var_326_12 + var_326_6 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_12 + var_326_6
					end

					if var_326_8.prefab_name ~= "" and arg_323_1.actors_[var_326_8.prefab_name] ~= nil then
						local var_326_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_8.prefab_name].transform, "story_v_out_120421", "120421078", "story_v_out_120421.awb")

						arg_323_1:RecordAudio("120421078", var_326_13)
						arg_323_1:RecordAudio("120421078", var_326_13)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_120421", "120421078", "story_v_out_120421.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_120421", "120421078", "story_v_out_120421.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_14 = math.max(var_326_7, arg_323_1.talkMaxDuration)

			if var_326_6 <= arg_323_1.time_ and arg_323_1.time_ < var_326_6 + var_326_14 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_6) / var_326_14

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_6 + var_326_14 and arg_323_1.time_ < var_326_6 + var_326_14 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play120421079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 120421079
		arg_327_1.duration_ = 11.97

		local var_327_0 = {
			zh = 8.4,
			ja = 11.966
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play120421080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1074ui_story"]) and arg_327_1.var_.characterEffect1074ui_story == nil then
				arg_327_1.var_.characterEffect1074ui_story = arg_327_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1074ui_story"]) then
				if arg_327_1.var_.characterEffect1074ui_story and not isNil(arg_327_1.actors_["1074ui_story"]) then
					arg_327_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_0)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1074ui_story"]) and arg_327_1.var_.characterEffect1074ui_story then
				arg_327_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_330_1 = arg_327_1.actors_["1072ui_story"].transform

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos1072ui_story = var_330_1.localPosition
			end

			local var_330_2 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_2 then
				var_330_1.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_327_1.time_ - 0) / var_330_2)
				var_330_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_1.position).x, (manager.ui.mainCamera.transform.position - var_330_1.position).y, (manager.ui.mainCamera.transform.position - var_330_1.position).z)
				var_330_1.localEulerAngles.z = 0
				var_330_1.localEulerAngles.x = 0
				var_330_1.localEulerAngles = var_330_1.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_2 and arg_327_1.time_ < 0 + var_330_2 + arg_330_0 then
				var_330_1.localPosition = Vector3.New(0, -0.71, -6)
				var_330_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_1.position).x, (manager.ui.mainCamera.transform.position - var_330_1.position).y, (manager.ui.mainCamera.transform.position - var_330_1.position).z)
				var_330_1.localEulerAngles.z = 0
				var_330_1.localEulerAngles.x = 0
				var_330_1.localEulerAngles = var_330_1.localEulerAngles
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_330_3 = arg_327_1.actors_["1072ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_3) and arg_327_1.var_.characterEffect1072ui_story == nil then
				arg_327_1.var_.characterEffect1072ui_story = var_330_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_4 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_4 and not isNil(var_330_3) then
				if arg_327_1.var_.characterEffect1072ui_story and not isNil(var_330_3) then
					arg_327_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_4 and arg_327_1.time_ < 0 + var_330_4 + arg_330_0 and not isNil(var_330_3) and arg_327_1.var_.characterEffect1072ui_story then
				arg_327_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_330_6 = arg_327_1.actors_["1074ui_story"].transform

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos1074ui_story = var_330_6.localPosition
			end

			local var_330_7 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_7 then
				var_330_6.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_327_1.time_ - 0) / var_330_7)
				var_330_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_6.position).x, (manager.ui.mainCamera.transform.position - var_330_6.position).y, (manager.ui.mainCamera.transform.position - var_330_6.position).z)
				var_330_6.localEulerAngles.z = 0
				var_330_6.localEulerAngles.x = 0
				var_330_6.localEulerAngles = var_330_6.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_7 and arg_327_1.time_ < 0 + var_330_7 + arg_330_0 then
				var_330_6.localPosition = Vector3.New(0, 100, 0)
				var_330_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_6.position).x, (manager.ui.mainCamera.transform.position - var_330_6.position).y, (manager.ui.mainCamera.transform.position - var_330_6.position).z)
				var_330_6.localEulerAngles.z = 0
				var_330_6.localEulerAngles.x = 0
				var_330_6.localEulerAngles = var_330_6.localEulerAngles
			end

			local var_330_8 = 0
			local var_330_9 = 0.975

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_10 = arg_327_1:GetWordFromCfg(120421079)
				local var_330_11 = arg_327_1:FormatText(var_330_10.content)

				arg_327_1.text_.text = var_330_11

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_13 = 39 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 39)

				if (39 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 39)) > 0 and var_330_9 < var_330_13 then
					arg_327_1.talkMaxDuration = var_330_13

					if var_330_13 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_13 + var_330_8
					end
				end

				arg_327_1.text_.text = var_330_11
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421079", "story_v_out_120421.awb") ~= 0 then
					local var_330_14 = manager.audio:GetVoiceLength("story_v_out_120421", "120421079", "story_v_out_120421.awb") / 1000

					if var_330_14 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_14 + var_330_8
					end

					if var_330_10.prefab_name ~= "" and arg_327_1.actors_[var_330_10.prefab_name] ~= nil then
						local var_330_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_10.prefab_name].transform, "story_v_out_120421", "120421079", "story_v_out_120421.awb")

						arg_327_1:RecordAudio("120421079", var_330_15)
						arg_327_1:RecordAudio("120421079", var_330_15)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_120421", "120421079", "story_v_out_120421.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_120421", "120421079", "story_v_out_120421.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_16 = math.max(var_330_9, arg_327_1.talkMaxDuration)

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_16 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_8) / var_330_16

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_8 + var_330_16 and arg_327_1.time_ < var_330_8 + var_330_16 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play120421080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 120421080
		arg_331_1.duration_ = 5.13

		local var_331_0 = {
			zh = 3.066,
			ja = 5.133
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play120421081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["1074ui_story"]) and arg_331_1.var_.characterEffect1074ui_story == nil then
				arg_331_1.var_.characterEffect1074ui_story = arg_331_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["1074ui_story"]) then
				if arg_331_1.var_.characterEffect1074ui_story and not isNil(arg_331_1.actors_["1074ui_story"]) then
					arg_331_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["1074ui_story"]) and arg_331_1.var_.characterEffect1074ui_story then
				arg_331_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_334_2 = arg_331_1.actors_["1074ui_story"].transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1074ui_story = var_334_2.localPosition
			end

			local var_334_3 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_3 then
				var_334_2.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_331_1.time_ - 0) / var_334_3)
				var_334_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_2.position).x, (manager.ui.mainCamera.transform.position - var_334_2.position).y, (manager.ui.mainCamera.transform.position - var_334_2.position).z)
				var_334_2.localEulerAngles.z = 0
				var_334_2.localEulerAngles.x = 0
				var_334_2.localEulerAngles = var_334_2.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_3 and arg_331_1.time_ < 0 + var_334_3 + arg_334_0 then
				var_334_2.localPosition = Vector3.New(0, -1.055, -6.12)
				var_334_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_2.position).x, (manager.ui.mainCamera.transform.position - var_334_2.position).y, (manager.ui.mainCamera.transform.position - var_334_2.position).z)
				var_334_2.localEulerAngles.z = 0
				var_334_2.localEulerAngles.x = 0
				var_334_2.localEulerAngles = var_334_2.localEulerAngles
			end

			local var_334_4 = arg_331_1.actors_["1072ui_story"].transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1072ui_story = var_334_4.localPosition
			end

			local var_334_5 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_5 then
				var_334_4.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_331_1.time_ - 0) / var_334_5)
				var_334_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_4.position).x, (manager.ui.mainCamera.transform.position - var_334_4.position).y, (manager.ui.mainCamera.transform.position - var_334_4.position).z)
				var_334_4.localEulerAngles.z = 0
				var_334_4.localEulerAngles.x = 0
				var_334_4.localEulerAngles = var_334_4.localEulerAngles
			end

			if arg_331_1.time_ >= 0 + var_334_5 and arg_331_1.time_ < 0 + var_334_5 + arg_334_0 then
				var_334_4.localPosition = Vector3.New(0, 100, 0)
				var_334_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_334_4.position).x, (manager.ui.mainCamera.transform.position - var_334_4.position).y, (manager.ui.mainCamera.transform.position - var_334_4.position).z)
				var_334_4.localEulerAngles.z = 0
				var_334_4.localEulerAngles.x = 0
				var_334_4.localEulerAngles = var_334_4.localEulerAngles
			end

			local var_334_6 = 0
			local var_334_7 = 0.25

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_6 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_8 = arg_331_1:GetWordFromCfg(120421080)
				local var_334_9 = arg_331_1:FormatText(var_334_8.content)

				arg_331_1.text_.text = var_334_9

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_11 = 10 <= 0 and var_334_7 or var_334_7 * (utf8.len(var_334_9) / 10)

				if (10 <= 0 and var_334_7 or var_334_7 * (utf8.len(var_334_9) / 10)) > 0 and var_334_7 < var_334_11 then
					arg_331_1.talkMaxDuration = var_334_11

					if var_334_11 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_11 + var_334_6
					end
				end

				arg_331_1.text_.text = var_334_9
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421080", "story_v_out_120421.awb") ~= 0 then
					local var_334_12 = manager.audio:GetVoiceLength("story_v_out_120421", "120421080", "story_v_out_120421.awb") / 1000

					if var_334_12 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_12 + var_334_6
					end

					if var_334_8.prefab_name ~= "" and arg_331_1.actors_[var_334_8.prefab_name] ~= nil then
						local var_334_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_8.prefab_name].transform, "story_v_out_120421", "120421080", "story_v_out_120421.awb")

						arg_331_1:RecordAudio("120421080", var_334_13)
						arg_331_1:RecordAudio("120421080", var_334_13)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_120421", "120421080", "story_v_out_120421.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_120421", "120421080", "story_v_out_120421.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_14 = math.max(var_334_7, arg_331_1.talkMaxDuration)

			if var_334_6 <= arg_331_1.time_ and arg_331_1.time_ < var_334_6 + var_334_14 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_6) / var_334_14

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_6 + var_334_14 and arg_331_1.time_ < var_334_6 + var_334_14 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play120421081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 120421081
		arg_335_1.duration_ = 8.37

		local var_335_0 = {
			zh = 6.666,
			ja = 8.366
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play120421082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1074ui_story"]) and arg_335_1.var_.characterEffect1074ui_story == nil then
				arg_335_1.var_.characterEffect1074ui_story = arg_335_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1074ui_story"]) then
				if arg_335_1.var_.characterEffect1074ui_story and not isNil(arg_335_1.actors_["1074ui_story"]) then
					arg_335_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_335_1.time_ - 0) / var_338_0)
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1074ui_story"]) and arg_335_1.var_.characterEffect1074ui_story then
				arg_335_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_338_1 = arg_335_1.actors_["1072ui_story"].transform

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1072ui_story = var_338_1.localPosition
			end

			local var_338_2 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_2 then
				var_338_1.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_335_1.time_ - 0) / var_338_2)
				var_338_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_1.position).x, (manager.ui.mainCamera.transform.position - var_338_1.position).y, (manager.ui.mainCamera.transform.position - var_338_1.position).z)
				var_338_1.localEulerAngles.z = 0
				var_338_1.localEulerAngles.x = 0
				var_338_1.localEulerAngles = var_338_1.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_2 and arg_335_1.time_ < 0 + var_338_2 + arg_338_0 then
				var_338_1.localPosition = Vector3.New(0, -0.71, -6)
				var_338_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_1.position).x, (manager.ui.mainCamera.transform.position - var_338_1.position).y, (manager.ui.mainCamera.transform.position - var_338_1.position).z)
				var_338_1.localEulerAngles.z = 0
				var_338_1.localEulerAngles.x = 0
				var_338_1.localEulerAngles = var_338_1.localEulerAngles
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action7_1")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_338_3 = arg_335_1.actors_["1072ui_story"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_3) and arg_335_1.var_.characterEffect1072ui_story == nil then
				arg_335_1.var_.characterEffect1072ui_story = var_338_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_4 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 and not isNil(var_338_3) then
				if arg_335_1.var_.characterEffect1072ui_story and not isNil(var_338_3) then
					arg_335_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 and not isNil(var_338_3) and arg_335_1.var_.characterEffect1072ui_story then
				arg_335_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_338_6 = arg_335_1.actors_["1074ui_story"].transform

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1074ui_story = var_338_6.localPosition
			end

			local var_338_7 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_7 then
				var_338_6.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_335_1.time_ - 0) / var_338_7)
				var_338_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_6.position).x, (manager.ui.mainCamera.transform.position - var_338_6.position).y, (manager.ui.mainCamera.transform.position - var_338_6.position).z)
				var_338_6.localEulerAngles.z = 0
				var_338_6.localEulerAngles.x = 0
				var_338_6.localEulerAngles = var_338_6.localEulerAngles
			end

			if arg_335_1.time_ >= 0 + var_338_7 and arg_335_1.time_ < 0 + var_338_7 + arg_338_0 then
				var_338_6.localPosition = Vector3.New(0, 100, 0)
				var_338_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_338_6.position).x, (manager.ui.mainCamera.transform.position - var_338_6.position).y, (manager.ui.mainCamera.transform.position - var_338_6.position).z)
				var_338_6.localEulerAngles.z = 0
				var_338_6.localEulerAngles.x = 0
				var_338_6.localEulerAngles = var_338_6.localEulerAngles
			end

			local var_338_8 = 0
			local var_338_9 = 0.725

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_8 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_10 = arg_335_1:GetWordFromCfg(120421081)
				local var_338_11 = arg_335_1:FormatText(var_338_10.content)

				arg_335_1.text_.text = var_338_11

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_13 = 29 <= 0 and var_338_9 or var_338_9 * (utf8.len(var_338_11) / 29)

				if (29 <= 0 and var_338_9 or var_338_9 * (utf8.len(var_338_11) / 29)) > 0 and var_338_9 < var_338_13 then
					arg_335_1.talkMaxDuration = var_338_13

					if var_338_13 + var_338_8 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_13 + var_338_8
					end
				end

				arg_335_1.text_.text = var_338_11
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421081", "story_v_out_120421.awb") ~= 0 then
					local var_338_14 = manager.audio:GetVoiceLength("story_v_out_120421", "120421081", "story_v_out_120421.awb") / 1000

					if var_338_14 + var_338_8 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_14 + var_338_8
					end

					if var_338_10.prefab_name ~= "" and arg_335_1.actors_[var_338_10.prefab_name] ~= nil then
						local var_338_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_10.prefab_name].transform, "story_v_out_120421", "120421081", "story_v_out_120421.awb")

						arg_335_1:RecordAudio("120421081", var_338_15)
						arg_335_1:RecordAudio("120421081", var_338_15)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_120421", "120421081", "story_v_out_120421.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_120421", "120421081", "story_v_out_120421.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_16 = math.max(var_338_9, arg_335_1.talkMaxDuration)

			if var_338_8 <= arg_335_1.time_ and arg_335_1.time_ < var_338_8 + var_338_16 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_8) / var_338_16

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_8 + var_338_16 and arg_335_1.time_ < var_338_8 + var_338_16 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_335_1:InitPlayNodeList()
	end,
	Play120421082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 120421082
		arg_339_1.duration_ = 1.03

		local var_339_0 = {
			zh = 0.999999999999,
			ja = 1.033
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play120421083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1074ui_story"]) and arg_339_1.var_.characterEffect1074ui_story == nil then
				arg_339_1.var_.characterEffect1074ui_story = arg_339_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1074ui_story"]) then
				if arg_339_1.var_.characterEffect1074ui_story and not isNil(arg_339_1.actors_["1074ui_story"]) then
					arg_339_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1074ui_story"]) and arg_339_1.var_.characterEffect1074ui_story then
				arg_339_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_342_2 = arg_339_1.actors_["1074ui_story"].transform

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1074ui_story = var_342_2.localPosition
			end

			local var_342_3 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_3 then
				var_342_2.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_339_1.time_ - 0) / var_342_3)
				var_342_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_342_2.position).x, (manager.ui.mainCamera.transform.position - var_342_2.position).y, (manager.ui.mainCamera.transform.position - var_342_2.position).z)
				var_342_2.localEulerAngles.z = 0
				var_342_2.localEulerAngles.x = 0
				var_342_2.localEulerAngles = var_342_2.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_3 and arg_339_1.time_ < 0 + var_342_3 + arg_342_0 then
				var_342_2.localPosition = Vector3.New(0, -1.055, -6.12)
				var_342_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_342_2.position).x, (manager.ui.mainCamera.transform.position - var_342_2.position).y, (manager.ui.mainCamera.transform.position - var_342_2.position).z)
				var_342_2.localEulerAngles.z = 0
				var_342_2.localEulerAngles.x = 0
				var_342_2.localEulerAngles = var_342_2.localEulerAngles
			end

			local var_342_4 = arg_339_1.actors_["1072ui_story"].transform

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1072ui_story = var_342_4.localPosition
			end

			local var_342_5 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_5 then
				var_342_4.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_339_1.time_ - 0) / var_342_5)
				var_342_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_342_4.position).x, (manager.ui.mainCamera.transform.position - var_342_4.position).y, (manager.ui.mainCamera.transform.position - var_342_4.position).z)
				var_342_4.localEulerAngles.z = 0
				var_342_4.localEulerAngles.x = 0
				var_342_4.localEulerAngles = var_342_4.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_5 and arg_339_1.time_ < 0 + var_342_5 + arg_342_0 then
				var_342_4.localPosition = Vector3.New(0, 100, 0)
				var_342_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_342_4.position).x, (manager.ui.mainCamera.transform.position - var_342_4.position).y, (manager.ui.mainCamera.transform.position - var_342_4.position).z)
				var_342_4.localEulerAngles.z = 0
				var_342_4.localEulerAngles.x = 0
				var_342_4.localEulerAngles = var_342_4.localEulerAngles
			end

			local var_342_6 = 0
			local var_342_7 = 0.05

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_6 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_8 = arg_339_1:GetWordFromCfg(120421082)
				local var_342_9 = arg_339_1:FormatText(var_342_8.content)

				arg_339_1.text_.text = var_342_9

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_11 = 2 <= 0 and var_342_7 or var_342_7 * (utf8.len(var_342_9) / 2)

				if (2 <= 0 and var_342_7 or var_342_7 * (utf8.len(var_342_9) / 2)) > 0 and var_342_7 < var_342_11 then
					arg_339_1.talkMaxDuration = var_342_11

					if var_342_11 + var_342_6 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_11 + var_342_6
					end
				end

				arg_339_1.text_.text = var_342_9
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421082", "story_v_out_120421.awb") ~= 0 then
					local var_342_12 = manager.audio:GetVoiceLength("story_v_out_120421", "120421082", "story_v_out_120421.awb") / 1000

					if var_342_12 + var_342_6 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_12 + var_342_6
					end

					if var_342_8.prefab_name ~= "" and arg_339_1.actors_[var_342_8.prefab_name] ~= nil then
						local var_342_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_8.prefab_name].transform, "story_v_out_120421", "120421082", "story_v_out_120421.awb")

						arg_339_1:RecordAudio("120421082", var_342_13)
						arg_339_1:RecordAudio("120421082", var_342_13)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_120421", "120421082", "story_v_out_120421.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_120421", "120421082", "story_v_out_120421.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_14 = math.max(var_342_7, arg_339_1.talkMaxDuration)

			if var_342_6 <= arg_339_1.time_ and arg_339_1.time_ < var_342_6 + var_342_14 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_6) / var_342_14

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_6 + var_342_14 and arg_339_1.time_ < var_342_6 + var_342_14 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play120421083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 120421083
		arg_343_1.duration_ = 5.83

		local var_343_0 = {
			zh = 3.266,
			ja = 5.833
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play120421084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0.35

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_1 = arg_343_1:GetWordFromCfg(120421083)
				local var_346_2 = arg_343_1:FormatText(var_346_1.content)

				arg_343_1.text_.text = var_346_2

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_4 = 14 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 14)

				if (14 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 14)) > 0 and var_346_0 < var_346_4 then
					arg_343_1.talkMaxDuration = var_346_4

					if var_346_4 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_4 + 0
					end
				end

				arg_343_1.text_.text = var_346_2
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421083", "story_v_out_120421.awb") ~= 0 then
					local var_346_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421083", "story_v_out_120421.awb") / 1000

					if var_346_5 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + 0
					end

					if var_346_1.prefab_name ~= "" and arg_343_1.actors_[var_346_1.prefab_name] ~= nil then
						local var_346_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_1.prefab_name].transform, "story_v_out_120421", "120421083", "story_v_out_120421.awb")

						arg_343_1:RecordAudio("120421083", var_346_6)
						arg_343_1:RecordAudio("120421083", var_346_6)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_120421", "120421083", "story_v_out_120421.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_120421", "120421083", "story_v_out_120421.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_7 and arg_343_1.time_ < 0 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play120421084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 120421084
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play120421085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos1074ui_story = arg_347_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_350_0 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 then
				arg_347_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_347_1.time_ - 0) / var_350_0)
				arg_347_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1074ui_story"].transform.position).z)
				arg_347_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["1074ui_story"].transform.localEulerAngles = arg_347_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 then
				arg_347_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_347_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["1074ui_story"].transform.position).z)
				arg_347_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["1074ui_story"].transform.localEulerAngles = arg_347_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_350_1 = 0
			local var_350_2 = 1.25

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_3 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(120421084).content)

				arg_347_1.text_.text = var_350_3

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 50 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 50)

				if (50 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 50)) > 0 and var_350_2 < var_350_5 then
					arg_347_1.talkMaxDuration = var_350_5

					if var_350_5 + var_350_1 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + var_350_1
					end
				end

				arg_347_1.text_.text = var_350_3
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_6 = math.max(var_350_2, arg_347_1.talkMaxDuration)

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_6 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_1) / var_350_6

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_1 + var_350_6 and arg_347_1.time_ < var_350_1 + var_350_6 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play120421085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 120421085
		arg_351_1.duration_ = 4.4

		local var_351_0 = {
			zh = 4.4,
			ja = 4.033
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play120421086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1074ui_story"]) and arg_351_1.var_.characterEffect1074ui_story == nil then
				arg_351_1.var_.characterEffect1074ui_story = arg_351_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1074ui_story"]) then
				if arg_351_1.var_.characterEffect1074ui_story and not isNil(arg_351_1.actors_["1074ui_story"]) then
					arg_351_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1074ui_story"]) and arg_351_1.var_.characterEffect1074ui_story then
				arg_351_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_354_2 = arg_351_1.actors_["1074ui_story"].transform

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1074ui_story = var_354_2.localPosition
			end

			local var_354_3 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_3 then
				var_354_2.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_351_1.time_ - 0) / var_354_3)
				var_354_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_354_2.position).x, (manager.ui.mainCamera.transform.position - var_354_2.position).y, (manager.ui.mainCamera.transform.position - var_354_2.position).z)
				var_354_2.localEulerAngles.z = 0
				var_354_2.localEulerAngles.x = 0
				var_354_2.localEulerAngles = var_354_2.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_3 and arg_351_1.time_ < 0 + var_354_3 + arg_354_0 then
				var_354_2.localPosition = Vector3.New(0, -1.055, -6.12)
				var_354_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_354_2.position).x, (manager.ui.mainCamera.transform.position - var_354_2.position).y, (manager.ui.mainCamera.transform.position - var_354_2.position).z)
				var_354_2.localEulerAngles.z = 0
				var_354_2.localEulerAngles.x = 0
				var_354_2.localEulerAngles = var_354_2.localEulerAngles
			end

			local var_354_4 = 0
			local var_354_5 = 0.475

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_6 = arg_351_1:GetWordFromCfg(120421085)
				local var_354_7 = arg_351_1:FormatText(var_354_6.content)

				arg_351_1.text_.text = var_354_7

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_9 = 19 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 19)

				if (19 <= 0 and var_354_5 or var_354_5 * (utf8.len(var_354_7) / 19)) > 0 and var_354_5 < var_354_9 then
					arg_351_1.talkMaxDuration = var_354_9

					if var_354_9 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_9 + var_354_4
					end
				end

				arg_351_1.text_.text = var_354_7
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421085", "story_v_out_120421.awb") ~= 0 then
					local var_354_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421085", "story_v_out_120421.awb") / 1000

					if var_354_10 + var_354_4 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_4
					end

					if var_354_6.prefab_name ~= "" and arg_351_1.actors_[var_354_6.prefab_name] ~= nil then
						local var_354_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_6.prefab_name].transform, "story_v_out_120421", "120421085", "story_v_out_120421.awb")

						arg_351_1:RecordAudio("120421085", var_354_11)
						arg_351_1:RecordAudio("120421085", var_354_11)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_120421", "120421085", "story_v_out_120421.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_120421", "120421085", "story_v_out_120421.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_12 = math.max(var_354_5, arg_351_1.talkMaxDuration)

			if var_354_4 <= arg_351_1.time_ and arg_351_1.time_ < var_354_4 + var_354_12 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_4) / var_354_12

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_4 + var_354_12 and arg_351_1.time_ < var_354_4 + var_354_12 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play120421086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 120421086
		arg_355_1.duration_ = 13.83

		local var_355_0 = {
			zh = 7,
			ja = 13.833
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play120421087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["1074ui_story"]) and arg_355_1.var_.characterEffect1074ui_story == nil then
				arg_355_1.var_.characterEffect1074ui_story = arg_355_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["1074ui_story"]) then
				if arg_355_1.var_.characterEffect1074ui_story and not isNil(arg_355_1.actors_["1074ui_story"]) then
					arg_355_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_0)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["1074ui_story"]) and arg_355_1.var_.characterEffect1074ui_story then
				arg_355_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_358_1 = arg_355_1.actors_["1072ui_story"].transform

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos1072ui_story = var_358_1.localPosition
			end

			local var_358_2 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_2 then
				var_358_1.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_355_1.time_ - 0) / var_358_2)
				var_358_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_358_1.position).x, (manager.ui.mainCamera.transform.position - var_358_1.position).y, (manager.ui.mainCamera.transform.position - var_358_1.position).z)
				var_358_1.localEulerAngles.z = 0
				var_358_1.localEulerAngles.x = 0
				var_358_1.localEulerAngles = var_358_1.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_2 and arg_355_1.time_ < 0 + var_358_2 + arg_358_0 then
				var_358_1.localPosition = Vector3.New(0, -0.71, -6)
				var_358_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_358_1.position).x, (manager.ui.mainCamera.transform.position - var_358_1.position).y, (manager.ui.mainCamera.transform.position - var_358_1.position).z)
				var_358_1.localEulerAngles.z = 0
				var_358_1.localEulerAngles.x = 0
				var_358_1.localEulerAngles = var_358_1.localEulerAngles
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_358_3 = arg_355_1.actors_["1072ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_3) and arg_355_1.var_.characterEffect1072ui_story == nil then
				arg_355_1.var_.characterEffect1072ui_story = var_358_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_4 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_4 and not isNil(var_358_3) then
				if arg_355_1.var_.characterEffect1072ui_story and not isNil(var_358_3) then
					arg_355_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_4 and arg_355_1.time_ < 0 + var_358_4 + arg_358_0 and not isNil(var_358_3) and arg_355_1.var_.characterEffect1072ui_story then
				arg_355_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_358_6 = arg_355_1.actors_["1074ui_story"].transform

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos1074ui_story = var_358_6.localPosition
			end

			local var_358_7 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_7 then
				var_358_6.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_355_1.time_ - 0) / var_358_7)
				var_358_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_358_6.position).x, (manager.ui.mainCamera.transform.position - var_358_6.position).y, (manager.ui.mainCamera.transform.position - var_358_6.position).z)
				var_358_6.localEulerAngles.z = 0
				var_358_6.localEulerAngles.x = 0
				var_358_6.localEulerAngles = var_358_6.localEulerAngles
			end

			if arg_355_1.time_ >= 0 + var_358_7 and arg_355_1.time_ < 0 + var_358_7 + arg_358_0 then
				var_358_6.localPosition = Vector3.New(0, 100, 0)
				var_358_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_358_6.position).x, (manager.ui.mainCamera.transform.position - var_358_6.position).y, (manager.ui.mainCamera.transform.position - var_358_6.position).z)
				var_358_6.localEulerAngles.z = 0
				var_358_6.localEulerAngles.x = 0
				var_358_6.localEulerAngles = var_358_6.localEulerAngles
			end

			local var_358_8 = 0
			local var_358_9 = 0.825

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_8 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_10 = arg_355_1:GetWordFromCfg(120421086)
				local var_358_11 = arg_355_1:FormatText(var_358_10.content)

				arg_355_1.text_.text = var_358_11

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_13 = 33 <= 0 and var_358_9 or var_358_9 * (utf8.len(var_358_11) / 33)

				if (33 <= 0 and var_358_9 or var_358_9 * (utf8.len(var_358_11) / 33)) > 0 and var_358_9 < var_358_13 then
					arg_355_1.talkMaxDuration = var_358_13

					if var_358_13 + var_358_8 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_13 + var_358_8
					end
				end

				arg_355_1.text_.text = var_358_11
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421086", "story_v_out_120421.awb") ~= 0 then
					local var_358_14 = manager.audio:GetVoiceLength("story_v_out_120421", "120421086", "story_v_out_120421.awb") / 1000

					if var_358_14 + var_358_8 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_14 + var_358_8
					end

					if var_358_10.prefab_name ~= "" and arg_355_1.actors_[var_358_10.prefab_name] ~= nil then
						local var_358_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_10.prefab_name].transform, "story_v_out_120421", "120421086", "story_v_out_120421.awb")

						arg_355_1:RecordAudio("120421086", var_358_15)
						arg_355_1:RecordAudio("120421086", var_358_15)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_120421", "120421086", "story_v_out_120421.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_120421", "120421086", "story_v_out_120421.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_16 = math.max(var_358_9, arg_355_1.talkMaxDuration)

			if var_358_8 <= arg_355_1.time_ and arg_355_1.time_ < var_358_8 + var_358_16 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_8) / var_358_16

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_8 + var_358_16 and arg_355_1.time_ < var_358_8 + var_358_16 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_355_1:InitPlayNodeList()
	end,
	Play120421087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 120421087
		arg_359_1.duration_ = 13

		local var_359_0 = {
			zh = 9.866,
			ja = 13
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play120421088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1072ui_story = arg_359_1.actors_["1072ui_story"].transform.localPosition
			end

			local var_362_0 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 then
				arg_359_1.actors_["1072ui_story"].transform.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1072ui_story, Vector3.New(0, -0.71, -6), (arg_359_1.time_ - 0) / var_362_0)
				arg_359_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1072ui_story"].transform.position).z)
				arg_359_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1072ui_story"].transform.localEulerAngles = arg_359_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 then
				arg_359_1.actors_["1072ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_359_1.actors_["1072ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_359_1.actors_["1072ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1072ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_359_1.actors_["1072ui_story"].transform.position).z)
				arg_359_1.actors_["1072ui_story"].transform.localEulerAngles.z = 0
				arg_359_1.actors_["1072ui_story"].transform.localEulerAngles.x = 0
				arg_359_1.actors_["1072ui_story"].transform.localEulerAngles = arg_359_1.actors_["1072ui_story"].transform.localEulerAngles
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_362_1 = 0
			local var_362_2 = 1.175

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_3 = arg_359_1:GetWordFromCfg(120421087)
				local var_362_4 = arg_359_1:FormatText(var_362_3.content)

				arg_359_1.text_.text = var_362_4

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_6 = 47 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_4) / 47)

				if (47 <= 0 and var_362_2 or var_362_2 * (utf8.len(var_362_4) / 47)) > 0 and var_362_2 < var_362_6 then
					arg_359_1.talkMaxDuration = var_362_6

					if var_362_6 + var_362_1 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_6 + var_362_1
					end
				end

				arg_359_1.text_.text = var_362_4
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421087", "story_v_out_120421.awb") ~= 0 then
					local var_362_7 = manager.audio:GetVoiceLength("story_v_out_120421", "120421087", "story_v_out_120421.awb") / 1000

					if var_362_7 + var_362_1 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_1
					end

					if var_362_3.prefab_name ~= "" and arg_359_1.actors_[var_362_3.prefab_name] ~= nil then
						local var_362_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_3.prefab_name].transform, "story_v_out_120421", "120421087", "story_v_out_120421.awb")

						arg_359_1:RecordAudio("120421087", var_362_8)
						arg_359_1:RecordAudio("120421087", var_362_8)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_120421", "120421087", "story_v_out_120421.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_120421", "120421087", "story_v_out_120421.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_9 = math.max(var_362_2, arg_359_1.talkMaxDuration)

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_9 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_1) / var_362_9

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_1 + var_362_9 and arg_359_1.time_ < var_362_1 + var_362_9 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play120421088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 120421088
		arg_363_1.duration_ = 2

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play120421089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1074ui_story"]) and arg_363_1.var_.characterEffect1074ui_story == nil then
				arg_363_1.var_.characterEffect1074ui_story = arg_363_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1074ui_story"]) then
				if arg_363_1.var_.characterEffect1074ui_story and not isNil(arg_363_1.actors_["1074ui_story"]) then
					arg_363_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1074ui_story"]) and arg_363_1.var_.characterEffect1074ui_story then
				arg_363_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			local var_366_2 = arg_363_1.actors_["1074ui_story"].transform

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1074ui_story = var_366_2.localPosition
			end

			local var_366_3 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_3 then
				var_366_2.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_363_1.time_ - 0) / var_366_3)
				var_366_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_366_2.position).x, (manager.ui.mainCamera.transform.position - var_366_2.position).y, (manager.ui.mainCamera.transform.position - var_366_2.position).z)
				var_366_2.localEulerAngles.z = 0
				var_366_2.localEulerAngles.x = 0
				var_366_2.localEulerAngles = var_366_2.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_3 and arg_363_1.time_ < 0 + var_366_3 + arg_366_0 then
				var_366_2.localPosition = Vector3.New(0, -1.055, -6.12)
				var_366_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_366_2.position).x, (manager.ui.mainCamera.transform.position - var_366_2.position).y, (manager.ui.mainCamera.transform.position - var_366_2.position).z)
				var_366_2.localEulerAngles.z = 0
				var_366_2.localEulerAngles.x = 0
				var_366_2.localEulerAngles = var_366_2.localEulerAngles
			end

			local var_366_4 = arg_363_1.actors_["1072ui_story"].transform

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1072ui_story = var_366_4.localPosition
			end

			local var_366_5 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_5 then
				var_366_4.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1072ui_story, Vector3.New(0, 100, 0), (arg_363_1.time_ - 0) / var_366_5)
				var_366_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_366_4.position).x, (manager.ui.mainCamera.transform.position - var_366_4.position).y, (manager.ui.mainCamera.transform.position - var_366_4.position).z)
				var_366_4.localEulerAngles.z = 0
				var_366_4.localEulerAngles.x = 0
				var_366_4.localEulerAngles = var_366_4.localEulerAngles
			end

			if arg_363_1.time_ >= 0 + var_366_5 and arg_363_1.time_ < 0 + var_366_5 + arg_366_0 then
				var_366_4.localPosition = Vector3.New(0, 100, 0)
				var_366_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_366_4.position).x, (manager.ui.mainCamera.transform.position - var_366_4.position).y, (manager.ui.mainCamera.transform.position - var_366_4.position).z)
				var_366_4.localEulerAngles.z = 0
				var_366_4.localEulerAngles.x = 0
				var_366_4.localEulerAngles = var_366_4.localEulerAngles
			end

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				if arg_363_1.var_.characterEffect1072ui_story == nil then
					arg_363_1.var_.characterEffect1072ui_story = arg_363_1.actors_["1072ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_366_6 = arg_363_1.var_.characterEffect1072ui_story

				arg_363_1.var_.characterEffect1072ui_story.imageEffect:turnOff()

				var_366_6.interferenceEffect.enabled = false
				var_366_6.interferenceEffect.noise = 0.001
				var_366_6.interferenceEffect.simTimeScale = 1
				var_366_6.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_366_7 = 0
			local var_366_8 = 0.15

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_7 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_9 = arg_363_1:GetWordFromCfg(120421088)
				local var_366_10 = arg_363_1:FormatText(var_366_9.content)

				arg_363_1.text_.text = var_366_10

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_12 = 6 <= 0 and var_366_8 or var_366_8 * (utf8.len(var_366_10) / 6)

				if (6 <= 0 and var_366_8 or var_366_8 * (utf8.len(var_366_10) / 6)) > 0 and var_366_8 < var_366_12 then
					arg_363_1.talkMaxDuration = var_366_12

					if var_366_12 + var_366_7 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_12 + var_366_7
					end
				end

				arg_363_1.text_.text = var_366_10
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421088", "story_v_out_120421.awb") ~= 0 then
					local var_366_13 = manager.audio:GetVoiceLength("story_v_out_120421", "120421088", "story_v_out_120421.awb") / 1000

					if var_366_13 + var_366_7 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_13 + var_366_7
					end

					if var_366_9.prefab_name ~= "" and arg_363_1.actors_[var_366_9.prefab_name] ~= nil then
						local var_366_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_9.prefab_name].transform, "story_v_out_120421", "120421088", "story_v_out_120421.awb")

						arg_363_1:RecordAudio("120421088", var_366_14)
						arg_363_1:RecordAudio("120421088", var_366_14)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_120421", "120421088", "story_v_out_120421.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_120421", "120421088", "story_v_out_120421.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_15 = math.max(var_366_8, arg_363_1.talkMaxDuration)

			if var_366_7 <= arg_363_1.time_ and arg_363_1.time_ < var_366_7 + var_366_15 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_7) / var_366_15

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_7 + var_366_15 and arg_363_1.time_ < var_366_7 + var_366_15 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play120421089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 120421089
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play120421090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1074ui_story = arg_367_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_370_0 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				arg_367_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1074ui_story"].transform.position).z)
				arg_367_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1074ui_story"].transform.localEulerAngles = arg_367_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				arg_367_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_367_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["1074ui_story"].transform.position).z)
				arg_367_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["1074ui_story"].transform.localEulerAngles = arg_367_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_370_1 = 0
			local var_370_2 = 0.75

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_3 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(120421089).content)

				arg_367_1.text_.text = var_370_3

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_5 = 30 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_3) / 30)

				if (30 <= 0 and var_370_2 or var_370_2 * (utf8.len(var_370_3) / 30)) > 0 and var_370_2 < var_370_5 then
					arg_367_1.talkMaxDuration = var_370_5

					if var_370_5 + var_370_1 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + var_370_1
					end
				end

				arg_367_1.text_.text = var_370_3
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_6 = math.max(var_370_2, arg_367_1.talkMaxDuration)

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_6 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_1) / var_370_6

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_1 + var_370_6 and arg_367_1.time_ < var_370_1 + var_370_6 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play120421090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 120421090
		arg_371_1.duration_ = 9

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play120421091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 2 < arg_371_1.time_ and arg_371_1.time_ <= 2 + arg_374_0 then
				local var_374_0 = arg_371_1.bgs_.ST29

				arg_371_1.bgs_.ST29.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_374_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_374_1 = var_374_0:GetComponent("SpriteRenderer")

				if var_374_1 and var_374_1.sprite then
					local var_374_2 = 2 * (var_374_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_374_0.transform.localScale = Vector3.New(var_374_2 / var_374_1.sprite.bounds.size.y < var_374_2 * manager.ui.mainCameraCom_.aspect / var_374_1.sprite.bounds.size.x and var_374_2 * manager.ui.mainCameraCom_.aspect / var_374_1.sprite.bounds.size.x or var_374_2 / var_374_1.sprite.bounds.size.y, var_374_2 / var_374_1.sprite.bounds.size.y < var_374_2 * manager.ui.mainCameraCom_.aspect / var_374_1.sprite.bounds.size.x and var_374_2 * manager.ui.mainCameraCom_.aspect / var_374_1.sprite.bounds.size.x or var_374_2 / var_374_1.sprite.bounds.size.y, 0)
				end

				for iter_374_0, iter_374_1 in pairs(arg_371_1.bgs_) do
					if iter_374_0 ~= "ST29" then
						iter_374_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_374_3 = 0

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_3 + arg_374_0 then
				arg_371_1.mask_.enabled = true
				arg_371_1.mask_.raycastTarget = true

				arg_371_1:SetGaussion(false)
			end

			local var_374_4 = 2

			if var_374_3 <= arg_371_1.time_ and arg_371_1.time_ < var_374_3 + var_374_4 then
				local var_374_5 = Color.New(0, 0, 0)

				var_374_5.a = Mathf.Lerp(0, 1, (arg_371_1.time_ - var_374_3) / var_374_4)
				arg_371_1.mask_.color = var_374_5
			end

			if arg_371_1.time_ >= var_374_3 + var_374_4 and arg_371_1.time_ < var_374_3 + var_374_4 + arg_374_0 then
				local var_374_6 = Color.New(0, 0, 0)

				var_374_6.a = 1
				arg_371_1.mask_.color = var_374_6
			end

			local var_374_7 = 2

			if 2 < arg_371_1.time_ and arg_371_1.time_ <= var_374_7 + arg_374_0 then
				arg_371_1.mask_.enabled = true
				arg_371_1.mask_.raycastTarget = true

				arg_371_1:SetGaussion(false)
			end

			local var_374_8 = 2

			if var_374_7 <= arg_371_1.time_ and arg_371_1.time_ < var_374_7 + var_374_8 then
				local var_374_9 = Color.New(0, 0, 0)

				var_374_9.a = Mathf.Lerp(1, 0, (arg_371_1.time_ - var_374_7) / var_374_8)
				arg_371_1.mask_.color = var_374_9
			end

			if arg_371_1.time_ >= var_374_7 + var_374_8 and arg_371_1.time_ < var_374_7 + var_374_8 + arg_374_0 then
				local var_374_10 = Color.New(0, 0, 0)

				arg_371_1.mask_.enabled = false
				var_374_10.a = 0
				arg_371_1.mask_.color = var_374_10
			end

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_374_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_371_1.bgmTxt_.text ~= var_374_13 and arg_371_1.bgmTxt_.text ~= "" then
						if arg_371_1.bgmTxt2_.text ~= "" then
							arg_371_1.bgmTxt_.text = arg_371_1.bgmTxt2_.text
						end

						arg_371_1.bgmTxt2_.text = var_374_13

						arg_371_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_371_1.bgmTxt_.text = var_374_13
						arg_371_1.bgmTxt2_.text = var_374_13
					end

					if arg_371_1.bgmTimer then
						arg_371_1.bgmTimer:Stop()

						arg_371_1.bgmTimer = nil
					end

					if arg_371_1.settingData.show_music_name == 1 then
						arg_371_1.musicController:SetSelectedState("show")
						arg_371_1.musicAnimator_:Play("open", 0, 0)

						if arg_371_1.settingData.music_time ~= 0 then
							arg_371_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_371_1.settingData.music_time), function()
								if arg_371_1 == nil or isNil(arg_371_1.bgmTxt_) then
									return
								end

								arg_371_1.musicController:SetSelectedState("hide")
								arg_371_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_371_1.frameCnt_ <= 1 then
				arg_371_1.dialog_:SetActive(false)
			end

			local var_374_14 = 4
			local var_374_15 = 1.15

			if 4 < arg_371_1.time_ and arg_371_1.time_ <= var_374_14 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0

				arg_371_1.dialog_:SetActive(true)

				arg_371_1.dialogCg_.alpha = 0

				local var_374_16 = LeanTween.value(arg_371_1.dialog_, 0, 1, 0.3)

				var_374_16:setOnUpdate(LuaHelper.FloatAction(function(arg_376_0)
					arg_371_1.dialogCg_.alpha = arg_376_0
				end))
				var_374_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_371_1.dialog_)
					var_374_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_371_1.duration_ = arg_371_1.duration_ + 0.3

				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_17 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(120421090).content)

				arg_371_1.text_.text = var_374_17

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_19 = 46 <= 0 and var_374_15 or var_374_15 * (utf8.len(var_374_17) / 46)

				if (46 <= 0 and var_374_15 or var_374_15 * (utf8.len(var_374_17) / 46)) > 0 and var_374_15 < var_374_19 then
					arg_371_1.talkMaxDuration = var_374_19
					var_374_14 = var_374_14 + 0.3

					if var_374_19 + var_374_14 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_19 + var_374_14
					end
				end

				arg_371_1.text_.text = var_374_17
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_20 = var_374_14 + 0.3
			local var_374_21 = math.max(var_374_15, arg_371_1.talkMaxDuration)

			if var_374_14 + 0.3 <= arg_371_1.time_ and arg_371_1.time_ < var_374_20 + var_374_21 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_20) / var_374_21

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_20 + var_374_21 and arg_371_1.time_ < var_374_20 + var_374_21 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play120421091 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 120421091
		arg_378_1.duration_ = 3.63

		local var_378_0 = {
			zh = 2.366,
			ja = 3.633
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play120421092(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.var_.moveOldPos1074ui_story = arg_378_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_381_0 = 0.001

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_0 then
				arg_378_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_378_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_378_1.time_ - 0) / var_381_0)
				arg_378_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1074ui_story"].transform.position).z)
				arg_378_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["1074ui_story"].transform.localEulerAngles = arg_378_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_378_1.time_ >= 0 + var_381_0 and arg_378_1.time_ < 0 + var_381_0 + arg_381_0 then
				arg_378_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.12)
				arg_378_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_378_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_378_1.actors_["1074ui_story"].transform.position).z)
				arg_378_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_378_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_378_1.actors_["1074ui_story"].transform.localEulerAngles = arg_378_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_381_1 = arg_378_1.actors_["1074ui_story"]

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 and not isNil(var_381_1) and arg_378_1.var_.characterEffect1074ui_story == nil then
				arg_378_1.var_.characterEffect1074ui_story = var_381_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_381_2 = 0.2

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_2 and not isNil(var_381_1) then
				if arg_378_1.var_.characterEffect1074ui_story and not isNil(var_381_1) then
					arg_378_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_378_1.time_ >= 0 + var_381_2 and arg_378_1.time_ < 0 + var_381_2 + arg_381_0 and not isNil(var_381_1) and arg_378_1.var_.characterEffect1074ui_story then
				arg_378_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_381_4 = 0
			local var_381_5 = 0.175

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_4 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_6 = arg_378_1:GetWordFromCfg(120421091)
				local var_381_7 = arg_378_1:FormatText(var_381_6.content)

				arg_378_1.text_.text = var_381_7

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_9 = 7 <= 0 and var_381_5 or var_381_5 * (utf8.len(var_381_7) / 7)

				if (7 <= 0 and var_381_5 or var_381_5 * (utf8.len(var_381_7) / 7)) > 0 and var_381_5 < var_381_9 then
					arg_378_1.talkMaxDuration = var_381_9

					if var_381_9 + var_381_4 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_9 + var_381_4
					end
				end

				arg_378_1.text_.text = var_381_7
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421091", "story_v_out_120421.awb") ~= 0 then
					local var_381_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421091", "story_v_out_120421.awb") / 1000

					if var_381_10 + var_381_4 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_10 + var_381_4
					end

					if var_381_6.prefab_name ~= "" and arg_378_1.actors_[var_381_6.prefab_name] ~= nil then
						local var_381_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_6.prefab_name].transform, "story_v_out_120421", "120421091", "story_v_out_120421.awb")

						arg_378_1:RecordAudio("120421091", var_381_11)
						arg_378_1:RecordAudio("120421091", var_381_11)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_120421", "120421091", "story_v_out_120421.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_120421", "120421091", "story_v_out_120421.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_12 = math.max(var_381_5, arg_378_1.talkMaxDuration)

			if var_381_4 <= arg_378_1.time_ and arg_378_1.time_ < var_381_4 + var_381_12 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_4) / var_381_12

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_4 + var_381_12 and arg_378_1.time_ < var_381_4 + var_381_12 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_378_1:InitPlayNodeList()
	end,
	Play120421092 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 120421092
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play120421093(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.var_.moveOldPos1074ui_story = arg_382_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_385_0 = 0.001

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 then
				arg_382_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_382_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_382_1.time_ - 0) / var_385_0)
				arg_382_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1074ui_story"].transform.position).z)
				arg_382_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["1074ui_story"].transform.localEulerAngles = arg_382_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 then
				arg_382_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_382_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_382_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_382_1.actors_["1074ui_story"].transform.position).z)
				arg_382_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_382_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_382_1.actors_["1074ui_story"].transform.localEulerAngles = arg_382_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_385_1 = 0
			local var_385_2 = 1.2

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_1 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_3 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(120421092).content)

				arg_382_1.text_.text = var_385_3

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 48 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 48)

				if (48 <= 0 and var_385_2 or var_385_2 * (utf8.len(var_385_3) / 48)) > 0 and var_385_2 < var_385_5 then
					arg_382_1.talkMaxDuration = var_385_5

					if var_385_5 + var_385_1 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_5 + var_385_1
					end
				end

				arg_382_1.text_.text = var_385_3
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_6 = math.max(var_385_2, arg_382_1.talkMaxDuration)

			if var_385_1 <= arg_382_1.time_ and arg_382_1.time_ < var_385_1 + var_385_6 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_1) / var_385_6

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_1 + var_385_6 and arg_382_1.time_ < var_385_1 + var_385_6 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_382_1:InitPlayNodeList()
	end,
	Play120421093 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 120421093
		arg_386_1.duration_ = 2

		local var_386_0 = {
			zh = 2,
			ja = 0.999999999999
		}
		local var_386_1 = manager.audio:GetLocalizationFlag()

		if var_386_0[var_386_1] ~= nil then
			arg_386_1.duration_ = var_386_0[var_386_1]
		end

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play120421094(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0.075

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1074")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_1 = arg_386_1:GetWordFromCfg(120421093)
				local var_389_2 = arg_386_1:FormatText(var_389_1.content)

				arg_386_1.text_.text = var_389_2

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_4 = 3 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_2) / 3)

				if (3 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_2) / 3)) > 0 and var_389_0 < var_389_4 then
					arg_386_1.talkMaxDuration = var_389_4

					if var_389_4 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_4 + 0
					end
				end

				arg_386_1.text_.text = var_389_2
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421093", "story_v_out_120421.awb") ~= 0 then
					local var_389_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421093", "story_v_out_120421.awb") / 1000

					if var_389_5 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + 0
					end

					if var_389_1.prefab_name ~= "" and arg_386_1.actors_[var_389_1.prefab_name] ~= nil then
						local var_389_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_1.prefab_name].transform, "story_v_out_120421", "120421093", "story_v_out_120421.awb")

						arg_386_1:RecordAudio("120421093", var_389_6)
						arg_386_1:RecordAudio("120421093", var_389_6)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_120421", "120421093", "story_v_out_120421.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_120421", "120421093", "story_v_out_120421.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_7 = math.max(var_389_0, arg_386_1.talkMaxDuration)

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_7 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - 0) / var_389_7

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= 0 + var_389_7 and arg_386_1.time_ < 0 + var_389_7 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play120421094 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 120421094
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play120421095(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 1.2

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_1 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(120421094).content)

				arg_390_1.text_.text = var_393_1

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_3 = 48 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 48)

				if (48 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 48)) > 0 and var_393_0 < var_393_3 then
					arg_390_1.talkMaxDuration = var_393_3

					if var_393_3 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_3 + 0
					end
				end

				arg_390_1.text_.text = var_393_1
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_4 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_4

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play120421095 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 120421095
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play120421096(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.525

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

				local var_397_1 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(120421095).content)

				arg_394_1.text_.text = var_397_1

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_3 = 21 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 21)

				if (21 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 21)) > 0 and var_397_0 < var_397_3 then
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
	Play120421096 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 120421096
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play120421097(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				local var_401_0 = arg_398_1.bgs_.ST37

				arg_398_1.bgs_.ST37.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_401_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_401_1 = var_401_0:GetComponent("SpriteRenderer")

				if var_401_1 and var_401_1.sprite then
					local var_401_2 = 2 * (var_401_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_401_0.transform.localScale = Vector3.New(var_401_2 / var_401_1.sprite.bounds.size.y < var_401_2 * manager.ui.mainCameraCom_.aspect / var_401_1.sprite.bounds.size.x and var_401_2 * manager.ui.mainCameraCom_.aspect / var_401_1.sprite.bounds.size.x or var_401_2 / var_401_1.sprite.bounds.size.y, var_401_2 / var_401_1.sprite.bounds.size.y < var_401_2 * manager.ui.mainCameraCom_.aspect / var_401_1.sprite.bounds.size.x and var_401_2 * manager.ui.mainCameraCom_.aspect / var_401_1.sprite.bounds.size.x or var_401_2 / var_401_1.sprite.bounds.size.y, 0)
				end

				for iter_401_0, iter_401_1 in pairs(arg_398_1.bgs_) do
					if iter_401_0 ~= "ST37" then
						iter_401_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_401_3 = 0

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_3 + arg_401_0 then
				arg_398_1.mask_.enabled = true
				arg_398_1.mask_.raycastTarget = true

				arg_398_1:SetGaussion(false)
			end

			local var_401_4 = 2

			if var_401_3 <= arg_398_1.time_ and arg_398_1.time_ < var_401_3 + var_401_4 then
				local var_401_5 = Color.New(1, 1, 1)

				var_401_5.a = Mathf.Lerp(1, 0, (arg_398_1.time_ - var_401_3) / var_401_4)
				arg_398_1.mask_.color = var_401_5
			end

			if arg_398_1.time_ >= var_401_3 + var_401_4 and arg_398_1.time_ < var_401_3 + var_401_4 + arg_401_0 then
				local var_401_6 = Color.New(1, 1, 1)

				arg_398_1.mask_.enabled = false
				var_401_6.a = 0
				arg_398_1.mask_.color = var_401_6
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_dooropen", "")
			end

			local var_401_8 = 0
			local var_401_9 = 0.05

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_8 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_10 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(120421096).content)

				arg_398_1.text_.text = var_401_10

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_12 = 2 <= 0 and var_401_9 or var_401_9 * (utf8.len(var_401_10) / 2)

				if (2 <= 0 and var_401_9 or var_401_9 * (utf8.len(var_401_10) / 2)) > 0 and var_401_9 < var_401_12 then
					arg_398_1.talkMaxDuration = var_401_12

					if var_401_12 + var_401_8 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_12 + var_401_8
					end
				end

				arg_398_1.text_.text = var_401_10
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_13 = math.max(var_401_9, arg_398_1.talkMaxDuration)

			if var_401_8 <= arg_398_1.time_ and arg_398_1.time_ < var_401_8 + var_401_13 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_8) / var_401_13

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_8 + var_401_13 and arg_398_1.time_ < var_401_8 + var_401_13 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play120421097 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 120421097
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play120421098(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 1.075

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, false)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_1 = arg_402_1:FormatText(arg_402_1:GetWordFromCfg(120421097).content)

				arg_402_1.text_.text = var_405_1

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_3 = 43 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_1) / 43)

				if (43 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_1) / 43)) > 0 and var_405_0 < var_405_3 then
					arg_402_1.talkMaxDuration = var_405_3

					if var_405_3 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_3 + 0
					end
				end

				arg_402_1.text_.text = var_405_1
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_4 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_4 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_4

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_4 and arg_402_1.time_ < 0 + var_405_4 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play120421098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 120421098
		arg_406_1.duration_ = 4.47

		local var_406_0 = {
			zh = 4.466,
			ja = 3.566
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play120421099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.var_.moveOldPos1074ui_story = arg_406_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_409_0 = 0.001

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 then
				arg_406_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_406_1.var_.moveOldPos1074ui_story, Vector3.New(0, -1.055, -6.12), (arg_406_1.time_ - 0) / var_409_0)
				arg_406_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_406_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1074ui_story"].transform.position).z)
				arg_406_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_406_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_406_1.actors_["1074ui_story"].transform.localEulerAngles = arg_406_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 then
				arg_406_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(0, -1.055, -6.12)
				arg_406_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_406_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_406_1.actors_["1074ui_story"].transform.position).z)
				arg_406_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_406_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_406_1.actors_["1074ui_story"].transform.localEulerAngles = arg_406_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_409_1 = arg_406_1.actors_["1074ui_story"]

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(var_409_1) and arg_406_1.var_.characterEffect1074ui_story == nil then
				arg_406_1.var_.characterEffect1074ui_story = var_409_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_2 = 0.2

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_2 and not isNil(var_409_1) then
				if arg_406_1.var_.characterEffect1074ui_story and not isNil(var_409_1) then
					arg_406_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= 0 + var_409_2 and arg_406_1.time_ < 0 + var_409_2 + arg_409_0 and not isNil(var_409_1) and arg_406_1.var_.characterEffect1074ui_story then
				arg_406_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_409_4 = 0
			local var_409_5 = 0.1

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_4 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[400].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_6 = arg_406_1:GetWordFromCfg(120421098)
				local var_409_7 = arg_406_1:FormatText(var_409_6.content)

				arg_406_1.text_.text = var_409_7

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_9 = 4 <= 0 and var_409_5 or var_409_5 * (utf8.len(var_409_7) / 4)

				if (4 <= 0 and var_409_5 or var_409_5 * (utf8.len(var_409_7) / 4)) > 0 and var_409_5 < var_409_9 then
					arg_406_1.talkMaxDuration = var_409_9

					if var_409_9 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_9 + var_409_4
					end
				end

				arg_406_1.text_.text = var_409_7
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421098", "story_v_out_120421.awb") ~= 0 then
					local var_409_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421098", "story_v_out_120421.awb") / 1000

					if var_409_10 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_10 + var_409_4
					end

					if var_409_6.prefab_name ~= "" and arg_406_1.actors_[var_409_6.prefab_name] ~= nil then
						local var_409_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_6.prefab_name].transform, "story_v_out_120421", "120421098", "story_v_out_120421.awb")

						arg_406_1:RecordAudio("120421098", var_409_11)
						arg_406_1:RecordAudio("120421098", var_409_11)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_120421", "120421098", "story_v_out_120421.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_120421", "120421098", "story_v_out_120421.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_12 = math.max(var_409_5, arg_406_1.talkMaxDuration)

			if var_409_4 <= arg_406_1.time_ and arg_406_1.time_ < var_409_4 + var_409_12 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_4) / var_409_12

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_4 + var_409_12 and arg_406_1.time_ < var_409_4 + var_409_12 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_406_1:InitPlayNodeList()
	end,
	Play120421099 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 120421099
		arg_410_1.duration_ = 5

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play120421100(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 and not isNil(arg_410_1.actors_["1074ui_story"]) and arg_410_1.var_.characterEffect1074ui_story == nil then
				arg_410_1.var_.characterEffect1074ui_story = arg_410_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_413_0 = 0.2

			if 0 <= arg_410_1.time_ and arg_410_1.time_ < 0 + var_413_0 and not isNil(arg_410_1.actors_["1074ui_story"]) then
				if arg_410_1.var_.characterEffect1074ui_story and not isNil(arg_410_1.actors_["1074ui_story"]) then
					arg_410_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_410_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_410_1.time_ - 0) / var_413_0)
				end
			end

			if arg_410_1.time_ >= 0 + var_413_0 and arg_410_1.time_ < 0 + var_413_0 + arg_413_0 and not isNil(arg_410_1.actors_["1074ui_story"]) and arg_410_1.var_.characterEffect1074ui_story then
				arg_410_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_410_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_413_1 = 0
			local var_413_2 = 0.725

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_1 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, false)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_3 = arg_410_1:FormatText(arg_410_1:GetWordFromCfg(120421099).content)

				arg_410_1.text_.text = var_413_3

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 29 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 29)

				if (29 <= 0 and var_413_2 or var_413_2 * (utf8.len(var_413_3) / 29)) > 0 and var_413_2 < var_413_5 then
					arg_410_1.talkMaxDuration = var_413_5

					if var_413_5 + var_413_1 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + var_413_1
					end
				end

				arg_410_1.text_.text = var_413_3
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)
				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_6 = math.max(var_413_2, arg_410_1.talkMaxDuration)

			if var_413_1 <= arg_410_1.time_ and arg_410_1.time_ < var_413_1 + var_413_6 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_1) / var_413_6

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_1 + var_413_6 and arg_410_1.time_ < var_413_1 + var_413_6 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play120421100 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 120421100
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play120421101(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_417_2 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

				if "" ~= "" then
					if arg_414_1.bgmTxt_.text ~= var_417_2 and arg_414_1.bgmTxt_.text ~= "" then
						if arg_414_1.bgmTxt2_.text ~= "" then
							arg_414_1.bgmTxt_.text = arg_414_1.bgmTxt2_.text
						end

						arg_414_1.bgmTxt2_.text = var_417_2

						arg_414_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_414_1.bgmTxt_.text = var_417_2
						arg_414_1.bgmTxt2_.text = var_417_2
					end

					if arg_414_1.bgmTimer then
						arg_414_1.bgmTimer:Stop()

						arg_414_1.bgmTimer = nil
					end

					if arg_414_1.settingData.show_music_name == 1 then
						arg_414_1.musicController:SetSelectedState("show")
						arg_414_1.musicAnimator_:Play("open", 0, 0)

						if arg_414_1.settingData.music_time ~= 0 then
							arg_414_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_414_1.settingData.music_time), function()
								if arg_414_1 == nil or isNil(arg_414_1.bgmTxt_) then
									return
								end

								arg_414_1.musicController:SetSelectedState("hide")
								arg_414_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_417_3 = 0
			local var_417_4 = 1.55

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_3 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_5 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(120421100).content)

				arg_414_1.text_.text = var_417_5

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_7 = 62 <= 0 and var_417_4 or var_417_4 * (utf8.len(var_417_5) / 62)

				if (62 <= 0 and var_417_4 or var_417_4 * (utf8.len(var_417_5) / 62)) > 0 and var_417_4 < var_417_7 then
					arg_414_1.talkMaxDuration = var_417_7

					if var_417_7 + var_417_3 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_7 + var_417_3
					end
				end

				arg_414_1.text_.text = var_417_5
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_8 = math.max(var_417_4, arg_414_1.talkMaxDuration)

			if var_417_3 <= arg_414_1.time_ and arg_414_1.time_ < var_417_3 + var_417_8 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_3) / var_417_8

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_3 + var_417_8 and arg_414_1.time_ < var_417_3 + var_417_8 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play120421101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 120421101
		arg_419_1.duration_ = 2.53

		local var_419_0 = {
			zh = 2.399999999999,
			ja = 2.533
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play120421102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos1074ui_story = arg_419_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_422_0 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 then
				arg_419_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_419_1.time_ - 0) / var_422_0)
				arg_419_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1074ui_story"].transform.position).z)
				arg_419_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1074ui_story"].transform.localEulerAngles = arg_419_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 then
				arg_419_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_419_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1074ui_story"].transform.position).z)
				arg_419_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1074ui_story"].transform.localEulerAngles = arg_419_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_422_1 = "10044ui_story"

			if arg_419_1.actors_["10044ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10044ui_story"))) then
				local var_422_2 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_419_1.stage_.transform)

				var_422_2.name = var_422_1
				var_422_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_419_1.actors_[var_422_1] = var_422_2

				local var_422_3 = var_422_2:GetComponentInChildren(typeof(CharacterEffect))

				var_422_3.enabled = true

				local var_422_4 = GameObjectTools.GetOrAddComponent(var_422_2, typeof(DynamicBoneHelper))

				if var_422_4 then
					var_422_4:EnableDynamicBone(false)
				end

				arg_419_1:ShowWeapon(var_422_3.transform, false)

				arg_419_1.var_[var_422_1 .. "Animator"] = var_422_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_419_1.var_[var_422_1 .. "Animator"].applyRootMotion = true
				arg_419_1.var_[var_422_1 .. "LipSync"] = var_422_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_422_5 = arg_419_1.actors_["10044ui_story"].transform

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos10044ui_story = var_422_5.localPosition
			end

			local var_422_6 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_6 then
				var_422_5.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos10044ui_story, Vector3.New(0.7, -0.72, -6.3), (arg_419_1.time_ - 0) / var_422_6)
				var_422_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_422_5.position).x, (manager.ui.mainCamera.transform.position - var_422_5.position).y, (manager.ui.mainCamera.transform.position - var_422_5.position).z)
				var_422_5.localEulerAngles.z = 0
				var_422_5.localEulerAngles.x = 0
				var_422_5.localEulerAngles = var_422_5.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_6 and arg_419_1.time_ < 0 + var_422_6 + arg_422_0 then
				var_422_5.localPosition = Vector3.New(0.7, -0.72, -6.3)
				var_422_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_422_5.position).x, (manager.ui.mainCamera.transform.position - var_422_5.position).y, (manager.ui.mainCamera.transform.position - var_422_5.position).z)
				var_422_5.localEulerAngles.z = 0
				var_422_5.localEulerAngles.x = 0
				var_422_5.localEulerAngles = var_422_5.localEulerAngles
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_422_7 = arg_419_1.actors_["10044ui_story"]

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(var_422_7) and arg_419_1.var_.characterEffect10044ui_story == nil then
				arg_419_1.var_.characterEffect10044ui_story = var_422_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_8 = 0.2

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_8 and not isNil(var_422_7) then
				if arg_419_1.var_.characterEffect10044ui_story and not isNil(var_422_7) then
					arg_419_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_8 and arg_419_1.time_ < 0 + var_422_8 + arg_422_0 and not isNil(var_422_7) and arg_419_1.var_.characterEffect10044ui_story then
				arg_419_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_422_10 = 0
			local var_422_11 = 0.05

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_10 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_12 = arg_419_1:GetWordFromCfg(120421101)
				local var_422_13 = arg_419_1:FormatText(var_422_12.content)

				arg_419_1.text_.text = var_422_13

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_15 = 2 <= 0 and var_422_11 or var_422_11 * (utf8.len(var_422_13) / 2)

				if (2 <= 0 and var_422_11 or var_422_11 * (utf8.len(var_422_13) / 2)) > 0 and var_422_11 < var_422_15 then
					arg_419_1.talkMaxDuration = var_422_15

					if var_422_15 + var_422_10 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_15 + var_422_10
					end
				end

				arg_419_1.text_.text = var_422_13
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421101", "story_v_out_120421.awb") ~= 0 then
					local var_422_16 = manager.audio:GetVoiceLength("story_v_out_120421", "120421101", "story_v_out_120421.awb") / 1000

					if var_422_16 + var_422_10 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_16 + var_422_10
					end

					if var_422_12.prefab_name ~= "" and arg_419_1.actors_[var_422_12.prefab_name] ~= nil then
						local var_422_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_12.prefab_name].transform, "story_v_out_120421", "120421101", "story_v_out_120421.awb")

						arg_419_1:RecordAudio("120421101", var_422_17)
						arg_419_1:RecordAudio("120421101", var_422_17)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_120421", "120421101", "story_v_out_120421.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_120421", "120421101", "story_v_out_120421.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_18 = math.max(var_422_11, arg_419_1.talkMaxDuration)

			if var_422_10 <= arg_419_1.time_ and arg_419_1.time_ < var_422_10 + var_422_18 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_10) / var_422_18

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_10 + var_422_18 and arg_419_1.time_ < var_422_10 + var_422_18 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play120421102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 120421102
		arg_423_1.duration_ = 12.3

		local var_423_0 = {
			zh = 5.4,
			ja = 12.3
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play120421103(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["10044ui_story"]) and arg_423_1.var_.characterEffect10044ui_story == nil then
				arg_423_1.var_.characterEffect10044ui_story = arg_423_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["10044ui_story"]) then
				if arg_423_1.var_.characterEffect10044ui_story and not isNil(arg_423_1.actors_["10044ui_story"]) then
					arg_423_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_423_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_0)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["10044ui_story"]) and arg_423_1.var_.characterEffect10044ui_story then
				arg_423_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_423_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_426_1 = arg_423_1.actors_["1074ui_story"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1074ui_story == nil then
				arg_423_1.var_.characterEffect1074ui_story = var_426_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_2 and not isNil(var_426_1) then
				if arg_423_1.var_.characterEffect1074ui_story and not isNil(var_426_1) then
					arg_423_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_423_1.time_ >= 0 + var_426_2 and arg_423_1.time_ < 0 + var_426_2 + arg_426_0 and not isNil(var_426_1) and arg_423_1.var_.characterEffect1074ui_story then
				arg_423_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_426_4 = 0
			local var_426_5 = 0.4

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_4 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_6 = arg_423_1:GetWordFromCfg(120421102)
				local var_426_7 = arg_423_1:FormatText(var_426_6.content)

				arg_423_1.text_.text = var_426_7

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_9 = 16 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 16)

				if (16 <= 0 and var_426_5 or var_426_5 * (utf8.len(var_426_7) / 16)) > 0 and var_426_5 < var_426_9 then
					arg_423_1.talkMaxDuration = var_426_9

					if var_426_9 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_9 + var_426_4
					end
				end

				arg_423_1.text_.text = var_426_7
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421102", "story_v_out_120421.awb") ~= 0 then
					local var_426_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421102", "story_v_out_120421.awb") / 1000

					if var_426_10 + var_426_4 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_10 + var_426_4
					end

					if var_426_6.prefab_name ~= "" and arg_423_1.actors_[var_426_6.prefab_name] ~= nil then
						local var_426_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_6.prefab_name].transform, "story_v_out_120421", "120421102", "story_v_out_120421.awb")

						arg_423_1:RecordAudio("120421102", var_426_11)
						arg_423_1:RecordAudio("120421102", var_426_11)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_120421", "120421102", "story_v_out_120421.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_120421", "120421102", "story_v_out_120421.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_12 = math.max(var_426_5, arg_423_1.talkMaxDuration)

			if var_426_4 <= arg_423_1.time_ and arg_423_1.time_ < var_426_4 + var_426_12 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_4) / var_426_12

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_4 + var_426_12 and arg_423_1.time_ < var_426_4 + var_426_12 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play120421103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 120421103
		arg_427_1.duration_ = 7.93

		local var_427_0 = {
			zh = 4.233,
			ja = 7.933
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play120421104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos10044ui_story = arg_427_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_430_0 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 then
				arg_427_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_427_1.time_ - 0) / var_430_0)
				arg_427_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["10044ui_story"].transform.position).z)
				arg_427_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["10044ui_story"].transform.localEulerAngles = arg_427_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 then
				arg_427_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_427_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["10044ui_story"].transform.position).z)
				arg_427_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["10044ui_story"].transform.localEulerAngles = arg_427_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_430_1 = arg_427_1.actors_["1074ui_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1074ui_story == nil then
				arg_427_1.var_.characterEffect1074ui_story = var_430_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.2

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_2 and not isNil(var_430_1) then
				if arg_427_1.var_.characterEffect1074ui_story and not isNil(var_430_1) then
					arg_427_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_427_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_427_1.time_ - 0) / var_430_2)
				end
			end

			if arg_427_1.time_ >= 0 + var_430_2 and arg_427_1.time_ < 0 + var_430_2 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1074ui_story then
				arg_427_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_427_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_430_3 = arg_427_1.actors_["1075ui_story"].transform

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos1075ui_story = var_430_3.localPosition
			end

			local var_430_4 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_4 then
				var_430_3.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_427_1.time_ - 0) / var_430_4)
				var_430_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_430_3.position).x, (manager.ui.mainCamera.transform.position - var_430_3.position).y, (manager.ui.mainCamera.transform.position - var_430_3.position).z)
				var_430_3.localEulerAngles.z = 0
				var_430_3.localEulerAngles.x = 0
				var_430_3.localEulerAngles = var_430_3.localEulerAngles
			end

			if arg_427_1.time_ >= 0 + var_430_4 and arg_427_1.time_ < 0 + var_430_4 + arg_430_0 then
				var_430_3.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_430_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_430_3.position).x, (manager.ui.mainCamera.transform.position - var_430_3.position).y, (manager.ui.mainCamera.transform.position - var_430_3.position).z)
				var_430_3.localEulerAngles.z = 0
				var_430_3.localEulerAngles.x = 0
				var_430_3.localEulerAngles = var_430_3.localEulerAngles
			end

			local var_430_5 = arg_427_1.actors_["1075ui_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_5) and arg_427_1.var_.characterEffect1075ui_story == nil then
				arg_427_1.var_.characterEffect1075ui_story = var_430_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_6 = 0.2

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_6 and not isNil(var_430_5) then
				if arg_427_1.var_.characterEffect1075ui_story and not isNil(var_430_5) then
					arg_427_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_6 and arg_427_1.time_ < 0 + var_430_6 + arg_430_0 and not isNil(var_430_5) and arg_427_1.var_.characterEffect1075ui_story then
				arg_427_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_430_8 = 0
			local var_430_9 = 0.525

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_8 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_10 = arg_427_1:GetWordFromCfg(120421103)
				local var_430_11 = arg_427_1:FormatText(var_430_10.content)

				arg_427_1.text_.text = var_430_11

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_13 = 21 <= 0 and var_430_9 or var_430_9 * (utf8.len(var_430_11) / 21)

				if (21 <= 0 and var_430_9 or var_430_9 * (utf8.len(var_430_11) / 21)) > 0 and var_430_9 < var_430_13 then
					arg_427_1.talkMaxDuration = var_430_13

					if var_430_13 + var_430_8 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_13 + var_430_8
					end
				end

				arg_427_1.text_.text = var_430_11
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421103", "story_v_out_120421.awb") ~= 0 then
					local var_430_14 = manager.audio:GetVoiceLength("story_v_out_120421", "120421103", "story_v_out_120421.awb") / 1000

					if var_430_14 + var_430_8 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_14 + var_430_8
					end

					if var_430_10.prefab_name ~= "" and arg_427_1.actors_[var_430_10.prefab_name] ~= nil then
						local var_430_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_10.prefab_name].transform, "story_v_out_120421", "120421103", "story_v_out_120421.awb")

						arg_427_1:RecordAudio("120421103", var_430_15)
						arg_427_1:RecordAudio("120421103", var_430_15)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_120421", "120421103", "story_v_out_120421.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_120421", "120421103", "story_v_out_120421.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_16 = math.max(var_430_9, arg_427_1.talkMaxDuration)

			if var_430_8 <= arg_427_1.time_ and arg_427_1.time_ < var_430_8 + var_430_16 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_8) / var_430_16

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_8 + var_430_16 and arg_427_1.time_ < var_430_8 + var_430_16 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play120421104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 120421104
		arg_431_1.duration_ = 8.3

		local var_431_0 = {
			zh = 3.6,
			ja = 8.3
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play120421105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["1074ui_story"]) and arg_431_1.var_.characterEffect1074ui_story == nil then
				arg_431_1.var_.characterEffect1074ui_story = arg_431_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_0 = 0.2

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["1074ui_story"]) then
				if arg_431_1.var_.characterEffect1074ui_story and not isNil(arg_431_1.actors_["1074ui_story"]) then
					arg_431_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["1074ui_story"]) and arg_431_1.var_.characterEffect1074ui_story then
				arg_431_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_434_2 = arg_431_1.actors_["1075ui_story"]

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(var_434_2) and arg_431_1.var_.characterEffect1075ui_story == nil then
				arg_431_1.var_.characterEffect1075ui_story = var_434_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_3 = 0.2

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_3 and not isNil(var_434_2) then
				if arg_431_1.var_.characterEffect1075ui_story and not isNil(var_434_2) then
					arg_431_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_431_1.time_ - 0) / var_434_3)
				end
			end

			if arg_431_1.time_ >= 0 + var_434_3 and arg_431_1.time_ < 0 + var_434_3 + arg_434_0 and not isNil(var_434_2) and arg_431_1.var_.characterEffect1075ui_story then
				arg_431_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_434_4 = 0
			local var_434_5 = 0.4

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_4 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_6 = arg_431_1:GetWordFromCfg(120421104)
				local var_434_7 = arg_431_1:FormatText(var_434_6.content)

				arg_431_1.text_.text = var_434_7

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_9 = 16 <= 0 and var_434_5 or var_434_5 * (utf8.len(var_434_7) / 16)

				if (16 <= 0 and var_434_5 or var_434_5 * (utf8.len(var_434_7) / 16)) > 0 and var_434_5 < var_434_9 then
					arg_431_1.talkMaxDuration = var_434_9

					if var_434_9 + var_434_4 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_9 + var_434_4
					end
				end

				arg_431_1.text_.text = var_434_7
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421104", "story_v_out_120421.awb") ~= 0 then
					local var_434_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421104", "story_v_out_120421.awb") / 1000

					if var_434_10 + var_434_4 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_10 + var_434_4
					end

					if var_434_6.prefab_name ~= "" and arg_431_1.actors_[var_434_6.prefab_name] ~= nil then
						local var_434_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_6.prefab_name].transform, "story_v_out_120421", "120421104", "story_v_out_120421.awb")

						arg_431_1:RecordAudio("120421104", var_434_11)
						arg_431_1:RecordAudio("120421104", var_434_11)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_120421", "120421104", "story_v_out_120421.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_120421", "120421104", "story_v_out_120421.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_12 = math.max(var_434_5, arg_431_1.talkMaxDuration)

			if var_434_4 <= arg_431_1.time_ and arg_431_1.time_ < var_434_4 + var_434_12 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_4) / var_434_12

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_4 + var_434_12 and arg_431_1.time_ < var_434_4 + var_434_12 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play120421105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 120421105
		arg_435_1.duration_ = 5

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play120421106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["1074ui_story"]) and arg_435_1.var_.characterEffect1074ui_story == nil then
				arg_435_1.var_.characterEffect1074ui_story = arg_435_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["1074ui_story"]) then
				if arg_435_1.var_.characterEffect1074ui_story and not isNil(arg_435_1.actors_["1074ui_story"]) then
					arg_435_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_435_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_435_1.time_ - 0) / var_438_0)
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["1074ui_story"]) and arg_435_1.var_.characterEffect1074ui_story then
				arg_435_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_435_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_438_1 = 0
			local var_438_2 = 1.175

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_1 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, false)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_3 = arg_435_1:FormatText(arg_435_1:GetWordFromCfg(120421105).content)

				arg_435_1.text_.text = var_438_3

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 47 <= 0 and var_438_2 or var_438_2 * (utf8.len(var_438_3) / 47)

				if (47 <= 0 and var_438_2 or var_438_2 * (utf8.len(var_438_3) / 47)) > 0 and var_438_2 < var_438_5 then
					arg_435_1.talkMaxDuration = var_438_5

					if var_438_5 + var_438_1 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_5 + var_438_1
					end
				end

				arg_435_1.text_.text = var_438_3
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)
				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_6 = math.max(var_438_2, arg_435_1.talkMaxDuration)

			if var_438_1 <= arg_435_1.time_ and arg_435_1.time_ < var_438_1 + var_438_6 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_1) / var_438_6

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_1 + var_438_6 and arg_435_1.time_ < var_438_1 + var_438_6 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play120421106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 120421106
		arg_439_1.duration_ = 8.57

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play120421107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.mask_.enabled = true
				arg_439_1.mask_.raycastTarget = true

				arg_439_1:SetGaussion(false)
			end

			local var_442_0 = 2

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 then
				local var_442_1 = Color.New(0, 0, 0)

				var_442_1.a = Mathf.Lerp(0, 1, (arg_439_1.time_ - 0) / var_442_0)
				arg_439_1.mask_.color = var_442_1
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 then
				local var_442_2 = Color.New(0, 0, 0)

				var_442_2.a = 1
				arg_439_1.mask_.color = var_442_2
			end

			local var_442_3 = 2

			if 2 < arg_439_1.time_ and arg_439_1.time_ <= var_442_3 + arg_442_0 then
				arg_439_1.mask_.enabled = true
				arg_439_1.mask_.raycastTarget = true

				arg_439_1:SetGaussion(false)
			end

			local var_442_4 = 2

			if var_442_3 <= arg_439_1.time_ and arg_439_1.time_ < var_442_3 + var_442_4 then
				local var_442_5 = Color.New(0, 0, 0)

				var_442_5.a = Mathf.Lerp(1, 0, (arg_439_1.time_ - var_442_3) / var_442_4)
				arg_439_1.mask_.color = var_442_5
			end

			if arg_439_1.time_ >= var_442_3 + var_442_4 and arg_439_1.time_ < var_442_3 + var_442_4 + arg_442_0 then
				local var_442_6 = Color.New(0, 0, 0)

				arg_439_1.mask_.enabled = false
				var_442_6.a = 0
				arg_439_1.mask_.color = var_442_6
			end

			if arg_439_1.frameCnt_ <= 1 then
				arg_439_1.dialog_:SetActive(false)
			end

			local var_442_7 = 3.56666666666667
			local var_442_8 = 1.55

			if 3.56666666666667 < arg_439_1.time_ and arg_439_1.time_ <= var_442_7 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0

				arg_439_1.dialog_:SetActive(true)

				arg_439_1.dialogCg_.alpha = 0

				local var_442_9 = LeanTween.value(arg_439_1.dialog_, 0, 1, 0.3)

				var_442_9:setOnUpdate(LuaHelper.FloatAction(function(arg_443_0)
					arg_439_1.dialogCg_.alpha = arg_443_0
				end))
				var_442_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_439_1.dialog_)
					var_442_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_439_1.duration_ = arg_439_1.duration_ + 0.3

				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_10 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(120421106).content)

				arg_439_1.text_.text = var_442_10

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_12 = 62 <= 0 and var_442_8 or var_442_8 * (utf8.len(var_442_10) / 62)

				if (62 <= 0 and var_442_8 or var_442_8 * (utf8.len(var_442_10) / 62)) > 0 and var_442_8 < var_442_12 then
					arg_439_1.talkMaxDuration = var_442_12
					var_442_7 = var_442_7 + 0.3

					if var_442_12 + var_442_7 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_12 + var_442_7
					end
				end

				arg_439_1.text_.text = var_442_10
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_13 = var_442_7 + 0.3
			local var_442_14 = math.max(var_442_8, arg_439_1.talkMaxDuration)

			if var_442_7 + 0.3 <= arg_439_1.time_ and arg_439_1.time_ < var_442_13 + var_442_14 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_13) / var_442_14

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_13 + var_442_14 and arg_439_1.time_ < var_442_13 + var_442_14 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play120421107 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 120421107
		arg_445_1.duration_ = 11.33

		local var_445_0 = {
			zh = 8.033,
			ja = 11.333
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play120421108(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["1074ui_story"]) and arg_445_1.var_.characterEffect1074ui_story == nil then
				arg_445_1.var_.characterEffect1074ui_story = arg_445_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_448_0 = 0.2

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["1074ui_story"]) then
				if arg_445_1.var_.characterEffect1074ui_story and not isNil(arg_445_1.actors_["1074ui_story"]) then
					arg_445_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["1074ui_story"]) and arg_445_1.var_.characterEffect1074ui_story then
				arg_445_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_448_2 = 0
			local var_448_3 = 0.8

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_2 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_4 = arg_445_1:GetWordFromCfg(120421107)
				local var_448_5 = arg_445_1:FormatText(var_448_4.content)

				arg_445_1.text_.text = var_448_5

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_7 = 32 <= 0 and var_448_3 or var_448_3 * (utf8.len(var_448_5) / 32)

				if (32 <= 0 and var_448_3 or var_448_3 * (utf8.len(var_448_5) / 32)) > 0 and var_448_3 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_2 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_2
					end
				end

				arg_445_1.text_.text = var_448_5
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421107", "story_v_out_120421.awb") ~= 0 then
					local var_448_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421107", "story_v_out_120421.awb") / 1000

					if var_448_8 + var_448_2 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_8 + var_448_2
					end

					if var_448_4.prefab_name ~= "" and arg_445_1.actors_[var_448_4.prefab_name] ~= nil then
						local var_448_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_4.prefab_name].transform, "story_v_out_120421", "120421107", "story_v_out_120421.awb")

						arg_445_1:RecordAudio("120421107", var_448_9)
						arg_445_1:RecordAudio("120421107", var_448_9)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_120421", "120421107", "story_v_out_120421.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_120421", "120421107", "story_v_out_120421.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_10 = math.max(var_448_3, arg_445_1.talkMaxDuration)

			if var_448_2 <= arg_445_1.time_ and arg_445_1.time_ < var_448_2 + var_448_10 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_2) / var_448_10

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_2 + var_448_10 and arg_445_1.time_ < var_448_2 + var_448_10 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play120421108 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 120421108
		arg_449_1.duration_ = 4.6

		local var_449_0 = {
			zh = 3.1,
			ja = 4.6
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play120421109(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos1075ui_story = arg_449_1.actors_["1075ui_story"].transform.localPosition
			end

			local var_452_0 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 then
				arg_449_1.actors_["1075ui_story"].transform.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_449_1.time_ - 0) / var_452_0)
				arg_449_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1075ui_story"].transform.position).z)
				arg_449_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1075ui_story"].transform.localEulerAngles = arg_449_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 then
				arg_449_1.actors_["1075ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_449_1.actors_["1075ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1075ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1075ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1075ui_story"].transform.position).z)
				arg_449_1.actors_["1075ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1075ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1075ui_story"].transform.localEulerAngles = arg_449_1.actors_["1075ui_story"].transform.localEulerAngles
			end

			local var_452_1 = arg_449_1.actors_["10044ui_story"].transform

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos10044ui_story = var_452_1.localPosition
			end

			local var_452_2 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_2 then
				var_452_1.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos10044ui_story, Vector3.New(0.7, -0.72, -6.3), (arg_449_1.time_ - 0) / var_452_2)
				var_452_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_452_1.position).x, (manager.ui.mainCamera.transform.position - var_452_1.position).y, (manager.ui.mainCamera.transform.position - var_452_1.position).z)
				var_452_1.localEulerAngles.z = 0
				var_452_1.localEulerAngles.x = 0
				var_452_1.localEulerAngles = var_452_1.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_2 and arg_449_1.time_ < 0 + var_452_2 + arg_452_0 then
				var_452_1.localPosition = Vector3.New(0.7, -0.72, -6.3)
				var_452_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_452_1.position).x, (manager.ui.mainCamera.transform.position - var_452_1.position).y, (manager.ui.mainCamera.transform.position - var_452_1.position).z)
				var_452_1.localEulerAngles.z = 0
				var_452_1.localEulerAngles.x = 0
				var_452_1.localEulerAngles = var_452_1.localEulerAngles
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_452_3 = arg_449_1.actors_["10044ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_3) and arg_449_1.var_.characterEffect10044ui_story == nil then
				arg_449_1.var_.characterEffect10044ui_story = var_452_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_4 = 0.2

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_4 and not isNil(var_452_3) then
				if arg_449_1.var_.characterEffect10044ui_story and not isNil(var_452_3) then
					arg_449_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_4 and arg_449_1.time_ < 0 + var_452_4 + arg_452_0 and not isNil(var_452_3) and arg_449_1.var_.characterEffect10044ui_story then
				arg_449_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_452_6 = arg_449_1.actors_["1074ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_6) and arg_449_1.var_.characterEffect1074ui_story == nil then
				arg_449_1.var_.characterEffect1074ui_story = var_452_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_7 = 0.2

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_7 and not isNil(var_452_6) then
				if arg_449_1.var_.characterEffect1074ui_story and not isNil(var_452_6) then
					arg_449_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_449_1.time_ - 0) / var_452_7)
				end
			end

			if arg_449_1.time_ >= 0 + var_452_7 and arg_449_1.time_ < 0 + var_452_7 + arg_452_0 and not isNil(var_452_6) and arg_449_1.var_.characterEffect1074ui_story then
				arg_449_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_452_8 = 0
			local var_452_9 = 0.35

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_8 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_10 = arg_449_1:GetWordFromCfg(120421108)
				local var_452_11 = arg_449_1:FormatText(var_452_10.content)

				arg_449_1.text_.text = var_452_11

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_13 = 14 <= 0 and var_452_9 or var_452_9 * (utf8.len(var_452_11) / 14)

				if (14 <= 0 and var_452_9 or var_452_9 * (utf8.len(var_452_11) / 14)) > 0 and var_452_9 < var_452_13 then
					arg_449_1.talkMaxDuration = var_452_13

					if var_452_13 + var_452_8 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_13 + var_452_8
					end
				end

				arg_449_1.text_.text = var_452_11
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421108", "story_v_out_120421.awb") ~= 0 then
					local var_452_14 = manager.audio:GetVoiceLength("story_v_out_120421", "120421108", "story_v_out_120421.awb") / 1000

					if var_452_14 + var_452_8 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_14 + var_452_8
					end

					if var_452_10.prefab_name ~= "" and arg_449_1.actors_[var_452_10.prefab_name] ~= nil then
						local var_452_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_10.prefab_name].transform, "story_v_out_120421", "120421108", "story_v_out_120421.awb")

						arg_449_1:RecordAudio("120421108", var_452_15)
						arg_449_1:RecordAudio("120421108", var_452_15)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_120421", "120421108", "story_v_out_120421.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_120421", "120421108", "story_v_out_120421.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_16 = math.max(var_452_9, arg_449_1.talkMaxDuration)

			if var_452_8 <= arg_449_1.time_ and arg_449_1.time_ < var_452_8 + var_452_16 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_8) / var_452_16

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_8 + var_452_16 and arg_449_1.time_ < var_452_8 + var_452_16 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play120421109 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 120421109
		arg_453_1.duration_ = 3.1

		local var_453_0 = {
			zh = 2.3,
			ja = 3.1
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play120421110(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["10044ui_story"]) and arg_453_1.var_.characterEffect10044ui_story == nil then
				arg_453_1.var_.characterEffect10044ui_story = arg_453_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_0 = 0.2

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["10044ui_story"]) then
				if arg_453_1.var_.characterEffect10044ui_story and not isNil(arg_453_1.actors_["10044ui_story"]) then
					arg_453_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_453_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_453_1.time_ - 0) / var_456_0)
				end
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["10044ui_story"]) and arg_453_1.var_.characterEffect10044ui_story then
				arg_453_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_453_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_456_1 = arg_453_1.actors_["1074ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1074ui_story == nil then
				arg_453_1.var_.characterEffect1074ui_story = var_456_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_2 = 0.2

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_2 and not isNil(var_456_1) then
				if arg_453_1.var_.characterEffect1074ui_story and not isNil(var_456_1) then
					arg_453_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= 0 + var_456_2 and arg_453_1.time_ < 0 + var_456_2 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1074ui_story then
				arg_453_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_456_4 = 0
			local var_456_5 = 0.175

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_4 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_6 = arg_453_1:GetWordFromCfg(120421109)
				local var_456_7 = arg_453_1:FormatText(var_456_6.content)

				arg_453_1.text_.text = var_456_7

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_9 = 7 <= 0 and var_456_5 or var_456_5 * (utf8.len(var_456_7) / 7)

				if (7 <= 0 and var_456_5 or var_456_5 * (utf8.len(var_456_7) / 7)) > 0 and var_456_5 < var_456_9 then
					arg_453_1.talkMaxDuration = var_456_9

					if var_456_9 + var_456_4 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_9 + var_456_4
					end
				end

				arg_453_1.text_.text = var_456_7
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421109", "story_v_out_120421.awb") ~= 0 then
					local var_456_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421109", "story_v_out_120421.awb") / 1000

					if var_456_10 + var_456_4 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_10 + var_456_4
					end

					if var_456_6.prefab_name ~= "" and arg_453_1.actors_[var_456_6.prefab_name] ~= nil then
						local var_456_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_6.prefab_name].transform, "story_v_out_120421", "120421109", "story_v_out_120421.awb")

						arg_453_1:RecordAudio("120421109", var_456_11)
						arg_453_1:RecordAudio("120421109", var_456_11)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_120421", "120421109", "story_v_out_120421.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_120421", "120421109", "story_v_out_120421.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_12 = math.max(var_456_5, arg_453_1.talkMaxDuration)

			if var_456_4 <= arg_453_1.time_ and arg_453_1.time_ < var_456_4 + var_456_12 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_4) / var_456_12

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_4 + var_456_12 and arg_453_1.time_ < var_456_4 + var_456_12 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play120421110 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 120421110
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play120421111(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos10044ui_story = arg_457_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_460_0 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 then
				arg_457_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_457_1.time_ - 0) / var_460_0)
				arg_457_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10044ui_story"].transform.position).z)
				arg_457_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["10044ui_story"].transform.localEulerAngles = arg_457_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 then
				arg_457_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_457_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_457_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_457_1.actors_["10044ui_story"].transform.position).z)
				arg_457_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_457_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_457_1.actors_["10044ui_story"].transform.localEulerAngles = arg_457_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_460_1 = arg_457_1.actors_["1074ui_story"].transform

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos1074ui_story = var_460_1.localPosition
			end

			local var_460_2 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_2 then
				var_460_1.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_457_1.time_ - 0) / var_460_2)
				var_460_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_1.position).x, (manager.ui.mainCamera.transform.position - var_460_1.position).y, (manager.ui.mainCamera.transform.position - var_460_1.position).z)
				var_460_1.localEulerAngles.z = 0
				var_460_1.localEulerAngles.x = 0
				var_460_1.localEulerAngles = var_460_1.localEulerAngles
			end

			if arg_457_1.time_ >= 0 + var_460_2 and arg_457_1.time_ < 0 + var_460_2 + arg_460_0 then
				var_460_1.localPosition = Vector3.New(0, 100, 0)
				var_460_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_460_1.position).x, (manager.ui.mainCamera.transform.position - var_460_1.position).y, (manager.ui.mainCamera.transform.position - var_460_1.position).z)
				var_460_1.localEulerAngles.z = 0
				var_460_1.localEulerAngles.x = 0
				var_460_1.localEulerAngles = var_460_1.localEulerAngles
			end

			local var_460_3 = 0
			local var_460_4 = 1.05

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_3 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_5 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(120421110).content)

				arg_457_1.text_.text = var_460_5

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_7 = 42 <= 0 and var_460_4 or var_460_4 * (utf8.len(var_460_5) / 42)

				if (42 <= 0 and var_460_4 or var_460_4 * (utf8.len(var_460_5) / 42)) > 0 and var_460_4 < var_460_7 then
					arg_457_1.talkMaxDuration = var_460_7

					if var_460_7 + var_460_3 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_7 + var_460_3
					end
				end

				arg_457_1.text_.text = var_460_5
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_8 = math.max(var_460_4, arg_457_1.talkMaxDuration)

			if var_460_3 <= arg_457_1.time_ and arg_457_1.time_ < var_460_3 + var_460_8 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_3) / var_460_8

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_3 + var_460_8 and arg_457_1.time_ < var_460_3 + var_460_8 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play120421111 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 120421111
		arg_461_1.duration_ = 13.27

		local var_461_0 = {
			zh = 9.966,
			ja = 13.266
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play120421112(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos1074ui_story = arg_461_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_464_0 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 then
				arg_461_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_461_1.time_ - 0) / var_464_0)
				arg_461_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1074ui_story"].transform.position).z)
				arg_461_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1074ui_story"].transform.localEulerAngles = arg_461_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 then
				arg_461_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_461_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1074ui_story"].transform.position).z)
				arg_461_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1074ui_story"].transform.localEulerAngles = arg_461_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			local var_464_1 = arg_461_1.actors_["10044ui_story"].transform

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos10044ui_story = var_464_1.localPosition
			end

			local var_464_2 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_2 then
				var_464_1.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos10044ui_story, Vector3.New(0.7, -0.72, -6.3), (arg_461_1.time_ - 0) / var_464_2)
				var_464_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_464_1.position).x, (manager.ui.mainCamera.transform.position - var_464_1.position).y, (manager.ui.mainCamera.transform.position - var_464_1.position).z)
				var_464_1.localEulerAngles.z = 0
				var_464_1.localEulerAngles.x = 0
				var_464_1.localEulerAngles = var_464_1.localEulerAngles
			end

			if arg_461_1.time_ >= 0 + var_464_2 and arg_461_1.time_ < 0 + var_464_2 + arg_464_0 then
				var_464_1.localPosition = Vector3.New(0.7, -0.72, -6.3)
				var_464_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_464_1.position).x, (manager.ui.mainCamera.transform.position - var_464_1.position).y, (manager.ui.mainCamera.transform.position - var_464_1.position).z)
				var_464_1.localEulerAngles.z = 0
				var_464_1.localEulerAngles.x = 0
				var_464_1.localEulerAngles = var_464_1.localEulerAngles
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_464_3 = arg_461_1.actors_["10044ui_story"]

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(var_464_3) and arg_461_1.var_.characterEffect10044ui_story == nil then
				arg_461_1.var_.characterEffect10044ui_story = var_464_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_4 = 0.2

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 and not isNil(var_464_3) then
				if arg_461_1.var_.characterEffect10044ui_story and not isNil(var_464_3) then
					arg_461_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_461_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_461_1.time_ - 0) / var_464_4)
				end
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 and not isNil(var_464_3) and arg_461_1.var_.characterEffect10044ui_story then
				arg_461_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_461_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_464_5 = arg_461_1.actors_["1074ui_story"]

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(var_464_5) and arg_461_1.var_.characterEffect1074ui_story == nil then
				arg_461_1.var_.characterEffect1074ui_story = var_464_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_6 = 0.2

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_6 and not isNil(var_464_5) then
				if arg_461_1.var_.characterEffect1074ui_story and not isNil(var_464_5) then
					arg_461_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= 0 + var_464_6 and arg_461_1.time_ < 0 + var_464_6 + arg_464_0 and not isNil(var_464_5) and arg_461_1.var_.characterEffect1074ui_story then
				arg_461_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_464_8 = 0
			local var_464_9 = 1.1

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_8 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_10 = arg_461_1:GetWordFromCfg(120421111)
				local var_464_11 = arg_461_1:FormatText(var_464_10.content)

				arg_461_1.text_.text = var_464_11

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_13 = 44 <= 0 and var_464_9 or var_464_9 * (utf8.len(var_464_11) / 44)

				if (44 <= 0 and var_464_9 or var_464_9 * (utf8.len(var_464_11) / 44)) > 0 and var_464_9 < var_464_13 then
					arg_461_1.talkMaxDuration = var_464_13

					if var_464_13 + var_464_8 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_13 + var_464_8
					end
				end

				arg_461_1.text_.text = var_464_11
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421111", "story_v_out_120421.awb") ~= 0 then
					local var_464_14 = manager.audio:GetVoiceLength("story_v_out_120421", "120421111", "story_v_out_120421.awb") / 1000

					if var_464_14 + var_464_8 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_14 + var_464_8
					end

					if var_464_10.prefab_name ~= "" and arg_461_1.actors_[var_464_10.prefab_name] ~= nil then
						local var_464_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_10.prefab_name].transform, "story_v_out_120421", "120421111", "story_v_out_120421.awb")

						arg_461_1:RecordAudio("120421111", var_464_15)
						arg_461_1:RecordAudio("120421111", var_464_15)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_120421", "120421111", "story_v_out_120421.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_120421", "120421111", "story_v_out_120421.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_16 = math.max(var_464_9, arg_461_1.talkMaxDuration)

			if var_464_8 <= arg_461_1.time_ and arg_461_1.time_ < var_464_8 + var_464_16 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_8) / var_464_16

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_8 + var_464_16 and arg_461_1.time_ < var_464_8 + var_464_16 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play120421112 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 120421112
		arg_465_1.duration_ = 14.53

		local var_465_0 = {
			zh = 12.133,
			ja = 14.533
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play120421113(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 1.25

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_1 = arg_465_1:GetWordFromCfg(120421112)
				local var_468_2 = arg_465_1:FormatText(var_468_1.content)

				arg_465_1.text_.text = var_468_2

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_4 = 50 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_2) / 50)

				if (50 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_2) / 50)) > 0 and var_468_0 < var_468_4 then
					arg_465_1.talkMaxDuration = var_468_4

					if var_468_4 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_4 + 0
					end
				end

				arg_465_1.text_.text = var_468_2
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421112", "story_v_out_120421.awb") ~= 0 then
					local var_468_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421112", "story_v_out_120421.awb") / 1000

					if var_468_5 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_5 + 0
					end

					if var_468_1.prefab_name ~= "" and arg_465_1.actors_[var_468_1.prefab_name] ~= nil then
						local var_468_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_1.prefab_name].transform, "story_v_out_120421", "120421112", "story_v_out_120421.awb")

						arg_465_1:RecordAudio("120421112", var_468_6)
						arg_465_1:RecordAudio("120421112", var_468_6)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_120421", "120421112", "story_v_out_120421.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_120421", "120421112", "story_v_out_120421.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_7 and arg_465_1.time_ < 0 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play120421113 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 120421113
		arg_469_1.duration_ = 5.73

		local var_469_0 = {
			zh = 1.933,
			ja = 5.733
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play120421114(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0.2

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_1 = arg_469_1:GetWordFromCfg(120421113)
				local var_472_2 = arg_469_1:FormatText(var_472_1.content)

				arg_469_1.text_.text = var_472_2

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_4 = 8 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 8)

				if (8 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_2) / 8)) > 0 and var_472_0 < var_472_4 then
					arg_469_1.talkMaxDuration = var_472_4

					if var_472_4 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_4 + 0
					end
				end

				arg_469_1.text_.text = var_472_2
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421113", "story_v_out_120421.awb") ~= 0 then
					local var_472_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421113", "story_v_out_120421.awb") / 1000

					if var_472_5 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_5 + 0
					end

					if var_472_1.prefab_name ~= "" and arg_469_1.actors_[var_472_1.prefab_name] ~= nil then
						local var_472_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_1.prefab_name].transform, "story_v_out_120421", "120421113", "story_v_out_120421.awb")

						arg_469_1:RecordAudio("120421113", var_472_6)
						arg_469_1:RecordAudio("120421113", var_472_6)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_120421", "120421113", "story_v_out_120421.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_120421", "120421113", "story_v_out_120421.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_7 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_7 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_7

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_7 and arg_469_1.time_ < 0 + var_472_7 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play120421114 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 120421114
		arg_473_1.duration_ = 4.97

		local var_473_0 = {
			zh = 2.5,
			ja = 4.966
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play120421115(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(arg_473_1.actors_["10044ui_story"]) and arg_473_1.var_.characterEffect10044ui_story == nil then
				arg_473_1.var_.characterEffect10044ui_story = arg_473_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_0 = 0.2

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 and not isNil(arg_473_1.actors_["10044ui_story"]) then
				if arg_473_1.var_.characterEffect10044ui_story and not isNil(arg_473_1.actors_["10044ui_story"]) then
					arg_473_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 and not isNil(arg_473_1.actors_["10044ui_story"]) and arg_473_1.var_.characterEffect10044ui_story then
				arg_473_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_476_2 = arg_473_1.actors_["1074ui_story"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_2) and arg_473_1.var_.characterEffect1074ui_story == nil then
				arg_473_1.var_.characterEffect1074ui_story = var_476_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_3 = 0.2

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_3 and not isNil(var_476_2) then
				if arg_473_1.var_.characterEffect1074ui_story and not isNil(var_476_2) then
					arg_473_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_473_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_473_1.time_ - 0) / var_476_3)
				end
			end

			if arg_473_1.time_ >= 0 + var_476_3 and arg_473_1.time_ < 0 + var_476_3 + arg_476_0 and not isNil(var_476_2) and arg_473_1.var_.characterEffect1074ui_story then
				arg_473_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_473_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action4_1")
			end

			local var_476_4 = 0
			local var_476_5 = 0.3

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_4 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_6 = arg_473_1:GetWordFromCfg(120421114)
				local var_476_7 = arg_473_1:FormatText(var_476_6.content)

				arg_473_1.text_.text = var_476_7

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_9 = 12 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 12)

				if (12 <= 0 and var_476_5 or var_476_5 * (utf8.len(var_476_7) / 12)) > 0 and var_476_5 < var_476_9 then
					arg_473_1.talkMaxDuration = var_476_9

					if var_476_9 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_9 + var_476_4
					end
				end

				arg_473_1.text_.text = var_476_7
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421114", "story_v_out_120421.awb") ~= 0 then
					local var_476_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421114", "story_v_out_120421.awb") / 1000

					if var_476_10 + var_476_4 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_10 + var_476_4
					end

					if var_476_6.prefab_name ~= "" and arg_473_1.actors_[var_476_6.prefab_name] ~= nil then
						local var_476_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_6.prefab_name].transform, "story_v_out_120421", "120421114", "story_v_out_120421.awb")

						arg_473_1:RecordAudio("120421114", var_476_11)
						arg_473_1:RecordAudio("120421114", var_476_11)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_120421", "120421114", "story_v_out_120421.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_120421", "120421114", "story_v_out_120421.awb")
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

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play120421115 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 120421115
		arg_477_1.duration_ = 2

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play120421116(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["10044ui_story"]) and arg_477_1.var_.characterEffect10044ui_story == nil then
				arg_477_1.var_.characterEffect10044ui_story = arg_477_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_0 = 0.2

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["10044ui_story"]) then
				if arg_477_1.var_.characterEffect10044ui_story and not isNil(arg_477_1.actors_["10044ui_story"]) then
					arg_477_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_477_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_477_1.time_ - 0) / var_480_0)
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["10044ui_story"]) and arg_477_1.var_.characterEffect10044ui_story then
				arg_477_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_477_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_480_1 = arg_477_1.actors_["1074ui_story"]

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1074ui_story == nil then
				arg_477_1.var_.characterEffect1074ui_story = var_480_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_2 = 0.2

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_2 and not isNil(var_480_1) then
				if arg_477_1.var_.characterEffect1074ui_story and not isNil(var_480_1) then
					arg_477_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= 0 + var_480_2 and arg_477_1.time_ < 0 + var_480_2 + arg_480_0 and not isNil(var_480_1) and arg_477_1.var_.characterEffect1074ui_story then
				arg_477_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_480_4 = 0
			local var_480_5 = 0.225

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_4 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_6 = arg_477_1:GetWordFromCfg(120421115)
				local var_480_7 = arg_477_1:FormatText(var_480_6.content)

				arg_477_1.text_.text = var_480_7

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_9 = 9 <= 0 and var_480_5 or var_480_5 * (utf8.len(var_480_7) / 9)

				if (9 <= 0 and var_480_5 or var_480_5 * (utf8.len(var_480_7) / 9)) > 0 and var_480_5 < var_480_9 then
					arg_477_1.talkMaxDuration = var_480_9

					if var_480_9 + var_480_4 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_9 + var_480_4
					end
				end

				arg_477_1.text_.text = var_480_7
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421115", "story_v_out_120421.awb") ~= 0 then
					local var_480_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421115", "story_v_out_120421.awb") / 1000

					if var_480_10 + var_480_4 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_10 + var_480_4
					end

					if var_480_6.prefab_name ~= "" and arg_477_1.actors_[var_480_6.prefab_name] ~= nil then
						local var_480_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_6.prefab_name].transform, "story_v_out_120421", "120421115", "story_v_out_120421.awb")

						arg_477_1:RecordAudio("120421115", var_480_11)
						arg_477_1:RecordAudio("120421115", var_480_11)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_120421", "120421115", "story_v_out_120421.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_120421", "120421115", "story_v_out_120421.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_12 = math.max(var_480_5, arg_477_1.talkMaxDuration)

			if var_480_4 <= arg_477_1.time_ and arg_477_1.time_ < var_480_4 + var_480_12 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_4) / var_480_12

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_4 + var_480_12 and arg_477_1.time_ < var_480_4 + var_480_12 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play120421116 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 120421116
		arg_481_1.duration_ = 9.17

		local var_481_0 = {
			zh = 7.333,
			ja = 9.166
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play120421117(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0.775

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_1 = arg_481_1:GetWordFromCfg(120421116)
				local var_484_2 = arg_481_1:FormatText(var_484_1.content)

				arg_481_1.text_.text = var_484_2

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_4 = 31 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 31)

				if (31 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_2) / 31)) > 0 and var_484_0 < var_484_4 then
					arg_481_1.talkMaxDuration = var_484_4

					if var_484_4 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_4 + 0
					end
				end

				arg_481_1.text_.text = var_484_2
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421116", "story_v_out_120421.awb") ~= 0 then
					local var_484_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421116", "story_v_out_120421.awb") / 1000

					if var_484_5 + 0 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_5 + 0
					end

					if var_484_1.prefab_name ~= "" and arg_481_1.actors_[var_484_1.prefab_name] ~= nil then
						local var_484_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_1.prefab_name].transform, "story_v_out_120421", "120421116", "story_v_out_120421.awb")

						arg_481_1:RecordAudio("120421116", var_484_6)
						arg_481_1:RecordAudio("120421116", var_484_6)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_120421", "120421116", "story_v_out_120421.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_120421", "120421116", "story_v_out_120421.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_7 = math.max(var_484_0, arg_481_1.talkMaxDuration)

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_7 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - 0) / var_484_7

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= 0 + var_484_7 and arg_481_1.time_ < 0 + var_484_7 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play120421117 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 120421117
		arg_485_1.duration_ = 2

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play120421118(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["10044ui_story"]) and arg_485_1.var_.characterEffect10044ui_story == nil then
				arg_485_1.var_.characterEffect10044ui_story = arg_485_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_0 = 0.2

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["10044ui_story"]) then
				if arg_485_1.var_.characterEffect10044ui_story and not isNil(arg_485_1.actors_["10044ui_story"]) then
					arg_485_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["10044ui_story"]) and arg_485_1.var_.characterEffect10044ui_story then
				arg_485_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_488_2 = arg_485_1.actors_["1074ui_story"]

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(var_488_2) and arg_485_1.var_.characterEffect1074ui_story == nil then
				arg_485_1.var_.characterEffect1074ui_story = var_488_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_3 = 0.2

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_3 and not isNil(var_488_2) then
				if arg_485_1.var_.characterEffect1074ui_story and not isNil(var_488_2) then
					arg_485_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_485_1.time_ - 0) / var_488_3)
				end
			end

			if arg_485_1.time_ >= 0 + var_488_3 and arg_485_1.time_ < 0 + var_488_3 + arg_488_0 and not isNil(var_488_2) and arg_485_1.var_.characterEffect1074ui_story then
				arg_485_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action443")
			end

			local var_488_4 = 0
			local var_488_5 = 0.1

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_4 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_6 = arg_485_1:GetWordFromCfg(120421117)
				local var_488_7 = arg_485_1:FormatText(var_488_6.content)

				arg_485_1.text_.text = var_488_7

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_9 = 4 <= 0 and var_488_5 or var_488_5 * (utf8.len(var_488_7) / 4)

				if (4 <= 0 and var_488_5 or var_488_5 * (utf8.len(var_488_7) / 4)) > 0 and var_488_5 < var_488_9 then
					arg_485_1.talkMaxDuration = var_488_9

					if var_488_9 + var_488_4 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_9 + var_488_4
					end
				end

				arg_485_1.text_.text = var_488_7
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421117", "story_v_out_120421.awb") ~= 0 then
					local var_488_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421117", "story_v_out_120421.awb") / 1000

					if var_488_10 + var_488_4 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_10 + var_488_4
					end

					if var_488_6.prefab_name ~= "" and arg_485_1.actors_[var_488_6.prefab_name] ~= nil then
						local var_488_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_6.prefab_name].transform, "story_v_out_120421", "120421117", "story_v_out_120421.awb")

						arg_485_1:RecordAudio("120421117", var_488_11)
						arg_485_1:RecordAudio("120421117", var_488_11)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_120421", "120421117", "story_v_out_120421.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_120421", "120421117", "story_v_out_120421.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_12 = math.max(var_488_5, arg_485_1.talkMaxDuration)

			if var_488_4 <= arg_485_1.time_ and arg_485_1.time_ < var_488_4 + var_488_12 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_4) / var_488_12

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_4 + var_488_12 and arg_485_1.time_ < var_488_4 + var_488_12 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play120421118 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 120421118
		arg_489_1.duration_ = 8.2

		local var_489_0 = {
			zh = 8.2,
			ja = 8.166
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play120421119(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(arg_489_1.actors_["10044ui_story"]) and arg_489_1.var_.characterEffect10044ui_story == nil then
				arg_489_1.var_.characterEffect10044ui_story = arg_489_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_0 = 0.2

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 and not isNil(arg_489_1.actors_["10044ui_story"]) then
				if arg_489_1.var_.characterEffect10044ui_story and not isNil(arg_489_1.actors_["10044ui_story"]) then
					arg_489_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_489_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_489_1.time_ - 0) / var_492_0)
				end
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 and not isNil(arg_489_1.actors_["10044ui_story"]) and arg_489_1.var_.characterEffect10044ui_story then
				arg_489_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_489_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			local var_492_1 = arg_489_1.actors_["1074ui_story"]

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(var_492_1) and arg_489_1.var_.characterEffect1074ui_story == nil then
				arg_489_1.var_.characterEffect1074ui_story = var_492_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_492_2 = 0.2

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_2 and not isNil(var_492_1) then
				if arg_489_1.var_.characterEffect1074ui_story and not isNil(var_492_1) then
					arg_489_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_489_1.time_ >= 0 + var_492_2 and arg_489_1.time_ < 0 + var_492_2 + arg_492_0 and not isNil(var_492_1) and arg_489_1.var_.characterEffect1074ui_story then
				arg_489_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_492_4 = 0
			local var_492_5 = 0.9

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_4 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_6 = arg_489_1:GetWordFromCfg(120421118)
				local var_492_7 = arg_489_1:FormatText(var_492_6.content)

				arg_489_1.text_.text = var_492_7

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_9 = 36 <= 0 and var_492_5 or var_492_5 * (utf8.len(var_492_7) / 36)

				if (36 <= 0 and var_492_5 or var_492_5 * (utf8.len(var_492_7) / 36)) > 0 and var_492_5 < var_492_9 then
					arg_489_1.talkMaxDuration = var_492_9

					if var_492_9 + var_492_4 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_9 + var_492_4
					end
				end

				arg_489_1.text_.text = var_492_7
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421118", "story_v_out_120421.awb") ~= 0 then
					local var_492_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421118", "story_v_out_120421.awb") / 1000

					if var_492_10 + var_492_4 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_10 + var_492_4
					end

					if var_492_6.prefab_name ~= "" and arg_489_1.actors_[var_492_6.prefab_name] ~= nil then
						local var_492_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_6.prefab_name].transform, "story_v_out_120421", "120421118", "story_v_out_120421.awb")

						arg_489_1:RecordAudio("120421118", var_492_11)
						arg_489_1:RecordAudio("120421118", var_492_11)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_120421", "120421118", "story_v_out_120421.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_120421", "120421118", "story_v_out_120421.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_12 = math.max(var_492_5, arg_489_1.talkMaxDuration)

			if var_492_4 <= arg_489_1.time_ and arg_489_1.time_ < var_492_4 + var_492_12 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_4) / var_492_12

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_4 + var_492_12 and arg_489_1.time_ < var_492_4 + var_492_12 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play120421119 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 120421119
		arg_493_1.duration_ = 4.8

		local var_493_0 = {
			zh = 0.999999999999,
			ja = 4.8
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play120421120(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(arg_493_1.actors_["10044ui_story"]) and arg_493_1.var_.characterEffect10044ui_story == nil then
				arg_493_1.var_.characterEffect10044ui_story = arg_493_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_0 = 0.2

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 and not isNil(arg_493_1.actors_["10044ui_story"]) then
				if arg_493_1.var_.characterEffect10044ui_story and not isNil(arg_493_1.actors_["10044ui_story"]) then
					arg_493_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 and not isNil(arg_493_1.actors_["10044ui_story"]) and arg_493_1.var_.characterEffect10044ui_story then
				arg_493_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_496_2 = arg_493_1.actors_["1074ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_2) and arg_493_1.var_.characterEffect1074ui_story == nil then
				arg_493_1.var_.characterEffect1074ui_story = var_496_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_3 = 0.2

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_3 and not isNil(var_496_2) then
				if arg_493_1.var_.characterEffect1074ui_story and not isNil(var_496_2) then
					arg_493_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_493_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_493_1.time_ - 0) / var_496_3)
				end
			end

			if arg_493_1.time_ >= 0 + var_496_3 and arg_493_1.time_ < 0 + var_496_3 + arg_496_0 and not isNil(var_496_2) and arg_493_1.var_.characterEffect1074ui_story then
				arg_493_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_493_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_496_4 = 0
			local var_496_5 = 0.125

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_4 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_6 = arg_493_1:GetWordFromCfg(120421119)
				local var_496_7 = arg_493_1:FormatText(var_496_6.content)

				arg_493_1.text_.text = var_496_7

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_9 = 5 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 5)

				if (5 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 5)) > 0 and var_496_5 < var_496_9 then
					arg_493_1.talkMaxDuration = var_496_9

					if var_496_9 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_9 + var_496_4
					end
				end

				arg_493_1.text_.text = var_496_7
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421119", "story_v_out_120421.awb") ~= 0 then
					local var_496_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421119", "story_v_out_120421.awb") / 1000

					if var_496_10 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_10 + var_496_4
					end

					if var_496_6.prefab_name ~= "" and arg_493_1.actors_[var_496_6.prefab_name] ~= nil then
						local var_496_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_6.prefab_name].transform, "story_v_out_120421", "120421119", "story_v_out_120421.awb")

						arg_493_1:RecordAudio("120421119", var_496_11)
						arg_493_1:RecordAudio("120421119", var_496_11)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_120421", "120421119", "story_v_out_120421.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_120421", "120421119", "story_v_out_120421.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_12 = math.max(var_496_5, arg_493_1.talkMaxDuration)

			if var_496_4 <= arg_493_1.time_ and arg_493_1.time_ < var_496_4 + var_496_12 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_4) / var_496_12

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_4 + var_496_12 and arg_493_1.time_ < var_496_4 + var_496_12 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {}

		arg_493_1:InitPlayNodeList()
	end,
	Play120421120 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 120421120
		arg_497_1.duration_ = 8.1

		local var_497_0 = {
			zh = 4.3,
			ja = 8.1
		}
		local var_497_1 = manager.audio:GetLocalizationFlag()

		if var_497_0[var_497_1] ~= nil then
			arg_497_1.duration_ = var_497_0[var_497_1]
		end

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play120421121(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(arg_497_1.actors_["1075ui_story"]) and arg_497_1.var_.characterEffect1075ui_story == nil then
				arg_497_1.var_.characterEffect1075ui_story = arg_497_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_0 = 0.2

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 and not isNil(arg_497_1.actors_["1075ui_story"]) then
				if arg_497_1.var_.characterEffect1075ui_story and not isNil(arg_497_1.actors_["1075ui_story"]) then
					arg_497_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 and not isNil(arg_497_1.actors_["1075ui_story"]) and arg_497_1.var_.characterEffect1075ui_story then
				arg_497_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_500_2 = arg_497_1.actors_["1074ui_story"]

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(var_500_2) and arg_497_1.var_.characterEffect1074ui_story == nil then
				arg_497_1.var_.characterEffect1074ui_story = var_500_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_3 = 0.2

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_3 and not isNil(var_500_2) then
				if arg_497_1.var_.characterEffect1074ui_story and not isNil(var_500_2) then
					arg_497_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_497_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_497_1.time_ - 0) / var_500_3)
				end
			end

			if arg_497_1.time_ >= 0 + var_500_3 and arg_497_1.time_ < 0 + var_500_3 + arg_500_0 and not isNil(var_500_2) and arg_497_1.var_.characterEffect1074ui_story then
				arg_497_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_497_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_500_4 = arg_497_1.actors_["1075ui_story"].transform

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.var_.moveOldPos1075ui_story = var_500_4.localPosition
			end

			local var_500_5 = 0.001

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_5 then
				var_500_4.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_497_1.time_ - 0) / var_500_5)
				var_500_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_500_4.position).x, (manager.ui.mainCamera.transform.position - var_500_4.position).y, (manager.ui.mainCamera.transform.position - var_500_4.position).z)
				var_500_4.localEulerAngles.z = 0
				var_500_4.localEulerAngles.x = 0
				var_500_4.localEulerAngles = var_500_4.localEulerAngles
			end

			if arg_497_1.time_ >= 0 + var_500_5 and arg_497_1.time_ < 0 + var_500_5 + arg_500_0 then
				var_500_4.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_500_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_500_4.position).x, (manager.ui.mainCamera.transform.position - var_500_4.position).y, (manager.ui.mainCamera.transform.position - var_500_4.position).z)
				var_500_4.localEulerAngles.z = 0
				var_500_4.localEulerAngles.x = 0
				var_500_4.localEulerAngles = var_500_4.localEulerAngles
			end

			local var_500_6 = arg_497_1.actors_["10044ui_story"].transform

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.var_.moveOldPos10044ui_story = var_500_6.localPosition
			end

			local var_500_7 = 0.001

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_7 then
				var_500_6.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_497_1.time_ - 0) / var_500_7)
				var_500_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_500_6.position).x, (manager.ui.mainCamera.transform.position - var_500_6.position).y, (manager.ui.mainCamera.transform.position - var_500_6.position).z)
				var_500_6.localEulerAngles.z = 0
				var_500_6.localEulerAngles.x = 0
				var_500_6.localEulerAngles = var_500_6.localEulerAngles
			end

			if arg_497_1.time_ >= 0 + var_500_7 and arg_497_1.time_ < 0 + var_500_7 + arg_500_0 then
				var_500_6.localPosition = Vector3.New(0, 100, 0)
				var_500_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_500_6.position).x, (manager.ui.mainCamera.transform.position - var_500_6.position).y, (manager.ui.mainCamera.transform.position - var_500_6.position).z)
				var_500_6.localEulerAngles.z = 0
				var_500_6.localEulerAngles.x = 0
				var_500_6.localEulerAngles = var_500_6.localEulerAngles
			end

			local var_500_8 = 0
			local var_500_9 = 0.5

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_8 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, true)

				arg_497_1.leftNameTxt_.text = arg_497_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_497_1.leftNameTxt_.transform)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1.leftNameTxt_.text)
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_10 = arg_497_1:GetWordFromCfg(120421120)
				local var_500_11 = arg_497_1:FormatText(var_500_10.content)

				arg_497_1.text_.text = var_500_11

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_13 = 20 <= 0 and var_500_9 or var_500_9 * (utf8.len(var_500_11) / 20)

				if (20 <= 0 and var_500_9 or var_500_9 * (utf8.len(var_500_11) / 20)) > 0 and var_500_9 < var_500_13 then
					arg_497_1.talkMaxDuration = var_500_13

					if var_500_13 + var_500_8 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_13 + var_500_8
					end
				end

				arg_497_1.text_.text = var_500_11
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421120", "story_v_out_120421.awb") ~= 0 then
					local var_500_14 = manager.audio:GetVoiceLength("story_v_out_120421", "120421120", "story_v_out_120421.awb") / 1000

					if var_500_14 + var_500_8 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_14 + var_500_8
					end

					if var_500_10.prefab_name ~= "" and arg_497_1.actors_[var_500_10.prefab_name] ~= nil then
						local var_500_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_497_1.actors_[var_500_10.prefab_name].transform, "story_v_out_120421", "120421120", "story_v_out_120421.awb")

						arg_497_1:RecordAudio("120421120", var_500_15)
						arg_497_1:RecordAudio("120421120", var_500_15)
					else
						arg_497_1:AudioAction("play", "voice", "story_v_out_120421", "120421120", "story_v_out_120421.awb")
					end

					arg_497_1:RecordHistoryTalkVoice("story_v_out_120421", "120421120", "story_v_out_120421.awb")
				end

				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_16 = math.max(var_500_9, arg_497_1.talkMaxDuration)

			if var_500_8 <= arg_497_1.time_ and arg_497_1.time_ < var_500_8 + var_500_16 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_8) / var_500_16

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_8 + var_500_16 and arg_497_1.time_ < var_500_8 + var_500_16 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_497_1:InitPlayNodeList()
	end,
	Play120421121 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 120421121
		arg_501_1.duration_ = 8.97

		local var_501_0 = {
			zh = 5.2,
			ja = 8.966
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play120421122(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			local var_504_0 = 0.625

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_1 = arg_501_1:GetWordFromCfg(120421121)
				local var_504_2 = arg_501_1:FormatText(var_504_1.content)

				arg_501_1.text_.text = var_504_2

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_4 = 25 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_2) / 25)

				if (25 <= 0 and var_504_0 or var_504_0 * (utf8.len(var_504_2) / 25)) > 0 and var_504_0 < var_504_4 then
					arg_501_1.talkMaxDuration = var_504_4

					if var_504_4 + 0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_4 + 0
					end
				end

				arg_501_1.text_.text = var_504_2
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421121", "story_v_out_120421.awb") ~= 0 then
					local var_504_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421121", "story_v_out_120421.awb") / 1000

					if var_504_5 + 0 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_5 + 0
					end

					if var_504_1.prefab_name ~= "" and arg_501_1.actors_[var_504_1.prefab_name] ~= nil then
						local var_504_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_1.prefab_name].transform, "story_v_out_120421", "120421121", "story_v_out_120421.awb")

						arg_501_1:RecordAudio("120421121", var_504_6)
						arg_501_1:RecordAudio("120421121", var_504_6)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_out_120421", "120421121", "story_v_out_120421.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_out_120421", "120421121", "story_v_out_120421.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_7 = math.max(var_504_0, arg_501_1.talkMaxDuration)

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_7 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - 0) / var_504_7

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= 0 + var_504_7 and arg_501_1.time_ < 0 + var_504_7 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {}

		arg_501_1:InitPlayNodeList()
	end,
	Play120421122 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 120421122
		arg_505_1.duration_ = 3.87

		local var_505_0 = {
			zh = 2.366666666666,
			ja = 3.866
		}
		local var_505_1 = manager.audio:GetLocalizationFlag()

		if var_505_0[var_505_1] ~= nil then
			arg_505_1.duration_ = var_505_0[var_505_1]
		end

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play120421123(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(arg_505_1.actors_["1075ui_story"]) and arg_505_1.var_.characterEffect1075ui_story == nil then
				arg_505_1.var_.characterEffect1075ui_story = arg_505_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_0 = 0.2

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_0 and not isNil(arg_505_1.actors_["1075ui_story"]) then
				if arg_505_1.var_.characterEffect1075ui_story and not isNil(arg_505_1.actors_["1075ui_story"]) then
					arg_505_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_505_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_505_1.time_ - 0) / var_508_0)
				end
			end

			if arg_505_1.time_ >= 0 + var_508_0 and arg_505_1.time_ < 0 + var_508_0 + arg_508_0 and not isNil(arg_505_1.actors_["1075ui_story"]) and arg_505_1.var_.characterEffect1075ui_story then
				arg_505_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_505_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_508_1 = arg_505_1.actors_["1074ui_story"]

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(var_508_1) and arg_505_1.var_.characterEffect1074ui_story == nil then
				arg_505_1.var_.characterEffect1074ui_story = var_508_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_508_2 = 0.2

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_2 and not isNil(var_508_1) then
				if arg_505_1.var_.characterEffect1074ui_story and not isNil(var_508_1) then
					arg_505_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_505_1.time_ >= 0 + var_508_2 and arg_505_1.time_ < 0 + var_508_2 + arg_508_0 and not isNil(var_508_1) and arg_505_1.var_.characterEffect1074ui_story then
				arg_505_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_508_4 = 0
			local var_508_5 = 0.175

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_4 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, true)

				arg_505_1.leftNameTxt_.text = arg_505_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_505_1.leftNameTxt_.transform)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1.leftNameTxt_.text)
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_6 = arg_505_1:GetWordFromCfg(120421122)
				local var_508_7 = arg_505_1:FormatText(var_508_6.content)

				arg_505_1.text_.text = var_508_7

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_9 = 7 <= 0 and var_508_5 or var_508_5 * (utf8.len(var_508_7) / 7)

				if (7 <= 0 and var_508_5 or var_508_5 * (utf8.len(var_508_7) / 7)) > 0 and var_508_5 < var_508_9 then
					arg_505_1.talkMaxDuration = var_508_9

					if var_508_9 + var_508_4 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_9 + var_508_4
					end
				end

				arg_505_1.text_.text = var_508_7
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421122", "story_v_out_120421.awb") ~= 0 then
					local var_508_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421122", "story_v_out_120421.awb") / 1000

					if var_508_10 + var_508_4 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_10 + var_508_4
					end

					if var_508_6.prefab_name ~= "" and arg_505_1.actors_[var_508_6.prefab_name] ~= nil then
						local var_508_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_505_1.actors_[var_508_6.prefab_name].transform, "story_v_out_120421", "120421122", "story_v_out_120421.awb")

						arg_505_1:RecordAudio("120421122", var_508_11)
						arg_505_1:RecordAudio("120421122", var_508_11)
					else
						arg_505_1:AudioAction("play", "voice", "story_v_out_120421", "120421122", "story_v_out_120421.awb")
					end

					arg_505_1:RecordHistoryTalkVoice("story_v_out_120421", "120421122", "story_v_out_120421.awb")
				end

				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_12 = math.max(var_508_5, arg_505_1.talkMaxDuration)

			if var_508_4 <= arg_505_1.time_ and arg_505_1.time_ < var_508_4 + var_508_12 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_4) / var_508_12

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_4 + var_508_12 and arg_505_1.time_ < var_508_4 + var_508_12 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {}

		arg_505_1:InitPlayNodeList()
	end,
	Play120421123 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 120421123
		arg_509_1.duration_ = 7.77

		local var_509_0 = {
			zh = 4.033,
			ja = 7.766
		}
		local var_509_1 = manager.audio:GetLocalizationFlag()

		if var_509_0[var_509_1] ~= nil then
			arg_509_1.duration_ = var_509_0[var_509_1]
		end

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play120421124(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(arg_509_1.actors_["1075ui_story"]) and arg_509_1.var_.characterEffect1075ui_story == nil then
				arg_509_1.var_.characterEffect1075ui_story = arg_509_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_0 = 0.2

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_0 and not isNil(arg_509_1.actors_["1075ui_story"]) then
				if arg_509_1.var_.characterEffect1075ui_story and not isNil(arg_509_1.actors_["1075ui_story"]) then
					arg_509_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_509_1.time_ >= 0 + var_512_0 and arg_509_1.time_ < 0 + var_512_0 + arg_512_0 and not isNil(arg_509_1.actors_["1075ui_story"]) and arg_509_1.var_.characterEffect1075ui_story then
				arg_509_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_512_2 = arg_509_1.actors_["1074ui_story"]

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 and not isNil(var_512_2) and arg_509_1.var_.characterEffect1074ui_story == nil then
				arg_509_1.var_.characterEffect1074ui_story = var_512_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_512_3 = 0.2

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_3 and not isNil(var_512_2) then
				if arg_509_1.var_.characterEffect1074ui_story and not isNil(var_512_2) then
					arg_509_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_509_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_509_1.time_ - 0) / var_512_3)
				end
			end

			if arg_509_1.time_ >= 0 + var_512_3 and arg_509_1.time_ < 0 + var_512_3 + arg_512_0 and not isNil(var_512_2) and arg_509_1.var_.characterEffect1074ui_story then
				arg_509_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_509_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_512_4 = 0
			local var_512_5 = 0.525

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= var_512_4 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_6 = arg_509_1:GetWordFromCfg(120421123)
				local var_512_7 = arg_509_1:FormatText(var_512_6.content)

				arg_509_1.text_.text = var_512_7

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_9 = 21 <= 0 and var_512_5 or var_512_5 * (utf8.len(var_512_7) / 21)

				if (21 <= 0 and var_512_5 or var_512_5 * (utf8.len(var_512_7) / 21)) > 0 and var_512_5 < var_512_9 then
					arg_509_1.talkMaxDuration = var_512_9

					if var_512_9 + var_512_4 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_9 + var_512_4
					end
				end

				arg_509_1.text_.text = var_512_7
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421123", "story_v_out_120421.awb") ~= 0 then
					local var_512_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421123", "story_v_out_120421.awb") / 1000

					if var_512_10 + var_512_4 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_10 + var_512_4
					end

					if var_512_6.prefab_name ~= "" and arg_509_1.actors_[var_512_6.prefab_name] ~= nil then
						local var_512_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_6.prefab_name].transform, "story_v_out_120421", "120421123", "story_v_out_120421.awb")

						arg_509_1:RecordAudio("120421123", var_512_11)
						arg_509_1:RecordAudio("120421123", var_512_11)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_out_120421", "120421123", "story_v_out_120421.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_out_120421", "120421123", "story_v_out_120421.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_12 = math.max(var_512_5, arg_509_1.talkMaxDuration)

			if var_512_4 <= arg_509_1.time_ and arg_509_1.time_ < var_512_4 + var_512_12 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - var_512_4) / var_512_12

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= var_512_4 + var_512_12 and arg_509_1.time_ < var_512_4 + var_512_12 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play120421124 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 120421124
		arg_513_1.duration_ = 8.5

		local var_513_0 = {
			zh = 4.8,
			ja = 8.5
		}
		local var_513_1 = manager.audio:GetLocalizationFlag()

		if var_513_0[var_513_1] ~= nil then
			arg_513_1.duration_ = var_513_0[var_513_1]
		end

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play120421125(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.6

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, true)

				arg_513_1.leftNameTxt_.text = arg_513_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_513_1.leftNameTxt_.transform)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1.leftNameTxt_.text)
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_1 = arg_513_1:GetWordFromCfg(120421124)
				local var_516_2 = arg_513_1:FormatText(var_516_1.content)

				arg_513_1.text_.text = var_516_2

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_4 = 24 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_2) / 24)

				if (24 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_2) / 24)) > 0 and var_516_0 < var_516_4 then
					arg_513_1.talkMaxDuration = var_516_4

					if var_516_4 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_4 + 0
					end
				end

				arg_513_1.text_.text = var_516_2
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421124", "story_v_out_120421.awb") ~= 0 then
					local var_516_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421124", "story_v_out_120421.awb") / 1000

					if var_516_5 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_5 + 0
					end

					if var_516_1.prefab_name ~= "" and arg_513_1.actors_[var_516_1.prefab_name] ~= nil then
						local var_516_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_513_1.actors_[var_516_1.prefab_name].transform, "story_v_out_120421", "120421124", "story_v_out_120421.awb")

						arg_513_1:RecordAudio("120421124", var_516_6)
						arg_513_1:RecordAudio("120421124", var_516_6)
					else
						arg_513_1:AudioAction("play", "voice", "story_v_out_120421", "120421124", "story_v_out_120421.awb")
					end

					arg_513_1:RecordHistoryTalkVoice("story_v_out_120421", "120421124", "story_v_out_120421.awb")
				end

				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_7 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_7 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_7

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_7 and arg_513_1.time_ < 0 + var_516_7 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play120421125 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 120421125
		arg_517_1.duration_ = 11.47

		local var_517_0 = {
			zh = 8.566,
			ja = 11.466
		}
		local var_517_1 = manager.audio:GetLocalizationFlag()

		if var_517_0[var_517_1] ~= nil then
			arg_517_1.duration_ = var_517_0[var_517_1]
		end

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play120421126(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 1.1

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, true)

				arg_517_1.leftNameTxt_.text = arg_517_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_517_1.leftNameTxt_.transform)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1.leftNameTxt_.text)
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_1 = arg_517_1:GetWordFromCfg(120421125)
				local var_520_2 = arg_517_1:FormatText(var_520_1.content)

				arg_517_1.text_.text = var_520_2

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_4 = 44 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 44)

				if (44 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_2) / 44)) > 0 and var_520_0 < var_520_4 then
					arg_517_1.talkMaxDuration = var_520_4

					if var_520_4 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_4 + 0
					end
				end

				arg_517_1.text_.text = var_520_2
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421125", "story_v_out_120421.awb") ~= 0 then
					local var_520_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421125", "story_v_out_120421.awb") / 1000

					if var_520_5 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_5 + 0
					end

					if var_520_1.prefab_name ~= "" and arg_517_1.actors_[var_520_1.prefab_name] ~= nil then
						local var_520_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_517_1.actors_[var_520_1.prefab_name].transform, "story_v_out_120421", "120421125", "story_v_out_120421.awb")

						arg_517_1:RecordAudio("120421125", var_520_6)
						arg_517_1:RecordAudio("120421125", var_520_6)
					else
						arg_517_1:AudioAction("play", "voice", "story_v_out_120421", "120421125", "story_v_out_120421.awb")
					end

					arg_517_1:RecordHistoryTalkVoice("story_v_out_120421", "120421125", "story_v_out_120421.awb")
				end

				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_7 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_7 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_7

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_7 and arg_517_1.time_ < 0 + var_520_7 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play120421126 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 120421126
		arg_521_1.duration_ = 3.5

		local var_521_0 = {
			zh = 3.5,
			ja = 1.999999999999
		}
		local var_521_1 = manager.audio:GetLocalizationFlag()

		if var_521_0[var_521_1] ~= nil then
			arg_521_1.duration_ = var_521_0[var_521_1]
		end

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play120421127(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(arg_521_1.actors_["1075ui_story"]) and arg_521_1.var_.characterEffect1075ui_story == nil then
				arg_521_1.var_.characterEffect1075ui_story = arg_521_1.actors_["1075ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_0 = 0.2

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_0 and not isNil(arg_521_1.actors_["1075ui_story"]) then
				if arg_521_1.var_.characterEffect1075ui_story and not isNil(arg_521_1.actors_["1075ui_story"]) then
					arg_521_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_521_1.var_.characterEffect1075ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_521_1.time_ - 0) / var_524_0)
				end
			end

			if arg_521_1.time_ >= 0 + var_524_0 and arg_521_1.time_ < 0 + var_524_0 + arg_524_0 and not isNil(arg_521_1.actors_["1075ui_story"]) and arg_521_1.var_.characterEffect1075ui_story then
				arg_521_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_521_1.var_.characterEffect1075ui_story.fillRatio = 0.5
			end

			local var_524_1 = arg_521_1.actors_["1074ui_story"]

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 and not isNil(var_524_1) and arg_521_1.var_.characterEffect1074ui_story == nil then
				arg_521_1.var_.characterEffect1074ui_story = var_524_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_524_2 = 0.2

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_2 and not isNil(var_524_1) then
				if arg_521_1.var_.characterEffect1074ui_story and not isNil(var_524_1) then
					arg_521_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_521_1.time_ >= 0 + var_524_2 and arg_521_1.time_ < 0 + var_524_2 + arg_524_0 and not isNil(var_524_1) and arg_521_1.var_.characterEffect1074ui_story then
				arg_521_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_1")
			end

			local var_524_4 = 0
			local var_524_5 = 0.125

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= var_524_4 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, true)

				arg_521_1.leftNameTxt_.text = arg_521_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_521_1.leftNameTxt_.transform)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1.leftNameTxt_.text)
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_6 = arg_521_1:GetWordFromCfg(120421126)
				local var_524_7 = arg_521_1:FormatText(var_524_6.content)

				arg_521_1.text_.text = var_524_7

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_9 = 5 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_7) / 5)

				if (5 <= 0 and var_524_5 or var_524_5 * (utf8.len(var_524_7) / 5)) > 0 and var_524_5 < var_524_9 then
					arg_521_1.talkMaxDuration = var_524_9

					if var_524_9 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_9 + var_524_4
					end
				end

				arg_521_1.text_.text = var_524_7
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421126", "story_v_out_120421.awb") ~= 0 then
					local var_524_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421126", "story_v_out_120421.awb") / 1000

					if var_524_10 + var_524_4 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_10 + var_524_4
					end

					if var_524_6.prefab_name ~= "" and arg_521_1.actors_[var_524_6.prefab_name] ~= nil then
						local var_524_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_521_1.actors_[var_524_6.prefab_name].transform, "story_v_out_120421", "120421126", "story_v_out_120421.awb")

						arg_521_1:RecordAudio("120421126", var_524_11)
						arg_521_1:RecordAudio("120421126", var_524_11)
					else
						arg_521_1:AudioAction("play", "voice", "story_v_out_120421", "120421126", "story_v_out_120421.awb")
					end

					arg_521_1:RecordHistoryTalkVoice("story_v_out_120421", "120421126", "story_v_out_120421.awb")
				end

				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_12 = math.max(var_524_5, arg_521_1.talkMaxDuration)

			if var_524_4 <= arg_521_1.time_ and arg_521_1.time_ < var_524_4 + var_524_12 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - var_524_4) / var_524_12

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= var_524_4 + var_524_12 and arg_521_1.time_ < var_524_4 + var_524_12 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play120421127 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 120421127
		arg_525_1.duration_ = 9.4

		local var_525_0 = {
			zh = 5.633,
			ja = 9.4
		}
		local var_525_1 = manager.audio:GetLocalizationFlag()

		if var_525_0[var_525_1] ~= nil then
			arg_525_1.duration_ = var_525_0[var_525_1]
		end

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
		end

		function arg_525_1.playNext_(arg_527_0)
			if arg_527_0 == 1 then
				arg_525_0:Play120421128(arg_525_1)
			end
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(arg_525_1.actors_["10044ui_story"]) and arg_525_1.var_.characterEffect10044ui_story == nil then
				arg_525_1.var_.characterEffect10044ui_story = arg_525_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_0 = 0.2

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_0 and not isNil(arg_525_1.actors_["10044ui_story"]) then
				if arg_525_1.var_.characterEffect10044ui_story and not isNil(arg_525_1.actors_["10044ui_story"]) then
					arg_525_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_525_1.time_ >= 0 + var_528_0 and arg_525_1.time_ < 0 + var_528_0 + arg_528_0 and not isNil(arg_525_1.actors_["10044ui_story"]) and arg_525_1.var_.characterEffect10044ui_story then
				arg_525_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_528_2 = arg_525_1.actors_["1074ui_story"]

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 and not isNil(var_528_2) and arg_525_1.var_.characterEffect1074ui_story == nil then
				arg_525_1.var_.characterEffect1074ui_story = var_528_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_528_3 = 0.2

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_3 and not isNil(var_528_2) then
				if arg_525_1.var_.characterEffect1074ui_story and not isNil(var_528_2) then
					arg_525_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_525_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_525_1.time_ - 0) / var_528_3)
				end
			end

			if arg_525_1.time_ >= 0 + var_528_3 and arg_525_1.time_ < 0 + var_528_3 + arg_528_0 and not isNil(var_528_2) and arg_525_1.var_.characterEffect1074ui_story then
				arg_525_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_525_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_528_4 = arg_525_1.actors_["1075ui_story"].transform

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.var_.moveOldPos1075ui_story = var_528_4.localPosition
			end

			local var_528_5 = 0.001

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_5 then
				var_528_4.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_525_1.time_ - 0) / var_528_5)
				var_528_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_528_4.position).x, (manager.ui.mainCamera.transform.position - var_528_4.position).y, (manager.ui.mainCamera.transform.position - var_528_4.position).z)
				var_528_4.localEulerAngles.z = 0
				var_528_4.localEulerAngles.x = 0
				var_528_4.localEulerAngles = var_528_4.localEulerAngles
			end

			if arg_525_1.time_ >= 0 + var_528_5 and arg_525_1.time_ < 0 + var_528_5 + arg_528_0 then
				var_528_4.localPosition = Vector3.New(0, 100, 0)
				var_528_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_528_4.position).x, (manager.ui.mainCamera.transform.position - var_528_4.position).y, (manager.ui.mainCamera.transform.position - var_528_4.position).z)
				var_528_4.localEulerAngles.z = 0
				var_528_4.localEulerAngles.x = 0
				var_528_4.localEulerAngles = var_528_4.localEulerAngles
			end

			local var_528_6 = arg_525_1.actors_["10044ui_story"].transform

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.var_.moveOldPos10044ui_story = var_528_6.localPosition
			end

			local var_528_7 = 0.001

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_7 then
				var_528_6.localPosition = Vector3.Lerp(arg_525_1.var_.moveOldPos10044ui_story, Vector3.New(0.7, -0.72, -6.3), (arg_525_1.time_ - 0) / var_528_7)
				var_528_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_528_6.position).x, (manager.ui.mainCamera.transform.position - var_528_6.position).y, (manager.ui.mainCamera.transform.position - var_528_6.position).z)
				var_528_6.localEulerAngles.z = 0
				var_528_6.localEulerAngles.x = 0
				var_528_6.localEulerAngles = var_528_6.localEulerAngles
			end

			if arg_525_1.time_ >= 0 + var_528_7 and arg_525_1.time_ < 0 + var_528_7 + arg_528_0 then
				var_528_6.localPosition = Vector3.New(0.7, -0.72, -6.3)
				var_528_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_528_6.position).x, (manager.ui.mainCamera.transform.position - var_528_6.position).y, (manager.ui.mainCamera.transform.position - var_528_6.position).z)
				var_528_6.localEulerAngles.z = 0
				var_528_6.localEulerAngles.x = 0
				var_528_6.localEulerAngles = var_528_6.localEulerAngles
			end

			local var_528_8 = 0
			local var_528_9 = 0.575

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= var_528_8 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, true)

				arg_525_1.leftNameTxt_.text = arg_525_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_525_1.leftNameTxt_.transform)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1.leftNameTxt_.text)
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_10 = arg_525_1:GetWordFromCfg(120421127)
				local var_528_11 = arg_525_1:FormatText(var_528_10.content)

				arg_525_1.text_.text = var_528_11

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_13 = 23 <= 0 and var_528_9 or var_528_9 * (utf8.len(var_528_11) / 23)

				if (23 <= 0 and var_528_9 or var_528_9 * (utf8.len(var_528_11) / 23)) > 0 and var_528_9 < var_528_13 then
					arg_525_1.talkMaxDuration = var_528_13

					if var_528_13 + var_528_8 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_13 + var_528_8
					end
				end

				arg_525_1.text_.text = var_528_11
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421127", "story_v_out_120421.awb") ~= 0 then
					local var_528_14 = manager.audio:GetVoiceLength("story_v_out_120421", "120421127", "story_v_out_120421.awb") / 1000

					if var_528_14 + var_528_8 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_14 + var_528_8
					end

					if var_528_10.prefab_name ~= "" and arg_525_1.actors_[var_528_10.prefab_name] ~= nil then
						local var_528_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_525_1.actors_[var_528_10.prefab_name].transform, "story_v_out_120421", "120421127", "story_v_out_120421.awb")

						arg_525_1:RecordAudio("120421127", var_528_15)
						arg_525_1:RecordAudio("120421127", var_528_15)
					else
						arg_525_1:AudioAction("play", "voice", "story_v_out_120421", "120421127", "story_v_out_120421.awb")
					end

					arg_525_1:RecordHistoryTalkVoice("story_v_out_120421", "120421127", "story_v_out_120421.awb")
				end

				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_16 = math.max(var_528_9, arg_525_1.talkMaxDuration)

			if var_528_8 <= arg_525_1.time_ and arg_525_1.time_ < var_528_8 + var_528_16 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - var_528_8) / var_528_16

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= var_528_8 + var_528_16 and arg_525_1.time_ < var_528_8 + var_528_16 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_525_1:InitPlayNodeList()
	end,
	Play120421128 = function(arg_529_0, arg_529_1)
		arg_529_1.time_ = 0
		arg_529_1.frameCnt_ = 0
		arg_529_1.state_ = "playing"
		arg_529_1.curTalkId_ = 120421128
		arg_529_1.duration_ = 5

		SetActive(arg_529_1.tipsGo_, false)

		function arg_529_1.onSingleLineFinish_()
			arg_529_1.onSingleLineUpdate_ = nil
			arg_529_1.onSingleLineFinish_ = nil
			arg_529_1.state_ = "waiting"
		end

		function arg_529_1.playNext_(arg_531_0)
			if arg_531_0 == 1 then
				arg_529_0:Play120421129(arg_529_1)
			end
		end

		function arg_529_1.onSingleLineUpdate_(arg_532_0)
			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.var_.moveOldPos10044ui_story = arg_529_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_532_0 = 0.001

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_0 then
				arg_529_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_529_1.time_ - 0) / var_532_0)
				arg_529_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_529_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["10044ui_story"].transform.position).z)
				arg_529_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_529_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_529_1.actors_["10044ui_story"].transform.localEulerAngles = arg_529_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_529_1.time_ >= 0 + var_532_0 and arg_529_1.time_ < 0 + var_532_0 + arg_532_0 then
				arg_529_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_529_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_529_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_529_1.actors_["10044ui_story"].transform.position).z)
				arg_529_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_529_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_529_1.actors_["10044ui_story"].transform.localEulerAngles = arg_529_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_532_1 = arg_529_1.actors_["1074ui_story"].transform

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= 0 + arg_532_0 then
				arg_529_1.var_.moveOldPos1074ui_story = var_532_1.localPosition
			end

			local var_532_2 = 0.001

			if 0 <= arg_529_1.time_ and arg_529_1.time_ < 0 + var_532_2 then
				var_532_1.localPosition = Vector3.Lerp(arg_529_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_529_1.time_ - 0) / var_532_2)
				var_532_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_532_1.position).x, (manager.ui.mainCamera.transform.position - var_532_1.position).y, (manager.ui.mainCamera.transform.position - var_532_1.position).z)
				var_532_1.localEulerAngles.z = 0
				var_532_1.localEulerAngles.x = 0
				var_532_1.localEulerAngles = var_532_1.localEulerAngles
			end

			if arg_529_1.time_ >= 0 + var_532_2 and arg_529_1.time_ < 0 + var_532_2 + arg_532_0 then
				var_532_1.localPosition = Vector3.New(0, 100, 0)
				var_532_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_532_1.position).x, (manager.ui.mainCamera.transform.position - var_532_1.position).y, (manager.ui.mainCamera.transform.position - var_532_1.position).z)
				var_532_1.localEulerAngles.z = 0
				var_532_1.localEulerAngles.x = 0
				var_532_1.localEulerAngles = var_532_1.localEulerAngles
			end

			local var_532_3 = 0
			local var_532_4 = 1.075

			if 0 < arg_529_1.time_ and arg_529_1.time_ <= var_532_3 + arg_532_0 then
				arg_529_1.talkMaxDuration = 0
				arg_529_1.dialogCg_.alpha = 1

				arg_529_1.dialog_:SetActive(true)
				SetActive(arg_529_1.leftNameGo_, false)

				arg_529_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_529_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_529_1:RecordName(arg_529_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_529_1.iconTrs_.gameObject, false)
				arg_529_1.callingController_:SetSelectedState("normal")

				local var_532_5 = arg_529_1:FormatText(arg_529_1:GetWordFromCfg(120421128).content)

				arg_529_1.text_.text = var_532_5

				LuaForUtil.ClearLinePrefixSymbol(arg_529_1.text_)

				local var_532_7 = 43 <= 0 and var_532_4 or var_532_4 * (utf8.len(var_532_5) / 43)

				if (43 <= 0 and var_532_4 or var_532_4 * (utf8.len(var_532_5) / 43)) > 0 and var_532_4 < var_532_7 then
					arg_529_1.talkMaxDuration = var_532_7

					if var_532_7 + var_532_3 > arg_529_1.duration_ then
						arg_529_1.duration_ = var_532_7 + var_532_3
					end
				end

				arg_529_1.text_.text = var_532_5
				arg_529_1.typewritter.percent = 0

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(false)
				arg_529_1:RecordContent(arg_529_1.text_.text)
			end

			local var_532_8 = math.max(var_532_4, arg_529_1.talkMaxDuration)

			if var_532_3 <= arg_529_1.time_ and arg_529_1.time_ < var_532_3 + var_532_8 then
				arg_529_1.typewritter.percent = (arg_529_1.time_ - var_532_3) / var_532_8

				arg_529_1.typewritter:SetDirty()
			end

			if arg_529_1.time_ >= var_532_3 + var_532_8 and arg_529_1.time_ < var_532_3 + var_532_8 + arg_532_0 then
				arg_529_1.typewritter.percent = 1

				arg_529_1.typewritter:SetDirty()
				arg_529_1:ShowNextGo(true)
			end
		end

		arg_529_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_529_1:InitPlayNodeList()
	end,
	Play120421129 = function(arg_533_0, arg_533_1)
		arg_533_1.time_ = 0
		arg_533_1.frameCnt_ = 0
		arg_533_1.state_ = "playing"
		arg_533_1.curTalkId_ = 120421129
		arg_533_1.duration_ = 5

		SetActive(arg_533_1.tipsGo_, false)

		function arg_533_1.onSingleLineFinish_()
			arg_533_1.onSingleLineUpdate_ = nil
			arg_533_1.onSingleLineFinish_ = nil
			arg_533_1.state_ = "waiting"
		end

		function arg_533_1.playNext_(arg_535_0)
			if arg_535_0 == 1 then
				arg_533_0:Play120421130(arg_533_1)
			end
		end

		function arg_533_1.onSingleLineUpdate_(arg_536_0)
			local var_536_0 = 1.1

			if 0 < arg_533_1.time_ and arg_533_1.time_ <= 0 + arg_536_0 then
				arg_533_1.talkMaxDuration = 0
				arg_533_1.dialogCg_.alpha = 1

				arg_533_1.dialog_:SetActive(true)
				SetActive(arg_533_1.leftNameGo_, false)

				arg_533_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_533_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_533_1:RecordName(arg_533_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_533_1.iconTrs_.gameObject, false)
				arg_533_1.callingController_:SetSelectedState("normal")

				local var_536_1 = arg_533_1:FormatText(arg_533_1:GetWordFromCfg(120421129).content)

				arg_533_1.text_.text = var_536_1

				LuaForUtil.ClearLinePrefixSymbol(arg_533_1.text_)

				local var_536_3 = 44 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_1) / 44)

				if (44 <= 0 and var_536_0 or var_536_0 * (utf8.len(var_536_1) / 44)) > 0 and var_536_0 < var_536_3 then
					arg_533_1.talkMaxDuration = var_536_3

					if var_536_3 + 0 > arg_533_1.duration_ then
						arg_533_1.duration_ = var_536_3 + 0
					end
				end

				arg_533_1.text_.text = var_536_1
				arg_533_1.typewritter.percent = 0

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(false)
				arg_533_1:RecordContent(arg_533_1.text_.text)
			end

			local var_536_4 = math.max(var_536_0, arg_533_1.talkMaxDuration)

			if 0 <= arg_533_1.time_ and arg_533_1.time_ < 0 + var_536_4 then
				arg_533_1.typewritter.percent = (arg_533_1.time_ - 0) / var_536_4

				arg_533_1.typewritter:SetDirty()
			end

			if arg_533_1.time_ >= 0 + var_536_4 and arg_533_1.time_ < 0 + var_536_4 + arg_536_0 then
				arg_533_1.typewritter.percent = 1

				arg_533_1.typewritter:SetDirty()
				arg_533_1:ShowNextGo(true)
			end
		end

		arg_533_1.nodeConfigList_ = {}

		arg_533_1:InitPlayNodeList()
	end,
	Play120421130 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 120421130
		arg_537_1.duration_ = 5

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play120421131(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			local var_540_0 = 0.825

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, false)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_1 = arg_537_1:FormatText(arg_537_1:GetWordFromCfg(120421130).content)

				arg_537_1.text_.text = var_540_1

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_3 = 33 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 33)

				if (33 <= 0 and var_540_0 or var_540_0 * (utf8.len(var_540_1) / 33)) > 0 and var_540_0 < var_540_3 then
					arg_537_1.talkMaxDuration = var_540_3

					if var_540_3 + 0 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_3 + 0
					end
				end

				arg_537_1.text_.text = var_540_1
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)
				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_4 = math.max(var_540_0, arg_537_1.talkMaxDuration)

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_4 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - 0) / var_540_4

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= 0 + var_540_4 and arg_537_1.time_ < 0 + var_540_4 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {}

		arg_537_1:InitPlayNodeList()
	end,
	Play120421131 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 120421131
		arg_541_1.duration_ = 4.53

		local var_541_0 = {
			zh = 4.533,
			ja = 3.5
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play120421132(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.var_.moveOldPos10044ui_story = arg_541_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_544_0 = 0.001

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 then
				arg_541_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos10044ui_story, Vector3.New(-0.7, -0.72, -6.3), (arg_541_1.time_ - 0) / var_544_0)
				arg_541_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["10044ui_story"].transform.position).z)
				arg_541_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["10044ui_story"].transform.localEulerAngles = arg_541_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 then
				arg_541_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(-0.7, -0.72, -6.3)
				arg_541_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_541_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_541_1.actors_["10044ui_story"].transform.position).z)
				arg_541_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_541_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_541_1.actors_["10044ui_story"].transform.localEulerAngles = arg_541_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_544_1 = arg_541_1.actors_["10044ui_story"]

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(var_544_1) and arg_541_1.var_.characterEffect10044ui_story == nil then
				arg_541_1.var_.characterEffect10044ui_story = var_544_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_544_2 = 0.2

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_2 and not isNil(var_544_1) then
				if arg_541_1.var_.characterEffect10044ui_story and not isNil(var_544_1) then
					arg_541_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_541_1.time_ >= 0 + var_544_2 and arg_541_1.time_ < 0 + var_544_2 + arg_544_0 and not isNil(var_544_1) and arg_541_1.var_.characterEffect10044ui_story then
				arg_541_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_544_4 = arg_541_1.actors_["1074ui_story"].transform

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1.var_.moveOldPos1074ui_story = var_544_4.localPosition
			end

			local var_544_5 = 0.001

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_5 then
				var_544_4.localPosition = Vector3.Lerp(arg_541_1.var_.moveOldPos1074ui_story, Vector3.New(0.7, -1.055, -6.12), (arg_541_1.time_ - 0) / var_544_5)
				var_544_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_544_4.position).x, (manager.ui.mainCamera.transform.position - var_544_4.position).y, (manager.ui.mainCamera.transform.position - var_544_4.position).z)
				var_544_4.localEulerAngles.z = 0
				var_544_4.localEulerAngles.x = 0
				var_544_4.localEulerAngles = var_544_4.localEulerAngles
			end

			if arg_541_1.time_ >= 0 + var_544_5 and arg_541_1.time_ < 0 + var_544_5 + arg_544_0 then
				var_544_4.localPosition = Vector3.New(0.7, -1.055, -6.12)
				var_544_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_544_4.position).x, (manager.ui.mainCamera.transform.position - var_544_4.position).y, (manager.ui.mainCamera.transform.position - var_544_4.position).z)
				var_544_4.localEulerAngles.z = 0
				var_544_4.localEulerAngles.x = 0
				var_544_4.localEulerAngles = var_544_4.localEulerAngles
			end

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 then
				arg_541_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_544_6 = 0
			local var_544_7 = 0.525

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_6 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, false)
				arg_541_1.callingController_:SetSelectedState("normal")

				local var_544_8 = arg_541_1:GetWordFromCfg(120421131)
				local var_544_9 = arg_541_1:FormatText(var_544_8.content)

				arg_541_1.text_.text = var_544_9

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_11 = 21 <= 0 and var_544_7 or var_544_7 * (utf8.len(var_544_9) / 21)

				if (21 <= 0 and var_544_7 or var_544_7 * (utf8.len(var_544_9) / 21)) > 0 and var_544_7 < var_544_11 then
					arg_541_1.talkMaxDuration = var_544_11

					if var_544_11 + var_544_6 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_11 + var_544_6
					end
				end

				arg_541_1.text_.text = var_544_9
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421131", "story_v_out_120421.awb") ~= 0 then
					local var_544_12 = manager.audio:GetVoiceLength("story_v_out_120421", "120421131", "story_v_out_120421.awb") / 1000

					if var_544_12 + var_544_6 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_12 + var_544_6
					end

					if var_544_8.prefab_name ~= "" and arg_541_1.actors_[var_544_8.prefab_name] ~= nil then
						local var_544_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_8.prefab_name].transform, "story_v_out_120421", "120421131", "story_v_out_120421.awb")

						arg_541_1:RecordAudio("120421131", var_544_13)
						arg_541_1:RecordAudio("120421131", var_544_13)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_120421", "120421131", "story_v_out_120421.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_120421", "120421131", "story_v_out_120421.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_14 = math.max(var_544_7, arg_541_1.talkMaxDuration)

			if var_544_6 <= arg_541_1.time_ and arg_541_1.time_ < var_544_6 + var_544_14 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_6) / var_544_14

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_6 + var_544_14 and arg_541_1.time_ < var_544_6 + var_544_14 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_541_1:InitPlayNodeList()
	end,
	Play120421132 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 120421132
		arg_545_1.duration_ = 2

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play120421133(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(arg_545_1.actors_["10044ui_story"]) and arg_545_1.var_.characterEffect10044ui_story == nil then
				arg_545_1.var_.characterEffect10044ui_story = arg_545_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_0 = 0.2

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 and not isNil(arg_545_1.actors_["10044ui_story"]) then
				if arg_545_1.var_.characterEffect10044ui_story and not isNil(arg_545_1.actors_["10044ui_story"]) then
					arg_545_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_545_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_545_1.time_ - 0) / var_548_0)
				end
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 and not isNil(arg_545_1.actors_["10044ui_story"]) and arg_545_1.var_.characterEffect10044ui_story then
				arg_545_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_545_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_548_1 = arg_545_1.actors_["1074ui_story"]

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(var_548_1) and arg_545_1.var_.characterEffect1074ui_story == nil then
				arg_545_1.var_.characterEffect1074ui_story = var_548_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_548_2 = 0.2

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_2 and not isNil(var_548_1) then
				if arg_545_1.var_.characterEffect1074ui_story and not isNil(var_548_1) then
					arg_545_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_545_1.time_ >= 0 + var_548_2 and arg_545_1.time_ < 0 + var_548_2 + arg_548_0 and not isNil(var_548_1) and arg_545_1.var_.characterEffect1074ui_story then
				arg_545_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_548_4 = 0
			local var_548_5 = 0.125

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_4 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_6 = arg_545_1:GetWordFromCfg(120421132)
				local var_548_7 = arg_545_1:FormatText(var_548_6.content)

				arg_545_1.text_.text = var_548_7

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_9 = 5 <= 0 and var_548_5 or var_548_5 * (utf8.len(var_548_7) / 5)

				if (5 <= 0 and var_548_5 or var_548_5 * (utf8.len(var_548_7) / 5)) > 0 and var_548_5 < var_548_9 then
					arg_545_1.talkMaxDuration = var_548_9

					if var_548_9 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_9 + var_548_4
					end
				end

				arg_545_1.text_.text = var_548_7
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421132", "story_v_out_120421.awb") ~= 0 then
					local var_548_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421132", "story_v_out_120421.awb") / 1000

					if var_548_10 + var_548_4 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_10 + var_548_4
					end

					if var_548_6.prefab_name ~= "" and arg_545_1.actors_[var_548_6.prefab_name] ~= nil then
						local var_548_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_6.prefab_name].transform, "story_v_out_120421", "120421132", "story_v_out_120421.awb")

						arg_545_1:RecordAudio("120421132", var_548_11)
						arg_545_1:RecordAudio("120421132", var_548_11)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_120421", "120421132", "story_v_out_120421.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_120421", "120421132", "story_v_out_120421.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_12 = math.max(var_548_5, arg_545_1.talkMaxDuration)

			if var_548_4 <= arg_545_1.time_ and arg_545_1.time_ < var_548_4 + var_548_12 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_4) / var_548_12

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_4 + var_548_12 and arg_545_1.time_ < var_548_4 + var_548_12 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {}

		arg_545_1:InitPlayNodeList()
	end,
	Play120421133 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 120421133
		arg_549_1.duration_ = 7.3

		local var_549_0 = {
			zh = 3.3,
			ja = 7.3
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play120421134(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_552_0 = arg_549_1.actors_["1074ui_story"]

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 and not isNil(var_552_0) and arg_549_1.var_.characterEffect1074ui_story == nil then
				arg_549_1.var_.characterEffect1074ui_story = var_552_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_552_1 = 0.2

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_1 and not isNil(var_552_0) then
				if arg_549_1.var_.characterEffect1074ui_story and not isNil(var_552_0) then
					arg_549_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_549_1.time_ >= 0 + var_552_1 and arg_549_1.time_ < 0 + var_552_1 + arg_552_0 and not isNil(var_552_0) and arg_549_1.var_.characterEffect1074ui_story then
				arg_549_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_552_3 = 0
			local var_552_4 = 0.25

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= var_552_3 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_5 = arg_549_1:GetWordFromCfg(120421133)
				local var_552_6 = arg_549_1:FormatText(var_552_5.content)

				arg_549_1.text_.text = var_552_6

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_8 = 10 <= 0 and var_552_4 or var_552_4 * (utf8.len(var_552_6) / 10)

				if (10 <= 0 and var_552_4 or var_552_4 * (utf8.len(var_552_6) / 10)) > 0 and var_552_4 < var_552_8 then
					arg_549_1.talkMaxDuration = var_552_8

					if var_552_8 + var_552_3 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_8 + var_552_3
					end
				end

				arg_549_1.text_.text = var_552_6
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421133", "story_v_out_120421.awb") ~= 0 then
					local var_552_9 = manager.audio:GetVoiceLength("story_v_out_120421", "120421133", "story_v_out_120421.awb") / 1000

					if var_552_9 + var_552_3 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_9 + var_552_3
					end

					if var_552_5.prefab_name ~= "" and arg_549_1.actors_[var_552_5.prefab_name] ~= nil then
						local var_552_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_5.prefab_name].transform, "story_v_out_120421", "120421133", "story_v_out_120421.awb")

						arg_549_1:RecordAudio("120421133", var_552_10)
						arg_549_1:RecordAudio("120421133", var_552_10)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_120421", "120421133", "story_v_out_120421.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_120421", "120421133", "story_v_out_120421.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_11 = math.max(var_552_4, arg_549_1.talkMaxDuration)

			if var_552_3 <= arg_549_1.time_ and arg_549_1.time_ < var_552_3 + var_552_11 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - var_552_3) / var_552_11

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= var_552_3 + var_552_11 and arg_549_1.time_ < var_552_3 + var_552_11 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play120421134 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 120421134
		arg_553_1.duration_ = 5.3

		local var_553_0 = {
			zh = 4.066,
			ja = 5.3
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play120421135(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(arg_553_1.actors_["1074ui_story"]) and arg_553_1.var_.characterEffect1074ui_story == nil then
				arg_553_1.var_.characterEffect1074ui_story = arg_553_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_0 = 0.2

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 and not isNil(arg_553_1.actors_["1074ui_story"]) then
				if arg_553_1.var_.characterEffect1074ui_story and not isNil(arg_553_1.actors_["1074ui_story"]) then
					arg_553_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_553_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_553_1.time_ - 0) / var_556_0)
				end
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 and not isNil(arg_553_1.actors_["1074ui_story"]) and arg_553_1.var_.characterEffect1074ui_story then
				arg_553_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_553_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_556_1 = arg_553_1.actors_["10044ui_story"]

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(var_556_1) and arg_553_1.var_.characterEffect10044ui_story == nil then
				arg_553_1.var_.characterEffect10044ui_story = var_556_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_556_2 = 0.2

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_2 and not isNil(var_556_1) then
				if arg_553_1.var_.characterEffect10044ui_story and not isNil(var_556_1) then
					arg_553_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_553_1.time_ >= 0 + var_556_2 and arg_553_1.time_ < 0 + var_556_2 + arg_556_0 and not isNil(var_556_1) and arg_553_1.var_.characterEffect10044ui_story then
				arg_553_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_556_4 = 0
			local var_556_5 = 0.4

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_4 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_6 = arg_553_1:GetWordFromCfg(120421134)
				local var_556_7 = arg_553_1:FormatText(var_556_6.content)

				arg_553_1.text_.text = var_556_7

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_9 = 16 <= 0 and var_556_5 or var_556_5 * (utf8.len(var_556_7) / 16)

				if (16 <= 0 and var_556_5 or var_556_5 * (utf8.len(var_556_7) / 16)) > 0 and var_556_5 < var_556_9 then
					arg_553_1.talkMaxDuration = var_556_9

					if var_556_9 + var_556_4 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_9 + var_556_4
					end
				end

				arg_553_1.text_.text = var_556_7
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421134", "story_v_out_120421.awb") ~= 0 then
					local var_556_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421134", "story_v_out_120421.awb") / 1000

					if var_556_10 + var_556_4 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_10 + var_556_4
					end

					if var_556_6.prefab_name ~= "" and arg_553_1.actors_[var_556_6.prefab_name] ~= nil then
						local var_556_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_6.prefab_name].transform, "story_v_out_120421", "120421134", "story_v_out_120421.awb")

						arg_553_1:RecordAudio("120421134", var_556_11)
						arg_553_1:RecordAudio("120421134", var_556_11)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_120421", "120421134", "story_v_out_120421.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_120421", "120421134", "story_v_out_120421.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_12 = math.max(var_556_5, arg_553_1.talkMaxDuration)

			if var_556_4 <= arg_553_1.time_ and arg_553_1.time_ < var_556_4 + var_556_12 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_4) / var_556_12

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_4 + var_556_12 and arg_553_1.time_ < var_556_4 + var_556_12 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {}

		arg_553_1:InitPlayNodeList()
	end,
	Play120421135 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 120421135
		arg_557_1.duration_ = 5

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play120421136(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.var_.moveOldPos10044ui_story = arg_557_1.actors_["10044ui_story"].transform.localPosition
			end

			local var_560_0 = 0.001

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 then
				arg_557_1.actors_["10044ui_story"].transform.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_557_1.time_ - 0) / var_560_0)
				arg_557_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_557_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_557_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_557_1.actors_["10044ui_story"].transform.position).z)
				arg_557_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_557_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_557_1.actors_["10044ui_story"].transform.localEulerAngles = arg_557_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 then
				arg_557_1.actors_["10044ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_557_1.actors_["10044ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_557_1.actors_["10044ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_557_1.actors_["10044ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_557_1.actors_["10044ui_story"].transform.position).z)
				arg_557_1.actors_["10044ui_story"].transform.localEulerAngles.z = 0
				arg_557_1.actors_["10044ui_story"].transform.localEulerAngles.x = 0
				arg_557_1.actors_["10044ui_story"].transform.localEulerAngles = arg_557_1.actors_["10044ui_story"].transform.localEulerAngles
			end

			local var_560_1 = arg_557_1.actors_["1074ui_story"].transform

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 then
				arg_557_1.var_.moveOldPos1074ui_story = var_560_1.localPosition
			end

			local var_560_2 = 0.001

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_2 then
				var_560_1.localPosition = Vector3.Lerp(arg_557_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_557_1.time_ - 0) / var_560_2)
				var_560_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_560_1.position).x, (manager.ui.mainCamera.transform.position - var_560_1.position).y, (manager.ui.mainCamera.transform.position - var_560_1.position).z)
				var_560_1.localEulerAngles.z = 0
				var_560_1.localEulerAngles.x = 0
				var_560_1.localEulerAngles = var_560_1.localEulerAngles
			end

			if arg_557_1.time_ >= 0 + var_560_2 and arg_557_1.time_ < 0 + var_560_2 + arg_560_0 then
				var_560_1.localPosition = Vector3.New(0, 100, 0)
				var_560_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_560_1.position).x, (manager.ui.mainCamera.transform.position - var_560_1.position).y, (manager.ui.mainCamera.transform.position - var_560_1.position).z)
				var_560_1.localEulerAngles.z = 0
				var_560_1.localEulerAngles.x = 0
				var_560_1.localEulerAngles = var_560_1.localEulerAngles
			end

			local var_560_3 = 0
			local var_560_4 = 0.9

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_3 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, false)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_557_1.iconTrs_.gameObject, false)
				arg_557_1.callingController_:SetSelectedState("normal")

				local var_560_5 = arg_557_1:FormatText(arg_557_1:GetWordFromCfg(120421135).content)

				arg_557_1.text_.text = var_560_5

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_7 = 36 <= 0 and var_560_4 or var_560_4 * (utf8.len(var_560_5) / 36)

				if (36 <= 0 and var_560_4 or var_560_4 * (utf8.len(var_560_5) / 36)) > 0 and var_560_4 < var_560_7 then
					arg_557_1.talkMaxDuration = var_560_7

					if var_560_7 + var_560_3 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_7 + var_560_3
					end
				end

				arg_557_1.text_.text = var_560_5
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)
				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_8 = math.max(var_560_4, arg_557_1.talkMaxDuration)

			if var_560_3 <= arg_557_1.time_ and arg_557_1.time_ < var_560_3 + var_560_8 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_3) / var_560_8

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_3 + var_560_8 and arg_557_1.time_ < var_560_3 + var_560_8 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_557_1:InitPlayNodeList()
	end,
	Play120421136 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 120421136
		arg_561_1.duration_ = 12.1

		local var_561_0 = {
			zh = 7.9,
			ja = 12.1
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
		end

		function arg_561_1.playNext_(arg_563_0)
			if arg_563_0 == 1 then
				arg_561_0:Play120421137(arg_561_1)
			end
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.var_.moveOldPos1074ui_story = arg_561_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_564_0 = 0.001

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 then
				arg_561_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_561_1.time_ - 0) / var_564_0)
				arg_561_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1074ui_story"].transform.position).z)
				arg_561_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["1074ui_story"].transform.localEulerAngles = arg_561_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 then
				arg_561_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_561_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_561_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_561_1.actors_["1074ui_story"].transform.position).z)
				arg_561_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_561_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_561_1.actors_["1074ui_story"].transform.localEulerAngles = arg_561_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_564_1 = arg_561_1.actors_["1074ui_story"]

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(var_564_1) and arg_561_1.var_.characterEffect1074ui_story == nil then
				arg_561_1.var_.characterEffect1074ui_story = var_564_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_564_2 = 0.2

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_2 and not isNil(var_564_1) then
				if arg_561_1.var_.characterEffect1074ui_story and not isNil(var_564_1) then
					arg_561_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_561_1.time_ >= 0 + var_564_2 and arg_561_1.time_ < 0 + var_564_2 + arg_564_0 and not isNil(var_564_1) and arg_561_1.var_.characterEffect1074ui_story then
				arg_561_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_564_4 = 0
			local var_564_5 = 0.825

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_4 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_6 = arg_561_1:GetWordFromCfg(120421136)
				local var_564_7 = arg_561_1:FormatText(var_564_6.content)

				arg_561_1.text_.text = var_564_7

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_9 = 33 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 33)

				if (33 <= 0 and var_564_5 or var_564_5 * (utf8.len(var_564_7) / 33)) > 0 and var_564_5 < var_564_9 then
					arg_561_1.talkMaxDuration = var_564_9

					if var_564_9 + var_564_4 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_9 + var_564_4
					end
				end

				arg_561_1.text_.text = var_564_7
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421136", "story_v_out_120421.awb") ~= 0 then
					local var_564_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421136", "story_v_out_120421.awb") / 1000

					if var_564_10 + var_564_4 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_10 + var_564_4
					end

					if var_564_6.prefab_name ~= "" and arg_561_1.actors_[var_564_6.prefab_name] ~= nil then
						local var_564_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_6.prefab_name].transform, "story_v_out_120421", "120421136", "story_v_out_120421.awb")

						arg_561_1:RecordAudio("120421136", var_564_11)
						arg_561_1:RecordAudio("120421136", var_564_11)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_120421", "120421136", "story_v_out_120421.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_120421", "120421136", "story_v_out_120421.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_12 = math.max(var_564_5, arg_561_1.talkMaxDuration)

			if var_564_4 <= arg_561_1.time_ and arg_561_1.time_ < var_564_4 + var_564_12 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_4) / var_564_12

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_4 + var_564_12 and arg_561_1.time_ < var_564_4 + var_564_12 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	Play120421137 = function(arg_565_0, arg_565_1)
		arg_565_1.time_ = 0
		arg_565_1.frameCnt_ = 0
		arg_565_1.state_ = "playing"
		arg_565_1.curTalkId_ = 120421137
		arg_565_1.duration_ = 2.3

		local var_565_0 = {
			zh = 2.166,
			ja = 2.3
		}
		local var_565_1 = manager.audio:GetLocalizationFlag()

		if var_565_0[var_565_1] ~= nil then
			arg_565_1.duration_ = var_565_0[var_565_1]
		end

		SetActive(arg_565_1.tipsGo_, false)

		function arg_565_1.onSingleLineFinish_()
			arg_565_1.onSingleLineUpdate_ = nil
			arg_565_1.onSingleLineFinish_ = nil
			arg_565_1.state_ = "waiting"
		end

		function arg_565_1.playNext_(arg_567_0)
			if arg_567_0 == 1 then
				arg_565_0:Play120421138(arg_565_1)
			end
		end

		function arg_565_1.onSingleLineUpdate_(arg_568_0)
			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 and not isNil(arg_565_1.actors_["1084ui_story"]) and arg_565_1.var_.characterEffect1084ui_story == nil then
				arg_565_1.var_.characterEffect1084ui_story = arg_565_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_0 = 0.2

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_0 and not isNil(arg_565_1.actors_["1084ui_story"]) then
				if arg_565_1.var_.characterEffect1084ui_story and not isNil(arg_565_1.actors_["1084ui_story"]) then
					arg_565_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_565_1.time_ >= 0 + var_568_0 and arg_565_1.time_ < 0 + var_568_0 + arg_568_0 and not isNil(arg_565_1.actors_["1084ui_story"]) and arg_565_1.var_.characterEffect1084ui_story then
				arg_565_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_568_2 = arg_565_1.actors_["1084ui_story"].transform

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1.var_.moveOldPos1084ui_story = var_568_2.localPosition
			end

			local var_568_3 = 0.001

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_3 then
				var_568_2.localPosition = Vector3.Lerp(arg_565_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_565_1.time_ - 0) / var_568_3)
				var_568_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_568_2.position).x, (manager.ui.mainCamera.transform.position - var_568_2.position).y, (manager.ui.mainCamera.transform.position - var_568_2.position).z)
				var_568_2.localEulerAngles.z = 0
				var_568_2.localEulerAngles.x = 0
				var_568_2.localEulerAngles = var_568_2.localEulerAngles
			end

			if arg_565_1.time_ >= 0 + var_568_3 and arg_565_1.time_ < 0 + var_568_3 + arg_568_0 then
				var_568_2.localPosition = Vector3.New(0.7, -0.97, -6)
				var_568_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_568_2.position).x, (manager.ui.mainCamera.transform.position - var_568_2.position).y, (manager.ui.mainCamera.transform.position - var_568_2.position).z)
				var_568_2.localEulerAngles.z = 0
				var_568_2.localEulerAngles.x = 0
				var_568_2.localEulerAngles = var_568_2.localEulerAngles
			end

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 then
				arg_565_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_568_4 = arg_565_1.actors_["1074ui_story"]

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= 0 + arg_568_0 and not isNil(var_568_4) and arg_565_1.var_.characterEffect1074ui_story == nil then
				arg_565_1.var_.characterEffect1074ui_story = var_568_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_568_5 = 0.2

			if 0 <= arg_565_1.time_ and arg_565_1.time_ < 0 + var_568_5 and not isNil(var_568_4) then
				if arg_565_1.var_.characterEffect1074ui_story and not isNil(var_568_4) then
					arg_565_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_565_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_565_1.time_ - 0) / var_568_5)
				end
			end

			if arg_565_1.time_ >= 0 + var_568_5 and arg_565_1.time_ < 0 + var_568_5 + arg_568_0 and not isNil(var_568_4) and arg_565_1.var_.characterEffect1074ui_story then
				arg_565_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_565_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_568_6 = 0
			local var_568_7 = 0.2

			if 0 < arg_565_1.time_ and arg_565_1.time_ <= var_568_6 + arg_568_0 then
				arg_565_1.talkMaxDuration = 0
				arg_565_1.dialogCg_.alpha = 1

				arg_565_1.dialog_:SetActive(true)
				SetActive(arg_565_1.leftNameGo_, true)

				arg_565_1.leftNameTxt_.text = arg_565_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_565_1.leftNameTxt_.transform)

				arg_565_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_565_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_565_1:RecordName(arg_565_1.leftNameTxt_.text)
				SetActive(arg_565_1.iconTrs_.gameObject, false)
				arg_565_1.callingController_:SetSelectedState("normal")

				local var_568_8 = arg_565_1:GetWordFromCfg(120421137)
				local var_568_9 = arg_565_1:FormatText(var_568_8.content)

				arg_565_1.text_.text = var_568_9

				LuaForUtil.ClearLinePrefixSymbol(arg_565_1.text_)

				local var_568_11 = 8 <= 0 and var_568_7 or var_568_7 * (utf8.len(var_568_9) / 8)

				if (8 <= 0 and var_568_7 or var_568_7 * (utf8.len(var_568_9) / 8)) > 0 and var_568_7 < var_568_11 then
					arg_565_1.talkMaxDuration = var_568_11

					if var_568_11 + var_568_6 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_11 + var_568_6
					end
				end

				arg_565_1.text_.text = var_568_9
				arg_565_1.typewritter.percent = 0

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421137", "story_v_out_120421.awb") ~= 0 then
					local var_568_12 = manager.audio:GetVoiceLength("story_v_out_120421", "120421137", "story_v_out_120421.awb") / 1000

					if var_568_12 + var_568_6 > arg_565_1.duration_ then
						arg_565_1.duration_ = var_568_12 + var_568_6
					end

					if var_568_8.prefab_name ~= "" and arg_565_1.actors_[var_568_8.prefab_name] ~= nil then
						local var_568_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_565_1.actors_[var_568_8.prefab_name].transform, "story_v_out_120421", "120421137", "story_v_out_120421.awb")

						arg_565_1:RecordAudio("120421137", var_568_13)
						arg_565_1:RecordAudio("120421137", var_568_13)
					else
						arg_565_1:AudioAction("play", "voice", "story_v_out_120421", "120421137", "story_v_out_120421.awb")
					end

					arg_565_1:RecordHistoryTalkVoice("story_v_out_120421", "120421137", "story_v_out_120421.awb")
				end

				arg_565_1:RecordContent(arg_565_1.text_.text)
			end

			local var_568_14 = math.max(var_568_7, arg_565_1.talkMaxDuration)

			if var_568_6 <= arg_565_1.time_ and arg_565_1.time_ < var_568_6 + var_568_14 then
				arg_565_1.typewritter.percent = (arg_565_1.time_ - var_568_6) / var_568_14

				arg_565_1.typewritter:SetDirty()
			end

			if arg_565_1.time_ >= var_568_6 + var_568_14 and arg_565_1.time_ < var_568_6 + var_568_14 + arg_568_0 then
				arg_565_1.typewritter.percent = 1

				arg_565_1.typewritter:SetDirty()
				arg_565_1:ShowNextGo(true)
			end
		end

		arg_565_1.nodeConfigList_ = {
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

		arg_565_1:InitPlayNodeList()
	end,
	Play120421138 = function(arg_569_0, arg_569_1)
		arg_569_1.time_ = 0
		arg_569_1.frameCnt_ = 0
		arg_569_1.state_ = "playing"
		arg_569_1.curTalkId_ = 120421138
		arg_569_1.duration_ = 7.27

		local var_569_0 = {
			zh = 7.266,
			ja = 6.733
		}
		local var_569_1 = manager.audio:GetLocalizationFlag()

		if var_569_0[var_569_1] ~= nil then
			arg_569_1.duration_ = var_569_0[var_569_1]
		end

		SetActive(arg_569_1.tipsGo_, false)

		function arg_569_1.onSingleLineFinish_()
			arg_569_1.onSingleLineUpdate_ = nil
			arg_569_1.onSingleLineFinish_ = nil
			arg_569_1.state_ = "waiting"
		end

		function arg_569_1.playNext_(arg_571_0)
			if arg_571_0 == 1 then
				arg_569_0:Play120421139(arg_569_1)
			end
		end

		function arg_569_1.onSingleLineUpdate_(arg_572_0)
			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 and not isNil(arg_569_1.actors_["1084ui_story"]) and arg_569_1.var_.characterEffect1084ui_story == nil then
				arg_569_1.var_.characterEffect1084ui_story = arg_569_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_0 = 0.2

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_0 and not isNil(arg_569_1.actors_["1084ui_story"]) then
				if arg_569_1.var_.characterEffect1084ui_story and not isNil(arg_569_1.actors_["1084ui_story"]) then
					arg_569_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_569_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_569_1.time_ - 0) / var_572_0)
				end
			end

			if arg_569_1.time_ >= 0 + var_572_0 and arg_569_1.time_ < 0 + var_572_0 + arg_572_0 and not isNil(arg_569_1.actors_["1084ui_story"]) and arg_569_1.var_.characterEffect1084ui_story then
				arg_569_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_569_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_572_1 = arg_569_1.actors_["1074ui_story"]

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= 0 + arg_572_0 and not isNil(var_572_1) and arg_569_1.var_.characterEffect1074ui_story == nil then
				arg_569_1.var_.characterEffect1074ui_story = var_572_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_572_2 = 0.2

			if 0 <= arg_569_1.time_ and arg_569_1.time_ < 0 + var_572_2 and not isNil(var_572_1) then
				if arg_569_1.var_.characterEffect1074ui_story and not isNil(var_572_1) then
					arg_569_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_569_1.time_ >= 0 + var_572_2 and arg_569_1.time_ < 0 + var_572_2 + arg_572_0 and not isNil(var_572_1) and arg_569_1.var_.characterEffect1074ui_story then
				arg_569_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_572_4 = 0
			local var_572_5 = 0.925

			if 0 < arg_569_1.time_ and arg_569_1.time_ <= var_572_4 + arg_572_0 then
				arg_569_1.talkMaxDuration = 0
				arg_569_1.dialogCg_.alpha = 1

				arg_569_1.dialog_:SetActive(true)
				SetActive(arg_569_1.leftNameGo_, true)

				arg_569_1.leftNameTxt_.text = arg_569_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_569_1.leftNameTxt_.transform)

				arg_569_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_569_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_569_1:RecordName(arg_569_1.leftNameTxt_.text)
				SetActive(arg_569_1.iconTrs_.gameObject, false)
				arg_569_1.callingController_:SetSelectedState("normal")

				local var_572_6 = arg_569_1:GetWordFromCfg(120421138)
				local var_572_7 = arg_569_1:FormatText(var_572_6.content)

				arg_569_1.text_.text = var_572_7

				LuaForUtil.ClearLinePrefixSymbol(arg_569_1.text_)

				local var_572_9 = 37 <= 0 and var_572_5 or var_572_5 * (utf8.len(var_572_7) / 37)

				if (37 <= 0 and var_572_5 or var_572_5 * (utf8.len(var_572_7) / 37)) > 0 and var_572_5 < var_572_9 then
					arg_569_1.talkMaxDuration = var_572_9

					if var_572_9 + var_572_4 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_9 + var_572_4
					end
				end

				arg_569_1.text_.text = var_572_7
				arg_569_1.typewritter.percent = 0

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421138", "story_v_out_120421.awb") ~= 0 then
					local var_572_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421138", "story_v_out_120421.awb") / 1000

					if var_572_10 + var_572_4 > arg_569_1.duration_ then
						arg_569_1.duration_ = var_572_10 + var_572_4
					end

					if var_572_6.prefab_name ~= "" and arg_569_1.actors_[var_572_6.prefab_name] ~= nil then
						local var_572_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_569_1.actors_[var_572_6.prefab_name].transform, "story_v_out_120421", "120421138", "story_v_out_120421.awb")

						arg_569_1:RecordAudio("120421138", var_572_11)
						arg_569_1:RecordAudio("120421138", var_572_11)
					else
						arg_569_1:AudioAction("play", "voice", "story_v_out_120421", "120421138", "story_v_out_120421.awb")
					end

					arg_569_1:RecordHistoryTalkVoice("story_v_out_120421", "120421138", "story_v_out_120421.awb")
				end

				arg_569_1:RecordContent(arg_569_1.text_.text)
			end

			local var_572_12 = math.max(var_572_5, arg_569_1.talkMaxDuration)

			if var_572_4 <= arg_569_1.time_ and arg_569_1.time_ < var_572_4 + var_572_12 then
				arg_569_1.typewritter.percent = (arg_569_1.time_ - var_572_4) / var_572_12

				arg_569_1.typewritter:SetDirty()
			end

			if arg_569_1.time_ >= var_572_4 + var_572_12 and arg_569_1.time_ < var_572_4 + var_572_12 + arg_572_0 then
				arg_569_1.typewritter.percent = 1

				arg_569_1.typewritter:SetDirty()
				arg_569_1:ShowNextGo(true)
			end
		end

		arg_569_1.nodeConfigList_ = {}

		arg_569_1:InitPlayNodeList()
	end,
	Play120421139 = function(arg_573_0, arg_573_1)
		arg_573_1.time_ = 0
		arg_573_1.frameCnt_ = 0
		arg_573_1.state_ = "playing"
		arg_573_1.curTalkId_ = 120421139
		arg_573_1.duration_ = 9.3

		local var_573_0 = {
			zh = 3.5,
			ja = 9.3
		}
		local var_573_1 = manager.audio:GetLocalizationFlag()

		if var_573_0[var_573_1] ~= nil then
			arg_573_1.duration_ = var_573_0[var_573_1]
		end

		SetActive(arg_573_1.tipsGo_, false)

		function arg_573_1.onSingleLineFinish_()
			arg_573_1.onSingleLineUpdate_ = nil
			arg_573_1.onSingleLineFinish_ = nil
			arg_573_1.state_ = "waiting"
		end

		function arg_573_1.playNext_(arg_575_0)
			if arg_575_0 == 1 then
				arg_573_0:Play120421140(arg_573_1)
			end
		end

		function arg_573_1.onSingleLineUpdate_(arg_576_0)
			local var_576_0 = 0.35

			if 0 < arg_573_1.time_ and arg_573_1.time_ <= 0 + arg_576_0 then
				arg_573_1.talkMaxDuration = 0
				arg_573_1.dialogCg_.alpha = 1

				arg_573_1.dialog_:SetActive(true)
				SetActive(arg_573_1.leftNameGo_, true)

				arg_573_1.leftNameTxt_.text = arg_573_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_573_1.leftNameTxt_.transform)

				arg_573_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_573_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_573_1:RecordName(arg_573_1.leftNameTxt_.text)
				SetActive(arg_573_1.iconTrs_.gameObject, false)
				arg_573_1.callingController_:SetSelectedState("normal")

				local var_576_1 = arg_573_1:GetWordFromCfg(120421139)
				local var_576_2 = arg_573_1:FormatText(var_576_1.content)

				arg_573_1.text_.text = var_576_2

				LuaForUtil.ClearLinePrefixSymbol(arg_573_1.text_)

				local var_576_4 = 14 <= 0 and var_576_0 or var_576_0 * (utf8.len(var_576_2) / 14)

				if (14 <= 0 and var_576_0 or var_576_0 * (utf8.len(var_576_2) / 14)) > 0 and var_576_0 < var_576_4 then
					arg_573_1.talkMaxDuration = var_576_4

					if var_576_4 + 0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_4 + 0
					end
				end

				arg_573_1.text_.text = var_576_2
				arg_573_1.typewritter.percent = 0

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421139", "story_v_out_120421.awb") ~= 0 then
					local var_576_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421139", "story_v_out_120421.awb") / 1000

					if var_576_5 + 0 > arg_573_1.duration_ then
						arg_573_1.duration_ = var_576_5 + 0
					end

					if var_576_1.prefab_name ~= "" and arg_573_1.actors_[var_576_1.prefab_name] ~= nil then
						local var_576_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_573_1.actors_[var_576_1.prefab_name].transform, "story_v_out_120421", "120421139", "story_v_out_120421.awb")

						arg_573_1:RecordAudio("120421139", var_576_6)
						arg_573_1:RecordAudio("120421139", var_576_6)
					else
						arg_573_1:AudioAction("play", "voice", "story_v_out_120421", "120421139", "story_v_out_120421.awb")
					end

					arg_573_1:RecordHistoryTalkVoice("story_v_out_120421", "120421139", "story_v_out_120421.awb")
				end

				arg_573_1:RecordContent(arg_573_1.text_.text)
			end

			local var_576_7 = math.max(var_576_0, arg_573_1.talkMaxDuration)

			if 0 <= arg_573_1.time_ and arg_573_1.time_ < 0 + var_576_7 then
				arg_573_1.typewritter.percent = (arg_573_1.time_ - 0) / var_576_7

				arg_573_1.typewritter:SetDirty()
			end

			if arg_573_1.time_ >= 0 + var_576_7 and arg_573_1.time_ < 0 + var_576_7 + arg_576_0 then
				arg_573_1.typewritter.percent = 1

				arg_573_1.typewritter:SetDirty()
				arg_573_1:ShowNextGo(true)
			end
		end

		arg_573_1.nodeConfigList_ = {}

		arg_573_1:InitPlayNodeList()
	end,
	Play120421140 = function(arg_577_0, arg_577_1)
		arg_577_1.time_ = 0
		arg_577_1.frameCnt_ = 0
		arg_577_1.state_ = "playing"
		arg_577_1.curTalkId_ = 120421140
		arg_577_1.duration_ = 5

		SetActive(arg_577_1.tipsGo_, false)

		function arg_577_1.onSingleLineFinish_()
			arg_577_1.onSingleLineUpdate_ = nil
			arg_577_1.onSingleLineFinish_ = nil
			arg_577_1.state_ = "waiting"
		end

		function arg_577_1.playNext_(arg_579_0)
			if arg_579_0 == 1 then
				arg_577_0:Play120421141(arg_577_1)
			end
		end

		function arg_577_1.onSingleLineUpdate_(arg_580_0)
			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1.var_.moveOldPos1084ui_story = arg_577_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_580_0 = 0.001

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_0 then
				arg_577_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_577_1.time_ - 0) / var_580_0)
				arg_577_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_577_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["1084ui_story"].transform.position).z)
				arg_577_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_577_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_577_1.actors_["1084ui_story"].transform.localEulerAngles = arg_577_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_577_1.time_ >= 0 + var_580_0 and arg_577_1.time_ < 0 + var_580_0 + arg_580_0 then
				arg_577_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_577_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_577_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_577_1.actors_["1084ui_story"].transform.position).z)
				arg_577_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_577_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_577_1.actors_["1084ui_story"].transform.localEulerAngles = arg_577_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_580_1 = arg_577_1.actors_["1074ui_story"].transform

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= 0 + arg_580_0 then
				arg_577_1.var_.moveOldPos1074ui_story = var_580_1.localPosition
			end

			local var_580_2 = 0.001

			if 0 <= arg_577_1.time_ and arg_577_1.time_ < 0 + var_580_2 then
				var_580_1.localPosition = Vector3.Lerp(arg_577_1.var_.moveOldPos1074ui_story, Vector3.New(0, 100, 0), (arg_577_1.time_ - 0) / var_580_2)
				var_580_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_580_1.position).x, (manager.ui.mainCamera.transform.position - var_580_1.position).y, (manager.ui.mainCamera.transform.position - var_580_1.position).z)
				var_580_1.localEulerAngles.z = 0
				var_580_1.localEulerAngles.x = 0
				var_580_1.localEulerAngles = var_580_1.localEulerAngles
			end

			if arg_577_1.time_ >= 0 + var_580_2 and arg_577_1.time_ < 0 + var_580_2 + arg_580_0 then
				var_580_1.localPosition = Vector3.New(0, 100, 0)
				var_580_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_580_1.position).x, (manager.ui.mainCamera.transform.position - var_580_1.position).y, (manager.ui.mainCamera.transform.position - var_580_1.position).z)
				var_580_1.localEulerAngles.z = 0
				var_580_1.localEulerAngles.x = 0
				var_580_1.localEulerAngles = var_580_1.localEulerAngles
			end

			local var_580_3 = 0
			local var_580_4 = 0.975

			if 0 < arg_577_1.time_ and arg_577_1.time_ <= var_580_3 + arg_580_0 then
				arg_577_1.talkMaxDuration = 0
				arg_577_1.dialogCg_.alpha = 1

				arg_577_1.dialog_:SetActive(true)
				SetActive(arg_577_1.leftNameGo_, false)

				arg_577_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_577_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_577_1:RecordName(arg_577_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_577_1.iconTrs_.gameObject, false)
				arg_577_1.callingController_:SetSelectedState("normal")

				local var_580_5 = arg_577_1:FormatText(arg_577_1:GetWordFromCfg(120421140).content)

				arg_577_1.text_.text = var_580_5

				LuaForUtil.ClearLinePrefixSymbol(arg_577_1.text_)

				local var_580_7 = 39 <= 0 and var_580_4 or var_580_4 * (utf8.len(var_580_5) / 39)

				if (39 <= 0 and var_580_4 or var_580_4 * (utf8.len(var_580_5) / 39)) > 0 and var_580_4 < var_580_7 then
					arg_577_1.talkMaxDuration = var_580_7

					if var_580_7 + var_580_3 > arg_577_1.duration_ then
						arg_577_1.duration_ = var_580_7 + var_580_3
					end
				end

				arg_577_1.text_.text = var_580_5
				arg_577_1.typewritter.percent = 0

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(false)
				arg_577_1:RecordContent(arg_577_1.text_.text)
			end

			local var_580_8 = math.max(var_580_4, arg_577_1.talkMaxDuration)

			if var_580_3 <= arg_577_1.time_ and arg_577_1.time_ < var_580_3 + var_580_8 then
				arg_577_1.typewritter.percent = (arg_577_1.time_ - var_580_3) / var_580_8

				arg_577_1.typewritter:SetDirty()
			end

			if arg_577_1.time_ >= var_580_3 + var_580_8 and arg_577_1.time_ < var_580_3 + var_580_8 + arg_580_0 then
				arg_577_1.typewritter.percent = 1

				arg_577_1.typewritter:SetDirty()
				arg_577_1:ShowNextGo(true)
			end
		end

		arg_577_1.nodeConfigList_ = {
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
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_577_1:InitPlayNodeList()
	end,
	Play120421141 = function(arg_581_0, arg_581_1)
		arg_581_1.time_ = 0
		arg_581_1.frameCnt_ = 0
		arg_581_1.state_ = "playing"
		arg_581_1.curTalkId_ = 120421141
		arg_581_1.duration_ = 9.67

		local var_581_0 = {
			zh = 6.066,
			ja = 9.666
		}
		local var_581_1 = manager.audio:GetLocalizationFlag()

		if var_581_0[var_581_1] ~= nil then
			arg_581_1.duration_ = var_581_0[var_581_1]
		end

		SetActive(arg_581_1.tipsGo_, false)

		function arg_581_1.onSingleLineFinish_()
			arg_581_1.onSingleLineUpdate_ = nil
			arg_581_1.onSingleLineFinish_ = nil
			arg_581_1.state_ = "waiting"
		end

		function arg_581_1.playNext_(arg_583_0)
			if arg_583_0 == 1 then
				arg_581_0:Play120421142(arg_581_1)
			end
		end

		function arg_581_1.onSingleLineUpdate_(arg_584_0)
			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1.var_.moveOldPos1084ui_story = arg_581_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_584_0 = 0.001

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_0 then
				arg_581_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_581_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_581_1.time_ - 0) / var_584_0)
				arg_581_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_581_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1084ui_story"].transform.position).z)
				arg_581_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_581_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_581_1.actors_["1084ui_story"].transform.localEulerAngles = arg_581_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_581_1.time_ >= 0 + var_584_0 and arg_581_1.time_ < 0 + var_584_0 + arg_584_0 then
				arg_581_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_581_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_581_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_581_1.actors_["1084ui_story"].transform.position).z)
				arg_581_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_581_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_581_1.actors_["1084ui_story"].transform.localEulerAngles = arg_581_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 then
				arg_581_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_584_1 = arg_581_1.actors_["1084ui_story"]

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= 0 + arg_584_0 and not isNil(var_584_1) and arg_581_1.var_.characterEffect1084ui_story == nil then
				arg_581_1.var_.characterEffect1084ui_story = var_584_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_584_2 = 0.2

			if 0 <= arg_581_1.time_ and arg_581_1.time_ < 0 + var_584_2 and not isNil(var_584_1) then
				if arg_581_1.var_.characterEffect1084ui_story and not isNil(var_584_1) then
					arg_581_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_581_1.time_ >= 0 + var_584_2 and arg_581_1.time_ < 0 + var_584_2 + arg_584_0 and not isNil(var_584_1) and arg_581_1.var_.characterEffect1084ui_story then
				arg_581_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_584_4 = 0
			local var_584_5 = 0.525

			if 0 < arg_581_1.time_ and arg_581_1.time_ <= var_584_4 + arg_584_0 then
				arg_581_1.talkMaxDuration = 0
				arg_581_1.dialogCg_.alpha = 1

				arg_581_1.dialog_:SetActive(true)
				SetActive(arg_581_1.leftNameGo_, true)

				arg_581_1.leftNameTxt_.text = arg_581_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_581_1.leftNameTxt_.transform)

				arg_581_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_581_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_581_1:RecordName(arg_581_1.leftNameTxt_.text)
				SetActive(arg_581_1.iconTrs_.gameObject, false)
				arg_581_1.callingController_:SetSelectedState("normal")

				local var_584_6 = arg_581_1:GetWordFromCfg(120421141)
				local var_584_7 = arg_581_1:FormatText(var_584_6.content)

				arg_581_1.text_.text = var_584_7

				LuaForUtil.ClearLinePrefixSymbol(arg_581_1.text_)

				local var_584_9 = 21 <= 0 and var_584_5 or var_584_5 * (utf8.len(var_584_7) / 21)

				if (21 <= 0 and var_584_5 or var_584_5 * (utf8.len(var_584_7) / 21)) > 0 and var_584_5 < var_584_9 then
					arg_581_1.talkMaxDuration = var_584_9

					if var_584_9 + var_584_4 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_9 + var_584_4
					end
				end

				arg_581_1.text_.text = var_584_7
				arg_581_1.typewritter.percent = 0

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421141", "story_v_out_120421.awb") ~= 0 then
					local var_584_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421141", "story_v_out_120421.awb") / 1000

					if var_584_10 + var_584_4 > arg_581_1.duration_ then
						arg_581_1.duration_ = var_584_10 + var_584_4
					end

					if var_584_6.prefab_name ~= "" and arg_581_1.actors_[var_584_6.prefab_name] ~= nil then
						local var_584_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_581_1.actors_[var_584_6.prefab_name].transform, "story_v_out_120421", "120421141", "story_v_out_120421.awb")

						arg_581_1:RecordAudio("120421141", var_584_11)
						arg_581_1:RecordAudio("120421141", var_584_11)
					else
						arg_581_1:AudioAction("play", "voice", "story_v_out_120421", "120421141", "story_v_out_120421.awb")
					end

					arg_581_1:RecordHistoryTalkVoice("story_v_out_120421", "120421141", "story_v_out_120421.awb")
				end

				arg_581_1:RecordContent(arg_581_1.text_.text)
			end

			local var_584_12 = math.max(var_584_5, arg_581_1.talkMaxDuration)

			if var_584_4 <= arg_581_1.time_ and arg_581_1.time_ < var_584_4 + var_584_12 then
				arg_581_1.typewritter.percent = (arg_581_1.time_ - var_584_4) / var_584_12

				arg_581_1.typewritter:SetDirty()
			end

			if arg_581_1.time_ >= var_584_4 + var_584_12 and arg_581_1.time_ < var_584_4 + var_584_12 + arg_584_0 then
				arg_581_1.typewritter.percent = 1

				arg_581_1.typewritter:SetDirty()
				arg_581_1:ShowNextGo(true)
			end
		end

		arg_581_1.nodeConfigList_ = {
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

		arg_581_1:InitPlayNodeList()
	end,
	Play120421142 = function(arg_585_0, arg_585_1)
		arg_585_1.time_ = 0
		arg_585_1.frameCnt_ = 0
		arg_585_1.state_ = "playing"
		arg_585_1.curTalkId_ = 120421142
		arg_585_1.duration_ = 7.33

		local var_585_0 = {
			zh = 3.233,
			ja = 7.333
		}
		local var_585_1 = manager.audio:GetLocalizationFlag()

		if var_585_0[var_585_1] ~= nil then
			arg_585_1.duration_ = var_585_0[var_585_1]
		end

		SetActive(arg_585_1.tipsGo_, false)

		function arg_585_1.onSingleLineFinish_()
			arg_585_1.onSingleLineUpdate_ = nil
			arg_585_1.onSingleLineFinish_ = nil
			arg_585_1.state_ = "waiting"
		end

		function arg_585_1.playNext_(arg_587_0)
			if arg_587_0 == 1 then
				arg_585_0:Play120421143(arg_585_1)
			end
		end

		function arg_585_1.onSingleLineUpdate_(arg_588_0)
			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action1_1")
			end

			local var_588_0 = arg_585_1.actors_["1075ui_story"]

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 and not isNil(var_588_0) and arg_585_1.var_.characterEffect1075ui_story == nil then
				arg_585_1.var_.characterEffect1075ui_story = var_588_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_1 = 0.2

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_1 and not isNil(var_588_0) then
				if arg_585_1.var_.characterEffect1075ui_story and not isNil(var_588_0) then
					arg_585_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_585_1.time_ >= 0 + var_588_1 and arg_585_1.time_ < 0 + var_588_1 + arg_588_0 and not isNil(var_588_0) and arg_585_1.var_.characterEffect1075ui_story then
				arg_585_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_588_3 = arg_585_1.actors_["1075ui_story"].transform

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 then
				arg_585_1.var_.moveOldPos1075ui_story = var_588_3.localPosition
			end

			local var_588_4 = 0.001

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_4 then
				var_588_3.localPosition = Vector3.Lerp(arg_585_1.var_.moveOldPos1075ui_story, Vector3.New(0.7, -1.055, -6.16), (arg_585_1.time_ - 0) / var_588_4)
				var_588_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_588_3.position).x, (manager.ui.mainCamera.transform.position - var_588_3.position).y, (manager.ui.mainCamera.transform.position - var_588_3.position).z)
				var_588_3.localEulerAngles.z = 0
				var_588_3.localEulerAngles.x = 0
				var_588_3.localEulerAngles = var_588_3.localEulerAngles
			end

			if arg_585_1.time_ >= 0 + var_588_4 and arg_585_1.time_ < 0 + var_588_4 + arg_588_0 then
				var_588_3.localPosition = Vector3.New(0.7, -1.055, -6.16)
				var_588_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_588_3.position).x, (manager.ui.mainCamera.transform.position - var_588_3.position).y, (manager.ui.mainCamera.transform.position - var_588_3.position).z)
				var_588_3.localEulerAngles.z = 0
				var_588_3.localEulerAngles.x = 0
				var_588_3.localEulerAngles = var_588_3.localEulerAngles
			end

			local var_588_5 = arg_585_1.actors_["1084ui_story"]

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= 0 + arg_588_0 and not isNil(var_588_5) and arg_585_1.var_.characterEffect1084ui_story == nil then
				arg_585_1.var_.characterEffect1084ui_story = var_588_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_588_6 = 0.2

			if 0 <= arg_585_1.time_ and arg_585_1.time_ < 0 + var_588_6 and not isNil(var_588_5) then
				if arg_585_1.var_.characterEffect1084ui_story and not isNil(var_588_5) then
					arg_585_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_585_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_585_1.time_ - 0) / var_588_6)
				end
			end

			if arg_585_1.time_ >= 0 + var_588_6 and arg_585_1.time_ < 0 + var_588_6 + arg_588_0 and not isNil(var_588_5) and arg_585_1.var_.characterEffect1084ui_story then
				arg_585_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_585_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_588_7 = 0
			local var_588_8 = 0.275

			if 0 < arg_585_1.time_ and arg_585_1.time_ <= var_588_7 + arg_588_0 then
				arg_585_1.talkMaxDuration = 0
				arg_585_1.dialogCg_.alpha = 1

				arg_585_1.dialog_:SetActive(true)
				SetActive(arg_585_1.leftNameGo_, true)

				arg_585_1.leftNameTxt_.text = arg_585_1:FormatText(StoryNameCfg[381].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_585_1.leftNameTxt_.transform)

				arg_585_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_585_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_585_1:RecordName(arg_585_1.leftNameTxt_.text)
				SetActive(arg_585_1.iconTrs_.gameObject, false)
				arg_585_1.callingController_:SetSelectedState("normal")

				local var_588_9 = arg_585_1:GetWordFromCfg(120421142)
				local var_588_10 = arg_585_1:FormatText(var_588_9.content)

				arg_585_1.text_.text = var_588_10

				LuaForUtil.ClearLinePrefixSymbol(arg_585_1.text_)

				local var_588_12 = 11 <= 0 and var_588_8 or var_588_8 * (utf8.len(var_588_10) / 11)

				if (11 <= 0 and var_588_8 or var_588_8 * (utf8.len(var_588_10) / 11)) > 0 and var_588_8 < var_588_12 then
					arg_585_1.talkMaxDuration = var_588_12

					if var_588_12 + var_588_7 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_12 + var_588_7
					end
				end

				arg_585_1.text_.text = var_588_10
				arg_585_1.typewritter.percent = 0

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421142", "story_v_out_120421.awb") ~= 0 then
					local var_588_13 = manager.audio:GetVoiceLength("story_v_out_120421", "120421142", "story_v_out_120421.awb") / 1000

					if var_588_13 + var_588_7 > arg_585_1.duration_ then
						arg_585_1.duration_ = var_588_13 + var_588_7
					end

					if var_588_9.prefab_name ~= "" and arg_585_1.actors_[var_588_9.prefab_name] ~= nil then
						local var_588_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_585_1.actors_[var_588_9.prefab_name].transform, "story_v_out_120421", "120421142", "story_v_out_120421.awb")

						arg_585_1:RecordAudio("120421142", var_588_14)
						arg_585_1:RecordAudio("120421142", var_588_14)
					else
						arg_585_1:AudioAction("play", "voice", "story_v_out_120421", "120421142", "story_v_out_120421.awb")
					end

					arg_585_1:RecordHistoryTalkVoice("story_v_out_120421", "120421142", "story_v_out_120421.awb")
				end

				arg_585_1:RecordContent(arg_585_1.text_.text)
			end

			local var_588_15 = math.max(var_588_8, arg_585_1.talkMaxDuration)

			if var_588_7 <= arg_585_1.time_ and arg_585_1.time_ < var_588_7 + var_588_15 then
				arg_585_1.typewritter.percent = (arg_585_1.time_ - var_588_7) / var_588_15

				arg_585_1.typewritter:SetDirty()
			end

			if arg_585_1.time_ >= var_588_7 + var_588_15 and arg_585_1.time_ < var_588_7 + var_588_15 + arg_588_0 then
				arg_585_1.typewritter.percent = 1

				arg_585_1.typewritter:SetDirty()
				arg_585_1:ShowNextGo(true)
			end
		end

		arg_585_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_585_1:InitPlayNodeList()
	end,
	Play120421143 = function(arg_589_0, arg_589_1)
		arg_589_1.time_ = 0
		arg_589_1.frameCnt_ = 0
		arg_589_1.state_ = "playing"
		arg_589_1.curTalkId_ = 120421143
		arg_589_1.duration_ = 11.77

		local var_589_0 = {
			zh = 8.9,
			ja = 11.766
		}
		local var_589_1 = manager.audio:GetLocalizationFlag()

		if var_589_0[var_589_1] ~= nil then
			arg_589_1.duration_ = var_589_0[var_589_1]
		end

		SetActive(arg_589_1.tipsGo_, false)

		function arg_589_1.onSingleLineFinish_()
			arg_589_1.onSingleLineUpdate_ = nil
			arg_589_1.onSingleLineFinish_ = nil
			arg_589_1.state_ = "waiting"
		end

		function arg_589_1.playNext_(arg_591_0)
			if arg_591_0 == 1 then
				arg_589_0:Play120421144(arg_589_1)
			end
		end

		function arg_589_1.onSingleLineUpdate_(arg_592_0)
			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.var_.moveOldPos1084ui_story = arg_589_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_592_0 = 0.001

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_0 then
				arg_589_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_589_1.time_ - 0) / var_592_0)
				arg_589_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_589_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1084ui_story"].transform.position).z)
				arg_589_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_589_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_589_1.actors_["1084ui_story"].transform.localEulerAngles = arg_589_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_589_1.time_ >= 0 + var_592_0 and arg_589_1.time_ < 0 + var_592_0 + arg_592_0 then
				arg_589_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_589_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_589_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_589_1.actors_["1084ui_story"].transform.position).z)
				arg_589_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_589_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_589_1.actors_["1084ui_story"].transform.localEulerAngles = arg_589_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_592_1 = arg_589_1.actors_["1075ui_story"].transform

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.var_.moveOldPos1075ui_story = var_592_1.localPosition
			end

			local var_592_2 = 0.001

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_2 then
				var_592_1.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos1075ui_story, Vector3.New(0, 100, 0), (arg_589_1.time_ - 0) / var_592_2)
				var_592_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_592_1.position).x, (manager.ui.mainCamera.transform.position - var_592_1.position).y, (manager.ui.mainCamera.transform.position - var_592_1.position).z)
				var_592_1.localEulerAngles.z = 0
				var_592_1.localEulerAngles.x = 0
				var_592_1.localEulerAngles = var_592_1.localEulerAngles
			end

			if arg_589_1.time_ >= 0 + var_592_2 and arg_589_1.time_ < 0 + var_592_2 + arg_592_0 then
				var_592_1.localPosition = Vector3.New(0, 100, 0)
				var_592_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_592_1.position).x, (manager.ui.mainCamera.transform.position - var_592_1.position).y, (manager.ui.mainCamera.transform.position - var_592_1.position).z)
				var_592_1.localEulerAngles.z = 0
				var_592_1.localEulerAngles.x = 0
				var_592_1.localEulerAngles = var_592_1.localEulerAngles
			end

			local var_592_3 = arg_589_1.actors_["10044ui_story"].transform

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1.var_.moveOldPos10044ui_story = var_592_3.localPosition
			end

			local var_592_4 = 0.001

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_4 then
				var_592_3.localPosition = Vector3.Lerp(arg_589_1.var_.moveOldPos10044ui_story, Vector3.New(0, -0.72, -6.3), (arg_589_1.time_ - 0) / var_592_4)
				var_592_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_592_3.position).x, (manager.ui.mainCamera.transform.position - var_592_3.position).y, (manager.ui.mainCamera.transform.position - var_592_3.position).z)
				var_592_3.localEulerAngles.z = 0
				var_592_3.localEulerAngles.x = 0
				var_592_3.localEulerAngles = var_592_3.localEulerAngles
			end

			if arg_589_1.time_ >= 0 + var_592_4 and arg_589_1.time_ < 0 + var_592_4 + arg_592_0 then
				var_592_3.localPosition = Vector3.New(0, -0.72, -6.3)
				var_592_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_592_3.position).x, (manager.ui.mainCamera.transform.position - var_592_3.position).y, (manager.ui.mainCamera.transform.position - var_592_3.position).z)
				var_592_3.localEulerAngles.z = 0
				var_592_3.localEulerAngles.x = 0
				var_592_3.localEulerAngles = var_592_3.localEulerAngles
			end

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 then
				arg_589_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_592_5 = arg_589_1.actors_["10044ui_story"]

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= 0 + arg_592_0 and not isNil(var_592_5) and arg_589_1.var_.characterEffect10044ui_story == nil then
				arg_589_1.var_.characterEffect10044ui_story = var_592_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_592_6 = 0.2

			if 0 <= arg_589_1.time_ and arg_589_1.time_ < 0 + var_592_6 and not isNil(var_592_5) then
				if arg_589_1.var_.characterEffect10044ui_story and not isNil(var_592_5) then
					arg_589_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_589_1.time_ >= 0 + var_592_6 and arg_589_1.time_ < 0 + var_592_6 + arg_592_0 and not isNil(var_592_5) and arg_589_1.var_.characterEffect10044ui_story then
				arg_589_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_592_8 = 0
			local var_592_9 = 0.85

			if 0 < arg_589_1.time_ and arg_589_1.time_ <= var_592_8 + arg_592_0 then
				arg_589_1.talkMaxDuration = 0
				arg_589_1.dialogCg_.alpha = 1

				arg_589_1.dialog_:SetActive(true)
				SetActive(arg_589_1.leftNameGo_, true)

				arg_589_1.leftNameTxt_.text = arg_589_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_589_1.leftNameTxt_.transform)

				arg_589_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_589_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_589_1:RecordName(arg_589_1.leftNameTxt_.text)
				SetActive(arg_589_1.iconTrs_.gameObject, false)
				arg_589_1.callingController_:SetSelectedState("normal")

				local var_592_10 = arg_589_1:GetWordFromCfg(120421143)
				local var_592_11 = arg_589_1:FormatText(var_592_10.content)

				arg_589_1.text_.text = var_592_11

				LuaForUtil.ClearLinePrefixSymbol(arg_589_1.text_)

				local var_592_13 = 34 <= 0 and var_592_9 or var_592_9 * (utf8.len(var_592_11) / 34)

				if (34 <= 0 and var_592_9 or var_592_9 * (utf8.len(var_592_11) / 34)) > 0 and var_592_9 < var_592_13 then
					arg_589_1.talkMaxDuration = var_592_13

					if var_592_13 + var_592_8 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_13 + var_592_8
					end
				end

				arg_589_1.text_.text = var_592_11
				arg_589_1.typewritter.percent = 0

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421143", "story_v_out_120421.awb") ~= 0 then
					local var_592_14 = manager.audio:GetVoiceLength("story_v_out_120421", "120421143", "story_v_out_120421.awb") / 1000

					if var_592_14 + var_592_8 > arg_589_1.duration_ then
						arg_589_1.duration_ = var_592_14 + var_592_8
					end

					if var_592_10.prefab_name ~= "" and arg_589_1.actors_[var_592_10.prefab_name] ~= nil then
						local var_592_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_589_1.actors_[var_592_10.prefab_name].transform, "story_v_out_120421", "120421143", "story_v_out_120421.awb")

						arg_589_1:RecordAudio("120421143", var_592_15)
						arg_589_1:RecordAudio("120421143", var_592_15)
					else
						arg_589_1:AudioAction("play", "voice", "story_v_out_120421", "120421143", "story_v_out_120421.awb")
					end

					arg_589_1:RecordHistoryTalkVoice("story_v_out_120421", "120421143", "story_v_out_120421.awb")
				end

				arg_589_1:RecordContent(arg_589_1.text_.text)
			end

			local var_592_16 = math.max(var_592_9, arg_589_1.talkMaxDuration)

			if var_592_8 <= arg_589_1.time_ and arg_589_1.time_ < var_592_8 + var_592_16 then
				arg_589_1.typewritter.percent = (arg_589_1.time_ - var_592_8) / var_592_16

				arg_589_1.typewritter:SetDirty()
			end

			if arg_589_1.time_ >= var_592_8 + var_592_16 and arg_589_1.time_ < var_592_8 + var_592_16 + arg_592_0 then
				arg_589_1.typewritter.percent = 1

				arg_589_1.typewritter:SetDirty()
				arg_589_1:ShowNextGo(true)
			end
		end

		arg_589_1.nodeConfigList_ = {
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
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_589_1:InitPlayNodeList()
	end,
	Play120421144 = function(arg_593_0, arg_593_1)
		arg_593_1.time_ = 0
		arg_593_1.frameCnt_ = 0
		arg_593_1.state_ = "playing"
		arg_593_1.curTalkId_ = 120421144
		arg_593_1.duration_ = 15.4

		local var_593_0 = {
			zh = 15.4,
			ja = 13.366
		}
		local var_593_1 = manager.audio:GetLocalizationFlag()

		if var_593_0[var_593_1] ~= nil then
			arg_593_1.duration_ = var_593_0[var_593_1]
		end

		SetActive(arg_593_1.tipsGo_, false)

		function arg_593_1.onSingleLineFinish_()
			arg_593_1.onSingleLineUpdate_ = nil
			arg_593_1.onSingleLineFinish_ = nil
			arg_593_1.state_ = "waiting"
		end

		function arg_593_1.playNext_(arg_595_0)
			if arg_595_0 == 1 then
				arg_593_0:Play120421145(arg_593_1)
			end
		end

		function arg_593_1.onSingleLineUpdate_(arg_596_0)
			local var_596_0 = 1.475

			if 0 < arg_593_1.time_ and arg_593_1.time_ <= 0 + arg_596_0 then
				arg_593_1.talkMaxDuration = 0
				arg_593_1.dialogCg_.alpha = 1

				arg_593_1.dialog_:SetActive(true)
				SetActive(arg_593_1.leftNameGo_, true)

				arg_593_1.leftNameTxt_.text = arg_593_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_593_1.leftNameTxt_.transform)

				arg_593_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_593_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_593_1:RecordName(arg_593_1.leftNameTxt_.text)
				SetActive(arg_593_1.iconTrs_.gameObject, false)
				arg_593_1.callingController_:SetSelectedState("normal")

				local var_596_1 = arg_593_1:GetWordFromCfg(120421144)
				local var_596_2 = arg_593_1:FormatText(var_596_1.content)

				arg_593_1.text_.text = var_596_2

				LuaForUtil.ClearLinePrefixSymbol(arg_593_1.text_)

				local var_596_4 = 59 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_2) / 59)

				if (59 <= 0 and var_596_0 or var_596_0 * (utf8.len(var_596_2) / 59)) > 0 and var_596_0 < var_596_4 then
					arg_593_1.talkMaxDuration = var_596_4

					if var_596_4 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_4 + 0
					end
				end

				arg_593_1.text_.text = var_596_2
				arg_593_1.typewritter.percent = 0

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421144", "story_v_out_120421.awb") ~= 0 then
					local var_596_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421144", "story_v_out_120421.awb") / 1000

					if var_596_5 + 0 > arg_593_1.duration_ then
						arg_593_1.duration_ = var_596_5 + 0
					end

					if var_596_1.prefab_name ~= "" and arg_593_1.actors_[var_596_1.prefab_name] ~= nil then
						local var_596_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_593_1.actors_[var_596_1.prefab_name].transform, "story_v_out_120421", "120421144", "story_v_out_120421.awb")

						arg_593_1:RecordAudio("120421144", var_596_6)
						arg_593_1:RecordAudio("120421144", var_596_6)
					else
						arg_593_1:AudioAction("play", "voice", "story_v_out_120421", "120421144", "story_v_out_120421.awb")
					end

					arg_593_1:RecordHistoryTalkVoice("story_v_out_120421", "120421144", "story_v_out_120421.awb")
				end

				arg_593_1:RecordContent(arg_593_1.text_.text)
			end

			local var_596_7 = math.max(var_596_0, arg_593_1.talkMaxDuration)

			if 0 <= arg_593_1.time_ and arg_593_1.time_ < 0 + var_596_7 then
				arg_593_1.typewritter.percent = (arg_593_1.time_ - 0) / var_596_7

				arg_593_1.typewritter:SetDirty()
			end

			if arg_593_1.time_ >= 0 + var_596_7 and arg_593_1.time_ < 0 + var_596_7 + arg_596_0 then
				arg_593_1.typewritter.percent = 1

				arg_593_1.typewritter:SetDirty()
				arg_593_1:ShowNextGo(true)
			end
		end

		arg_593_1.nodeConfigList_ = {}

		arg_593_1:InitPlayNodeList()
	end,
	Play120421145 = function(arg_597_0, arg_597_1)
		arg_597_1.time_ = 0
		arg_597_1.frameCnt_ = 0
		arg_597_1.state_ = "playing"
		arg_597_1.curTalkId_ = 120421145
		arg_597_1.duration_ = 7.8

		local var_597_0 = {
			zh = 7.066,
			ja = 7.8
		}
		local var_597_1 = manager.audio:GetLocalizationFlag()

		if var_597_0[var_597_1] ~= nil then
			arg_597_1.duration_ = var_597_0[var_597_1]
		end

		SetActive(arg_597_1.tipsGo_, false)

		function arg_597_1.onSingleLineFinish_()
			arg_597_1.onSingleLineUpdate_ = nil
			arg_597_1.onSingleLineFinish_ = nil
			arg_597_1.state_ = "waiting"
		end

		function arg_597_1.playNext_(arg_599_0)
			if arg_599_0 == 1 then
				arg_597_0:Play120421146(arg_597_1)
			end
		end

		function arg_597_1.onSingleLineUpdate_(arg_600_0)
			local var_600_0 = 0.65

			if 0 < arg_597_1.time_ and arg_597_1.time_ <= 0 + arg_600_0 then
				arg_597_1.talkMaxDuration = 0
				arg_597_1.dialogCg_.alpha = 1

				arg_597_1.dialog_:SetActive(true)
				SetActive(arg_597_1.leftNameGo_, true)

				arg_597_1.leftNameTxt_.text = arg_597_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_597_1.leftNameTxt_.transform)

				arg_597_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_597_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_597_1:RecordName(arg_597_1.leftNameTxt_.text)
				SetActive(arg_597_1.iconTrs_.gameObject, false)
				arg_597_1.callingController_:SetSelectedState("normal")

				local var_600_1 = arg_597_1:GetWordFromCfg(120421145)
				local var_600_2 = arg_597_1:FormatText(var_600_1.content)

				arg_597_1.text_.text = var_600_2

				LuaForUtil.ClearLinePrefixSymbol(arg_597_1.text_)

				local var_600_4 = 26 <= 0 and var_600_0 or var_600_0 * (utf8.len(var_600_2) / 26)

				if (26 <= 0 and var_600_0 or var_600_0 * (utf8.len(var_600_2) / 26)) > 0 and var_600_0 < var_600_4 then
					arg_597_1.talkMaxDuration = var_600_4

					if var_600_4 + 0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_4 + 0
					end
				end

				arg_597_1.text_.text = var_600_2
				arg_597_1.typewritter.percent = 0

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421145", "story_v_out_120421.awb") ~= 0 then
					local var_600_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421145", "story_v_out_120421.awb") / 1000

					if var_600_5 + 0 > arg_597_1.duration_ then
						arg_597_1.duration_ = var_600_5 + 0
					end

					if var_600_1.prefab_name ~= "" and arg_597_1.actors_[var_600_1.prefab_name] ~= nil then
						local var_600_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_597_1.actors_[var_600_1.prefab_name].transform, "story_v_out_120421", "120421145", "story_v_out_120421.awb")

						arg_597_1:RecordAudio("120421145", var_600_6)
						arg_597_1:RecordAudio("120421145", var_600_6)
					else
						arg_597_1:AudioAction("play", "voice", "story_v_out_120421", "120421145", "story_v_out_120421.awb")
					end

					arg_597_1:RecordHistoryTalkVoice("story_v_out_120421", "120421145", "story_v_out_120421.awb")
				end

				arg_597_1:RecordContent(arg_597_1.text_.text)
			end

			local var_600_7 = math.max(var_600_0, arg_597_1.talkMaxDuration)

			if 0 <= arg_597_1.time_ and arg_597_1.time_ < 0 + var_600_7 then
				arg_597_1.typewritter.percent = (arg_597_1.time_ - 0) / var_600_7

				arg_597_1.typewritter:SetDirty()
			end

			if arg_597_1.time_ >= 0 + var_600_7 and arg_597_1.time_ < 0 + var_600_7 + arg_600_0 then
				arg_597_1.typewritter.percent = 1

				arg_597_1.typewritter:SetDirty()
				arg_597_1:ShowNextGo(true)
			end
		end

		arg_597_1.nodeConfigList_ = {}

		arg_597_1:InitPlayNodeList()
	end,
	Play120421146 = function(arg_601_0, arg_601_1)
		arg_601_1.time_ = 0
		arg_601_1.frameCnt_ = 0
		arg_601_1.state_ = "playing"
		arg_601_1.curTalkId_ = 120421146
		arg_601_1.duration_ = 5

		SetActive(arg_601_1.tipsGo_, false)

		function arg_601_1.onSingleLineFinish_()
			arg_601_1.onSingleLineUpdate_ = nil
			arg_601_1.onSingleLineFinish_ = nil
			arg_601_1.state_ = "waiting"
		end

		function arg_601_1.playNext_(arg_603_0)
			if arg_603_0 == 1 then
				arg_601_0:Play120421147(arg_601_1)
			end
		end

		function arg_601_1.onSingleLineUpdate_(arg_604_0)
			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 and not isNil(arg_601_1.actors_["10044ui_story"]) and arg_601_1.var_.characterEffect10044ui_story == nil then
				arg_601_1.var_.characterEffect10044ui_story = arg_601_1.actors_["10044ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_604_0 = 0.2

			if 0 <= arg_601_1.time_ and arg_601_1.time_ < 0 + var_604_0 and not isNil(arg_601_1.actors_["10044ui_story"]) then
				if arg_601_1.var_.characterEffect10044ui_story and not isNil(arg_601_1.actors_["10044ui_story"]) then
					arg_601_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_601_1.var_.characterEffect10044ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_601_1.time_ - 0) / var_604_0)
				end
			end

			if arg_601_1.time_ >= 0 + var_604_0 and arg_601_1.time_ < 0 + var_604_0 + arg_604_0 and not isNil(arg_601_1.actors_["10044ui_story"]) and arg_601_1.var_.characterEffect10044ui_story then
				arg_601_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_601_1.var_.characterEffect10044ui_story.fillRatio = 0.5
			end

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= 0 + arg_604_0 then
				arg_601_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_2")
			end

			local var_604_1 = 0
			local var_604_2 = 0.8

			if 0 < arg_601_1.time_ and arg_601_1.time_ <= var_604_1 + arg_604_0 then
				arg_601_1.talkMaxDuration = 0
				arg_601_1.dialogCg_.alpha = 1

				arg_601_1.dialog_:SetActive(true)
				SetActive(arg_601_1.leftNameGo_, false)

				arg_601_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_601_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_601_1:RecordName(arg_601_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_601_1.iconTrs_.gameObject, false)
				arg_601_1.callingController_:SetSelectedState("normal")

				local var_604_3 = arg_601_1:FormatText(arg_601_1:GetWordFromCfg(120421146).content)

				arg_601_1.text_.text = var_604_3

				LuaForUtil.ClearLinePrefixSymbol(arg_601_1.text_)

				local var_604_5 = 32 <= 0 and var_604_2 or var_604_2 * (utf8.len(var_604_3) / 32)

				if (32 <= 0 and var_604_2 or var_604_2 * (utf8.len(var_604_3) / 32)) > 0 and var_604_2 < var_604_5 then
					arg_601_1.talkMaxDuration = var_604_5

					if var_604_5 + var_604_1 > arg_601_1.duration_ then
						arg_601_1.duration_ = var_604_5 + var_604_1
					end
				end

				arg_601_1.text_.text = var_604_3
				arg_601_1.typewritter.percent = 0

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(false)
				arg_601_1:RecordContent(arg_601_1.text_.text)
			end

			local var_604_6 = math.max(var_604_2, arg_601_1.talkMaxDuration)

			if var_604_1 <= arg_601_1.time_ and arg_601_1.time_ < var_604_1 + var_604_6 then
				arg_601_1.typewritter.percent = (arg_601_1.time_ - var_604_1) / var_604_6

				arg_601_1.typewritter:SetDirty()
			end

			if arg_601_1.time_ >= var_604_1 + var_604_6 and arg_601_1.time_ < var_604_1 + var_604_6 + arg_604_0 then
				arg_601_1.typewritter.percent = 1

				arg_601_1.typewritter:SetDirty()
				arg_601_1:ShowNextGo(true)
			end
		end

		arg_601_1.nodeConfigList_ = {}

		arg_601_1:InitPlayNodeList()
	end,
	Play120421147 = function(arg_605_0, arg_605_1)
		arg_605_1.time_ = 0
		arg_605_1.frameCnt_ = 0
		arg_605_1.state_ = "playing"
		arg_605_1.curTalkId_ = 120421147
		arg_605_1.duration_ = 6.07

		local var_605_0 = {
			zh = 4.966,
			ja = 6.066
		}
		local var_605_1 = manager.audio:GetLocalizationFlag()

		if var_605_0[var_605_1] ~= nil then
			arg_605_1.duration_ = var_605_0[var_605_1]
		end

		SetActive(arg_605_1.tipsGo_, false)

		function arg_605_1.onSingleLineFinish_()
			arg_605_1.onSingleLineUpdate_ = nil
			arg_605_1.onSingleLineFinish_ = nil
			arg_605_1.state_ = "waiting"
		end

		function arg_605_1.playNext_(arg_607_0)
			if arg_607_0 == 1 then
				arg_605_0:Play120421148(arg_605_1)
			end
		end

		function arg_605_1.onSingleLineUpdate_(arg_608_0)
			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 then
				arg_605_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_608_0 = arg_605_1.actors_["10044ui_story"]

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= 0 + arg_608_0 and not isNil(var_608_0) and arg_605_1.var_.characterEffect10044ui_story == nil then
				arg_605_1.var_.characterEffect10044ui_story = var_608_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_608_1 = 0.2

			if 0 <= arg_605_1.time_ and arg_605_1.time_ < 0 + var_608_1 and not isNil(var_608_0) then
				if arg_605_1.var_.characterEffect10044ui_story and not isNil(var_608_0) then
					arg_605_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_605_1.time_ >= 0 + var_608_1 and arg_605_1.time_ < 0 + var_608_1 + arg_608_0 and not isNil(var_608_0) and arg_605_1.var_.characterEffect10044ui_story then
				arg_605_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_608_3 = 0
			local var_608_4 = 0.375

			if 0 < arg_605_1.time_ and arg_605_1.time_ <= var_608_3 + arg_608_0 then
				arg_605_1.talkMaxDuration = 0
				arg_605_1.dialogCg_.alpha = 1

				arg_605_1.dialog_:SetActive(true)
				SetActive(arg_605_1.leftNameGo_, true)

				arg_605_1.leftNameTxt_.text = arg_605_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_605_1.leftNameTxt_.transform)

				arg_605_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_605_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_605_1:RecordName(arg_605_1.leftNameTxt_.text)
				SetActive(arg_605_1.iconTrs_.gameObject, false)
				arg_605_1.callingController_:SetSelectedState("normal")

				local var_608_5 = arg_605_1:GetWordFromCfg(120421147)
				local var_608_6 = arg_605_1:FormatText(var_608_5.content)

				arg_605_1.text_.text = var_608_6

				LuaForUtil.ClearLinePrefixSymbol(arg_605_1.text_)

				local var_608_8 = 15 <= 0 and var_608_4 or var_608_4 * (utf8.len(var_608_6) / 15)

				if (15 <= 0 and var_608_4 or var_608_4 * (utf8.len(var_608_6) / 15)) > 0 and var_608_4 < var_608_8 then
					arg_605_1.talkMaxDuration = var_608_8

					if var_608_8 + var_608_3 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_8 + var_608_3
					end
				end

				arg_605_1.text_.text = var_608_6
				arg_605_1.typewritter.percent = 0

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421147", "story_v_out_120421.awb") ~= 0 then
					local var_608_9 = manager.audio:GetVoiceLength("story_v_out_120421", "120421147", "story_v_out_120421.awb") / 1000

					if var_608_9 + var_608_3 > arg_605_1.duration_ then
						arg_605_1.duration_ = var_608_9 + var_608_3
					end

					if var_608_5.prefab_name ~= "" and arg_605_1.actors_[var_608_5.prefab_name] ~= nil then
						local var_608_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_605_1.actors_[var_608_5.prefab_name].transform, "story_v_out_120421", "120421147", "story_v_out_120421.awb")

						arg_605_1:RecordAudio("120421147", var_608_10)
						arg_605_1:RecordAudio("120421147", var_608_10)
					else
						arg_605_1:AudioAction("play", "voice", "story_v_out_120421", "120421147", "story_v_out_120421.awb")
					end

					arg_605_1:RecordHistoryTalkVoice("story_v_out_120421", "120421147", "story_v_out_120421.awb")
				end

				arg_605_1:RecordContent(arg_605_1.text_.text)
			end

			local var_608_11 = math.max(var_608_4, arg_605_1.talkMaxDuration)

			if var_608_3 <= arg_605_1.time_ and arg_605_1.time_ < var_608_3 + var_608_11 then
				arg_605_1.typewritter.percent = (arg_605_1.time_ - var_608_3) / var_608_11

				arg_605_1.typewritter:SetDirty()
			end

			if arg_605_1.time_ >= var_608_3 + var_608_11 and arg_605_1.time_ < var_608_3 + var_608_11 + arg_608_0 then
				arg_605_1.typewritter.percent = 1

				arg_605_1.typewritter:SetDirty()
				arg_605_1:ShowNextGo(true)
			end
		end

		arg_605_1.nodeConfigList_ = {}

		arg_605_1:InitPlayNodeList()
	end,
	Play120421148 = function(arg_609_0, arg_609_1)
		arg_609_1.time_ = 0
		arg_609_1.frameCnt_ = 0
		arg_609_1.state_ = "playing"
		arg_609_1.curTalkId_ = 120421148
		arg_609_1.duration_ = 9

		SetActive(arg_609_1.tipsGo_, false)

		function arg_609_1.onSingleLineFinish_()
			arg_609_1.onSingleLineUpdate_ = nil
			arg_609_1.onSingleLineFinish_ = nil
			arg_609_1.state_ = "waiting"
		end

		function arg_609_1.playNext_(arg_611_0)
			if arg_611_0 == 1 then
				arg_609_0:Play120421149(arg_609_1)
			end
		end

		function arg_609_1.onSingleLineUpdate_(arg_612_0)
			if 2 < arg_609_1.time_ and arg_609_1.time_ <= 2 + arg_612_0 then
				local var_612_0 = arg_609_1.bgs_.ST29

				arg_609_1.bgs_.ST29.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_612_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_612_1 = var_612_0:GetComponent("SpriteRenderer")

				if var_612_1 and var_612_1.sprite then
					local var_612_2 = 2 * (var_612_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_612_0.transform.localScale = Vector3.New(var_612_2 / var_612_1.sprite.bounds.size.y < var_612_2 * manager.ui.mainCameraCom_.aspect / var_612_1.sprite.bounds.size.x and var_612_2 * manager.ui.mainCameraCom_.aspect / var_612_1.sprite.bounds.size.x or var_612_2 / var_612_1.sprite.bounds.size.y, var_612_2 / var_612_1.sprite.bounds.size.y < var_612_2 * manager.ui.mainCameraCom_.aspect / var_612_1.sprite.bounds.size.x and var_612_2 * manager.ui.mainCameraCom_.aspect / var_612_1.sprite.bounds.size.x or var_612_2 / var_612_1.sprite.bounds.size.y, 0)
				end

				for iter_612_0, iter_612_1 in pairs(arg_609_1.bgs_) do
					if iter_612_0 ~= "ST29" then
						iter_612_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_612_3 = 0

			if 0 < arg_609_1.time_ and arg_609_1.time_ <= var_612_3 + arg_612_0 then
				arg_609_1.mask_.enabled = true
				arg_609_1.mask_.raycastTarget = true

				arg_609_1:SetGaussion(false)
			end

			local var_612_4 = 2

			if var_612_3 <= arg_609_1.time_ and arg_609_1.time_ < var_612_3 + var_612_4 then
				local var_612_5 = Color.New(0, 0, 0)

				var_612_5.a = Mathf.Lerp(0, 1, (arg_609_1.time_ - var_612_3) / var_612_4)
				arg_609_1.mask_.color = var_612_5
			end

			if arg_609_1.time_ >= var_612_3 + var_612_4 and arg_609_1.time_ < var_612_3 + var_612_4 + arg_612_0 then
				local var_612_6 = Color.New(0, 0, 0)

				var_612_6.a = 1
				arg_609_1.mask_.color = var_612_6
			end

			local var_612_7 = 2

			if 2 < arg_609_1.time_ and arg_609_1.time_ <= var_612_7 + arg_612_0 then
				arg_609_1.mask_.enabled = true
				arg_609_1.mask_.raycastTarget = true

				arg_609_1:SetGaussion(false)
			end

			local var_612_8 = 2

			if var_612_7 <= arg_609_1.time_ and arg_609_1.time_ < var_612_7 + var_612_8 then
				local var_612_9 = Color.New(0, 0, 0)

				var_612_9.a = Mathf.Lerp(1, 0, (arg_609_1.time_ - var_612_7) / var_612_8)
				arg_609_1.mask_.color = var_612_9
			end

			if arg_609_1.time_ >= var_612_7 + var_612_8 and arg_609_1.time_ < var_612_7 + var_612_8 + arg_612_0 then
				local var_612_10 = Color.New(0, 0, 0)

				arg_609_1.mask_.enabled = false
				var_612_10.a = 0
				arg_609_1.mask_.color = var_612_10
			end

			local var_612_11 = arg_609_1.actors_["10044ui_story"].transform

			if 1.966 < arg_609_1.time_ and arg_609_1.time_ <= 1.966 + arg_612_0 then
				arg_609_1.var_.moveOldPos10044ui_story = var_612_11.localPosition
			end

			local var_612_12 = 0.001

			if 1.966 <= arg_609_1.time_ and arg_609_1.time_ < 1.966 + var_612_12 then
				var_612_11.localPosition = Vector3.Lerp(arg_609_1.var_.moveOldPos10044ui_story, Vector3.New(0, 100, 0), (arg_609_1.time_ - 1.966) / var_612_12)
				var_612_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_612_11.position).x, (manager.ui.mainCamera.transform.position - var_612_11.position).y, (manager.ui.mainCamera.transform.position - var_612_11.position).z)
				var_612_11.localEulerAngles.z = 0
				var_612_11.localEulerAngles.x = 0
				var_612_11.localEulerAngles = var_612_11.localEulerAngles
			end

			if arg_609_1.time_ >= 1.966 + var_612_12 and arg_609_1.time_ < 1.966 + var_612_12 + arg_612_0 then
				var_612_11.localPosition = Vector3.New(0, 100, 0)
				var_612_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_612_11.position).x, (manager.ui.mainCamera.transform.position - var_612_11.position).y, (manager.ui.mainCamera.transform.position - var_612_11.position).z)
				var_612_11.localEulerAngles.z = 0
				var_612_11.localEulerAngles.x = 0
				var_612_11.localEulerAngles = var_612_11.localEulerAngles
			end

			if arg_609_1.frameCnt_ <= 1 then
				arg_609_1.dialog_:SetActive(false)
			end

			local var_612_13 = 4
			local var_612_14 = 0.675

			if 4 < arg_609_1.time_ and arg_609_1.time_ <= var_612_13 + arg_612_0 then
				arg_609_1.talkMaxDuration = 0

				arg_609_1.dialog_:SetActive(true)

				arg_609_1.dialogCg_.alpha = 0

				local var_612_15 = LeanTween.value(arg_609_1.dialog_, 0, 1, 0.3)

				var_612_15:setOnUpdate(LuaHelper.FloatAction(function(arg_613_0)
					arg_609_1.dialogCg_.alpha = arg_613_0
				end))
				var_612_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_609_1.dialog_)
					var_612_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_609_1.duration_ = arg_609_1.duration_ + 0.3

				SetActive(arg_609_1.leftNameGo_, false)

				arg_609_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_609_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_609_1:RecordName(arg_609_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_609_1.iconTrs_.gameObject, false)
				arg_609_1.callingController_:SetSelectedState("normal")

				local var_612_16 = arg_609_1:FormatText(arg_609_1:GetWordFromCfg(120421148).content)

				arg_609_1.text_.text = var_612_16

				LuaForUtil.ClearLinePrefixSymbol(arg_609_1.text_)

				local var_612_18 = 27 <= 0 and var_612_14 or var_612_14 * (utf8.len(var_612_16) / 27)

				if (27 <= 0 and var_612_14 or var_612_14 * (utf8.len(var_612_16) / 27)) > 0 and var_612_14 < var_612_18 then
					arg_609_1.talkMaxDuration = var_612_18
					var_612_13 = var_612_13 + 0.3

					if var_612_18 + var_612_13 > arg_609_1.duration_ then
						arg_609_1.duration_ = var_612_18 + var_612_13
					end
				end

				arg_609_1.text_.text = var_612_16
				arg_609_1.typewritter.percent = 0

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(false)
				arg_609_1:RecordContent(arg_609_1.text_.text)
			end

			local var_612_19 = var_612_13 + 0.3
			local var_612_20 = math.max(var_612_14, arg_609_1.talkMaxDuration)

			if var_612_13 + 0.3 <= arg_609_1.time_ and arg_609_1.time_ < var_612_19 + var_612_20 then
				arg_609_1.typewritter.percent = (arg_609_1.time_ - var_612_19) / var_612_20

				arg_609_1.typewritter:SetDirty()
			end

			if arg_609_1.time_ >= var_612_19 + var_612_20 and arg_609_1.time_ < var_612_19 + var_612_20 + arg_612_0 then
				arg_609_1.typewritter.percent = 1

				arg_609_1.typewritter:SetDirty()
				arg_609_1:ShowNextGo(true)
			end
		end

		arg_609_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_609_1:InitPlayNodeList()
	end,
	Play120421149 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 120421149
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play120421150(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 0.925

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, false)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_615_1.iconTrs_.gameObject, false)
				arg_615_1.callingController_:SetSelectedState("normal")

				local var_618_1 = arg_615_1:FormatText(arg_615_1:GetWordFromCfg(120421149).content)

				arg_615_1.text_.text = var_618_1

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_3 = 37 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_1) / 37)

				if (37 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_1) / 37)) > 0 and var_618_0 < var_618_3 then
					arg_615_1.talkMaxDuration = var_618_3

					if var_618_3 + 0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_3 + 0
					end
				end

				arg_615_1.text_.text = var_618_1
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_4 = math.max(var_618_0, arg_615_1.talkMaxDuration)

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_4 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - 0) / var_618_4

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= 0 + var_618_4 and arg_615_1.time_ < 0 + var_618_4 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play120421150 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 120421150
		arg_619_1.duration_ = 5

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play120421151(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			local var_622_0 = 0.6

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, false)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_1 = arg_619_1:FormatText(arg_619_1:GetWordFromCfg(120421150).content)

				arg_619_1.text_.text = var_622_1

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_3 = 24 <= 0 and var_622_0 or var_622_0 * (utf8.len(var_622_1) / 24)

				if (24 <= 0 and var_622_0 or var_622_0 * (utf8.len(var_622_1) / 24)) > 0 and var_622_0 < var_622_3 then
					arg_619_1.talkMaxDuration = var_622_3

					if var_622_3 + 0 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_3 + 0
					end
				end

				arg_619_1.text_.text = var_622_1
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)
				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_4 = math.max(var_622_0, arg_619_1.talkMaxDuration)

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_4 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - 0) / var_622_4

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= 0 + var_622_4 and arg_619_1.time_ < 0 + var_622_4 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {}

		arg_619_1:InitPlayNodeList()
	end,
	Play120421151 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 120421151
		arg_623_1.duration_ = 3.9

		local var_623_0 = {
			zh = 3.9,
			ja = 3.5
		}
		local var_623_1 = manager.audio:GetLocalizationFlag()

		if var_623_0[var_623_1] ~= nil then
			arg_623_1.duration_ = var_623_0[var_623_1]
		end

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play120421152(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1.var_.moveOldPos1074ui_story = arg_623_1.actors_["1074ui_story"].transform.localPosition
			end

			local var_626_0 = 0.001

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_0 then
				arg_623_1.actors_["1074ui_story"].transform.localPosition = Vector3.Lerp(arg_623_1.var_.moveOldPos1074ui_story, Vector3.New(-0.7, -1.055, -6.12), (arg_623_1.time_ - 0) / var_626_0)
				arg_623_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_623_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1074ui_story"].transform.position).z)
				arg_623_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_623_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_623_1.actors_["1074ui_story"].transform.localEulerAngles = arg_623_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if arg_623_1.time_ >= 0 + var_626_0 and arg_623_1.time_ < 0 + var_626_0 + arg_626_0 then
				arg_623_1.actors_["1074ui_story"].transform.localPosition = Vector3.New(-0.7, -1.055, -6.12)
				arg_623_1.actors_["1074ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_623_1.actors_["1074ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1074ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_623_1.actors_["1074ui_story"].transform.position).z)
				arg_623_1.actors_["1074ui_story"].transform.localEulerAngles.z = 0
				arg_623_1.actors_["1074ui_story"].transform.localEulerAngles.x = 0
				arg_623_1.actors_["1074ui_story"].transform.localEulerAngles = arg_623_1.actors_["1074ui_story"].transform.localEulerAngles
			end

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_626_1 = arg_623_1.actors_["1074ui_story"]

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(var_626_1) and arg_623_1.var_.characterEffect1074ui_story == nil then
				arg_623_1.var_.characterEffect1074ui_story = var_626_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_2 = 0.2

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_2 and not isNil(var_626_1) then
				if arg_623_1.var_.characterEffect1074ui_story and not isNil(var_626_1) then
					arg_623_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_623_1.time_ >= 0 + var_626_2 and arg_623_1.time_ < 0 + var_626_2 + arg_626_0 and not isNil(var_626_1) and arg_623_1.var_.characterEffect1074ui_story then
				arg_623_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_626_4 = "1076ui_story"

			if arg_623_1.actors_["1076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1076ui_story"))) then
				local var_626_5 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_623_1.stage_.transform)

				var_626_5.name = var_626_4
				var_626_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_623_1.actors_[var_626_4] = var_626_5

				local var_626_6 = var_626_5:GetComponentInChildren(typeof(CharacterEffect))

				var_626_6.enabled = true

				local var_626_7 = GameObjectTools.GetOrAddComponent(var_626_5, typeof(DynamicBoneHelper))

				if var_626_7 then
					var_626_7:EnableDynamicBone(false)
				end

				arg_623_1:ShowWeapon(var_626_6.transform, false)

				arg_623_1.var_[var_626_4 .. "Animator"] = var_626_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_623_1.var_[var_626_4 .. "Animator"].applyRootMotion = true
				arg_623_1.var_[var_626_4 .. "LipSync"] = var_626_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_626_8 = arg_623_1.actors_["1076ui_story"]

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(var_626_8) and arg_623_1.var_.characterEffect1076ui_story == nil then
				arg_623_1.var_.characterEffect1076ui_story = var_626_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_626_9 = 0.2

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_9 and not isNil(var_626_8) then
				if arg_623_1.var_.characterEffect1076ui_story and not isNil(var_626_8) then
					arg_623_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_623_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_623_1.time_ - 0) / var_626_9)
				end
			end

			if arg_623_1.time_ >= 0 + var_626_9 and arg_623_1.time_ < 0 + var_626_9 + arg_626_0 and not isNil(var_626_8) and arg_623_1.var_.characterEffect1076ui_story then
				arg_623_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_623_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			local var_626_10 = arg_623_1.actors_["1076ui_story"].transform

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 then
				arg_623_1.var_.moveOldPos1076ui_story = var_626_10.localPosition
			end

			local var_626_11 = 0.001

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_11 then
				var_626_10.localPosition = Vector3.Lerp(arg_623_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_623_1.time_ - 0) / var_626_11)
				var_626_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_626_10.position).x, (manager.ui.mainCamera.transform.position - var_626_10.position).y, (manager.ui.mainCamera.transform.position - var_626_10.position).z)
				var_626_10.localEulerAngles.z = 0
				var_626_10.localEulerAngles.x = 0
				var_626_10.localEulerAngles = var_626_10.localEulerAngles
			end

			if arg_623_1.time_ >= 0 + var_626_11 and arg_623_1.time_ < 0 + var_626_11 + arg_626_0 then
				var_626_10.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_626_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_626_10.position).x, (manager.ui.mainCamera.transform.position - var_626_10.position).y, (manager.ui.mainCamera.transform.position - var_626_10.position).z)
				var_626_10.localEulerAngles.z = 0
				var_626_10.localEulerAngles.x = 0
				var_626_10.localEulerAngles = var_626_10.localEulerAngles
			end

			local var_626_12 = 0
			local var_626_13 = 0.225

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_12 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				arg_623_1.leftNameTxt_.text = arg_623_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, false)
				arg_623_1.callingController_:SetSelectedState("normal")

				local var_626_14 = arg_623_1:GetWordFromCfg(120421151)
				local var_626_15 = arg_623_1:FormatText(var_626_14.content)

				arg_623_1.text_.text = var_626_15

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_17 = 9 <= 0 and var_626_13 or var_626_13 * (utf8.len(var_626_15) / 9)

				if (9 <= 0 and var_626_13 or var_626_13 * (utf8.len(var_626_15) / 9)) > 0 and var_626_13 < var_626_17 then
					arg_623_1.talkMaxDuration = var_626_17

					if var_626_17 + var_626_12 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_17 + var_626_12
					end
				end

				arg_623_1.text_.text = var_626_15
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421151", "story_v_out_120421.awb") ~= 0 then
					local var_626_18 = manager.audio:GetVoiceLength("story_v_out_120421", "120421151", "story_v_out_120421.awb") / 1000

					if var_626_18 + var_626_12 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_18 + var_626_12
					end

					if var_626_14.prefab_name ~= "" and arg_623_1.actors_[var_626_14.prefab_name] ~= nil then
						local var_626_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_623_1.actors_[var_626_14.prefab_name].transform, "story_v_out_120421", "120421151", "story_v_out_120421.awb")

						arg_623_1:RecordAudio("120421151", var_626_19)
						arg_623_1:RecordAudio("120421151", var_626_19)
					else
						arg_623_1:AudioAction("play", "voice", "story_v_out_120421", "120421151", "story_v_out_120421.awb")
					end

					arg_623_1:RecordHistoryTalkVoice("story_v_out_120421", "120421151", "story_v_out_120421.awb")
				end

				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_20 = math.max(var_626_13, arg_623_1.talkMaxDuration)

			if var_626_12 <= arg_623_1.time_ and arg_623_1.time_ < var_626_12 + var_626_20 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_12) / var_626_20

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_12 + var_626_20 and arg_623_1.time_ < var_626_12 + var_626_20 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_623_1:InitPlayNodeList()
	end,
	Play120421152 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 120421152
		arg_627_1.duration_ = 5.6

		local var_627_0 = {
			zh = 3.566,
			ja = 5.6
		}
		local var_627_1 = manager.audio:GetLocalizationFlag()

		if var_627_0[var_627_1] ~= nil then
			arg_627_1.duration_ = var_627_0[var_627_1]
		end

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play120421153(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(arg_627_1.actors_["1074ui_story"]) and arg_627_1.var_.characterEffect1074ui_story == nil then
				arg_627_1.var_.characterEffect1074ui_story = arg_627_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_0 = 0.2

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_0 and not isNil(arg_627_1.actors_["1074ui_story"]) then
				if arg_627_1.var_.characterEffect1074ui_story and not isNil(arg_627_1.actors_["1074ui_story"]) then
					arg_627_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_627_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_627_1.time_ - 0) / var_630_0)
				end
			end

			if arg_627_1.time_ >= 0 + var_630_0 and arg_627_1.time_ < 0 + var_630_0 + arg_630_0 and not isNil(arg_627_1.actors_["1074ui_story"]) and arg_627_1.var_.characterEffect1074ui_story then
				arg_627_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_627_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_630_1 = arg_627_1.actors_["1076ui_story"]

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(var_630_1) and arg_627_1.var_.characterEffect1076ui_story == nil then
				arg_627_1.var_.characterEffect1076ui_story = var_630_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_630_2 = 0.2

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_2 and not isNil(var_630_1) then
				if arg_627_1.var_.characterEffect1076ui_story and not isNil(var_630_1) then
					arg_627_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_627_1.time_ >= 0 + var_630_2 and arg_627_1.time_ < 0 + var_630_2 + arg_630_0 and not isNil(var_630_1) and arg_627_1.var_.characterEffect1076ui_story then
				arg_627_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_630_4 = 0
			local var_630_5 = 0.35

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_4 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_6 = arg_627_1:GetWordFromCfg(120421152)
				local var_630_7 = arg_627_1:FormatText(var_630_6.content)

				arg_627_1.text_.text = var_630_7

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_9 = 14 <= 0 and var_630_5 or var_630_5 * (utf8.len(var_630_7) / 14)

				if (14 <= 0 and var_630_5 or var_630_5 * (utf8.len(var_630_7) / 14)) > 0 and var_630_5 < var_630_9 then
					arg_627_1.talkMaxDuration = var_630_9

					if var_630_9 + var_630_4 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_9 + var_630_4
					end
				end

				arg_627_1.text_.text = var_630_7
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421152", "story_v_out_120421.awb") ~= 0 then
					local var_630_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421152", "story_v_out_120421.awb") / 1000

					if var_630_10 + var_630_4 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_10 + var_630_4
					end

					if var_630_6.prefab_name ~= "" and arg_627_1.actors_[var_630_6.prefab_name] ~= nil then
						local var_630_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_6.prefab_name].transform, "story_v_out_120421", "120421152", "story_v_out_120421.awb")

						arg_627_1:RecordAudio("120421152", var_630_11)
						arg_627_1:RecordAudio("120421152", var_630_11)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_out_120421", "120421152", "story_v_out_120421.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_out_120421", "120421152", "story_v_out_120421.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_12 = math.max(var_630_5, arg_627_1.talkMaxDuration)

			if var_630_4 <= arg_627_1.time_ and arg_627_1.time_ < var_630_4 + var_630_12 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_4) / var_630_12

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_4 + var_630_12 and arg_627_1.time_ < var_630_4 + var_630_12 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {}

		arg_627_1:InitPlayNodeList()
	end,
	Play120421153 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 120421153
		arg_631_1.duration_ = 7.3

		local var_631_0 = {
			zh = 6.033,
			ja = 7.3
		}
		local var_631_1 = manager.audio:GetLocalizationFlag()

		if var_631_0[var_631_1] ~= nil then
			arg_631_1.duration_ = var_631_0[var_631_1]
		end

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play120421154(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 and not isNil(arg_631_1.actors_["1074ui_story"]) and arg_631_1.var_.characterEffect1074ui_story == nil then
				arg_631_1.var_.characterEffect1074ui_story = arg_631_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_0 = 0.2

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_0 and not isNil(arg_631_1.actors_["1074ui_story"]) then
				if arg_631_1.var_.characterEffect1074ui_story and not isNil(arg_631_1.actors_["1074ui_story"]) then
					arg_631_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_631_1.time_ >= 0 + var_634_0 and arg_631_1.time_ < 0 + var_634_0 + arg_634_0 and not isNil(arg_631_1.actors_["1074ui_story"]) and arg_631_1.var_.characterEffect1074ui_story then
				arg_631_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_634_2 = arg_631_1.actors_["1076ui_story"]

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 and not isNil(var_634_2) and arg_631_1.var_.characterEffect1076ui_story == nil then
				arg_631_1.var_.characterEffect1076ui_story = var_634_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_634_3 = 0.2

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_3 and not isNil(var_634_2) then
				if arg_631_1.var_.characterEffect1076ui_story and not isNil(var_634_2) then
					arg_631_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_631_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_631_1.time_ - 0) / var_634_3)
				end
			end

			if arg_631_1.time_ >= 0 + var_634_3 and arg_631_1.time_ < 0 + var_634_3 + arg_634_0 and not isNil(var_634_2) and arg_631_1.var_.characterEffect1076ui_story then
				arg_631_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_631_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_634_4 = 0
			local var_634_5 = 0.65

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_4 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, false)
				arg_631_1.callingController_:SetSelectedState("normal")

				local var_634_6 = arg_631_1:GetWordFromCfg(120421153)
				local var_634_7 = arg_631_1:FormatText(var_634_6.content)

				arg_631_1.text_.text = var_634_7

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_9 = 26 <= 0 and var_634_5 or var_634_5 * (utf8.len(var_634_7) / 26)

				if (26 <= 0 and var_634_5 or var_634_5 * (utf8.len(var_634_7) / 26)) > 0 and var_634_5 < var_634_9 then
					arg_631_1.talkMaxDuration = var_634_9

					if var_634_9 + var_634_4 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_9 + var_634_4
					end
				end

				arg_631_1.text_.text = var_634_7
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421153", "story_v_out_120421.awb") ~= 0 then
					local var_634_10 = manager.audio:GetVoiceLength("story_v_out_120421", "120421153", "story_v_out_120421.awb") / 1000

					if var_634_10 + var_634_4 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_10 + var_634_4
					end

					if var_634_6.prefab_name ~= "" and arg_631_1.actors_[var_634_6.prefab_name] ~= nil then
						local var_634_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_631_1.actors_[var_634_6.prefab_name].transform, "story_v_out_120421", "120421153", "story_v_out_120421.awb")

						arg_631_1:RecordAudio("120421153", var_634_11)
						arg_631_1:RecordAudio("120421153", var_634_11)
					else
						arg_631_1:AudioAction("play", "voice", "story_v_out_120421", "120421153", "story_v_out_120421.awb")
					end

					arg_631_1:RecordHistoryTalkVoice("story_v_out_120421", "120421153", "story_v_out_120421.awb")
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

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play120421154 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 120421154
		arg_635_1.duration_ = 6.9

		local var_635_0 = {
			zh = 4.633,
			ja = 6.9
		}
		local var_635_1 = manager.audio:GetLocalizationFlag()

		if var_635_0[var_635_1] ~= nil then
			arg_635_1.duration_ = var_635_0[var_635_1]
		end

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play120421155(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = 0.575

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				arg_635_1.leftNameTxt_.text = arg_635_1:FormatText(StoryNameCfg[410].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, false)
				arg_635_1.callingController_:SetSelectedState("normal")

				local var_638_1 = arg_635_1:GetWordFromCfg(120421154)
				local var_638_2 = arg_635_1:FormatText(var_638_1.content)

				arg_635_1.text_.text = var_638_2

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_4 = 23 <= 0 and var_638_0 or var_638_0 * (utf8.len(var_638_2) / 23)

				if (23 <= 0 and var_638_0 or var_638_0 * (utf8.len(var_638_2) / 23)) > 0 and var_638_0 < var_638_4 then
					arg_635_1.talkMaxDuration = var_638_4

					if var_638_4 + 0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_4 + 0
					end
				end

				arg_635_1.text_.text = var_638_2
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421154", "story_v_out_120421.awb") ~= 0 then
					local var_638_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421154", "story_v_out_120421.awb") / 1000

					if var_638_5 + 0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_5 + 0
					end

					if var_638_1.prefab_name ~= "" and arg_635_1.actors_[var_638_1.prefab_name] ~= nil then
						local var_638_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_635_1.actors_[var_638_1.prefab_name].transform, "story_v_out_120421", "120421154", "story_v_out_120421.awb")

						arg_635_1:RecordAudio("120421154", var_638_6)
						arg_635_1:RecordAudio("120421154", var_638_6)
					else
						arg_635_1:AudioAction("play", "voice", "story_v_out_120421", "120421154", "story_v_out_120421.awb")
					end

					arg_635_1:RecordHistoryTalkVoice("story_v_out_120421", "120421154", "story_v_out_120421.awb")
				end

				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_7 = math.max(var_638_0, arg_635_1.talkMaxDuration)

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_7 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - 0) / var_638_7

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= 0 + var_638_7 and arg_635_1.time_ < 0 + var_638_7 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play120421155 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 120421155
		arg_639_1.duration_ = 3.93

		local var_639_0 = {
			zh = 2.933,
			ja = 3.933
		}
		local var_639_1 = manager.audio:GetLocalizationFlag()

		if var_639_0[var_639_1] ~= nil then
			arg_639_1.duration_ = var_639_0[var_639_1]
		end

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play120421156(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 and not isNil(arg_639_1.actors_["1074ui_story"]) and arg_639_1.var_.characterEffect1074ui_story == nil then
				arg_639_1.var_.characterEffect1074ui_story = arg_639_1.actors_["1074ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_642_0 = 0.2

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_0 and not isNil(arg_639_1.actors_["1074ui_story"]) then
				if arg_639_1.var_.characterEffect1074ui_story and not isNil(arg_639_1.actors_["1074ui_story"]) then
					arg_639_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_639_1.var_.characterEffect1074ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_639_1.time_ - 0) / var_642_0)
				end
			end

			if arg_639_1.time_ >= 0 + var_642_0 and arg_639_1.time_ < 0 + var_642_0 + arg_642_0 and not isNil(arg_639_1.actors_["1074ui_story"]) and arg_639_1.var_.characterEffect1074ui_story then
				arg_639_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_639_1.var_.characterEffect1074ui_story.fillRatio = 0.5
			end

			local var_642_1 = 0
			local var_642_2 = 0.3

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_1 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				arg_639_1.leftNameTxt_.text = arg_639_1:FormatText(StoryNameCfg[379].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, true)
				arg_639_1.iconController_:SetSelectedState("hero")

				arg_639_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_639_1.callingController_:SetSelectedState("normal")

				arg_639_1.keyicon_.color = Color.New(1, 1, 1)
				arg_639_1.icon_.color = Color.New(1, 1, 1)

				local var_642_3 = arg_639_1:GetWordFromCfg(120421155)
				local var_642_4 = arg_639_1:FormatText(var_642_3.content)

				arg_639_1.text_.text = var_642_4

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_6 = 12 <= 0 and var_642_2 or var_642_2 * (utf8.len(var_642_4) / 12)

				if (12 <= 0 and var_642_2 or var_642_2 * (utf8.len(var_642_4) / 12)) > 0 and var_642_2 < var_642_6 then
					arg_639_1.talkMaxDuration = var_642_6

					if var_642_6 + var_642_1 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_6 + var_642_1
					end
				end

				arg_639_1.text_.text = var_642_4
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421155", "story_v_out_120421.awb") ~= 0 then
					local var_642_7 = manager.audio:GetVoiceLength("story_v_out_120421", "120421155", "story_v_out_120421.awb") / 1000

					if var_642_7 + var_642_1 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_7 + var_642_1
					end

					if var_642_3.prefab_name ~= "" and arg_639_1.actors_[var_642_3.prefab_name] ~= nil then
						local var_642_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_3.prefab_name].transform, "story_v_out_120421", "120421155", "story_v_out_120421.awb")

						arg_639_1:RecordAudio("120421155", var_642_8)
						arg_639_1:RecordAudio("120421155", var_642_8)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_out_120421", "120421155", "story_v_out_120421.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_out_120421", "120421155", "story_v_out_120421.awb")
				end

				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_9 = math.max(var_642_2, arg_639_1.talkMaxDuration)

			if var_642_1 <= arg_639_1.time_ and arg_639_1.time_ < var_642_1 + var_642_9 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_1) / var_642_9

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_1 + var_642_9 and arg_639_1.time_ < var_642_1 + var_642_9 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {}

		arg_639_1:InitPlayNodeList()
	end,
	Play120421156 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 120421156
		arg_643_1.duration_ = 8.1

		local var_643_0 = {
			zh = 4.433,
			ja = 8.1
		}
		local var_643_1 = manager.audio:GetLocalizationFlag()

		if var_643_0[var_643_1] ~= nil then
			arg_643_1.duration_ = var_643_0[var_643_1]
		end

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play120421157(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 and not isNil(arg_643_1.actors_["1076ui_story"]) and arg_643_1.var_.characterEffect1076ui_story == nil then
				arg_643_1.var_.characterEffect1076ui_story = arg_643_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_646_0 = 0.2

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_0 and not isNil(arg_643_1.actors_["1076ui_story"]) then
				if arg_643_1.var_.characterEffect1076ui_story and not isNil(arg_643_1.actors_["1076ui_story"]) then
					arg_643_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_643_1.time_ >= 0 + var_646_0 and arg_643_1.time_ < 0 + var_646_0 + arg_646_0 and not isNil(arg_643_1.actors_["1076ui_story"]) and arg_643_1.var_.characterEffect1076ui_story then
				arg_643_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			local var_646_2 = 0
			local var_646_3 = 0.35

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_2 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				arg_643_1.leftNameTxt_.text = arg_643_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, false)
				arg_643_1.callingController_:SetSelectedState("normal")

				local var_646_4 = arg_643_1:GetWordFromCfg(120421156)
				local var_646_5 = arg_643_1:FormatText(var_646_4.content)

				arg_643_1.text_.text = var_646_5

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_7 = 14 <= 0 and var_646_3 or var_646_3 * (utf8.len(var_646_5) / 14)

				if (14 <= 0 and var_646_3 or var_646_3 * (utf8.len(var_646_5) / 14)) > 0 and var_646_3 < var_646_7 then
					arg_643_1.talkMaxDuration = var_646_7

					if var_646_7 + var_646_2 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_7 + var_646_2
					end
				end

				arg_643_1.text_.text = var_646_5
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421156", "story_v_out_120421.awb") ~= 0 then
					local var_646_8 = manager.audio:GetVoiceLength("story_v_out_120421", "120421156", "story_v_out_120421.awb") / 1000

					if var_646_8 + var_646_2 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_8 + var_646_2
					end

					if var_646_4.prefab_name ~= "" and arg_643_1.actors_[var_646_4.prefab_name] ~= nil then
						local var_646_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_643_1.actors_[var_646_4.prefab_name].transform, "story_v_out_120421", "120421156", "story_v_out_120421.awb")

						arg_643_1:RecordAudio("120421156", var_646_9)
						arg_643_1:RecordAudio("120421156", var_646_9)
					else
						arg_643_1:AudioAction("play", "voice", "story_v_out_120421", "120421156", "story_v_out_120421.awb")
					end

					arg_643_1:RecordHistoryTalkVoice("story_v_out_120421", "120421156", "story_v_out_120421.awb")
				end

				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_10 = math.max(var_646_3, arg_643_1.talkMaxDuration)

			if var_646_2 <= arg_643_1.time_ and arg_643_1.time_ < var_646_2 + var_646_10 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_2) / var_646_10

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_2 + var_646_10 and arg_643_1.time_ < var_646_2 + var_646_10 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play120421157 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 120421157
		arg_647_1.duration_ = 10.73

		local var_647_0 = {
			zh = 6.233,
			ja = 10.733
		}
		local var_647_1 = manager.audio:GetLocalizationFlag()

		if var_647_0[var_647_1] ~= nil then
			arg_647_1.duration_ = var_647_0[var_647_1]
		end

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
			arg_647_1.auto_ = false
		end

		function arg_647_1.playNext_(arg_649_0)
			arg_647_1.onStoryFinished_()
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 0.7

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, true)

				arg_647_1.leftNameTxt_.text = arg_647_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_647_1.leftNameTxt_.transform)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1.leftNameTxt_.text)
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_1 = arg_647_1:GetWordFromCfg(120421157)
				local var_650_2 = arg_647_1:FormatText(var_650_1.content)

				arg_647_1.text_.text = var_650_2

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_4 = 28 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_2) / 28)

				if (28 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_2) / 28)) > 0 and var_650_0 < var_650_4 then
					arg_647_1.talkMaxDuration = var_650_4

					if var_650_4 + 0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_4 + 0
					end
				end

				arg_647_1.text_.text = var_650_2
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_120421", "120421157", "story_v_out_120421.awb") ~= 0 then
					local var_650_5 = manager.audio:GetVoiceLength("story_v_out_120421", "120421157", "story_v_out_120421.awb") / 1000

					if var_650_5 + 0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_5 + 0
					end

					if var_650_1.prefab_name ~= "" and arg_647_1.actors_[var_650_1.prefab_name] ~= nil then
						local var_650_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_647_1.actors_[var_650_1.prefab_name].transform, "story_v_out_120421", "120421157", "story_v_out_120421.awb")

						arg_647_1:RecordAudio("120421157", var_650_6)
						arg_647_1:RecordAudio("120421157", var_650_6)
					else
						arg_647_1:AudioAction("play", "voice", "story_v_out_120421", "120421157", "story_v_out_120421.awb")
					end

					arg_647_1:RecordHistoryTalkVoice("story_v_out_120421", "120421157", "story_v_out_120421.awb")
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
	assets = {
		"TextureConfig/Background/XH0204",
		"TextureConfig/Background/ST37",
		"TextureConfig/Background/ST29",
		"TextureConfig/Background/ST31"
	},
	voices = {
		"story_v_out_120421.awb"
	}
}
