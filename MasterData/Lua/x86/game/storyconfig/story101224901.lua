return {
	Play122491001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122491001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play122491002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.XH0602 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0602")
				var_4_0.name = "XH0602"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.XH0602 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.XH0602

				arg_1_1.bgs_.XH0602.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "XH0602" then
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

			local var_4_8 = arg_1_1.bgs_.XH0602.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0602 = var_4_8.localPosition
			end

			local var_4_9 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_9 then
				var_4_8.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0602, Vector3.New(-0.5, 1, 9), (arg_1_1.time_ - 0) / var_4_9)
			end

			if arg_1_1.time_ >= 0 + var_4_9 and arg_1_1.time_ < 0 + var_4_9 + arg_4_0 then
				var_4_8.localPosition = Vector3.New(-0.5, 1, 9)
			end

			local var_4_10 = arg_1_1.bgs_.XH0602.transform

			if 0.0166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.0166666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPosXH0602 = var_4_10.localPosition
			end

			local var_4_11 = 5.5

			if 0.0166666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 0.0166666666666667 + var_4_11 then
				var_4_10.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXH0602, Vector3.New(0.5, 1, 9), (arg_1_1.time_ - 0.0166666666666667) / var_4_11)
			end

			if arg_1_1.time_ >= 0.0166666666666667 + var_4_11 and arg_1_1.time_ < 0.0166666666666667 + var_4_11 + arg_4_0 then
				var_4_10.localPosition = Vector3.New(0.5, 1, 9)
			end

			local var_4_12 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_12 + 3.51666666666667 and arg_1_1.time_ < var_4_12 + 3.51666666666667 + arg_4_0 then
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

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_2_ui", "bgm_activity_2_2_ui", "bgm_activity_2_2_ui.awb")

				local var_4_18 = manager.audio:GetAudioName("bgm_activity_2_2_ui", "bgm_activity_2_2_ui")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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

			local var_4_19 = 2
			local var_4_20 = 1.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(122491001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 50 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 50)

				if (50 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 50)) > 0 and var_4_20 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_19 = var_4_19 + 0.3

					if var_4_24 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_19 + 0.3
			local var_4_26 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_19 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
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
				actorName = "XH0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play122491002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 122491002
		arg_9_1.duration_ = 16.77

		local var_9_0 = {
			ja = 16.766,
			ko = 9.266,
			zh = 9.266
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
				arg_9_0:Play122491003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.925

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(122491002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 37 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 37)

				if (37 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 37)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491002", "story_v_out_122491.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491002", "story_v_out_122491.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_122491", "122491002", "story_v_out_122491.awb")

						arg_9_1:RecordAudio("122491002", var_12_6)
						arg_9_1:RecordAudio("122491002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_122491", "122491002", "story_v_out_122491.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_122491", "122491002", "story_v_out_122491.awb")
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
	Play122491003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 122491003
		arg_13_1.duration_ = 5.33

		local var_13_0 = {
			ja = 5.333,
			ko = 2.266,
			zh = 2.266
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
				arg_13_0:Play122491004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.25

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(122491003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 10 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 10)

				if (10 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 10)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491003", "story_v_out_122491.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491003", "story_v_out_122491.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_122491", "122491003", "story_v_out_122491.awb")

						arg_13_1:RecordAudio("122491003", var_16_6)
						arg_13_1:RecordAudio("122491003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_122491", "122491003", "story_v_out_122491.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_122491", "122491003", "story_v_out_122491.awb")
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
	Play122491004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 122491004
		arg_17_1.duration_ = 12.17

		local var_17_0 = {
			ja = 12.166,
			ko = 5.2,
			zh = 5.2
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
				arg_17_0:Play122491005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.625

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:GetWordFromCfg(122491004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 25 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 25)

				if (25 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 25)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491004", "story_v_out_122491.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491004", "story_v_out_122491.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_122491", "122491004", "story_v_out_122491.awb")

						arg_17_1:RecordAudio("122491004", var_20_6)
						arg_17_1:RecordAudio("122491004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_122491", "122491004", "story_v_out_122491.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_122491", "122491004", "story_v_out_122491.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play122491005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 122491005
		arg_21_1.duration_ = 5.27

		local var_21_0 = {
			ja = 5.266,
			ko = 2.666,
			zh = 2.666
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
				arg_21_0:Play122491006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.325

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(122491005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 13 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 13)

				if (13 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 13)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491005", "story_v_out_122491.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491005", "story_v_out_122491.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_122491", "122491005", "story_v_out_122491.awb")

						arg_21_1:RecordAudio("122491005", var_24_6)
						arg_21_1:RecordAudio("122491005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_122491", "122491005", "story_v_out_122491.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_122491", "122491005", "story_v_out_122491.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play122491006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 122491006
		arg_25_1.duration_ = 12.5

		local var_25_0 = {
			ja = 12.5,
			ko = 5.2,
			zh = 5.2
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play122491007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.7

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(122491006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 28 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 28)

				if (28 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 28)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491006", "story_v_out_122491.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491006", "story_v_out_122491.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_122491", "122491006", "story_v_out_122491.awb")

						arg_25_1:RecordAudio("122491006", var_28_6)
						arg_25_1:RecordAudio("122491006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_122491", "122491006", "story_v_out_122491.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_122491", "122491006", "story_v_out_122491.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play122491007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 122491007
		arg_29_1.duration_ = 13.47

		local var_29_0 = {
			ja = 13.466,
			ko = 7.7,
			zh = 7.7
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
				arg_29_0:Play122491008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.65

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(122491007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 26 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 26)

				if (26 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 26)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491007", "story_v_out_122491.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491007", "story_v_out_122491.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_122491", "122491007", "story_v_out_122491.awb")

						arg_29_1:RecordAudio("122491007", var_32_6)
						arg_29_1:RecordAudio("122491007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_122491", "122491007", "story_v_out_122491.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_122491", "122491007", "story_v_out_122491.awb")
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
	Play122491008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 122491008
		arg_33_1.duration_ = 10.33

		local var_33_0 = {
			ja = 10.333,
			ko = 4.166,
			zh = 4.166
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
				arg_33_0:Play122491009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.525

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(122491008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 21 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 21)

				if (21 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 21)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491008", "story_v_out_122491.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491008", "story_v_out_122491.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_122491", "122491008", "story_v_out_122491.awb")

						arg_33_1:RecordAudio("122491008", var_36_6)
						arg_33_1:RecordAudio("122491008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_122491", "122491008", "story_v_out_122491.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_122491", "122491008", "story_v_out_122491.awb")
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
	Play122491009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 122491009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play122491010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.9

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(122491009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 36 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 36)

				if (36 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 36)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play122491010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 122491010
		arg_41_1.duration_ = 5.57

		local var_41_0 = {
			ja = 5.566,
			ko = 1.966,
			zh = 1.966
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play122491011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.25

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:GetWordFromCfg(122491010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 10 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 10)

				if (10 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 10)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491010", "story_v_out_122491.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491010", "story_v_out_122491.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_122491", "122491010", "story_v_out_122491.awb")

						arg_41_1:RecordAudio("122491010", var_44_6)
						arg_41_1:RecordAudio("122491010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_122491", "122491010", "story_v_out_122491.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_122491", "122491010", "story_v_out_122491.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play122491011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 122491011
		arg_45_1.duration_ = 16.8

		local var_45_0 = {
			ja = 16.8,
			ko = 10.633,
			zh = 10.633
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play122491012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.075

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(122491011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 43 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 43)

				if (43 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 43)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491011", "story_v_out_122491.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491011", "story_v_out_122491.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_122491", "122491011", "story_v_out_122491.awb")

						arg_45_1:RecordAudio("122491011", var_48_6)
						arg_45_1:RecordAudio("122491011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_122491", "122491011", "story_v_out_122491.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_122491", "122491011", "story_v_out_122491.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play122491012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 122491012
		arg_49_1.duration_ = 7.53

		local var_49_0 = {
			ja = 7.533,
			ko = 5.066,
			zh = 5.066
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play122491013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.475

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(122491012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 19 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 19)

				if (19 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 19)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491012", "story_v_out_122491.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491012", "story_v_out_122491.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_122491", "122491012", "story_v_out_122491.awb")

						arg_49_1:RecordAudio("122491012", var_52_6)
						arg_49_1:RecordAudio("122491012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_122491", "122491012", "story_v_out_122491.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_122491", "122491012", "story_v_out_122491.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play122491013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 122491013
		arg_53_1.duration_ = 2.63

		local var_53_0 = {
			ja = 2.633,
			ko = 1.4,
			zh = 1.4
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play122491014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.075

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(122491013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 3 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 3)

				if (3 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 3)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491013", "story_v_out_122491.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491013", "story_v_out_122491.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_122491", "122491013", "story_v_out_122491.awb")

						arg_53_1:RecordAudio("122491013", var_56_6)
						arg_53_1:RecordAudio("122491013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_122491", "122491013", "story_v_out_122491.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_122491", "122491013", "story_v_out_122491.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play122491014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 122491014
		arg_57_1.duration_ = 17.97

		local var_57_0 = {
			ja = 17.966,
			ko = 11.733,
			zh = 11.733
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play122491015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.975

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(122491014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 39 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 39)

				if (39 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 39)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491014", "story_v_out_122491.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491014", "story_v_out_122491.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_122491", "122491014", "story_v_out_122491.awb")

						arg_57_1:RecordAudio("122491014", var_60_6)
						arg_57_1:RecordAudio("122491014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_122491", "122491014", "story_v_out_122491.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_122491", "122491014", "story_v_out_122491.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play122491015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 122491015
		arg_61_1.duration_ = 12.93

		local var_61_0 = {
			ja = 12.933,
			ko = 5.633,
			zh = 5.633
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play122491016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.65

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(122491015)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 26 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 26)

				if (26 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 26)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491015", "story_v_out_122491.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491015", "story_v_out_122491.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_out_122491", "122491015", "story_v_out_122491.awb")

						arg_61_1:RecordAudio("122491015", var_64_6)
						arg_61_1:RecordAudio("122491015", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_122491", "122491015", "story_v_out_122491.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_122491", "122491015", "story_v_out_122491.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play122491016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 122491016
		arg_65_1.duration_ = 5.5

		local var_65_0 = {
			ja = 5.5,
			ko = 3.266,
			zh = 3.266
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play122491017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.375

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_1 = arg_65_1:GetWordFromCfg(122491016)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 15 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 15)

				if (15 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 15)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491016", "story_v_out_122491.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491016", "story_v_out_122491.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_122491", "122491016", "story_v_out_122491.awb")

						arg_65_1:RecordAudio("122491016", var_68_6)
						arg_65_1:RecordAudio("122491016", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_122491", "122491016", "story_v_out_122491.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_122491", "122491016", "story_v_out_122491.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play122491017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 122491017
		arg_69_1.duration_ = 1.5

		local var_69_0 = {
			ja = 1.033,
			ko = 1.5,
			zh = 1.5
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play122491018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.125

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_1 = arg_69_1:GetWordFromCfg(122491017)
				local var_72_2 = arg_69_1:FormatText(var_72_1.content)

				arg_69_1.text_.text = var_72_2

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_4 = 5 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 5)

				if (5 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_2) / 5)) > 0 and var_72_0 < var_72_4 then
					arg_69_1.talkMaxDuration = var_72_4

					if var_72_4 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_4 + 0
					end
				end

				arg_69_1.text_.text = var_72_2
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491017", "story_v_out_122491.awb") ~= 0 then
					local var_72_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491017", "story_v_out_122491.awb") / 1000

					if var_72_5 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + 0
					end

					if var_72_1.prefab_name ~= "" and arg_69_1.actors_[var_72_1.prefab_name] ~= nil then
						local var_72_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_1.prefab_name].transform, "story_v_out_122491", "122491017", "story_v_out_122491.awb")

						arg_69_1:RecordAudio("122491017", var_72_6)
						arg_69_1:RecordAudio("122491017", var_72_6)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_122491", "122491017", "story_v_out_122491.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_122491", "122491017", "story_v_out_122491.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_7 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_7

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play122491018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 122491018
		arg_73_1.duration_ = 3.13

		local var_73_0 = {
			ja = 3.133,
			ko = 1.433,
			zh = 1.433
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
				arg_73_0:Play122491019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.125

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:GetWordFromCfg(122491018)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 5 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 5)

				if (5 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 5)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491018", "story_v_out_122491.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491018", "story_v_out_122491.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_122491", "122491018", "story_v_out_122491.awb")

						arg_73_1:RecordAudio("122491018", var_76_6)
						arg_73_1:RecordAudio("122491018", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_122491", "122491018", "story_v_out_122491.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_122491", "122491018", "story_v_out_122491.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play122491019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 122491019
		arg_77_1.duration_ = 7

		local var_77_0 = {
			ja = 7,
			ko = 2.033,
			zh = 2.033
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
				arg_77_0:Play122491020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.175

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:GetWordFromCfg(122491019)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 7 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 7)

				if (7 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 7)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491019", "story_v_out_122491.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491019", "story_v_out_122491.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_122491", "122491019", "story_v_out_122491.awb")

						arg_77_1:RecordAudio("122491019", var_80_6)
						arg_77_1:RecordAudio("122491019", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_122491", "122491019", "story_v_out_122491.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_122491", "122491019", "story_v_out_122491.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play122491020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 122491020
		arg_81_1.duration_ = 10.3

		local var_81_0 = {
			ja = 10.3,
			ko = 9.2,
			zh = 9.2
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
				arg_81_0:Play122491021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.95

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:GetWordFromCfg(122491020)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 38 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 38)

				if (38 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 38)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491020", "story_v_out_122491.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491020", "story_v_out_122491.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_122491", "122491020", "story_v_out_122491.awb")

						arg_81_1:RecordAudio("122491020", var_84_6)
						arg_81_1:RecordAudio("122491020", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_122491", "122491020", "story_v_out_122491.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_122491", "122491020", "story_v_out_122491.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_7 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_7

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play122491021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 122491021
		arg_85_1.duration_ = 13.33

		local var_85_0 = {
			ja = 13.333,
			ko = 8.033,
			zh = 8.033
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
				arg_85_0:Play122491022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.9

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_1 = arg_85_1:GetWordFromCfg(122491021)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 36 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 36)

				if (36 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 36)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491021", "story_v_out_122491.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491021", "story_v_out_122491.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_122491", "122491021", "story_v_out_122491.awb")

						arg_85_1:RecordAudio("122491021", var_88_6)
						arg_85_1:RecordAudio("122491021", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_122491", "122491021", "story_v_out_122491.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_122491", "122491021", "story_v_out_122491.awb")
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
	Play122491022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 122491022
		arg_89_1.duration_ = 4.7

		local var_89_0 = {
			ja = 4.7,
			ko = 1.8,
			zh = 1.8
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
				arg_89_0:Play122491023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.225

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(122491022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 9 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 9)

				if (9 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 9)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491022", "story_v_out_122491.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491022", "story_v_out_122491.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_122491", "122491022", "story_v_out_122491.awb")

						arg_89_1:RecordAudio("122491022", var_92_6)
						arg_89_1:RecordAudio("122491022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_122491", "122491022", "story_v_out_122491.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_122491", "122491022", "story_v_out_122491.awb")
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
	Play122491023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 122491023
		arg_93_1.duration_ = 18.57

		local var_93_0 = {
			ja = 18.566,
			ko = 10,
			zh = 10
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
				arg_93_0:Play122491024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.825

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:GetWordFromCfg(122491023)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 33 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 33)

				if (33 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 33)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491023", "story_v_out_122491.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491023", "story_v_out_122491.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_122491", "122491023", "story_v_out_122491.awb")

						arg_93_1:RecordAudio("122491023", var_96_6)
						arg_93_1:RecordAudio("122491023", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_122491", "122491023", "story_v_out_122491.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_122491", "122491023", "story_v_out_122491.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play122491024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 122491024
		arg_97_1.duration_ = 21.13

		local var_97_0 = {
			ja = 21.133,
			ko = 11.833,
			zh = 11.833
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
				arg_97_0:Play122491025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 1.025

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(122491024)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 41 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 41)

				if (41 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 41)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491024", "story_v_out_122491.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491024", "story_v_out_122491.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_122491", "122491024", "story_v_out_122491.awb")

						arg_97_1:RecordAudio("122491024", var_100_6)
						arg_97_1:RecordAudio("122491024", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_122491", "122491024", "story_v_out_122491.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_122491", "122491024", "story_v_out_122491.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play122491025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 122491025
		arg_101_1.duration_ = 10.2

		local var_101_0 = {
			ja = 10.2,
			ko = 3,
			zh = 3
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
				arg_101_0:Play122491026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.375

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(122491025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 15 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 15)

				if (15 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 15)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491025", "story_v_out_122491.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491025", "story_v_out_122491.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_122491", "122491025", "story_v_out_122491.awb")

						arg_101_1:RecordAudio("122491025", var_104_6)
						arg_101_1:RecordAudio("122491025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_122491", "122491025", "story_v_out_122491.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_122491", "122491025", "story_v_out_122491.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play122491026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 122491026
		arg_105_1.duration_ = 4.4

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play122491027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if arg_105_1.bgs_.STblack == nil then
				local var_108_0 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_108_0.name = "STblack"
				var_108_0.transform.parent = arg_105_1.stage_.transform
				var_108_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_.STblack = var_108_0
			end

			if 2 < arg_105_1.time_ and arg_105_1.time_ <= 2 + arg_108_0 then
				local var_108_1 = arg_105_1.bgs_.STblack

				arg_105_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_108_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_2 = var_108_1:GetComponent("SpriteRenderer")

				if var_108_2 and var_108_2.sprite then
					local var_108_3 = 2 * (var_108_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_108_1.transform.localScale = Vector3.New(var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, var_108_3 / var_108_2.sprite.bounds.size.y < var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x and var_108_3 * manager.ui.mainCameraCom_.aspect / var_108_2.sprite.bounds.size.x or var_108_3 / var_108_2.sprite.bounds.size.y, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "STblack" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_4 = 0

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_5 = 2

			if var_108_4 <= arg_105_1.time_ and arg_105_1.time_ < var_108_4 + var_108_5 then
				local var_108_6 = Color.New(0, 0, 0)

				var_108_6.a = Mathf.Lerp(0, 1, (arg_105_1.time_ - var_108_4) / var_108_5)
				arg_105_1.mask_.color = var_108_6
			end

			if arg_105_1.time_ >= var_108_4 + var_108_5 and arg_105_1.time_ < var_108_4 + var_108_5 + arg_108_0 then
				local var_108_7 = Color.New(0, 0, 0)

				var_108_7.a = 1
				arg_105_1.mask_.color = var_108_7
			end

			local var_108_8 = 2

			if 2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_9 = 2

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_9 then
				local var_108_10 = Color.New(0, 0, 0)

				var_108_10.a = Mathf.Lerp(1, 0, (arg_105_1.time_ - var_108_8) / var_108_9)
				arg_105_1.mask_.color = var_108_10
			end

			if arg_105_1.time_ >= var_108_8 + var_108_9 and arg_105_1.time_ < var_108_8 + var_108_9 + arg_108_0 then
				local var_108_11 = Color.New(0, 0, 0)

				arg_105_1.mask_.enabled = false
				var_108_11.a = 0
				arg_105_1.mask_.color = var_108_11
			end

			if 2.83333333333333 < arg_105_1.time_ and arg_105_1.time_ <= 2.83333333333333 + arg_108_0 then
				arg_105_1.fswbg_:SetActive(true)
				arg_105_1.dialog_:SetActive(false)

				arg_105_1.fswtw_.percent = 0
				arg_105_1.fswt_.text = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(122491026).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.fswt_)

				arg_105_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_105_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_105_1.fswtw_:SetDirty()

				arg_105_1.typewritterCharCountI18N = 0

				SetActive(arg_105_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_105_1:ShowNextGo(false)
			end

			local var_108_12 = 2.85

			if 2.85 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.var_.oldValueTypewriter = arg_105_1.fswtw_.percent

				SetActive(arg_105_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_105_1:ShowNextGo(false)
			end

			local var_108_13 = 19
			local var_108_14 = 1.26666666666667
			local var_108_15, var_108_16 = arg_105_1:GetPercentByPara(arg_105_1:FormatText(arg_105_1:GetWordFromCfg(122491026).content), 1)

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				local var_108_17 = var_108_13 <= 0 and var_108_14 or var_108_14 * ((var_108_16 - arg_105_1.typewritterCharCountI18N) / var_108_13)

				if (var_108_13 <= 0 and var_108_14 or var_108_14 * ((var_108_16 - arg_105_1.typewritterCharCountI18N) / var_108_13)) > 0 and var_108_14 < var_108_17 then
					arg_105_1.talkMaxDuration = var_108_17

					if var_108_17 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_17 + var_108_12
					end
				end
			end

			local var_108_18 = math.max(1.26666666666667, arg_105_1.talkMaxDuration)

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_18 then
				arg_105_1.fswtw_.percent = Mathf.Lerp(arg_105_1.var_.oldValueTypewriter, var_108_15, (arg_105_1.time_ - var_108_12) / var_108_18)
				arg_105_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_105_1.fswtw_:SetDirty()
			end

			if arg_105_1.time_ >= var_108_12 + var_108_18 and arg_105_1.time_ < var_108_12 + var_108_18 + arg_108_0 then
				arg_105_1.fswtw_.percent = var_108_15

				arg_105_1.fswtw_:SetDirty()
				arg_105_1:ShowNextGo(true)

				arg_105_1.typewritterCharCountI18N = var_108_16
			end

			if 1.98333333333333 < arg_105_1.time_ and arg_105_1.time_ <= 1.98333333333333 + arg_108_0 then
				arg_105_1.fswbg_:SetActive(false)
				arg_105_1.dialog_:SetActive(false)
				SetActive(arg_105_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_105_1:ShowNextGo(false)
			end

			if 2.83333333333333 < arg_105_1.time_ and arg_105_1.time_ <= 2.83333333333333 + arg_108_0 then
				local var_108_19 = arg_105_1.fswbg_.transform:Find("textbox/adapt/content") or arg_105_1.fswbg_.transform:Find("textbox/content")
				local var_108_20 = arg_105_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_108_21 = var_108_19:GetComponent("RectTransform")

				var_108_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_108_21.offsetMin = Vector2.New(0, 0)
				var_108_21.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play122491027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 122491027
		arg_109_1.duration_ = 1.02

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play122491028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.fswbg_:SetActive(true)
				arg_109_1.dialog_:SetActive(false)

				arg_109_1.fswtw_.percent = 0
				arg_109_1.fswt_.text = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(122491027).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.fswt_)

				arg_109_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_109_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_109_1.fswtw_:SetDirty()

				arg_109_1.typewritterCharCountI18N = 0

				SetActive(arg_109_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_109_1:ShowNextGo(false)
			end

			local var_112_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.var_.oldValueTypewriter = arg_109_1.fswtw_.percent

				SetActive(arg_109_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_109_1:ShowNextGo(false)
			end

			local var_112_1 = 15
			local var_112_2 = 1
			local var_112_3, var_112_4 = arg_109_1:GetPercentByPara(arg_109_1:FormatText(arg_109_1:GetWordFromCfg(122491027).content), 1)

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				local var_112_5 = var_112_1 <= 0 and var_112_2 or var_112_2 * ((var_112_4 - arg_109_1.typewritterCharCountI18N) / var_112_1)

				if (var_112_1 <= 0 and var_112_2 or var_112_2 * ((var_112_4 - arg_109_1.typewritterCharCountI18N) / var_112_1)) > 0 and var_112_2 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_0
					end
				end
			end

			local var_112_6 = math.max(1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_6 then
				arg_109_1.fswtw_.percent = Mathf.Lerp(arg_109_1.var_.oldValueTypewriter, var_112_3, (arg_109_1.time_ - var_112_0) / var_112_6)
				arg_109_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_109_1.fswtw_:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_6 and arg_109_1.time_ < var_112_0 + var_112_6 + arg_112_0 then
				arg_109_1.fswtw_.percent = var_112_3

				arg_109_1.fswtw_:SetDirty()
				arg_109_1:ShowNextGo(true)

				arg_109_1.typewritterCharCountI18N = var_112_4
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play122491028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 122491028
		arg_113_1.duration_ = 13.7

		local var_113_0 = {
			ja = 13.7,
			ko = 6.633,
			zh = 6.633
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
				arg_113_0:Play122491029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if arg_113_1.bgs_.XH0603 == nil then
				local var_116_0 = Object.Instantiate(arg_113_1.paintGo_)

				var_116_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0603")
				var_116_0.name = "XH0603"
				var_116_0.transform.parent = arg_113_1.stage_.transform
				var_116_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.bgs_.XH0603 = var_116_0
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				local var_116_1 = arg_113_1.bgs_.XH0603

				arg_113_1.bgs_.XH0603.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_116_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_116_2 = var_116_1:GetComponent("SpriteRenderer")

				if var_116_2 and var_116_2.sprite then
					local var_116_3 = 2 * (var_116_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_116_1.transform.localScale = Vector3.New(var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, var_116_3 / var_116_2.sprite.bounds.size.y < var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x and var_116_3 * manager.ui.mainCameraCom_.aspect / var_116_2.sprite.bounds.size.x or var_116_3 / var_116_2.sprite.bounds.size.y, 0)
				end

				for iter_116_0, iter_116_1 in pairs(arg_113_1.bgs_) do
					if iter_116_0 ~= "XH0603" then
						iter_116_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_116_4 = 0

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.mask_.enabled = true
				arg_113_1.mask_.raycastTarget = true

				arg_113_1:SetGaussion(false)
			end

			local var_116_5 = 2

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_5 then
				local var_116_6 = Color.New(0, 0, 0)

				var_116_6.a = Mathf.Lerp(1, 0, (arg_113_1.time_ - var_116_4) / var_116_5)
				arg_113_1.mask_.color = var_116_6
			end

			if arg_113_1.time_ >= var_116_4 + var_116_5 and arg_113_1.time_ < var_116_4 + var_116_5 + arg_116_0 then
				local var_116_7 = Color.New(0, 0, 0)

				arg_113_1.mask_.enabled = false
				var_116_7.a = 0
				arg_113_1.mask_.color = var_116_7
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.fswbg_:SetActive(false)
				arg_113_1.dialog_:SetActive(false)
				SetActive(arg_113_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_113_1:ShowNextGo(false)
			end

			local var_116_8 = arg_113_1.bgs_.XH0603.transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPosXH0603 = var_116_8.localPosition
			end

			local var_116_9 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_9 then
				var_116_8.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPosXH0603, Vector3.New(0, 3, 0), (arg_113_1.time_ - 0) / var_116_9)
			end

			if arg_113_1.time_ >= 0 + var_116_9 and arg_113_1.time_ < 0 + var_116_9 + arg_116_0 then
				var_116_8.localPosition = Vector3.New(0, 3, 0)
			end

			local var_116_10 = arg_113_1.bgs_.XH0603.transform

			if 0.034 < arg_113_1.time_ and arg_113_1.time_ <= 0.034 + arg_116_0 then
				arg_113_1.var_.moveOldPosXH0603 = var_116_10.localPosition
			end

			local var_116_11 = 4

			if 0.034 <= arg_113_1.time_ and arg_113_1.time_ < 0.034 + var_116_11 then
				var_116_10.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPosXH0603, Vector3.New(0, 3, 1), (arg_113_1.time_ - 0.034) / var_116_11)
			end

			if arg_113_1.time_ >= 0.034 + var_116_11 and arg_113_1.time_ < 0.034 + var_116_11 + arg_116_0 then
				var_116_10.localPosition = Vector3.New(0, 3, 1)
			end

			local var_116_12 = 2

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 then
				arg_113_1.allBtn_.enabled = false
			end

			if arg_113_1.time_ >= var_116_12 + 2.034 and arg_113_1.time_ < var_116_12 + 2.034 + arg_116_0 then
				arg_113_1.allBtn_.enabled = true
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_13 = 2
			local var_116_14 = 0.475

			if 2 < arg_113_1.time_ and arg_113_1.time_ <= var_116_13 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_15 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_15:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_16 = arg_113_1:GetWordFromCfg(122491028)
				local var_116_17 = arg_113_1:FormatText(var_116_16.content)

				arg_113_1.text_.text = var_116_17

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_19 = 19 <= 0 and var_116_14 or var_116_14 * (utf8.len(var_116_17) / 19)

				if (19 <= 0 and var_116_14 or var_116_14 * (utf8.len(var_116_17) / 19)) > 0 and var_116_14 < var_116_19 then
					arg_113_1.talkMaxDuration = var_116_19
					var_116_13 = var_116_13 + 0.3

					if var_116_19 + var_116_13 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_19 + var_116_13
					end
				end

				arg_113_1.text_.text = var_116_17
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491028", "story_v_out_122491.awb") ~= 0 then
					local var_116_20 = manager.audio:GetVoiceLength("story_v_out_122491", "122491028", "story_v_out_122491.awb") / 1000

					if var_116_20 + var_116_13 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_20 + var_116_13
					end

					if var_116_16.prefab_name ~= "" and arg_113_1.actors_[var_116_16.prefab_name] ~= nil then
						local var_116_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_16.prefab_name].transform, "story_v_out_122491", "122491028", "story_v_out_122491.awb")

						arg_113_1:RecordAudio("122491028", var_116_21)
						arg_113_1:RecordAudio("122491028", var_116_21)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_122491", "122491028", "story_v_out_122491.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_122491", "122491028", "story_v_out_122491.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_22 = var_116_13 + 0.3
			local var_116_23 = math.max(var_116_14, arg_113_1.talkMaxDuration)

			if var_116_13 + 0.3 <= arg_113_1.time_ and arg_113_1.time_ < var_116_22 + var_116_23 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_22) / var_116_23

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_22 + var_116_23 and arg_113_1.time_ < var_116_22 + var_116_23 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play122491029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 122491029
		arg_119_1.duration_ = 6.93

		local var_119_0 = {
			ja = 6.933,
			ko = 4.4,
			zh = 4.4
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play122491030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.35

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_1 = arg_119_1:GetWordFromCfg(122491029)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 14 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 14)

				if (14 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 14)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491029", "story_v_out_122491.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491029", "story_v_out_122491.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_out_122491", "122491029", "story_v_out_122491.awb")

						arg_119_1:RecordAudio("122491029", var_122_6)
						arg_119_1:RecordAudio("122491029", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_122491", "122491029", "story_v_out_122491.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_122491", "122491029", "story_v_out_122491.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play122491030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 122491030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play122491031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.825

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(122491030).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 33 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 33)

				if (33 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 33)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play122491031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 122491031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play122491032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 1.2

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(122491031).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 48 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 48)

				if (48 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 48)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play122491032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 122491032
		arg_131_1.duration_ = 4.5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play122491033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 1.999999999999 < arg_131_1.time_ and arg_131_1.time_ <= 1.999999999999 + arg_134_0 then
				local var_134_0 = arg_131_1.bgs_.STblack

				arg_131_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_134_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_134_1 = var_134_0:GetComponent("SpriteRenderer")

				if var_134_1 and var_134_1.sprite then
					local var_134_2 = 2 * (var_134_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_134_0.transform.localScale = Vector3.New(var_134_2 / var_134_1.sprite.bounds.size.y < var_134_2 * manager.ui.mainCameraCom_.aspect / var_134_1.sprite.bounds.size.x and var_134_2 * manager.ui.mainCameraCom_.aspect / var_134_1.sprite.bounds.size.x or var_134_2 / var_134_1.sprite.bounds.size.y, var_134_2 / var_134_1.sprite.bounds.size.y < var_134_2 * manager.ui.mainCameraCom_.aspect / var_134_1.sprite.bounds.size.x and var_134_2 * manager.ui.mainCameraCom_.aspect / var_134_1.sprite.bounds.size.x or var_134_2 / var_134_1.sprite.bounds.size.y, 0)
				end

				for iter_134_0, iter_134_1 in pairs(arg_131_1.bgs_) do
					if iter_134_0 ~= "STblack" then
						iter_134_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_134_3 = 0

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_3 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_4 = 2

			if var_134_3 <= arg_131_1.time_ and arg_131_1.time_ < var_134_3 + var_134_4 then
				local var_134_5 = Color.New(0, 0, 0)

				var_134_5.a = Mathf.Lerp(0, 1, (arg_131_1.time_ - var_134_3) / var_134_4)
				arg_131_1.mask_.color = var_134_5
			end

			if arg_131_1.time_ >= var_134_3 + var_134_4 and arg_131_1.time_ < var_134_3 + var_134_4 + arg_134_0 then
				local var_134_6 = Color.New(0, 0, 0)

				var_134_6.a = 1
				arg_131_1.mask_.color = var_134_6
			end

			local var_134_7 = 2

			if 2 < arg_131_1.time_ and arg_131_1.time_ <= var_134_7 + arg_134_0 then
				arg_131_1.mask_.enabled = true
				arg_131_1.mask_.raycastTarget = true

				arg_131_1:SetGaussion(false)
			end

			local var_134_8 = 2

			if var_134_7 <= arg_131_1.time_ and arg_131_1.time_ < var_134_7 + var_134_8 then
				local var_134_9 = Color.New(0, 0, 0)

				var_134_9.a = Mathf.Lerp(1, 0, (arg_131_1.time_ - var_134_7) / var_134_8)
				arg_131_1.mask_.color = var_134_9
			end

			if arg_131_1.time_ >= var_134_7 + var_134_8 and arg_131_1.time_ < var_134_7 + var_134_8 + arg_134_0 then
				local var_134_10 = Color.New(0, 0, 0)

				arg_131_1.mask_.enabled = false
				var_134_10.a = 0
				arg_131_1.mask_.color = var_134_10
			end

			if 1.98333333333333 < arg_131_1.time_ and arg_131_1.time_ <= 1.98333333333333 + arg_134_0 then
				arg_131_1.fswbg_:SetActive(false)
				arg_131_1.dialog_:SetActive(false)
				SetActive(arg_131_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_131_1:ShowNextGo(false)
			end

			if 2.78333333333233 < arg_131_1.time_ and arg_131_1.time_ <= 2.78333333333233 + arg_134_0 then
				arg_131_1.fswbg_:SetActive(true)
				arg_131_1.dialog_:SetActive(false)

				arg_131_1.fswtw_.percent = 0
				arg_131_1.fswt_.text = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(122491032).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.fswt_)

				arg_131_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_131_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_131_1.fswtw_:SetDirty()

				arg_131_1.typewritterCharCountI18N = 0

				SetActive(arg_131_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_131_1:ShowNextGo(false)
			end

			local var_134_11 = 2.799999999999

			if 2.799999999999 < arg_131_1.time_ and arg_131_1.time_ <= var_134_11 + arg_134_0 then
				arg_131_1.var_.oldValueTypewriter = arg_131_1.fswtw_.percent

				SetActive(arg_131_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_131_1:ShowNextGo(false)
			end

			local var_134_12 = 18
			local var_134_13 = 1.2
			local var_134_14, var_134_15 = arg_131_1:GetPercentByPara(arg_131_1:FormatText(arg_131_1:GetWordFromCfg(122491032).content), 1)

			if var_134_11 < arg_131_1.time_ and arg_131_1.time_ <= var_134_11 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0

				local var_134_16 = var_134_12 <= 0 and var_134_13 or var_134_13 * ((var_134_15 - arg_131_1.typewritterCharCountI18N) / var_134_12)

				if (var_134_12 <= 0 and var_134_13 or var_134_13 * ((var_134_15 - arg_131_1.typewritterCharCountI18N) / var_134_12)) > 0 and var_134_13 < var_134_16 then
					arg_131_1.talkMaxDuration = var_134_16

					if var_134_16 + var_134_11 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_16 + var_134_11
					end
				end
			end

			local var_134_17 = math.max(1.2, arg_131_1.talkMaxDuration)

			if var_134_11 <= arg_131_1.time_ and arg_131_1.time_ < var_134_11 + var_134_17 then
				arg_131_1.fswtw_.percent = Mathf.Lerp(arg_131_1.var_.oldValueTypewriter, var_134_14, (arg_131_1.time_ - var_134_11) / var_134_17)
				arg_131_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_131_1.fswtw_:SetDirty()
			end

			if arg_131_1.time_ >= var_134_11 + var_134_17 and arg_131_1.time_ < var_134_11 + var_134_17 + arg_134_0 then
				arg_131_1.fswtw_.percent = var_134_14

				arg_131_1.fswtw_:SetDirty()
				arg_131_1:ShowNextGo(true)

				arg_131_1.typewritterCharCountI18N = var_134_15
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play122491033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 122491033
		arg_135_1.duration_ = 1.02

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play122491034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.fswbg_:SetActive(true)
				arg_135_1.dialog_:SetActive(false)

				arg_135_1.fswtw_.percent = 0
				arg_135_1.fswt_.text = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(122491033).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.fswt_)

				arg_135_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_135_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_135_1.fswtw_:SetDirty()

				arg_135_1.typewritterCharCountI18N = 0

				SetActive(arg_135_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_135_1:ShowNextGo(false)
			end

			local var_138_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.var_.oldValueTypewriter = arg_135_1.fswtw_.percent

				SetActive(arg_135_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_135_1:ShowNextGo(false)
			end

			local var_138_1 = 15
			local var_138_2 = 1
			local var_138_3, var_138_4 = arg_135_1:GetPercentByPara(arg_135_1:FormatText(arg_135_1:GetWordFromCfg(122491033).content), 1)

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				local var_138_5 = var_138_1 <= 0 and var_138_2 or var_138_2 * ((var_138_4 - arg_135_1.typewritterCharCountI18N) / var_138_1)

				if (var_138_1 <= 0 and var_138_2 or var_138_2 * ((var_138_4 - arg_135_1.typewritterCharCountI18N) / var_138_1)) > 0 and var_138_2 < var_138_5 then
					arg_135_1.talkMaxDuration = var_138_5

					if var_138_5 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + var_138_0
					end
				end
			end

			local var_138_6 = math.max(1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_6 then
				arg_135_1.fswtw_.percent = Mathf.Lerp(arg_135_1.var_.oldValueTypewriter, var_138_3, (arg_135_1.time_ - var_138_0) / var_138_6)
				arg_135_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_135_1.fswtw_:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_6 and arg_135_1.time_ < var_138_0 + var_138_6 + arg_138_0 then
				arg_135_1.fswtw_.percent = var_138_3

				arg_135_1.fswtw_:SetDirty()
				arg_135_1:ShowNextGo(true)

				arg_135_1.typewritterCharCountI18N = var_138_4
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play122491034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 122491034
		arg_139_1.duration_ = 7

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play122491035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				local var_142_0 = arg_139_1.bgs_.XH0603

				arg_139_1.bgs_.XH0603.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_142_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_142_1 = var_142_0:GetComponent("SpriteRenderer")

				if var_142_1 and var_142_1.sprite then
					local var_142_2 = 2 * (var_142_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_142_0.transform.localScale = Vector3.New(var_142_2 / var_142_1.sprite.bounds.size.y < var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x and var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x or var_142_2 / var_142_1.sprite.bounds.size.y, var_142_2 / var_142_1.sprite.bounds.size.y < var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x and var_142_2 * manager.ui.mainCameraCom_.aspect / var_142_1.sprite.bounds.size.x or var_142_2 / var_142_1.sprite.bounds.size.y, 0)
				end

				for iter_142_0, iter_142_1 in pairs(arg_139_1.bgs_) do
					if iter_142_0 ~= "XH0603" then
						iter_142_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_142_3 = 0

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_3 + arg_142_0 then
				arg_139_1.mask_.enabled = true
				arg_139_1.mask_.raycastTarget = true

				arg_139_1:SetGaussion(false)
			end

			local var_142_4 = 2

			if var_142_3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_3 + var_142_4 then
				local var_142_5 = Color.New(0, 0, 0)

				var_142_5.a = Mathf.Lerp(1, 0, (arg_139_1.time_ - var_142_3) / var_142_4)
				arg_139_1.mask_.color = var_142_5
			end

			if arg_139_1.time_ >= var_142_3 + var_142_4 and arg_139_1.time_ < var_142_3 + var_142_4 + arg_142_0 then
				local var_142_6 = Color.New(0, 0, 0)

				arg_139_1.mask_.enabled = false
				var_142_6.a = 0
				arg_139_1.mask_.color = var_142_6
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.fswbg_:SetActive(false)
				arg_139_1.dialog_:SetActive(false)
				SetActive(arg_139_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_139_1:ShowNextGo(false)
			end

			local var_142_7 = arg_139_1.bgs_.XH0603.transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPosXH0603 = var_142_7.localPosition
			end

			local var_142_8 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_8 then
				var_142_7.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPosXH0603, Vector3.New(0, 1, 9), (arg_139_1.time_ - 0) / var_142_8)
			end

			if arg_139_1.time_ >= 0 + var_142_8 and arg_139_1.time_ < 0 + var_142_8 + arg_142_0 then
				var_142_7.localPosition = Vector3.New(0, 1, 9)
			end

			local var_142_9 = arg_139_1.bgs_.XH0603.transform

			if 0.034 < arg_139_1.time_ and arg_139_1.time_ <= 0.034 + arg_142_0 then
				arg_139_1.var_.moveOldPosXH0603 = var_142_9.localPosition
			end

			local var_142_10 = 4.5

			if 0.034 <= arg_139_1.time_ and arg_139_1.time_ < 0.034 + var_142_10 then
				var_142_9.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPosXH0603, Vector3.New(0, 1, 10), (arg_139_1.time_ - 0.034) / var_142_10)
			end

			if arg_139_1.time_ >= 0.034 + var_142_10 and arg_139_1.time_ < 0.034 + var_142_10 + arg_142_0 then
				var_142_9.localPosition = Vector3.New(0, 1, 10)
			end

			local var_142_11 = 2

			if 2 < arg_139_1.time_ and arg_139_1.time_ <= var_142_11 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			if arg_139_1.time_ >= var_142_11 + 2.534 and arg_139_1.time_ < var_142_11 + 2.534 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end

			if 2 < arg_139_1.time_ and arg_139_1.time_ <= 2 + arg_142_0 then
				arg_139_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_wandering", "")
			end

			if arg_139_1.frameCnt_ <= 1 then
				arg_139_1.dialog_:SetActive(false)
			end

			local var_142_13 = 2
			local var_142_14 = 0.775

			if 2 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				arg_139_1.dialog_:SetActive(true)

				arg_139_1.dialogCg_.alpha = 0

				local var_142_15 = LeanTween.value(arg_139_1.dialog_, 0, 1, 0.3)

				var_142_15:setOnUpdate(LuaHelper.FloatAction(function(arg_143_0)
					arg_139_1.dialogCg_.alpha = arg_143_0
				end))
				var_142_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_139_1.dialog_)
					var_142_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_139_1.duration_ = arg_139_1.duration_ + 0.3

				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_16 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(122491034).content)

				arg_139_1.text_.text = var_142_16

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_18 = 31 <= 0 and var_142_14 or var_142_14 * (utf8.len(var_142_16) / 31)

				if (31 <= 0 and var_142_14 or var_142_14 * (utf8.len(var_142_16) / 31)) > 0 and var_142_14 < var_142_18 then
					arg_139_1.talkMaxDuration = var_142_18
					var_142_13 = var_142_13 + 0.3

					if var_142_18 + var_142_13 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_18 + var_142_13
					end
				end

				arg_139_1.text_.text = var_142_16
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_19 = var_142_13 + 0.3
			local var_142_20 = math.max(var_142_14, arg_139_1.talkMaxDuration)

			if var_142_13 + 0.3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_19 + var_142_20 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_19) / var_142_20

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_19 + var_142_20 and arg_139_1.time_ < var_142_19 + var_142_20 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XH0603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XH0603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play122491035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 122491035
		arg_145_1.duration_ = 5.43

		local var_145_0 = {
			ja = 5.433,
			ko = 1.866,
			zh = 1.866
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
				arg_145_0:Play122491036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.125

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_1 = arg_145_1:GetWordFromCfg(122491035)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 5 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 5)

				if (5 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 5)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491035", "story_v_out_122491.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491035", "story_v_out_122491.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_122491", "122491035", "story_v_out_122491.awb")

						arg_145_1:RecordAudio("122491035", var_148_6)
						arg_145_1:RecordAudio("122491035", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_122491", "122491035", "story_v_out_122491.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_122491", "122491035", "story_v_out_122491.awb")
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
	Play122491036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 122491036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play122491037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 1

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(122491036).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 40 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 40)

				if (40 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 40)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play122491037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 122491037
		arg_153_1.duration_ = 22.07

		local var_153_0 = {
			ja = 22.066,
			ko = 9.7,
			zh = 9.7
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
				arg_153_0:Play122491038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.975

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(122491037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 39 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 39)

				if (39 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 39)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491037", "story_v_out_122491.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491037", "story_v_out_122491.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_122491", "122491037", "story_v_out_122491.awb")

						arg_153_1:RecordAudio("122491037", var_156_6)
						arg_153_1:RecordAudio("122491037", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_122491", "122491037", "story_v_out_122491.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_122491", "122491037", "story_v_out_122491.awb")
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
	Play122491038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 122491038
		arg_157_1.duration_ = 9.03

		local var_157_0 = {
			ja = 9.033,
			ko = 8.066,
			zh = 8.066
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
				arg_157_0:Play122491039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.925

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:GetWordFromCfg(122491038)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 37 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 37)

				if (37 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 37)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491038", "story_v_out_122491.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491038", "story_v_out_122491.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_122491", "122491038", "story_v_out_122491.awb")

						arg_157_1:RecordAudio("122491038", var_160_6)
						arg_157_1:RecordAudio("122491038", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_122491", "122491038", "story_v_out_122491.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_122491", "122491038", "story_v_out_122491.awb")
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
	Play122491039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 122491039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play122491040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.275

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(122491039).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 51 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 51)

				if (51 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 51)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play122491040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 122491040
		arg_165_1.duration_ = 4.73

		local var_165_0 = {
			ja = 4.733,
			ko = 3.8,
			zh = 3.8
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
				arg_165_0:Play122491041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0.2

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:GetWordFromCfg(122491040)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.text_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 8 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 8)

				if (8 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_2) / 8)) > 0 and var_168_0 < var_168_4 then
					arg_165_1.talkMaxDuration = var_168_4

					if var_168_4 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_4 + 0
					end
				end

				arg_165_1.text_.text = var_168_2
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491040", "story_v_out_122491.awb") ~= 0 then
					local var_168_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491040", "story_v_out_122491.awb") / 1000

					if var_168_5 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_5 + 0
					end

					if var_168_1.prefab_name ~= "" and arg_165_1.actors_[var_168_1.prefab_name] ~= nil then
						local var_168_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_1.prefab_name].transform, "story_v_out_122491", "122491040", "story_v_out_122491.awb")

						arg_165_1:RecordAudio("122491040", var_168_6)
						arg_165_1:RecordAudio("122491040", var_168_6)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_122491", "122491040", "story_v_out_122491.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_122491", "122491040", "story_v_out_122491.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_7 and arg_165_1.time_ < 0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play122491041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 122491041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play122491042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 1.225

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(122491041).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 49 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 49)

				if (49 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 49)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play122491042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 122491042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play122491043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0.575

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_1 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(122491042).content)

				arg_173_1.text_.text = var_176_1

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_3 = 23 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 23)

				if (23 <= 0 and var_176_0 or var_176_0 * (utf8.len(var_176_1) / 23)) > 0 and var_176_0 < var_176_3 then
					arg_173_1.talkMaxDuration = var_176_3

					if var_176_3 + 0 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_3 + 0
					end
				end

				arg_173_1.text_.text = var_176_1
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_4 = math.max(var_176_0, arg_173_1.talkMaxDuration)

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - 0) / var_176_4

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play122491043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 122491043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play122491044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.825

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(122491043).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 33 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 33)

				if (33 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 33)) > 0 and var_180_0 < var_180_3 then
					arg_177_1.talkMaxDuration = var_180_3

					if var_180_3 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_3 + 0
					end
				end

				arg_177_1.text_.text = var_180_1
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_4 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_4

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play122491044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 122491044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play122491045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.45

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(122491044).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 18 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 18)

				if (18 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 18)) > 0 and var_184_0 < var_184_3 then
					arg_181_1.talkMaxDuration = var_184_3

					if var_184_3 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_3 + 0
					end
				end

				arg_181_1.text_.text = var_184_1
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_4 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_4

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play122491045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 122491045
		arg_185_1.duration_ = 10.47

		local var_185_0 = {
			ja = 10.466,
			ko = 5.466,
			zh = 5.466
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
				arg_185_0:Play122491046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.65

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(122491045)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 26 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 26)

				if (26 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 26)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491045", "story_v_out_122491.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491045", "story_v_out_122491.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_122491", "122491045", "story_v_out_122491.awb")

						arg_185_1:RecordAudio("122491045", var_188_6)
						arg_185_1:RecordAudio("122491045", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_122491", "122491045", "story_v_out_122491.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_122491", "122491045", "story_v_out_122491.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play122491046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 122491046
		arg_189_1.duration_ = 9.7

		local var_189_0 = {
			ja = 9.7,
			ko = 8,
			zh = 8
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
				arg_189_0:Play122491047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.875

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_1 = arg_189_1:GetWordFromCfg(122491046)
				local var_192_2 = arg_189_1:FormatText(var_192_1.content)

				arg_189_1.text_.text = var_192_2

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 35 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 35)

				if (35 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_2) / 35)) > 0 and var_192_0 < var_192_4 then
					arg_189_1.talkMaxDuration = var_192_4

					if var_192_4 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_4 + 0
					end
				end

				arg_189_1.text_.text = var_192_2
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491046", "story_v_out_122491.awb") ~= 0 then
					local var_192_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491046", "story_v_out_122491.awb") / 1000

					if var_192_5 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + 0
					end

					if var_192_1.prefab_name ~= "" and arg_189_1.actors_[var_192_1.prefab_name] ~= nil then
						local var_192_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_1.prefab_name].transform, "story_v_out_122491", "122491046", "story_v_out_122491.awb")

						arg_189_1:RecordAudio("122491046", var_192_6)
						arg_189_1:RecordAudio("122491046", var_192_6)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_122491", "122491046", "story_v_out_122491.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_122491", "122491046", "story_v_out_122491.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_7 and arg_189_1.time_ < 0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play122491047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 122491047
		arg_193_1.duration_ = 12.63

		local var_193_0 = {
			ja = 12.633,
			ko = 7.4,
			zh = 7.4
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
				arg_193_0:Play122491048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.725

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_1 = arg_193_1:GetWordFromCfg(122491047)
				local var_196_2 = arg_193_1:FormatText(var_196_1.content)

				arg_193_1.text_.text = var_196_2

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_4 = 29 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 29)

				if (29 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_2) / 29)) > 0 and var_196_0 < var_196_4 then
					arg_193_1.talkMaxDuration = var_196_4

					if var_196_4 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_4 + 0
					end
				end

				arg_193_1.text_.text = var_196_2
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491047", "story_v_out_122491.awb") ~= 0 then
					local var_196_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491047", "story_v_out_122491.awb") / 1000

					if var_196_5 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_5 + 0
					end

					if var_196_1.prefab_name ~= "" and arg_193_1.actors_[var_196_1.prefab_name] ~= nil then
						local var_196_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_1.prefab_name].transform, "story_v_out_122491", "122491047", "story_v_out_122491.awb")

						arg_193_1:RecordAudio("122491047", var_196_6)
						arg_193_1:RecordAudio("122491047", var_196_6)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_122491", "122491047", "story_v_out_122491.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_122491", "122491047", "story_v_out_122491.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_7 and arg_193_1.time_ < 0 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play122491048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 122491048
		arg_197_1.duration_ = 7.93

		local var_197_0 = {
			ja = 7.933,
			ko = 3.833,
			zh = 3.833
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
				arg_197_0:Play122491049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.2

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(122491048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 8 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 8)

				if (8 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 8)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491048", "story_v_out_122491.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491048", "story_v_out_122491.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_122491", "122491048", "story_v_out_122491.awb")

						arg_197_1:RecordAudio("122491048", var_200_6)
						arg_197_1:RecordAudio("122491048", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_122491", "122491048", "story_v_out_122491.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_122491", "122491048", "story_v_out_122491.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play122491049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 122491049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play122491050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.825

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(122491049).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 33 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 33)

				if (33 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 33)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play122491050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 122491050
		arg_205_1.duration_ = 4.17

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play122491051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 2 < arg_205_1.time_ and arg_205_1.time_ <= 2 + arg_208_0 then
				local var_208_0 = arg_205_1.bgs_.STblack

				arg_205_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_208_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_208_1 = var_208_0:GetComponent("SpriteRenderer")

				if var_208_1 and var_208_1.sprite then
					local var_208_2 = 2 * (var_208_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_208_0.transform.localScale = Vector3.New(var_208_2 / var_208_1.sprite.bounds.size.y < var_208_2 * manager.ui.mainCameraCom_.aspect / var_208_1.sprite.bounds.size.x and var_208_2 * manager.ui.mainCameraCom_.aspect / var_208_1.sprite.bounds.size.x or var_208_2 / var_208_1.sprite.bounds.size.y, var_208_2 / var_208_1.sprite.bounds.size.y < var_208_2 * manager.ui.mainCameraCom_.aspect / var_208_1.sprite.bounds.size.x and var_208_2 * manager.ui.mainCameraCom_.aspect / var_208_1.sprite.bounds.size.x or var_208_2 / var_208_1.sprite.bounds.size.y, 0)
				end

				for iter_208_0, iter_208_1 in pairs(arg_205_1.bgs_) do
					if iter_208_0 ~= "STblack" then
						iter_208_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_208_3 = 0

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_3 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_4 = 2

			if var_208_3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_3 + var_208_4 then
				local var_208_5 = Color.New(0, 0, 0)

				var_208_5.a = Mathf.Lerp(0, 1, (arg_205_1.time_ - var_208_3) / var_208_4)
				arg_205_1.mask_.color = var_208_5
			end

			if arg_205_1.time_ >= var_208_3 + var_208_4 and arg_205_1.time_ < var_208_3 + var_208_4 + arg_208_0 then
				local var_208_6 = Color.New(0, 0, 0)

				var_208_6.a = 1
				arg_205_1.mask_.color = var_208_6
			end

			local var_208_7 = 2

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= var_208_7 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_8 = 2

			if var_208_7 <= arg_205_1.time_ and arg_205_1.time_ < var_208_7 + var_208_8 then
				local var_208_9 = Color.New(0, 0, 0)

				var_208_9.a = Mathf.Lerp(1, 0, (arg_205_1.time_ - var_208_7) / var_208_8)
				arg_205_1.mask_.color = var_208_9
			end

			if arg_205_1.time_ >= var_208_7 + var_208_8 and arg_205_1.time_ < var_208_7 + var_208_8 + arg_208_0 then
				local var_208_10 = Color.New(0, 0, 0)

				arg_205_1.mask_.enabled = false
				var_208_10.a = 0
				arg_205_1.mask_.color = var_208_10
			end

			if 2.68333333333333 < arg_205_1.time_ and arg_205_1.time_ <= 2.68333333333333 + arg_208_0 then
				arg_205_1.fswbg_:SetActive(true)
				arg_205_1.dialog_:SetActive(false)

				arg_205_1.fswtw_.percent = 0
				arg_205_1.fswt_.text = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(122491050).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.fswt_)

				arg_205_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_205_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_205_1.fswtw_:SetDirty()

				arg_205_1.typewritterCharCountI18N = 0

				SetActive(arg_205_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_205_1:ShowNextGo(false)
			end

			local var_208_11 = 2.7

			if 2.7 < arg_205_1.time_ and arg_205_1.time_ <= var_208_11 + arg_208_0 then
				arg_205_1.var_.oldValueTypewriter = arg_205_1.fswtw_.percent

				SetActive(arg_205_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_205_1:ShowNextGo(false)
			end

			local var_208_12 = 22
			local var_208_13 = 1.46666666666667
			local var_208_14, var_208_15 = arg_205_1:GetPercentByPara(arg_205_1:FormatText(arg_205_1:GetWordFromCfg(122491050).content), 1)

			if var_208_11 < arg_205_1.time_ and arg_205_1.time_ <= var_208_11 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				local var_208_16 = var_208_12 <= 0 and var_208_13 or var_208_13 * ((var_208_15 - arg_205_1.typewritterCharCountI18N) / var_208_12)

				if (var_208_12 <= 0 and var_208_13 or var_208_13 * ((var_208_15 - arg_205_1.typewritterCharCountI18N) / var_208_12)) > 0 and var_208_13 < var_208_16 then
					arg_205_1.talkMaxDuration = var_208_16

					if var_208_16 + var_208_11 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_16 + var_208_11
					end
				end
			end

			local var_208_17 = math.max(1.46666666666667, arg_205_1.talkMaxDuration)

			if var_208_11 <= arg_205_1.time_ and arg_205_1.time_ < var_208_11 + var_208_17 then
				arg_205_1.fswtw_.percent = Mathf.Lerp(arg_205_1.var_.oldValueTypewriter, var_208_14, (arg_205_1.time_ - var_208_11) / var_208_17)
				arg_205_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_205_1.fswtw_:SetDirty()
			end

			if arg_205_1.time_ >= var_208_11 + var_208_17 and arg_205_1.time_ < var_208_11 + var_208_17 + arg_208_0 then
				arg_205_1.fswtw_.percent = var_208_14

				arg_205_1.fswtw_:SetDirty()
				arg_205_1:ShowNextGo(true)

				arg_205_1.typewritterCharCountI18N = var_208_15
			end

			if 1.98333333333333 < arg_205_1.time_ and arg_205_1.time_ <= 1.98333333333333 + arg_208_0 then
				arg_205_1.fswbg_:SetActive(false)
				arg_205_1.dialog_:SetActive(false)
				SetActive(arg_205_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_205_1:ShowNextGo(false)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play122491051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 122491051
		arg_209_1.duration_ = 1

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play122491052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.fswbg_:SetActive(true)
				arg_209_1.dialog_:SetActive(false)

				arg_209_1.fswtw_.percent = 0
				arg_209_1.fswt_.text = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(122491051).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.fswt_)

				arg_209_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_209_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_209_1.fswtw_:SetDirty()

				arg_209_1.typewritterCharCountI18N = 0

				SetActive(arg_209_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_209_1:ShowNextGo(false)
			end

			local var_212_0 = 0.0166666666666666

			if 0.0166666666666666 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.var_.oldValueTypewriter = arg_209_1.fswtw_.percent

				SetActive(arg_209_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_209_1:ShowNextGo(false)
			end

			local var_212_1 = 12
			local var_212_2 = 0.8
			local var_212_3, var_212_4 = arg_209_1:GetPercentByPara(arg_209_1:FormatText(arg_209_1:GetWordFromCfg(122491051).content), 1)

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				local var_212_5 = var_212_1 <= 0 and var_212_2 or var_212_2 * ((var_212_4 - arg_209_1.typewritterCharCountI18N) / var_212_1)

				if (var_212_1 <= 0 and var_212_2 or var_212_2 * ((var_212_4 - arg_209_1.typewritterCharCountI18N) / var_212_1)) > 0 and var_212_2 < var_212_5 then
					arg_209_1.talkMaxDuration = var_212_5

					if var_212_5 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + var_212_0
					end
				end
			end

			local var_212_6 = math.max(0.8, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_6 then
				arg_209_1.fswtw_.percent = Mathf.Lerp(arg_209_1.var_.oldValueTypewriter, var_212_3, (arg_209_1.time_ - var_212_0) / var_212_6)
				arg_209_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_209_1.fswtw_:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_6 and arg_209_1.time_ < var_212_0 + var_212_6 + arg_212_0 then
				arg_209_1.fswtw_.percent = var_212_3

				arg_209_1.fswtw_:SetDirty()
				arg_209_1:ShowNextGo(true)

				arg_209_1.typewritterCharCountI18N = var_212_4
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play122491052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 122491052
		arg_213_1.duration_ = 18.9

		local var_213_0 = {
			ja = 18.9,
			ko = 8.166,
			zh = 8.166
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
				arg_213_0:Play122491053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if arg_213_1.bgs_.J08h == nil then
				local var_216_0 = Object.Instantiate(arg_213_1.paintGo_)

				var_216_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J08h")
				var_216_0.name = "J08h"
				var_216_0.transform.parent = arg_213_1.stage_.transform
				var_216_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.bgs_.J08h = var_216_0
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				local var_216_1 = arg_213_1.bgs_.J08h

				arg_213_1.bgs_.J08h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_216_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_216_2 = var_216_1:GetComponent("SpriteRenderer")

				if var_216_2 and var_216_2.sprite then
					local var_216_3 = 2 * (var_216_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_216_1.transform.localScale = Vector3.New(var_216_3 / var_216_2.sprite.bounds.size.y < var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x and var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x or var_216_3 / var_216_2.sprite.bounds.size.y, var_216_3 / var_216_2.sprite.bounds.size.y < var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x and var_216_3 * manager.ui.mainCameraCom_.aspect / var_216_2.sprite.bounds.size.x or var_216_3 / var_216_2.sprite.bounds.size.y, 0)
				end

				for iter_216_0, iter_216_1 in pairs(arg_213_1.bgs_) do
					if iter_216_0 ~= "J08h" then
						iter_216_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_216_4 = 0

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.mask_.enabled = true
				arg_213_1.mask_.raycastTarget = true

				arg_213_1:SetGaussion(false)
			end

			local var_216_5 = 3

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_5 then
				local var_216_6 = Color.New(0, 0, 0)

				var_216_6.a = Mathf.Lerp(1, 0, (arg_213_1.time_ - var_216_4) / var_216_5)
				arg_213_1.mask_.color = var_216_6
			end

			if arg_213_1.time_ >= var_216_4 + var_216_5 and arg_213_1.time_ < var_216_4 + var_216_5 + arg_216_0 then
				local var_216_7 = Color.New(0, 0, 0)

				arg_213_1.mask_.enabled = false
				var_216_7.a = 0
				arg_213_1.mask_.color = var_216_7
			end

			local var_216_8 = "4037ui_story"

			if arg_213_1.actors_["4037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4037ui_story"))) then
				local var_216_9 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_213_1.stage_.transform)

				var_216_9.name = var_216_8
				var_216_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.actors_[var_216_8] = var_216_9

				local var_216_10 = var_216_9:GetComponentInChildren(typeof(CharacterEffect))

				var_216_10.enabled = true

				local var_216_11 = GameObjectTools.GetOrAddComponent(var_216_9, typeof(DynamicBoneHelper))

				if var_216_11 then
					var_216_11:EnableDynamicBone(false)
				end

				arg_213_1:ShowWeapon(var_216_10.transform, false)

				arg_213_1.var_[var_216_8 .. "Animator"] = var_216_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_213_1.var_[var_216_8 .. "Animator"].applyRootMotion = true
				arg_213_1.var_[var_216_8 .. "LipSync"] = var_216_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_216_12 = arg_213_1.actors_["4037ui_story"].transform

			if 2.8 < arg_213_1.time_ and arg_213_1.time_ <= 2.8 + arg_216_0 then
				arg_213_1.var_.moveOldPos4037ui_story = var_216_12.localPosition
			end

			local var_216_13 = 0.001

			if 2.8 <= arg_213_1.time_ and arg_213_1.time_ < 2.8 + var_216_13 then
				var_216_12.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_213_1.time_ - 2.8) / var_216_13)
				var_216_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_12.position).x, (manager.ui.mainCamera.transform.position - var_216_12.position).y, (manager.ui.mainCamera.transform.position - var_216_12.position).z)
				var_216_12.localEulerAngles.z = 0
				var_216_12.localEulerAngles.x = 0
				var_216_12.localEulerAngles = var_216_12.localEulerAngles
			end

			if arg_213_1.time_ >= 2.8 + var_216_13 and arg_213_1.time_ < 2.8 + var_216_13 + arg_216_0 then
				var_216_12.localPosition = Vector3.New(0, -1.12, -6.2)
				var_216_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_12.position).x, (manager.ui.mainCamera.transform.position - var_216_12.position).y, (manager.ui.mainCamera.transform.position - var_216_12.position).z)
				var_216_12.localEulerAngles.z = 0
				var_216_12.localEulerAngles.x = 0
				var_216_12.localEulerAngles = var_216_12.localEulerAngles
			end

			local var_216_14 = arg_213_1.actors_["4037ui_story"]

			if 2.8 < arg_213_1.time_ and arg_213_1.time_ <= 2.8 + arg_216_0 and not isNil(var_216_14) and arg_213_1.var_.characterEffect4037ui_story == nil then
				arg_213_1.var_.characterEffect4037ui_story = var_216_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_15 = 0.200000002980232

			if 2.8 <= arg_213_1.time_ and arg_213_1.time_ < 2.8 + var_216_15 and not isNil(var_216_14) then
				if arg_213_1.var_.characterEffect4037ui_story and not isNil(var_216_14) then
					arg_213_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 2.8 + var_216_15 and arg_213_1.time_ < 2.8 + var_216_15 + arg_216_0 and not isNil(var_216_14) and arg_213_1.var_.characterEffect4037ui_story then
				arg_213_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 2.8 < arg_213_1.time_ and arg_213_1.time_ <= 2.8 + arg_216_0 then
				arg_213_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 2.8 < arg_213_1.time_ and arg_213_1.time_ <= 2.8 + arg_216_0 then
				arg_213_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.fswbg_:SetActive(false)
				arg_213_1.dialog_:SetActive(false)
				SetActive(arg_213_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_213_1:ShowNextGo(false)
			end

			if arg_213_1.frameCnt_ <= 1 then
				arg_213_1.dialog_:SetActive(false)
			end

			local var_216_17 = 3
			local var_216_18 = 0.625

			if 3 < arg_213_1.time_ and arg_213_1.time_ <= var_216_17 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_19 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_19:setOnUpdate(LuaHelper.FloatAction(function(arg_217_0)
					arg_213_1.dialogCg_.alpha = arg_217_0
				end))
				var_216_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_20 = arg_213_1:GetWordFromCfg(122491052)
				local var_216_21 = arg_213_1:FormatText(var_216_20.content)

				arg_213_1.text_.text = var_216_21

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_23 = 25 <= 0 and var_216_18 or var_216_18 * (utf8.len(var_216_21) / 25)

				if (25 <= 0 and var_216_18 or var_216_18 * (utf8.len(var_216_21) / 25)) > 0 and var_216_18 < var_216_23 then
					arg_213_1.talkMaxDuration = var_216_23
					var_216_17 = var_216_17 + 0.3

					if var_216_23 + var_216_17 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_23 + var_216_17
					end
				end

				arg_213_1.text_.text = var_216_21
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491052", "story_v_out_122491.awb") ~= 0 then
					local var_216_24 = manager.audio:GetVoiceLength("story_v_out_122491", "122491052", "story_v_out_122491.awb") / 1000

					if var_216_24 + var_216_17 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_24 + var_216_17
					end

					if var_216_20.prefab_name ~= "" and arg_213_1.actors_[var_216_20.prefab_name] ~= nil then
						local var_216_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_20.prefab_name].transform, "story_v_out_122491", "122491052", "story_v_out_122491.awb")

						arg_213_1:RecordAudio("122491052", var_216_25)
						arg_213_1:RecordAudio("122491052", var_216_25)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_122491", "122491052", "story_v_out_122491.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_122491", "122491052", "story_v_out_122491.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_26 = var_216_17 + 0.3
			local var_216_27 = math.max(var_216_18, arg_213_1.talkMaxDuration)

			if var_216_17 + 0.3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_26 + var_216_27 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_26) / var_216_27

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_26 + var_216_27 and arg_213_1.time_ < var_216_26 + var_216_27 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play122491053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 122491053
		arg_219_1.duration_ = 6.93

		local var_219_0 = {
			ja = 6.933,
			ko = 3.966,
			zh = 3.966
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play122491054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if arg_219_1.actors_["1076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1076ui_story"))) then
				local var_222_0 = Object.Instantiate(Asset.Load("Char/" .. "1076ui_story"), arg_219_1.stage_.transform)

				var_222_0.name = "1076ui_story"
				var_222_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_219_1.actors_["1076ui_story"] = var_222_0

				local var_222_1 = var_222_0:GetComponentInChildren(typeof(CharacterEffect))

				var_222_1.enabled = true

				local var_222_2 = GameObjectTools.GetOrAddComponent(var_222_0, typeof(DynamicBoneHelper))

				if var_222_2 then
					var_222_2:EnableDynamicBone(false)
				end

				arg_219_1:ShowWeapon(var_222_1.transform, false)

				arg_219_1.var_["1076ui_story" .. "Animator"] = var_222_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_219_1.var_["1076ui_story" .. "Animator"].applyRootMotion = true
				arg_219_1.var_["1076ui_story" .. "LipSync"] = var_222_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_222_3 = arg_219_1.actors_["1076ui_story"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1076ui_story = var_222_3.localPosition
			end

			local var_222_4 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 then
				var_222_3.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_219_1.time_ - 0) / var_222_4)
				var_222_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_3.position).x, (manager.ui.mainCamera.transform.position - var_222_3.position).y, (manager.ui.mainCamera.transform.position - var_222_3.position).z)
				var_222_3.localEulerAngles.z = 0
				var_222_3.localEulerAngles.x = 0
				var_222_3.localEulerAngles = var_222_3.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 then
				var_222_3.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_222_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_3.position).x, (manager.ui.mainCamera.transform.position - var_222_3.position).y, (manager.ui.mainCamera.transform.position - var_222_3.position).z)
				var_222_3.localEulerAngles.z = 0
				var_222_3.localEulerAngles.x = 0
				var_222_3.localEulerAngles = var_222_3.localEulerAngles
			end

			local var_222_5 = arg_219_1.actors_["1076ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_5) and arg_219_1.var_.characterEffect1076ui_story == nil then
				arg_219_1.var_.characterEffect1076ui_story = var_222_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_6 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_6 and not isNil(var_222_5) then
				if arg_219_1.var_.characterEffect1076ui_story and not isNil(var_222_5) then
					arg_219_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_6 and arg_219_1.time_ < 0 + var_222_6 + arg_222_0 and not isNil(var_222_5) and arg_219_1.var_.characterEffect1076ui_story then
				arg_219_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_222_8 = arg_219_1.actors_["4037ui_story"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos4037ui_story = var_222_8.localPosition
			end

			local var_222_9 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_9 then
				var_222_8.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_219_1.time_ - 0) / var_222_9)
				var_222_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_8.position).x, (manager.ui.mainCamera.transform.position - var_222_8.position).y, (manager.ui.mainCamera.transform.position - var_222_8.position).z)
				var_222_8.localEulerAngles.z = 0
				var_222_8.localEulerAngles.x = 0
				var_222_8.localEulerAngles = var_222_8.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_9 and arg_219_1.time_ < 0 + var_222_9 + arg_222_0 then
				var_222_8.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				var_222_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_8.position).x, (manager.ui.mainCamera.transform.position - var_222_8.position).y, (manager.ui.mainCamera.transform.position - var_222_8.position).z)
				var_222_8.localEulerAngles.z = 0
				var_222_8.localEulerAngles.x = 0
				var_222_8.localEulerAngles = var_222_8.localEulerAngles
			end

			local var_222_10 = arg_219_1.actors_["4037ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_10) and arg_219_1.var_.characterEffect4037ui_story == nil then
				arg_219_1.var_.characterEffect4037ui_story = var_222_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_11 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_11 and not isNil(var_222_10) then
				if arg_219_1.var_.characterEffect4037ui_story and not isNil(var_222_10) then
					arg_219_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_219_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_11)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_11 and arg_219_1.time_ < 0 + var_222_11 + arg_222_0 and not isNil(var_222_10) and arg_219_1.var_.characterEffect4037ui_story then
				arg_219_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_219_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_222_12 = 0
			local var_222_13 = 0.45

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_12 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_14 = arg_219_1:GetWordFromCfg(122491053)
				local var_222_15 = arg_219_1:FormatText(var_222_14.content)

				arg_219_1.text_.text = var_222_15

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_17 = 18 <= 0 and var_222_13 or var_222_13 * (utf8.len(var_222_15) / 18)

				if (18 <= 0 and var_222_13 or var_222_13 * (utf8.len(var_222_15) / 18)) > 0 and var_222_13 < var_222_17 then
					arg_219_1.talkMaxDuration = var_222_17

					if var_222_17 + var_222_12 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_17 + var_222_12
					end
				end

				arg_219_1.text_.text = var_222_15
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491053", "story_v_out_122491.awb") ~= 0 then
					local var_222_18 = manager.audio:GetVoiceLength("story_v_out_122491", "122491053", "story_v_out_122491.awb") / 1000

					if var_222_18 + var_222_12 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_18 + var_222_12
					end

					if var_222_14.prefab_name ~= "" and arg_219_1.actors_[var_222_14.prefab_name] ~= nil then
						local var_222_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_14.prefab_name].transform, "story_v_out_122491", "122491053", "story_v_out_122491.awb")

						arg_219_1:RecordAudio("122491053", var_222_19)
						arg_219_1:RecordAudio("122491053", var_222_19)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_122491", "122491053", "story_v_out_122491.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_122491", "122491053", "story_v_out_122491.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_20 = math.max(var_222_13, arg_219_1.talkMaxDuration)

			if var_222_12 <= arg_219_1.time_ and arg_219_1.time_ < var_222_12 + var_222_20 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_12) / var_222_20

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_12 + var_222_20 and arg_219_1.time_ < var_222_12 + var_222_20 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play122491054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 122491054
		arg_223_1.duration_ = 4.57

		local var_223_0 = {
			ja = 4.566,
			ko = 2,
			zh = 2
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play122491055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["4037ui_story"]) and arg_223_1.var_.characterEffect4037ui_story == nil then
				arg_223_1.var_.characterEffect4037ui_story = arg_223_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["4037ui_story"]) then
				if arg_223_1.var_.characterEffect4037ui_story and not isNil(arg_223_1.actors_["4037ui_story"]) then
					arg_223_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["4037ui_story"]) and arg_223_1.var_.characterEffect4037ui_story then
				arg_223_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_226_2 = arg_223_1.actors_["1076ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.characterEffect1076ui_story == nil then
				arg_223_1.var_.characterEffect1076ui_story = var_226_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_3 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_3 and not isNil(var_226_2) then
				if arg_223_1.var_.characterEffect1076ui_story and not isNil(var_226_2) then
					arg_223_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_3)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_3 and arg_223_1.time_ < 0 + var_226_3 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.characterEffect1076ui_story then
				arg_223_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_226_4 = 0
			local var_226_5 = 0.2

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_4 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_6 = arg_223_1:GetWordFromCfg(122491054)
				local var_226_7 = arg_223_1:FormatText(var_226_6.content)

				arg_223_1.text_.text = var_226_7

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_9 = 8 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 8)

				if (8 <= 0 and var_226_5 or var_226_5 * (utf8.len(var_226_7) / 8)) > 0 and var_226_5 < var_226_9 then
					arg_223_1.talkMaxDuration = var_226_9

					if var_226_9 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_9 + var_226_4
					end
				end

				arg_223_1.text_.text = var_226_7
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491054", "story_v_out_122491.awb") ~= 0 then
					local var_226_10 = manager.audio:GetVoiceLength("story_v_out_122491", "122491054", "story_v_out_122491.awb") / 1000

					if var_226_10 + var_226_4 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_4
					end

					if var_226_6.prefab_name ~= "" and arg_223_1.actors_[var_226_6.prefab_name] ~= nil then
						local var_226_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_6.prefab_name].transform, "story_v_out_122491", "122491054", "story_v_out_122491.awb")

						arg_223_1:RecordAudio("122491054", var_226_11)
						arg_223_1:RecordAudio("122491054", var_226_11)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_122491", "122491054", "story_v_out_122491.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_122491", "122491054", "story_v_out_122491.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_12 = math.max(var_226_5, arg_223_1.talkMaxDuration)

			if var_226_4 <= arg_223_1.time_ and arg_223_1.time_ < var_226_4 + var_226_12 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_4) / var_226_12

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_4 + var_226_12 and arg_223_1.time_ < var_226_4 + var_226_12 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play122491055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 122491055
		arg_227_1.duration_ = 9.2

		local var_227_0 = {
			ja = 9.2,
			ko = 6.033,
			zh = 6.033
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play122491056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1076ui_story"]) and arg_227_1.var_.characterEffect1076ui_story == nil then
				arg_227_1.var_.characterEffect1076ui_story = arg_227_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_0 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1076ui_story"]) then
				if arg_227_1.var_.characterEffect1076ui_story and not isNil(arg_227_1.actors_["1076ui_story"]) then
					arg_227_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1076ui_story"]) and arg_227_1.var_.characterEffect1076ui_story then
				arg_227_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_230_2 = arg_227_1.actors_["4037ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.characterEffect4037ui_story == nil then
				arg_227_1.var_.characterEffect4037ui_story = var_230_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_3 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_3 and not isNil(var_230_2) then
				if arg_227_1.var_.characterEffect4037ui_story and not isNil(var_230_2) then
					arg_227_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_227_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_3)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_3 and arg_227_1.time_ < 0 + var_230_3 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.characterEffect4037ui_story then
				arg_227_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_227_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_230_4 = 0
			local var_230_5 = 0.65

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_6 = arg_227_1:GetWordFromCfg(122491055)
				local var_230_7 = arg_227_1:FormatText(var_230_6.content)

				arg_227_1.text_.text = var_230_7

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_9 = 26 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 26)

				if (26 <= 0 and var_230_5 or var_230_5 * (utf8.len(var_230_7) / 26)) > 0 and var_230_5 < var_230_9 then
					arg_227_1.talkMaxDuration = var_230_9

					if var_230_9 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_9 + var_230_4
					end
				end

				arg_227_1.text_.text = var_230_7
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491055", "story_v_out_122491.awb") ~= 0 then
					local var_230_10 = manager.audio:GetVoiceLength("story_v_out_122491", "122491055", "story_v_out_122491.awb") / 1000

					if var_230_10 + var_230_4 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_4
					end

					if var_230_6.prefab_name ~= "" and arg_227_1.actors_[var_230_6.prefab_name] ~= nil then
						local var_230_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_6.prefab_name].transform, "story_v_out_122491", "122491055", "story_v_out_122491.awb")

						arg_227_1:RecordAudio("122491055", var_230_11)
						arg_227_1:RecordAudio("122491055", var_230_11)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_122491", "122491055", "story_v_out_122491.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_122491", "122491055", "story_v_out_122491.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_12 = math.max(var_230_5, arg_227_1.talkMaxDuration)

			if var_230_4 <= arg_227_1.time_ and arg_227_1.time_ < var_230_4 + var_230_12 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_4) / var_230_12

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_4 + var_230_12 and arg_227_1.time_ < var_230_4 + var_230_12 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play122491056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 122491056
		arg_231_1.duration_ = 14.93

		local var_231_0 = {
			ja = 14.933,
			ko = 10.766,
			zh = 10.766
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play122491057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["4037ui_story"]) and arg_231_1.var_.characterEffect4037ui_story == nil then
				arg_231_1.var_.characterEffect4037ui_story = arg_231_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["4037ui_story"]) then
				if arg_231_1.var_.characterEffect4037ui_story and not isNil(arg_231_1.actors_["4037ui_story"]) then
					arg_231_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["4037ui_story"]) and arg_231_1.var_.characterEffect4037ui_story then
				arg_231_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_2 = arg_231_1.actors_["1076ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.characterEffect1076ui_story == nil then
				arg_231_1.var_.characterEffect1076ui_story = var_234_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_3 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 and not isNil(var_234_2) then
				if arg_231_1.var_.characterEffect1076ui_story and not isNil(var_234_2) then
					arg_231_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_3)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.characterEffect1076ui_story then
				arg_231_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_234_4 = 0
			local var_234_5 = 1.05

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_6 = arg_231_1:GetWordFromCfg(122491056)
				local var_234_7 = arg_231_1:FormatText(var_234_6.content)

				arg_231_1.text_.text = var_234_7

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_9 = 42 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 42)

				if (42 <= 0 and var_234_5 or var_234_5 * (utf8.len(var_234_7) / 42)) > 0 and var_234_5 < var_234_9 then
					arg_231_1.talkMaxDuration = var_234_9

					if var_234_9 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_4
					end
				end

				arg_231_1.text_.text = var_234_7
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491056", "story_v_out_122491.awb") ~= 0 then
					local var_234_10 = manager.audio:GetVoiceLength("story_v_out_122491", "122491056", "story_v_out_122491.awb") / 1000

					if var_234_10 + var_234_4 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_4
					end

					if var_234_6.prefab_name ~= "" and arg_231_1.actors_[var_234_6.prefab_name] ~= nil then
						local var_234_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_6.prefab_name].transform, "story_v_out_122491", "122491056", "story_v_out_122491.awb")

						arg_231_1:RecordAudio("122491056", var_234_11)
						arg_231_1:RecordAudio("122491056", var_234_11)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_122491", "122491056", "story_v_out_122491.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_122491", "122491056", "story_v_out_122491.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_12 = math.max(var_234_5, arg_231_1.talkMaxDuration)

			if var_234_4 <= arg_231_1.time_ and arg_231_1.time_ < var_234_4 + var_234_12 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_4) / var_234_12

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_4 + var_234_12 and arg_231_1.time_ < var_234_4 + var_234_12 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play122491057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 122491057
		arg_235_1.duration_ = 10.93

		local var_235_0 = {
			ja = 10.933,
			ko = 4.533,
			zh = 4.533
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play122491058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_1")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_238_0 = 0
			local var_238_1 = 0.425

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_2 = arg_235_1:GetWordFromCfg(122491057)
				local var_238_3 = arg_235_1:FormatText(var_238_2.content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 17 <= 0 and var_238_1 or var_238_1 * (utf8.len(var_238_3) / 17)

				if (17 <= 0 and var_238_1 or var_238_1 * (utf8.len(var_238_3) / 17)) > 0 and var_238_1 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491057", "story_v_out_122491.awb") ~= 0 then
					local var_238_6 = manager.audio:GetVoiceLength("story_v_out_122491", "122491057", "story_v_out_122491.awb") / 1000

					if var_238_6 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_0
					end

					if var_238_2.prefab_name ~= "" and arg_235_1.actors_[var_238_2.prefab_name] ~= nil then
						local var_238_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_2.prefab_name].transform, "story_v_out_122491", "122491057", "story_v_out_122491.awb")

						arg_235_1:RecordAudio("122491057", var_238_7)
						arg_235_1:RecordAudio("122491057", var_238_7)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_122491", "122491057", "story_v_out_122491.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_122491", "122491057", "story_v_out_122491.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_8 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_8 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_8

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_8 and arg_235_1.time_ < var_238_0 + var_238_8 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play122491058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 122491058
		arg_239_1.duration_ = 6.93

		local var_239_0 = {
			ja = 6.933,
			ko = 4.833,
			zh = 4.833
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play122491059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1076ui_story = arg_239_1.actors_["1076ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1076ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1076ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1076ui_story"].transform.position).z)
				arg_239_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1076ui_story"].transform.localEulerAngles = arg_239_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1076ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_239_1.actors_["1076ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1076ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1076ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1076ui_story"].transform.position).z)
				arg_239_1.actors_["1076ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1076ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1076ui_story"].transform.localEulerAngles = arg_239_1.actors_["1076ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1076ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1076ui_story == nil then
				arg_239_1.var_.characterEffect1076ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1076ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1076ui_story then
				arg_239_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_242_4 = arg_239_1.actors_["4037ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_4) and arg_239_1.var_.characterEffect4037ui_story == nil then
				arg_239_1.var_.characterEffect4037ui_story = var_242_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_5 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_5 and not isNil(var_242_4) then
				if arg_239_1.var_.characterEffect4037ui_story and not isNil(var_242_4) then
					arg_239_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_239_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_239_1.time_ - 0) / var_242_5)
				end
			end

			if arg_239_1.time_ >= 0 + var_242_5 and arg_239_1.time_ < 0 + var_242_5 + arg_242_0 and not isNil(var_242_4) and arg_239_1.var_.characterEffect4037ui_story then
				arg_239_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_239_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_242_6 = 0
			local var_242_7 = 0.625

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_6 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_8 = arg_239_1:GetWordFromCfg(122491058)
				local var_242_9 = arg_239_1:FormatText(var_242_8.content)

				arg_239_1.text_.text = var_242_9

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_11 = 25 <= 0 and var_242_7 or var_242_7 * (utf8.len(var_242_9) / 25)

				if (25 <= 0 and var_242_7 or var_242_7 * (utf8.len(var_242_9) / 25)) > 0 and var_242_7 < var_242_11 then
					arg_239_1.talkMaxDuration = var_242_11

					if var_242_11 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_11 + var_242_6
					end
				end

				arg_239_1.text_.text = var_242_9
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491058", "story_v_out_122491.awb") ~= 0 then
					local var_242_12 = manager.audio:GetVoiceLength("story_v_out_122491", "122491058", "story_v_out_122491.awb") / 1000

					if var_242_12 + var_242_6 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_12 + var_242_6
					end

					if var_242_8.prefab_name ~= "" and arg_239_1.actors_[var_242_8.prefab_name] ~= nil then
						local var_242_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_8.prefab_name].transform, "story_v_out_122491", "122491058", "story_v_out_122491.awb")

						arg_239_1:RecordAudio("122491058", var_242_13)
						arg_239_1:RecordAudio("122491058", var_242_13)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_122491", "122491058", "story_v_out_122491.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_122491", "122491058", "story_v_out_122491.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_14 = math.max(var_242_7, arg_239_1.talkMaxDuration)

			if var_242_6 <= arg_239_1.time_ and arg_239_1.time_ < var_242_6 + var_242_14 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_6) / var_242_14

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_6 + var_242_14 and arg_239_1.time_ < var_242_6 + var_242_14 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play122491059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 122491059
		arg_243_1.duration_ = 21.63

		local var_243_0 = {
			ja = 21.633,
			ko = 13.1,
			zh = 13.1
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play122491060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1076ui_story"]) and arg_243_1.var_.characterEffect1076ui_story == nil then
				arg_243_1.var_.characterEffect1076ui_story = arg_243_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1076ui_story"]) then
				if arg_243_1.var_.characterEffect1076ui_story and not isNil(arg_243_1.actors_["1076ui_story"]) then
					arg_243_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1076ui_story"]) and arg_243_1.var_.characterEffect1076ui_story then
				arg_243_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_246_2 = 0
			local var_246_3 = 1.2

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_2 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_4 = arg_243_1:GetWordFromCfg(122491059)
				local var_246_5 = arg_243_1:FormatText(var_246_4.content)

				arg_243_1.text_.text = var_246_5

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_7 = 48 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_5) / 48)

				if (48 <= 0 and var_246_3 or var_246_3 * (utf8.len(var_246_5) / 48)) > 0 and var_246_3 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_2
					end
				end

				arg_243_1.text_.text = var_246_5
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491059", "story_v_out_122491.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_out_122491", "122491059", "story_v_out_122491.awb") / 1000

					if var_246_8 + var_246_2 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_2
					end

					if var_246_4.prefab_name ~= "" and arg_243_1.actors_[var_246_4.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_4.prefab_name].transform, "story_v_out_122491", "122491059", "story_v_out_122491.awb")

						arg_243_1:RecordAudio("122491059", var_246_9)
						arg_243_1:RecordAudio("122491059", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_122491", "122491059", "story_v_out_122491.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_122491", "122491059", "story_v_out_122491.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_3, arg_243_1.talkMaxDuration)

			if var_246_2 <= arg_243_1.time_ and arg_243_1.time_ < var_246_2 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_2) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_2 + var_246_10 and arg_243_1.time_ < var_246_2 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play122491060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 122491060
		arg_247_1.duration_ = 15.83

		local var_247_0 = {
			ja = 15.833,
			ko = 12.033,
			zh = 12.033
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play122491061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_250_0 = 0
			local var_250_1 = 1.1

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_2 = arg_247_1:GetWordFromCfg(122491060)
				local var_250_3 = arg_247_1:FormatText(var_250_2.content)

				arg_247_1.text_.text = var_250_3

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_5 = 44 <= 0 and var_250_1 or var_250_1 * (utf8.len(var_250_3) / 44)

				if (44 <= 0 and var_250_1 or var_250_1 * (utf8.len(var_250_3) / 44)) > 0 and var_250_1 < var_250_5 then
					arg_247_1.talkMaxDuration = var_250_5

					if var_250_5 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_3
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491060", "story_v_out_122491.awb") ~= 0 then
					local var_250_6 = manager.audio:GetVoiceLength("story_v_out_122491", "122491060", "story_v_out_122491.awb") / 1000

					if var_250_6 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_6 + var_250_0
					end

					if var_250_2.prefab_name ~= "" and arg_247_1.actors_[var_250_2.prefab_name] ~= nil then
						local var_250_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_2.prefab_name].transform, "story_v_out_122491", "122491060", "story_v_out_122491.awb")

						arg_247_1:RecordAudio("122491060", var_250_7)
						arg_247_1:RecordAudio("122491060", var_250_7)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_122491", "122491060", "story_v_out_122491.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_122491", "122491060", "story_v_out_122491.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_8 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_8 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_8

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_8 and arg_247_1.time_ < var_250_0 + var_250_8 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play122491061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 122491061
		arg_251_1.duration_ = 21.73

		local var_251_0 = {
			ja = 21.733,
			ko = 13.766,
			zh = 13.766
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play122491062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_254_0 = 0
			local var_254_1 = 1.375

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_2 = arg_251_1:GetWordFromCfg(122491061)
				local var_254_3 = arg_251_1:FormatText(var_254_2.content)

				arg_251_1.text_.text = var_254_3

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_5 = 55 <= 0 and var_254_1 or var_254_1 * (utf8.len(var_254_3) / 55)

				if (55 <= 0 and var_254_1 or var_254_1 * (utf8.len(var_254_3) / 55)) > 0 and var_254_1 < var_254_5 then
					arg_251_1.talkMaxDuration = var_254_5

					if var_254_5 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + var_254_0
					end
				end

				arg_251_1.text_.text = var_254_3
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491061", "story_v_out_122491.awb") ~= 0 then
					local var_254_6 = manager.audio:GetVoiceLength("story_v_out_122491", "122491061", "story_v_out_122491.awb") / 1000

					if var_254_6 + var_254_0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_0
					end

					if var_254_2.prefab_name ~= "" and arg_251_1.actors_[var_254_2.prefab_name] ~= nil then
						local var_254_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_2.prefab_name].transform, "story_v_out_122491", "122491061", "story_v_out_122491.awb")

						arg_251_1:RecordAudio("122491061", var_254_7)
						arg_251_1:RecordAudio("122491061", var_254_7)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_122491", "122491061", "story_v_out_122491.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_122491", "122491061", "story_v_out_122491.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_8 = math.max(var_254_1, arg_251_1.talkMaxDuration)

			if var_254_0 <= arg_251_1.time_ and arg_251_1.time_ < var_254_0 + var_254_8 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_0) / var_254_8

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_0 + var_254_8 and arg_251_1.time_ < var_254_0 + var_254_8 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play122491062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 122491062
		arg_255_1.duration_ = 18.87

		local var_255_0 = {
			ja = 18.866,
			ko = 7.4,
			zh = 7.4
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play122491063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["4037ui_story"]) and arg_255_1.var_.characterEffect4037ui_story == nil then
				arg_255_1.var_.characterEffect4037ui_story = arg_255_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["4037ui_story"]) then
				if arg_255_1.var_.characterEffect4037ui_story and not isNil(arg_255_1.actors_["4037ui_story"]) then
					arg_255_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["4037ui_story"]) and arg_255_1.var_.characterEffect4037ui_story then
				arg_255_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action3_2")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_258_2 = arg_255_1.actors_["1076ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_2) and arg_255_1.var_.characterEffect1076ui_story == nil then
				arg_255_1.var_.characterEffect1076ui_story = var_258_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_3 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_3 and not isNil(var_258_2) then
				if arg_255_1.var_.characterEffect1076ui_story and not isNil(var_258_2) then
					arg_255_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_3)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_3 and arg_255_1.time_ < 0 + var_258_3 + arg_258_0 and not isNil(var_258_2) and arg_255_1.var_.characterEffect1076ui_story then
				arg_255_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_258_4 = 0
			local var_258_5 = 0.8

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_6 = arg_255_1:GetWordFromCfg(122491062)
				local var_258_7 = arg_255_1:FormatText(var_258_6.content)

				arg_255_1.text_.text = var_258_7

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_9 = 32 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_7) / 32)

				if (32 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_7) / 32)) > 0 and var_258_5 < var_258_9 then
					arg_255_1.talkMaxDuration = var_258_9

					if var_258_9 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_9 + var_258_4
					end
				end

				arg_255_1.text_.text = var_258_7
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491062", "story_v_out_122491.awb") ~= 0 then
					local var_258_10 = manager.audio:GetVoiceLength("story_v_out_122491", "122491062", "story_v_out_122491.awb") / 1000

					if var_258_10 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_4
					end

					if var_258_6.prefab_name ~= "" and arg_255_1.actors_[var_258_6.prefab_name] ~= nil then
						local var_258_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_6.prefab_name].transform, "story_v_out_122491", "122491062", "story_v_out_122491.awb")

						arg_255_1:RecordAudio("122491062", var_258_11)
						arg_255_1:RecordAudio("122491062", var_258_11)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_122491", "122491062", "story_v_out_122491.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_122491", "122491062", "story_v_out_122491.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_12 = math.max(var_258_5, arg_255_1.talkMaxDuration)

			if var_258_4 <= arg_255_1.time_ and arg_255_1.time_ < var_258_4 + var_258_12 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_4) / var_258_12

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_4 + var_258_12 and arg_255_1.time_ < var_258_4 + var_258_12 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play122491063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 122491063
		arg_259_1.duration_ = 22.4

		local var_259_0 = {
			ja = 22.4,
			ko = 13.6,
			zh = 13.6
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play122491064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 1.5

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:GetWordFromCfg(122491063)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 60 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 60)

				if (60 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 60)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491063", "story_v_out_122491.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491063", "story_v_out_122491.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_out_122491", "122491063", "story_v_out_122491.awb")

						arg_259_1:RecordAudio("122491063", var_262_6)
						arg_259_1:RecordAudio("122491063", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_122491", "122491063", "story_v_out_122491.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_122491", "122491063", "story_v_out_122491.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play122491064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 122491064
		arg_263_1.duration_ = 12.17

		local var_263_0 = {
			ja = 12.166,
			ko = 8.2,
			zh = 8.2
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play122491065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action5_1")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_266_0 = 0
			local var_266_1 = 0.775

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_2 = arg_263_1:GetWordFromCfg(122491064)
				local var_266_3 = arg_263_1:FormatText(var_266_2.content)

				arg_263_1.text_.text = var_266_3

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 31 <= 0 and var_266_1 or var_266_1 * (utf8.len(var_266_3) / 31)

				if (31 <= 0 and var_266_1 or var_266_1 * (utf8.len(var_266_3) / 31)) > 0 and var_266_1 < var_266_5 then
					arg_263_1.talkMaxDuration = var_266_5

					if var_266_5 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + var_266_0
					end
				end

				arg_263_1.text_.text = var_266_3
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491064", "story_v_out_122491.awb") ~= 0 then
					local var_266_6 = manager.audio:GetVoiceLength("story_v_out_122491", "122491064", "story_v_out_122491.awb") / 1000

					if var_266_6 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_6 + var_266_0
					end

					if var_266_2.prefab_name ~= "" and arg_263_1.actors_[var_266_2.prefab_name] ~= nil then
						local var_266_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_2.prefab_name].transform, "story_v_out_122491", "122491064", "story_v_out_122491.awb")

						arg_263_1:RecordAudio("122491064", var_266_7)
						arg_263_1:RecordAudio("122491064", var_266_7)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_122491", "122491064", "story_v_out_122491.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_122491", "122491064", "story_v_out_122491.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_8 = math.max(var_266_1, arg_263_1.talkMaxDuration)

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_8 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_0) / var_266_8

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_0 + var_266_8 and arg_263_1.time_ < var_266_0 + var_266_8 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play122491065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 122491065
		arg_267_1.duration_ = 9.2

		local var_267_0 = {
			ja = 9.2,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play122491066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1076ui_story"]) and arg_267_1.var_.characterEffect1076ui_story == nil then
				arg_267_1.var_.characterEffect1076ui_story = arg_267_1.actors_["1076ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1076ui_story"]) then
				if arg_267_1.var_.characterEffect1076ui_story and not isNil(arg_267_1.actors_["1076ui_story"]) then
					arg_267_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1076ui_story"]) and arg_267_1.var_.characterEffect1076ui_story then
				arg_267_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_270_2 = arg_267_1.actors_["4037ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.characterEffect4037ui_story == nil then
				arg_267_1.var_.characterEffect4037ui_story = var_270_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_3 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_3 and not isNil(var_270_2) then
				if arg_267_1.var_.characterEffect4037ui_story and not isNil(var_270_2) then
					arg_267_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_267_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_3)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_3 and arg_267_1.time_ < 0 + var_270_3 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.characterEffect4037ui_story then
				arg_267_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_267_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_270_4 = 0
			local var_270_5 = 0.275

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_4 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_6 = arg_267_1:GetWordFromCfg(122491065)
				local var_270_7 = arg_267_1:FormatText(var_270_6.content)

				arg_267_1.text_.text = var_270_7

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_9 = 11 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 11)

				if (11 <= 0 and var_270_5 or var_270_5 * (utf8.len(var_270_7) / 11)) > 0 and var_270_5 < var_270_9 then
					arg_267_1.talkMaxDuration = var_270_9

					if var_270_9 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_4
					end
				end

				arg_267_1.text_.text = var_270_7
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491065", "story_v_out_122491.awb") ~= 0 then
					local var_270_10 = manager.audio:GetVoiceLength("story_v_out_122491", "122491065", "story_v_out_122491.awb") / 1000

					if var_270_10 + var_270_4 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_10 + var_270_4
					end

					if var_270_6.prefab_name ~= "" and arg_267_1.actors_[var_270_6.prefab_name] ~= nil then
						local var_270_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_6.prefab_name].transform, "story_v_out_122491", "122491065", "story_v_out_122491.awb")

						arg_267_1:RecordAudio("122491065", var_270_11)
						arg_267_1:RecordAudio("122491065", var_270_11)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_122491", "122491065", "story_v_out_122491.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_122491", "122491065", "story_v_out_122491.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_12 = math.max(var_270_5, arg_267_1.talkMaxDuration)

			if var_270_4 <= arg_267_1.time_ and arg_267_1.time_ < var_270_4 + var_270_12 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_4) / var_270_12

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_4 + var_270_12 and arg_267_1.time_ < var_270_4 + var_270_12 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play122491066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 122491066
		arg_271_1.duration_ = 9.87

		local var_271_0 = {
			ja = 9.866,
			ko = 2.7,
			zh = 2.7
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play122491067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action2_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_274_0 = 0
			local var_274_1 = 0.275

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_2 = arg_271_1:GetWordFromCfg(122491066)
				local var_274_3 = arg_271_1:FormatText(var_274_2.content)

				arg_271_1.text_.text = var_274_3

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_5 = 11 <= 0 and var_274_1 or var_274_1 * (utf8.len(var_274_3) / 11)

				if (11 <= 0 and var_274_1 or var_274_1 * (utf8.len(var_274_3) / 11)) > 0 and var_274_1 < var_274_5 then
					arg_271_1.talkMaxDuration = var_274_5

					if var_274_5 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + var_274_0
					end
				end

				arg_271_1.text_.text = var_274_3
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491066", "story_v_out_122491.awb") ~= 0 then
					local var_274_6 = manager.audio:GetVoiceLength("story_v_out_122491", "122491066", "story_v_out_122491.awb") / 1000

					if var_274_6 + var_274_0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_6 + var_274_0
					end

					if var_274_2.prefab_name ~= "" and arg_271_1.actors_[var_274_2.prefab_name] ~= nil then
						local var_274_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_2.prefab_name].transform, "story_v_out_122491", "122491066", "story_v_out_122491.awb")

						arg_271_1:RecordAudio("122491066", var_274_7)
						arg_271_1:RecordAudio("122491066", var_274_7)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_122491", "122491066", "story_v_out_122491.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_122491", "122491066", "story_v_out_122491.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_8 = math.max(var_274_1, arg_271_1.talkMaxDuration)

			if var_274_0 <= arg_271_1.time_ and arg_271_1.time_ < var_274_0 + var_274_8 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_0) / var_274_8

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_0 + var_274_8 and arg_271_1.time_ < var_274_0 + var_274_8 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play122491067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 122491067
		arg_275_1.duration_ = 2

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play122491068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["4037ui_story"]) and arg_275_1.var_.characterEffect4037ui_story == nil then
				arg_275_1.var_.characterEffect4037ui_story = arg_275_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_0 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["4037ui_story"]) then
				if arg_275_1.var_.characterEffect4037ui_story and not isNil(arg_275_1.actors_["4037ui_story"]) then
					arg_275_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["4037ui_story"]) and arg_275_1.var_.characterEffect4037ui_story then
				arg_275_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action5_2")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_278_2 = arg_275_1.actors_["1076ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.characterEffect1076ui_story == nil then
				arg_275_1.var_.characterEffect1076ui_story = var_278_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_3 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_3 and not isNil(var_278_2) then
				if arg_275_1.var_.characterEffect1076ui_story and not isNil(var_278_2) then
					arg_275_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_3)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_3 and arg_275_1.time_ < 0 + var_278_3 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.characterEffect1076ui_story then
				arg_275_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_278_4 = 0
			local var_278_5 = 0.1

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_4 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_6 = arg_275_1:GetWordFromCfg(122491067)
				local var_278_7 = arg_275_1:FormatText(var_278_6.content)

				arg_275_1.text_.text = var_278_7

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_9 = 4 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 4)

				if (4 <= 0 and var_278_5 or var_278_5 * (utf8.len(var_278_7) / 4)) > 0 and var_278_5 < var_278_9 then
					arg_275_1.talkMaxDuration = var_278_9

					if var_278_9 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_9 + var_278_4
					end
				end

				arg_275_1.text_.text = var_278_7
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491067", "story_v_out_122491.awb") ~= 0 then
					local var_278_10 = manager.audio:GetVoiceLength("story_v_out_122491", "122491067", "story_v_out_122491.awb") / 1000

					if var_278_10 + var_278_4 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_4
					end

					if var_278_6.prefab_name ~= "" and arg_275_1.actors_[var_278_6.prefab_name] ~= nil then
						local var_278_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_6.prefab_name].transform, "story_v_out_122491", "122491067", "story_v_out_122491.awb")

						arg_275_1:RecordAudio("122491067", var_278_11)
						arg_275_1:RecordAudio("122491067", var_278_11)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_122491", "122491067", "story_v_out_122491.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_122491", "122491067", "story_v_out_122491.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_12 = math.max(var_278_5, arg_275_1.talkMaxDuration)

			if var_278_4 <= arg_275_1.time_ and arg_275_1.time_ < var_278_4 + var_278_12 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_4) / var_278_12

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_4 + var_278_12 and arg_275_1.time_ < var_278_4 + var_278_12 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play122491068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 122491068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play122491069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos4037ui_story = arg_279_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_282_0 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 then
				arg_279_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 0) / var_282_0)
				arg_279_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["4037ui_story"].transform.position).z)
				arg_279_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["4037ui_story"].transform.localEulerAngles = arg_279_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 then
				arg_279_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_279_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["4037ui_story"].transform.position).z)
				arg_279_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["4037ui_story"].transform.localEulerAngles = arg_279_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_282_1 = arg_279_1.actors_["4037ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect4037ui_story == nil then
				arg_279_1.var_.characterEffect4037ui_story = var_282_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_2 and not isNil(var_282_1) then
				if arg_279_1.var_.characterEffect4037ui_story and not isNil(var_282_1) then
					arg_279_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_279_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_2)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_2 and arg_279_1.time_ < 0 + var_282_2 + arg_282_0 and not isNil(var_282_1) and arg_279_1.var_.characterEffect4037ui_story then
				arg_279_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_279_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_282_3 = arg_279_1.actors_["1076ui_story"].transform

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos1076ui_story = var_282_3.localPosition
			end

			local var_282_4 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				var_282_3.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_279_1.time_ - 0) / var_282_4)
				var_282_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_3.position).x, (manager.ui.mainCamera.transform.position - var_282_3.position).y, (manager.ui.mainCamera.transform.position - var_282_3.position).z)
				var_282_3.localEulerAngles.z = 0
				var_282_3.localEulerAngles.x = 0
				var_282_3.localEulerAngles = var_282_3.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				var_282_3.localPosition = Vector3.New(0, 100, 0)
				var_282_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_282_3.position).x, (manager.ui.mainCamera.transform.position - var_282_3.position).y, (manager.ui.mainCamera.transform.position - var_282_3.position).z)
				var_282_3.localEulerAngles.z = 0
				var_282_3.localEulerAngles.x = 0
				var_282_3.localEulerAngles = var_282_3.localEulerAngles
			end

			local var_282_5 = arg_279_1.actors_["1076ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_5) and arg_279_1.var_.characterEffect1076ui_story == nil then
				arg_279_1.var_.characterEffect1076ui_story = var_282_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_6 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_6 and not isNil(var_282_5) then
				if arg_279_1.var_.characterEffect1076ui_story and not isNil(var_282_5) then
					arg_279_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_6)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_6 and arg_279_1.time_ < 0 + var_282_6 + arg_282_0 and not isNil(var_282_5) and arg_279_1.var_.characterEffect1076ui_story then
				arg_279_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_282_7 = 0
			local var_282_8 = 0.8

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_7 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_9 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(122491068).content)

				arg_279_1.text_.text = var_282_9

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_11 = 32 <= 0 and var_282_8 or var_282_8 * (utf8.len(var_282_9) / 32)

				if (32 <= 0 and var_282_8 or var_282_8 * (utf8.len(var_282_9) / 32)) > 0 and var_282_8 < var_282_11 then
					arg_279_1.talkMaxDuration = var_282_11

					if var_282_11 + var_282_7 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_11 + var_282_7
					end
				end

				arg_279_1.text_.text = var_282_9
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_12 = math.max(var_282_8, arg_279_1.talkMaxDuration)

			if var_282_7 <= arg_279_1.time_ and arg_279_1.time_ < var_282_7 + var_282_12 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_7) / var_282_12

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_7 + var_282_12 and arg_279_1.time_ < var_282_7 + var_282_12 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play122491069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 122491069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play122491070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0.95

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(122491069).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 38 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 38)

				if (38 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 38)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play122491070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 122491070
		arg_287_1.duration_ = 6.83

		local var_287_0 = {
			ja = 6.833,
			ko = 5.7,
			zh = 5.7
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play122491071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 2 < arg_287_1.time_ and arg_287_1.time_ <= 2 + arg_290_0 then
				local var_290_0 = arg_287_1.bgs_.XH0602

				arg_287_1.bgs_.XH0602.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_290_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_290_1 = var_290_0:GetComponent("SpriteRenderer")

				if var_290_1 and var_290_1.sprite then
					local var_290_2 = 2 * (var_290_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_290_0.transform.localScale = Vector3.New(var_290_2 / var_290_1.sprite.bounds.size.y < var_290_2 * manager.ui.mainCameraCom_.aspect / var_290_1.sprite.bounds.size.x and var_290_2 * manager.ui.mainCameraCom_.aspect / var_290_1.sprite.bounds.size.x or var_290_2 / var_290_1.sprite.bounds.size.y, var_290_2 / var_290_1.sprite.bounds.size.y < var_290_2 * manager.ui.mainCameraCom_.aspect / var_290_1.sprite.bounds.size.x and var_290_2 * manager.ui.mainCameraCom_.aspect / var_290_1.sprite.bounds.size.x or var_290_2 / var_290_1.sprite.bounds.size.y, 0)
				end

				for iter_290_0, iter_290_1 in pairs(arg_287_1.bgs_) do
					if iter_290_0 ~= "XH0602" then
						iter_290_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_290_3 = 0

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_3 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_4 = 2

			if var_290_3 <= arg_287_1.time_ and arg_287_1.time_ < var_290_3 + var_290_4 then
				local var_290_5 = Color.New(0, 0, 0)

				var_290_5.a = Mathf.Lerp(0, 1, (arg_287_1.time_ - var_290_3) / var_290_4)
				arg_287_1.mask_.color = var_290_5
			end

			if arg_287_1.time_ >= var_290_3 + var_290_4 and arg_287_1.time_ < var_290_3 + var_290_4 + arg_290_0 then
				local var_290_6 = Color.New(0, 0, 0)

				var_290_6.a = 1
				arg_287_1.mask_.color = var_290_6
			end

			local var_290_7 = 2

			if 2 < arg_287_1.time_ and arg_287_1.time_ <= var_290_7 + arg_290_0 then
				arg_287_1.mask_.enabled = true
				arg_287_1.mask_.raycastTarget = true

				arg_287_1:SetGaussion(false)
			end

			local var_290_8 = 2

			if var_290_7 <= arg_287_1.time_ and arg_287_1.time_ < var_290_7 + var_290_8 then
				local var_290_9 = Color.New(0, 0, 0)

				var_290_9.a = Mathf.Lerp(1, 0, (arg_287_1.time_ - var_290_7) / var_290_8)
				arg_287_1.mask_.color = var_290_9
			end

			if arg_287_1.time_ >= var_290_7 + var_290_8 and arg_287_1.time_ < var_290_7 + var_290_8 + arg_290_0 then
				local var_290_10 = Color.New(0, 0, 0)

				arg_287_1.mask_.enabled = false
				var_290_10.a = 0
				arg_287_1.mask_.color = var_290_10
			end

			local var_290_11 = 2

			arg_287_1.isInRecall_ = false

			if var_290_11 < arg_287_1.time_ and arg_287_1.time_ <= var_290_11 + arg_290_0 then
				arg_287_1.screenFilterGo_:SetActive(true)

				arg_287_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_290_2, iter_290_3 in pairs(arg_287_1.actors_) do
					for iter_290_4, iter_290_5 in ipairs((iter_290_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_290_5.color = iter_290_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_290_12 = 0.1

			if var_290_11 <= arg_287_1.time_ and arg_287_1.time_ < var_290_11 + var_290_12 then
				arg_287_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_287_1.time_ - var_290_11) / var_290_12)
			end

			if arg_287_1.time_ >= var_290_11 + var_290_12 and arg_287_1.time_ < var_290_11 + var_290_12 + arg_290_0 then
				arg_287_1.screenFilterEffect_.weight = 1
			end

			if arg_287_1.frameCnt_ <= 1 then
				arg_287_1.dialog_:SetActive(false)
			end

			local var_290_13 = 4
			local var_290_14 = 0.125

			if 4 < arg_287_1.time_ and arg_287_1.time_ <= var_290_13 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0

				arg_287_1.dialog_:SetActive(true)

				arg_287_1.dialogCg_.alpha = 0

				local var_290_15 = LeanTween.value(arg_287_1.dialog_, 0, 1, 0.3)

				var_290_15:setOnUpdate(LuaHelper.FloatAction(function(arg_291_0)
					arg_287_1.dialogCg_.alpha = arg_291_0
				end))
				var_290_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_287_1.dialog_)
					var_290_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_287_1.duration_ = arg_287_1.duration_ + 0.3

				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_16 = arg_287_1:GetWordFromCfg(122491070)
				local var_290_17 = arg_287_1:FormatText(var_290_16.content)

				arg_287_1.text_.text = var_290_17

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_19 = 5 <= 0 and var_290_14 or var_290_14 * (utf8.len(var_290_17) / 5)

				if (5 <= 0 and var_290_14 or var_290_14 * (utf8.len(var_290_17) / 5)) > 0 and var_290_14 < var_290_19 then
					arg_287_1.talkMaxDuration = var_290_19
					var_290_13 = var_290_13 + 0.3

					if var_290_19 + var_290_13 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_19 + var_290_13
					end
				end

				arg_287_1.text_.text = var_290_17
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491070", "story_v_out_122491.awb") ~= 0 then
					local var_290_20 = manager.audio:GetVoiceLength("story_v_out_122491", "122491070", "story_v_out_122491.awb") / 1000

					if var_290_20 + var_290_13 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_20 + var_290_13
					end

					if var_290_16.prefab_name ~= "" and arg_287_1.actors_[var_290_16.prefab_name] ~= nil then
						local var_290_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_16.prefab_name].transform, "story_v_out_122491", "122491070", "story_v_out_122491.awb")

						arg_287_1:RecordAudio("122491070", var_290_21)
						arg_287_1:RecordAudio("122491070", var_290_21)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_122491", "122491070", "story_v_out_122491.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_122491", "122491070", "story_v_out_122491.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_22 = var_290_13 + 0.3
			local var_290_23 = math.max(var_290_14, arg_287_1.talkMaxDuration)

			if var_290_13 + 0.3 <= arg_287_1.time_ and arg_287_1.time_ < var_290_22 + var_290_23 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_22) / var_290_23

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_22 + var_290_23 and arg_287_1.time_ < var_290_22 + var_290_23 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play122491071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 122491071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play122491072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 1.225

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_1 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(122491071).content)

				arg_293_1.text_.text = var_296_1

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_3 = 49 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 49)

				if (49 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 49)) > 0 and var_296_0 < var_296_3 then
					arg_293_1.talkMaxDuration = var_296_3

					if var_296_3 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_3 + 0
					end
				end

				arg_293_1.text_.text = var_296_1
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_4 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_4

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play122491072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 122491072
		arg_297_1.duration_ = 5.07

		local var_297_0 = {
			ja = 5.066,
			ko = 4.1,
			zh = 4.1
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play122491073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.3

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[384].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1071")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_1 = arg_297_1:GetWordFromCfg(122491072)
				local var_300_2 = arg_297_1:FormatText(var_300_1.content)

				arg_297_1.text_.text = var_300_2

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_4 = 12 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_2) / 12)

				if (12 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_2) / 12)) > 0 and var_300_0 < var_300_4 then
					arg_297_1.talkMaxDuration = var_300_4

					if var_300_4 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_4 + 0
					end
				end

				arg_297_1.text_.text = var_300_2
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491072", "story_v_out_122491.awb") ~= 0 then
					local var_300_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491072", "story_v_out_122491.awb") / 1000

					if var_300_5 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + 0
					end

					if var_300_1.prefab_name ~= "" and arg_297_1.actors_[var_300_1.prefab_name] ~= nil then
						local var_300_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_1.prefab_name].transform, "story_v_out_122491", "122491072", "story_v_out_122491.awb")

						arg_297_1:RecordAudio("122491072", var_300_6)
						arg_297_1:RecordAudio("122491072", var_300_6)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_122491", "122491072", "story_v_out_122491.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_122491", "122491072", "story_v_out_122491.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_7 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_7 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_7

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_7 and arg_297_1.time_ < 0 + var_300_7 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play122491073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 122491073
		arg_301_1.duration_ = 1.63

		local var_301_0 = {
			ja = 1.633,
			ko = 0.999999999999,
			zh = 0.999999999999
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play122491074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.1

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1076")

				arg_301_1.callingController_:SetSelectedState("normal")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_1 = arg_301_1:GetWordFromCfg(122491073)
				local var_304_2 = arg_301_1:FormatText(var_304_1.content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 4 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 4)

				if (4 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 4)) > 0 and var_304_0 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + 0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491073", "story_v_out_122491.awb") ~= 0 then
					local var_304_5 = manager.audio:GetVoiceLength("story_v_out_122491", "122491073", "story_v_out_122491.awb") / 1000

					if var_304_5 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + 0
					end

					if var_304_1.prefab_name ~= "" and arg_301_1.actors_[var_304_1.prefab_name] ~= nil then
						local var_304_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_1.prefab_name].transform, "story_v_out_122491", "122491073", "story_v_out_122491.awb")

						arg_301_1:RecordAudio("122491073", var_304_6)
						arg_301_1:RecordAudio("122491073", var_304_6)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_122491", "122491073", "story_v_out_122491.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_122491", "122491073", "story_v_out_122491.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_7 and arg_301_1.time_ < 0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play122491074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 122491074
		arg_305_1.duration_ = 9

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play122491075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 2 < arg_305_1.time_ and arg_305_1.time_ <= 2 + arg_308_0 then
				local var_308_0 = arg_305_1.bgs_.J08h

				arg_305_1.bgs_.J08h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_308_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_308_1 = var_308_0:GetComponent("SpriteRenderer")

				if var_308_1 and var_308_1.sprite then
					local var_308_2 = 2 * (var_308_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_308_0.transform.localScale = Vector3.New(var_308_2 / var_308_1.sprite.bounds.size.y < var_308_2 * manager.ui.mainCameraCom_.aspect / var_308_1.sprite.bounds.size.x and var_308_2 * manager.ui.mainCameraCom_.aspect / var_308_1.sprite.bounds.size.x or var_308_2 / var_308_1.sprite.bounds.size.y, var_308_2 / var_308_1.sprite.bounds.size.y < var_308_2 * manager.ui.mainCameraCom_.aspect / var_308_1.sprite.bounds.size.x and var_308_2 * manager.ui.mainCameraCom_.aspect / var_308_1.sprite.bounds.size.x or var_308_2 / var_308_1.sprite.bounds.size.y, 0)
				end

				for iter_308_0, iter_308_1 in pairs(arg_305_1.bgs_) do
					if iter_308_0 ~= "J08h" then
						iter_308_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_308_3 = 0

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_3 + arg_308_0 then
				arg_305_1.mask_.enabled = true
				arg_305_1.mask_.raycastTarget = true

				arg_305_1:SetGaussion(false)
			end

			local var_308_4 = 2

			if var_308_3 <= arg_305_1.time_ and arg_305_1.time_ < var_308_3 + var_308_4 then
				local var_308_5 = Color.New(0, 0, 0)

				var_308_5.a = Mathf.Lerp(0, 1, (arg_305_1.time_ - var_308_3) / var_308_4)
				arg_305_1.mask_.color = var_308_5
			end

			if arg_305_1.time_ >= var_308_3 + var_308_4 and arg_305_1.time_ < var_308_3 + var_308_4 + arg_308_0 then
				local var_308_6 = Color.New(0, 0, 0)

				var_308_6.a = 1
				arg_305_1.mask_.color = var_308_6
			end

			local var_308_7 = 2

			if 2 < arg_305_1.time_ and arg_305_1.time_ <= var_308_7 + arg_308_0 then
				arg_305_1.mask_.enabled = true
				arg_305_1.mask_.raycastTarget = true

				arg_305_1:SetGaussion(false)
			end

			local var_308_8 = 2

			if var_308_7 <= arg_305_1.time_ and arg_305_1.time_ < var_308_7 + var_308_8 then
				local var_308_9 = Color.New(0, 0, 0)

				var_308_9.a = Mathf.Lerp(1, 0, (arg_305_1.time_ - var_308_7) / var_308_8)
				arg_305_1.mask_.color = var_308_9
			end

			if arg_305_1.time_ >= var_308_7 + var_308_8 and arg_305_1.time_ < var_308_7 + var_308_8 + arg_308_0 then
				local var_308_10 = Color.New(0, 0, 0)

				arg_305_1.mask_.enabled = false
				var_308_10.a = 0
				arg_305_1.mask_.color = var_308_10
			end

			local var_308_11 = 2

			arg_305_1.isInRecall_ = false

			if var_308_11 < arg_305_1.time_ and arg_305_1.time_ <= var_308_11 + arg_308_0 then
				arg_305_1.screenFilterGo_:SetActive(false)

				for iter_308_2, iter_308_3 in pairs(arg_305_1.actors_) do
					for iter_308_4, iter_308_5 in ipairs((iter_308_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_308_5.color = iter_308_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_308_12 = 0.0166666666666666

			if var_308_11 <= arg_305_1.time_ and arg_305_1.time_ < var_308_11 + var_308_12 then
				arg_305_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_305_1.time_ - var_308_11) / var_308_12)
			end

			if arg_305_1.time_ >= var_308_11 + var_308_12 and arg_305_1.time_ < var_308_11 + var_308_12 + arg_308_0 then
				arg_305_1.screenFilterEffect_.weight = 0
			end

			if arg_305_1.frameCnt_ <= 1 then
				arg_305_1.dialog_:SetActive(false)
			end

			local var_308_13 = 4
			local var_308_14 = 1.425

			if 4 < arg_305_1.time_ and arg_305_1.time_ <= var_308_13 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0

				arg_305_1.dialog_:SetActive(true)

				arg_305_1.dialogCg_.alpha = 0

				local var_308_15 = LeanTween.value(arg_305_1.dialog_, 0, 1, 0.3)

				var_308_15:setOnUpdate(LuaHelper.FloatAction(function(arg_309_0)
					arg_305_1.dialogCg_.alpha = arg_309_0
				end))
				var_308_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_305_1.dialog_)
					var_308_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_305_1.duration_ = arg_305_1.duration_ + 0.3

				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_16 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(122491074).content)

				arg_305_1.text_.text = var_308_16

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_18 = 57 <= 0 and var_308_14 or var_308_14 * (utf8.len(var_308_16) / 57)

				if (57 <= 0 and var_308_14 or var_308_14 * (utf8.len(var_308_16) / 57)) > 0 and var_308_14 < var_308_18 then
					arg_305_1.talkMaxDuration = var_308_18
					var_308_13 = var_308_13 + 0.3

					if var_308_18 + var_308_13 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_18 + var_308_13
					end
				end

				arg_305_1.text_.text = var_308_16
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_19 = var_308_13 + 0.3
			local var_308_20 = math.max(var_308_14, arg_305_1.talkMaxDuration)

			if var_308_13 + 0.3 <= arg_305_1.time_ and arg_305_1.time_ < var_308_19 + var_308_20 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_19) / var_308_20

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_19 + var_308_20 and arg_305_1.time_ < var_308_19 + var_308_20 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play122491075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 122491075
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play122491076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.725

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(122491075).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 29 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 29)

				if (29 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 29)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play122491076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 122491076
		arg_315_1.duration_ = 8.03

		local var_315_0 = {
			ja = 7.333,
			ko = 8.033,
			zh = 8.033
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
				arg_315_0:Play122491077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos4037ui_story = arg_315_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_318_0 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 then
				arg_315_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_315_1.time_ - 0) / var_318_0)
				arg_315_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["4037ui_story"].transform.position).z)
				arg_315_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["4037ui_story"].transform.localEulerAngles = arg_315_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 then
				arg_315_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_315_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["4037ui_story"].transform.position).z)
				arg_315_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["4037ui_story"].transform.localEulerAngles = arg_315_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_318_1 = arg_315_1.actors_["4037ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect4037ui_story == nil then
				arg_315_1.var_.characterEffect4037ui_story = var_318_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_2 and not isNil(var_318_1) then
				if arg_315_1.var_.characterEffect4037ui_story and not isNil(var_318_1) then
					arg_315_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_2 and arg_315_1.time_ < 0 + var_318_2 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect4037ui_story then
				arg_315_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_318_4 = 0
			local var_318_5 = 0.5

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_4 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_6 = arg_315_1:GetWordFromCfg(122491076)
				local var_318_7 = arg_315_1:FormatText(var_318_6.content)

				arg_315_1.text_.text = var_318_7

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_9 = 20 <= 0 and var_318_5 or var_318_5 * (utf8.len(var_318_7) / 20)

				if (20 <= 0 and var_318_5 or var_318_5 * (utf8.len(var_318_7) / 20)) > 0 and var_318_5 < var_318_9 then
					arg_315_1.talkMaxDuration = var_318_9

					if var_318_9 + var_318_4 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_9 + var_318_4
					end
				end

				arg_315_1.text_.text = var_318_7
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491076", "story_v_out_122491.awb") ~= 0 then
					local var_318_10 = manager.audio:GetVoiceLength("story_v_out_122491", "122491076", "story_v_out_122491.awb") / 1000

					if var_318_10 + var_318_4 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_10 + var_318_4
					end

					if var_318_6.prefab_name ~= "" and arg_315_1.actors_[var_318_6.prefab_name] ~= nil then
						local var_318_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_6.prefab_name].transform, "story_v_out_122491", "122491076", "story_v_out_122491.awb")

						arg_315_1:RecordAudio("122491076", var_318_11)
						arg_315_1:RecordAudio("122491076", var_318_11)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_122491", "122491076", "story_v_out_122491.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_122491", "122491076", "story_v_out_122491.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_12 = math.max(var_318_5, arg_315_1.talkMaxDuration)

			if var_318_4 <= arg_315_1.time_ and arg_315_1.time_ < var_318_4 + var_318_12 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_4) / var_318_12

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_4 + var_318_12 and arg_315_1.time_ < var_318_4 + var_318_12 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play122491077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 122491077
		arg_319_1.duration_ = 6.03

		local var_319_0 = {
			ja = 6.033,
			ko = 3.966,
			zh = 3.966
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
				arg_319_0:Play122491078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos4037ui_story = arg_319_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_322_0 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 then
				arg_319_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_319_1.time_ - 0) / var_322_0)
				arg_319_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["4037ui_story"].transform.position).z)
				arg_319_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["4037ui_story"].transform.localEulerAngles = arg_319_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 then
				arg_319_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_319_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_319_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_319_1.actors_["4037ui_story"].transform.position).z)
				arg_319_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_319_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_319_1.actors_["4037ui_story"].transform.localEulerAngles = arg_319_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_322_1 = arg_319_1.actors_["4037ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect4037ui_story == nil then
				arg_319_1.var_.characterEffect4037ui_story = var_322_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_2 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_2 and not isNil(var_322_1) then
				if arg_319_1.var_.characterEffect4037ui_story and not isNil(var_322_1) then
					arg_319_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_319_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_2)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_2 and arg_319_1.time_ < 0 + var_322_2 + arg_322_0 and not isNil(var_322_1) and arg_319_1.var_.characterEffect4037ui_story then
				arg_319_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_319_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_322_3 = arg_319_1.actors_["1076ui_story"].transform

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1076ui_story = var_322_3.localPosition
			end

			local var_322_4 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 then
				var_322_3.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1076ui_story, Vector3.New(0, -1.06, -6.2), (arg_319_1.time_ - 0) / var_322_4)
				var_322_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_3.position).x, (manager.ui.mainCamera.transform.position - var_322_3.position).y, (manager.ui.mainCamera.transform.position - var_322_3.position).z)
				var_322_3.localEulerAngles.z = 0
				var_322_3.localEulerAngles.x = 0
				var_322_3.localEulerAngles = var_322_3.localEulerAngles
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 then
				var_322_3.localPosition = Vector3.New(0, -1.06, -6.2)
				var_322_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_322_3.position).x, (manager.ui.mainCamera.transform.position - var_322_3.position).y, (manager.ui.mainCamera.transform.position - var_322_3.position).z)
				var_322_3.localEulerAngles.z = 0
				var_322_3.localEulerAngles.x = 0
				var_322_3.localEulerAngles = var_322_3.localEulerAngles
			end

			local var_322_5 = arg_319_1.actors_["1076ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_5) and arg_319_1.var_.characterEffect1076ui_story == nil then
				arg_319_1.var_.characterEffect1076ui_story = var_322_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_6 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_6 and not isNil(var_322_5) then
				if arg_319_1.var_.characterEffect1076ui_story and not isNil(var_322_5) then
					arg_319_1.var_.characterEffect1076ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_6 and arg_319_1.time_ < 0 + var_322_6 + arg_322_0 and not isNil(var_322_5) and arg_319_1.var_.characterEffect1076ui_story then
				arg_319_1.var_.characterEffect1076ui_story.fillFlat = false
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/story1076/story1076action/1076action1_1")
			end

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1:PlayTimeline("1076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_322_8 = 0
			local var_322_9 = 0.5

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[389].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_10 = arg_319_1:GetWordFromCfg(122491077)
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

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491077", "story_v_out_122491.awb") ~= 0 then
					local var_322_14 = manager.audio:GetVoiceLength("story_v_out_122491", "122491077", "story_v_out_122491.awb") / 1000

					if var_322_14 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_14 + var_322_8
					end

					if var_322_10.prefab_name ~= "" and arg_319_1.actors_[var_322_10.prefab_name] ~= nil then
						local var_322_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_10.prefab_name].transform, "story_v_out_122491", "122491077", "story_v_out_122491.awb")

						arg_319_1:RecordAudio("122491077", var_322_15)
						arg_319_1:RecordAudio("122491077", var_322_15)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_122491", "122491077", "story_v_out_122491.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_122491", "122491077", "story_v_out_122491.awb")
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
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play122491078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 122491078
		arg_323_1.duration_ = 8.33

		local var_323_0 = {
			ja = 8.333,
			ko = 4.4,
			zh = 4.4
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
				arg_323_0:Play122491079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos4037ui_story = arg_323_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_326_0 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 then
				arg_323_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_323_1.time_ - 0) / var_326_0)
				arg_323_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["4037ui_story"].transform.position).z)
				arg_323_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["4037ui_story"].transform.localEulerAngles = arg_323_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 then
				arg_323_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_323_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["4037ui_story"].transform.position).z)
				arg_323_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["4037ui_story"].transform.localEulerAngles = arg_323_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_326_1 = arg_323_1.actors_["4037ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect4037ui_story == nil then
				arg_323_1.var_.characterEffect4037ui_story = var_326_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_2 and not isNil(var_326_1) then
				if arg_323_1.var_.characterEffect4037ui_story and not isNil(var_326_1) then
					arg_323_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_2 and arg_323_1.time_ < 0 + var_326_2 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect4037ui_story then
				arg_323_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_326_4 = arg_323_1.actors_["1076ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1076ui_story = var_326_4.localPosition
			end

			local var_326_5 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_5 then
				var_326_4.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1076ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 0) / var_326_5)
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

			local var_326_6 = arg_323_1.actors_["1076ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_6) and arg_323_1.var_.characterEffect1076ui_story == nil then
				arg_323_1.var_.characterEffect1076ui_story = var_326_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_7 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_7 and not isNil(var_326_6) then
				if arg_323_1.var_.characterEffect1076ui_story and not isNil(var_326_6) then
					arg_323_1.var_.characterEffect1076ui_story.fillFlat = true
					arg_323_1.var_.characterEffect1076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_7)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_7 and arg_323_1.time_ < 0 + var_326_7 + arg_326_0 and not isNil(var_326_6) and arg_323_1.var_.characterEffect1076ui_story then
				arg_323_1.var_.characterEffect1076ui_story.fillFlat = true
				arg_323_1.var_.characterEffect1076ui_story.fillRatio = 0.5
			end

			local var_326_8 = 0
			local var_326_9 = 0.45

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_8 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_10 = arg_323_1:GetWordFromCfg(122491078)
				local var_326_11 = arg_323_1:FormatText(var_326_10.content)

				arg_323_1.text_.text = var_326_11

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_13 = 18 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 18)

				if (18 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 18)) > 0 and var_326_9 < var_326_13 then
					arg_323_1.talkMaxDuration = var_326_13

					if var_326_13 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_8
					end
				end

				arg_323_1.text_.text = var_326_11
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491078", "story_v_out_122491.awb") ~= 0 then
					local var_326_14 = manager.audio:GetVoiceLength("story_v_out_122491", "122491078", "story_v_out_122491.awb") / 1000

					if var_326_14 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_14 + var_326_8
					end

					if var_326_10.prefab_name ~= "" and arg_323_1.actors_[var_326_10.prefab_name] ~= nil then
						local var_326_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_10.prefab_name].transform, "story_v_out_122491", "122491078", "story_v_out_122491.awb")

						arg_323_1:RecordAudio("122491078", var_326_15)
						arg_323_1:RecordAudio("122491078", var_326_15)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_122491", "122491078", "story_v_out_122491.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_122491", "122491078", "story_v_out_122491.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_16 = math.max(var_326_9, arg_323_1.talkMaxDuration)

			if var_326_8 <= arg_323_1.time_ and arg_323_1.time_ < var_326_8 + var_326_16 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_8) / var_326_16

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_8 + var_326_16 and arg_323_1.time_ < var_326_8 + var_326_16 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play122491079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 122491079
		arg_327_1.duration_ = 6.77

		local var_327_0 = {
			ja = 6.766,
			ko = 5.4,
			zh = 5.4
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
			arg_327_1.auto_ = false
		end

		function arg_327_1.playNext_(arg_329_0)
			arg_327_1.onStoryFinished_()
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos4037ui_story = arg_327_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_330_0 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 then
				arg_327_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_327_1.time_ - 0) / var_330_0)
				arg_327_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["4037ui_story"].transform.position).z)
				arg_327_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["4037ui_story"].transform.localEulerAngles = arg_327_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 then
				arg_327_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_327_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_327_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_327_1.actors_["4037ui_story"].transform.position).z)
				arg_327_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_327_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_327_1.actors_["4037ui_story"].transform.localEulerAngles = arg_327_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_330_1 = arg_327_1.actors_["4037ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect4037ui_story == nil then
				arg_327_1.var_.characterEffect4037ui_story = var_330_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_2 and not isNil(var_330_1) then
				if arg_327_1.var_.characterEffect4037ui_story and not isNil(var_330_1) then
					arg_327_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_2 and arg_327_1.time_ < 0 + var_330_2 + arg_330_0 and not isNil(var_330_1) and arg_327_1.var_.characterEffect4037ui_story then
				arg_327_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_330_4 = 0
			local var_330_5 = 0.55

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_6 = arg_327_1:GetWordFromCfg(122491079)
				local var_330_7 = arg_327_1:FormatText(var_330_6.content)

				arg_327_1.text_.text = var_330_7

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_9 = 22 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 22)

				if (22 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 22)) > 0 and var_330_5 < var_330_9 then
					arg_327_1.talkMaxDuration = var_330_9

					if var_330_9 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_9 + var_330_4
					end
				end

				arg_327_1.text_.text = var_330_7
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122491", "122491079", "story_v_out_122491.awb") ~= 0 then
					local var_330_10 = manager.audio:GetVoiceLength("story_v_out_122491", "122491079", "story_v_out_122491.awb") / 1000

					if var_330_10 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_10 + var_330_4
					end

					if var_330_6.prefab_name ~= "" and arg_327_1.actors_[var_330_6.prefab_name] ~= nil then
						local var_330_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_6.prefab_name].transform, "story_v_out_122491", "122491079", "story_v_out_122491.awb")

						arg_327_1:RecordAudio("122491079", var_330_11)
						arg_327_1:RecordAudio("122491079", var_330_11)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_122491", "122491079", "story_v_out_122491.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_122491", "122491079", "story_v_out_122491.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_12 = math.max(var_330_5, arg_327_1.talkMaxDuration)

			if var_330_4 <= arg_327_1.time_ and arg_327_1.time_ < var_330_4 + var_330_12 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_4) / var_330_12

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_4 + var_330_12 and arg_327_1.time_ < var_330_4 + var_330_12 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/XH0602",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/XH0603",
		"TextureConfig/Background/J08h"
	},
	voices = {
		"story_v_out_122491.awb"
	}
}
