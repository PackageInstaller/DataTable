return {
	Play320042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 320042001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play320042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.XS0101 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XS0101")
				var_4_0.name = "XS0101"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.XS0101 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.XS0101

				arg_1_1.bgs_.XS0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "XS0101" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_6_story_brahma_enter", "bgm_activity_3_6_story_brahma_enter", "bgm_activity_3_6_story_brahma_enter.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_6_story_brahma_enter", "bgm_activity_3_6_story_brahma_enter")

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

			if 0.333333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.333333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_4_16 = arg_1_1.bgs_.XS0101.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosXS0101 = var_4_16.localPosition
			end

			local var_4_17 = 0.001

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_17 then
				var_4_16.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXS0101, Vector3.New(0, 1, 9.5), (arg_1_1.time_ - 0) / var_4_17)
			end

			if arg_1_1.time_ >= 0 + var_4_17 and arg_1_1.time_ < 0 + var_4_17 + arg_4_0 then
				var_4_16.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_4_18 = arg_1_1.bgs_.XS0101.transform

			if 0.0166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.0166666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPosXS0101 = var_4_18.localPosition
			end

			local var_4_19 = 6

			if 0.0166666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 0.0166666666666667 + var_4_19 then
				var_4_18.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosXS0101, Vector3.New(0, 1, 10), (arg_1_1.time_ - 0.0166666666666667) / var_4_19)
			end

			if arg_1_1.time_ >= 0.0166666666666667 + var_4_19 and arg_1_1.time_ < 0.0166666666666667 + var_4_19 + arg_4_0 then
				var_4_18.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_20 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_20 + 4.01666666666667 and arg_1_1.time_ < var_4_20 + 4.01666666666667 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_21 = 2
			local var_4_22 = 1.775

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_23 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_23:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_24 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(320042001).content)

				arg_1_1.text_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_26 = 71 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_24) / 71)

				if (71 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_24) / 71)) > 0 and var_4_22 < var_4_26 then
					arg_1_1.talkMaxDuration = var_4_26
					var_4_21 = var_4_21 + 0.3

					if var_4_26 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_21
					end
				end

				arg_1_1.text_.text = var_4_24
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_27 = var_4_21 + 0.3
			local var_4_28 = math.max(var_4_22, arg_1_1.talkMaxDuration)

			if var_4_21 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_28 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_27) / var_4_28

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_27 + var_4_28 and arg_1_1.time_ < var_4_27 + var_4_28 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "XS0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "XS0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 6,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play320042002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 320042002
		arg_9_1.duration_ = 7.57

		local var_9_0 = {
			zh = 6.233,
			ja = 7.566
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
				arg_9_0:Play320042003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.7

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(320042002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 28 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 28)

				if (28 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 28)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042002", "story_v_out_320042.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_320042", "320042002", "story_v_out_320042.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_320042", "320042002", "story_v_out_320042.awb")

						arg_9_1:RecordAudio("320042002", var_12_6)
						arg_9_1:RecordAudio("320042002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_320042", "320042002", "story_v_out_320042.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_320042", "320042002", "story_v_out_320042.awb")
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
	Play320042003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 320042003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play320042004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.15

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

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(320042003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 46 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 46)

				if (46 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 46)) > 0 and var_16_0 < var_16_3 then
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
	Play320042004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 320042004
		arg_17_1.duration_ = 3.83

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play320042005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.325

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:GetWordFromCfg(320042004)
				local var_20_2 = arg_17_1:FormatText(var_20_1.content)

				arg_17_1.text_.text = var_20_2

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_4 = 13 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 13)

				if (13 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_2) / 13)) > 0 and var_20_0 < var_20_4 then
					arg_17_1.talkMaxDuration = var_20_4

					if var_20_4 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_4 + 0
					end
				end

				arg_17_1.text_.text = var_20_2
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042004", "story_v_out_320042.awb") ~= 0 then
					local var_20_5 = manager.audio:GetVoiceLength("story_v_out_320042", "320042004", "story_v_out_320042.awb") / 1000

					if var_20_5 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + 0
					end

					if var_20_1.prefab_name ~= "" and arg_17_1.actors_[var_20_1.prefab_name] ~= nil then
						local var_20_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_1.prefab_name].transform, "story_v_out_320042", "320042004", "story_v_out_320042.awb")

						arg_17_1:RecordAudio("320042004", var_20_6)
						arg_17_1:RecordAudio("320042004", var_20_6)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_320042", "320042004", "story_v_out_320042.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_320042", "320042004", "story_v_out_320042.awb")
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
	Play320042005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 320042005
		arg_21_1.duration_ = 6.87

		local var_21_0 = {
			zh = 2.9,
			ja = 6.866
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
				arg_21_0:Play320042006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.325

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_1 = arg_21_1:GetWordFromCfg(320042005)
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

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042005", "story_v_out_320042.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_320042", "320042005", "story_v_out_320042.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_320042", "320042005", "story_v_out_320042.awb")

						arg_21_1:RecordAudio("320042005", var_24_6)
						arg_21_1:RecordAudio("320042005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_320042", "320042005", "story_v_out_320042.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_320042", "320042005", "story_v_out_320042.awb")
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
	Play320042006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 320042006
		arg_25_1.duration_ = 6.7

		local var_25_0 = {
			zh = 5.833,
			ja = 6.7
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
				arg_25_0:Play320042007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.675

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(320042006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 27 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 27)

				if (27 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 27)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042006", "story_v_out_320042.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_320042", "320042006", "story_v_out_320042.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_320042", "320042006", "story_v_out_320042.awb")

						arg_25_1:RecordAudio("320042006", var_28_6)
						arg_25_1:RecordAudio("320042006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_320042", "320042006", "story_v_out_320042.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_320042", "320042006", "story_v_out_320042.awb")
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
	Play320042007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 320042007
		arg_29_1.duration_ = 3.27

		local var_29_0 = {
			zh = 3.266,
			ja = 2.5
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
				arg_29_0:Play320042008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.275

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

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(320042007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 11 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 11)

				if (11 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 11)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042007", "story_v_out_320042.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_320042", "320042007", "story_v_out_320042.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_320042", "320042007", "story_v_out_320042.awb")

						arg_29_1:RecordAudio("320042007", var_32_6)
						arg_29_1:RecordAudio("320042007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_320042", "320042007", "story_v_out_320042.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_320042", "320042007", "story_v_out_320042.awb")
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
	Play320042008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 320042008
		arg_33_1.duration_ = 7.3

		local var_33_0 = {
			zh = 6.133,
			ja = 7.3
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
				arg_33_0:Play320042009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.625

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:GetWordFromCfg(320042008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 25 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 25)

				if (25 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 25)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042008", "story_v_out_320042.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_320042", "320042008", "story_v_out_320042.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_320042", "320042008", "story_v_out_320042.awb")

						arg_33_1:RecordAudio("320042008", var_36_6)
						arg_33_1:RecordAudio("320042008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_320042", "320042008", "story_v_out_320042.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_320042", "320042008", "story_v_out_320042.awb")
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
	Play320042009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 320042009
		arg_37_1.duration_ = 6.2

		local var_37_0 = {
			zh = 4.733,
			ja = 6.2
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
				arg_37_0:Play320042010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.525

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(320042009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 21 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 21)

				if (21 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 21)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042009", "story_v_out_320042.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_320042", "320042009", "story_v_out_320042.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_320042", "320042009", "story_v_out_320042.awb")

						arg_37_1:RecordAudio("320042009", var_40_6)
						arg_37_1:RecordAudio("320042009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_320042", "320042009", "story_v_out_320042.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_320042", "320042009", "story_v_out_320042.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play320042010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 320042010
		arg_41_1.duration_ = 9

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play320042011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if arg_41_1.bgs_.L02f == nil then
				local var_44_0 = Object.Instantiate(arg_41_1.paintGo_)

				var_44_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L02f")
				var_44_0.name = "L02f"
				var_44_0.transform.parent = arg_41_1.stage_.transform
				var_44_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.bgs_.L02f = var_44_0
			end

			if 2 < arg_41_1.time_ and arg_41_1.time_ <= 2 + arg_44_0 then
				local var_44_1 = arg_41_1.bgs_.L02f

				arg_41_1.bgs_.L02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_44_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_44_2 = var_44_1:GetComponent("SpriteRenderer")

				if var_44_2 and var_44_2.sprite then
					local var_44_3 = 2 * (var_44_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_44_1.transform.localScale = Vector3.New(var_44_3 / var_44_2.sprite.bounds.size.y < var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x and var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x or var_44_3 / var_44_2.sprite.bounds.size.y, var_44_3 / var_44_2.sprite.bounds.size.y < var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x and var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x or var_44_3 / var_44_2.sprite.bounds.size.y, 0)
				end

				for iter_44_0, iter_44_1 in pairs(arg_41_1.bgs_) do
					if iter_44_0 ~= "L02f" then
						iter_44_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_44_4 = 4

			if 4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			if arg_41_1.time_ >= var_44_4 + 0.3 and arg_41_1.time_ < var_44_4 + 0.3 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			local var_44_5 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_6 = 2

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 then
				local var_44_7 = Color.New(0, 0, 0)

				var_44_7.a = Mathf.Lerp(0, 1, (arg_41_1.time_ - var_44_5) / var_44_6)
				arg_41_1.mask_.color = var_44_7
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 then
				local var_44_8 = Color.New(0, 0, 0)

				var_44_8.a = 1
				arg_41_1.mask_.color = var_44_8
			end

			local var_44_9 = 2

			if 2 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_10 = 2

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 then
				local var_44_11 = Color.New(0, 0, 0)

				var_44_11.a = Mathf.Lerp(1, 0, (arg_41_1.time_ - var_44_9) / var_44_10)
				arg_41_1.mask_.color = var_44_11
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 then
				local var_44_12 = Color.New(0, 0, 0)

				arg_41_1.mask_.enabled = false
				var_44_12.a = 0
				arg_41_1.mask_.color = var_44_12
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_44_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_41_1.bgmTxt_.text ~= var_44_15 and arg_41_1.bgmTxt_.text ~= "" then
						if arg_41_1.bgmTxt2_.text ~= "" then
							arg_41_1.bgmTxt_.text = arg_41_1.bgmTxt2_.text
						end

						arg_41_1.bgmTxt2_.text = var_44_15

						arg_41_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_41_1.bgmTxt_.text = var_44_15
						arg_41_1.bgmTxt2_.text = var_44_15
					end

					if arg_41_1.bgmTimer then
						arg_41_1.bgmTimer:Stop()

						arg_41_1.bgmTimer = nil
					end

					if arg_41_1.settingData.show_music_name == 1 then
						arg_41_1.musicController:SetSelectedState("show")
						arg_41_1.musicAnimator_:Play("open", 0, 0)

						if arg_41_1.settingData.music_time ~= 0 then
							arg_41_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_41_1.settingData.music_time), function()
								if arg_41_1 == nil or isNil(arg_41_1.bgmTxt_) then
									return
								end

								arg_41_1.musicController:SetSelectedState("hide")
								arg_41_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1 < arg_41_1.time_ and arg_41_1.time_ <= 1 + arg_44_0 then
				arg_41_1:AudioAction("play", "music", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")

				local var_44_18 = manager.audio:GetAudioName("bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum")

				if "" ~= "" then
					if arg_41_1.bgmTxt_.text ~= var_44_18 and arg_41_1.bgmTxt_.text ~= "" then
						if arg_41_1.bgmTxt2_.text ~= "" then
							arg_41_1.bgmTxt_.text = arg_41_1.bgmTxt2_.text
						end

						arg_41_1.bgmTxt2_.text = var_44_18

						arg_41_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_41_1.bgmTxt_.text = var_44_18
						arg_41_1.bgmTxt2_.text = var_44_18
					end

					if arg_41_1.bgmTimer then
						arg_41_1.bgmTimer:Stop()

						arg_41_1.bgmTimer = nil
					end

					if arg_41_1.settingData.show_music_name == 1 then
						arg_41_1.musicController:SetSelectedState("show")
						arg_41_1.musicAnimator_:Play("open", 0, 0)

						if arg_41_1.settingData.music_time ~= 0 then
							arg_41_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_41_1.settingData.music_time), function()
								if arg_41_1 == nil or isNil(arg_41_1.bgmTxt_) then
									return
								end

								arg_41_1.musicController:SetSelectedState("hide")
								arg_41_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_19 = 4
			local var_44_20 = 1.025

			if 4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_19 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_21 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_21:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_41_1.dialogCg_.alpha = arg_47_0
				end))
				var_44_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_22 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(320042010).content)

				arg_41_1.text_.text = var_44_22

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_24 = 41 <= 0 and var_44_20 or var_44_20 * (utf8.len(var_44_22) / 41)

				if (41 <= 0 and var_44_20 or var_44_20 * (utf8.len(var_44_22) / 41)) > 0 and var_44_20 < var_44_24 then
					arg_41_1.talkMaxDuration = var_44_24
					var_44_19 = var_44_19 + 0.3

					if var_44_24 + var_44_19 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_24 + var_44_19
					end
				end

				arg_41_1.text_.text = var_44_22
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_25 = var_44_19 + 0.3
			local var_44_26 = math.max(var_44_20, arg_41_1.talkMaxDuration)

			if var_44_19 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_25 + var_44_26 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_25) / var_44_26

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_25 + var_44_26 and arg_41_1.time_ < var_44_25 + var_44_26 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play320042011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 320042011
		arg_49_1.duration_ = 12.03

		local var_49_0 = {
			zh = 8.866,
			ja = 12.033
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
				arg_49_0:Play320042012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if arg_49_1.actors_["10100ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10100ui_story"))) then
				local var_52_0 = Object.Instantiate(Asset.Load("Char/" .. "10100ui_story"), arg_49_1.stage_.transform)

				var_52_0.name = "10100ui_story"
				var_52_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.actors_["10100ui_story"] = var_52_0

				local var_52_1 = var_52_0:GetComponentInChildren(typeof(CharacterEffect))

				var_52_1.enabled = true

				local var_52_2 = GameObjectTools.GetOrAddComponent(var_52_0, typeof(DynamicBoneHelper))

				if var_52_2 then
					var_52_2:EnableDynamicBone(false)
				end

				arg_49_1:ShowWeapon(var_52_1.transform, false)

				arg_49_1.var_["10100ui_story" .. "Animator"] = var_52_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_49_1.var_["10100ui_story" .. "Animator"].applyRootMotion = true
				arg_49_1.var_["10100ui_story" .. "LipSync"] = var_52_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_52_3 = arg_49_1.actors_["10100ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10100ui_story = var_52_3.localPosition
			end

			local var_52_4 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				var_52_3.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10100ui_story, Vector3.New(0, -1.16, -6.25), (arg_49_1.time_ - 0) / var_52_4)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				var_52_3.localPosition = Vector3.New(0, -1.16, -6.25)
				var_52_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_3.position).x, (manager.ui.mainCamera.transform.position - var_52_3.position).y, (manager.ui.mainCamera.transform.position - var_52_3.position).z)
				var_52_3.localEulerAngles.z = 0
				var_52_3.localEulerAngles.x = 0
				var_52_3.localEulerAngles = var_52_3.localEulerAngles
			end

			local var_52_5 = arg_49_1.actors_["10100ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect10100ui_story == nil then
				arg_49_1.var_.characterEffect10100ui_story = var_52_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_6 and not isNil(var_52_5) then
				if arg_49_1.var_.characterEffect10100ui_story and not isNil(var_52_5) then
					arg_49_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_6 and arg_49_1.time_ < 0 + var_52_6 + arg_52_0 and not isNil(var_52_5) and arg_49_1.var_.characterEffect10100ui_story then
				arg_49_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action25_1")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_52_8 = 0
			local var_52_9 = 0.8

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:GetWordFromCfg(320042011)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 32 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 32)

				if (32 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 32)) > 0 and var_52_9 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042011", "story_v_out_320042.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_320042", "320042011", "story_v_out_320042.awb") / 1000

					if var_52_14 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_8
					end

					if var_52_10.prefab_name ~= "" and arg_49_1.actors_[var_52_10.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_10.prefab_name].transform, "story_v_out_320042", "320042011", "story_v_out_320042.awb")

						arg_49_1:RecordAudio("320042011", var_52_15)
						arg_49_1:RecordAudio("320042011", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_320042", "320042011", "story_v_out_320042.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_320042", "320042011", "story_v_out_320042.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_16 and arg_49_1.time_ < var_52_8 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play320042012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 320042012
		arg_53_1.duration_ = 10.67

		local var_53_0 = {
			zh = 7.866,
			ja = 10.666
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
				arg_53_0:Play320042013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10100ui_story = arg_53_1.actors_["10100ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["10100ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10100ui_story, Vector3.New(-0.7, -1.16, -6.25), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10100ui_story"].transform.position).z)
				arg_53_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10100ui_story"].transform.localEulerAngles = arg_53_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["10100ui_story"].transform.localPosition = Vector3.New(-0.7, -1.16, -6.25)
				arg_53_1.actors_["10100ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["10100ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10100ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["10100ui_story"].transform.position).z)
				arg_53_1.actors_["10100ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["10100ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["10100ui_story"].transform.localEulerAngles = arg_53_1.actors_["10100ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["10100ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect10100ui_story == nil then
				arg_53_1.var_.characterEffect10100ui_story = var_56_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 and not isNil(var_56_1) then
				if arg_53_1.var_.characterEffect10100ui_story and not isNil(var_56_1) then
					arg_53_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_2)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 and not isNil(var_56_1) and arg_53_1.var_.characterEffect10100ui_story then
				arg_53_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_56_3 = "1020ui_story"

			if arg_53_1.actors_["1020ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1020ui_story"))) then
				local var_56_4 = Object.Instantiate(Asset.Load("Char/" .. "1020ui_story"), arg_53_1.stage_.transform)

				var_56_4.name = var_56_3
				var_56_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_[var_56_3] = var_56_4

				local var_56_5 = var_56_4:GetComponentInChildren(typeof(CharacterEffect))

				var_56_5.enabled = true

				local var_56_6 = GameObjectTools.GetOrAddComponent(var_56_4, typeof(DynamicBoneHelper))

				if var_56_6 then
					var_56_6:EnableDynamicBone(false)
				end

				arg_53_1:ShowWeapon(var_56_5.transform, false)

				arg_53_1.var_[var_56_3 .. "Animator"] = var_56_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_53_1.var_[var_56_3 .. "Animator"].applyRootMotion = true
				arg_53_1.var_[var_56_3 .. "LipSync"] = var_56_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_56_7 = arg_53_1.actors_["1020ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1020ui_story = var_56_7.localPosition
			end

			local var_56_8 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_8 then
				var_56_7.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1020ui_story, Vector3.New(0.7, -0.85, -6.25), (arg_53_1.time_ - 0) / var_56_8)
				var_56_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_7.position).x, (manager.ui.mainCamera.transform.position - var_56_7.position).y, (manager.ui.mainCamera.transform.position - var_56_7.position).z)
				var_56_7.localEulerAngles.z = 0
				var_56_7.localEulerAngles.x = 0
				var_56_7.localEulerAngles = var_56_7.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_8 and arg_53_1.time_ < 0 + var_56_8 + arg_56_0 then
				var_56_7.localPosition = Vector3.New(0.7, -0.85, -6.25)
				var_56_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_7.position).x, (manager.ui.mainCamera.transform.position - var_56_7.position).y, (manager.ui.mainCamera.transform.position - var_56_7.position).z)
				var_56_7.localEulerAngles.z = 0
				var_56_7.localEulerAngles.x = 0
				var_56_7.localEulerAngles = var_56_7.localEulerAngles
			end

			local var_56_9 = arg_53_1.actors_["1020ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1020ui_story == nil then
				arg_53_1.var_.characterEffect1020ui_story = var_56_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_10 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_10 and not isNil(var_56_9) then
				if arg_53_1.var_.characterEffect1020ui_story and not isNil(var_56_9) then
					arg_53_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_10 and arg_53_1.time_ < 0 + var_56_10 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1020ui_story then
				arg_53_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action8_1")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_12 = 0
			local var_56_13 = 0.95

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_14 = arg_53_1:GetWordFromCfg(320042012)
				local var_56_15 = arg_53_1:FormatText(var_56_14.content)

				arg_53_1.text_.text = var_56_15

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_17 = 38 <= 0 and var_56_13 or var_56_13 * (utf8.len(var_56_15) / 38)

				if (38 <= 0 and var_56_13 or var_56_13 * (utf8.len(var_56_15) / 38)) > 0 and var_56_13 < var_56_17 then
					arg_53_1.talkMaxDuration = var_56_17

					if var_56_17 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_17 + var_56_12
					end
				end

				arg_53_1.text_.text = var_56_15
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042012", "story_v_out_320042.awb") ~= 0 then
					local var_56_18 = manager.audio:GetVoiceLength("story_v_out_320042", "320042012", "story_v_out_320042.awb") / 1000

					if var_56_18 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_12
					end

					if var_56_14.prefab_name ~= "" and arg_53_1.actors_[var_56_14.prefab_name] ~= nil then
						local var_56_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_14.prefab_name].transform, "story_v_out_320042", "320042012", "story_v_out_320042.awb")

						arg_53_1:RecordAudio("320042012", var_56_19)
						arg_53_1:RecordAudio("320042012", var_56_19)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_320042", "320042012", "story_v_out_320042.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_320042", "320042012", "story_v_out_320042.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_20 = math.max(var_56_13, arg_53_1.talkMaxDuration)

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_20 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_12) / var_56_20

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_12 + var_56_20 and arg_53_1.time_ < var_56_12 + var_56_20 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play320042013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 320042013
		arg_57_1.duration_ = 14.03

		local var_57_0 = {
			zh = 10.133,
			ja = 14.033
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
				arg_57_0:Play320042014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10100ui_story"]) and arg_57_1.var_.characterEffect10100ui_story == nil then
				arg_57_1.var_.characterEffect10100ui_story = arg_57_1.actors_["10100ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10100ui_story"]) then
				if arg_57_1.var_.characterEffect10100ui_story and not isNil(arg_57_1.actors_["10100ui_story"]) then
					arg_57_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10100ui_story"]) and arg_57_1.var_.characterEffect10100ui_story then
				arg_57_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action25_2")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_2 = arg_57_1.actors_["1020ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1020ui_story == nil then
				arg_57_1.var_.characterEffect1020ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect1020ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_3)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1020ui_story then
				arg_57_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_60_4 = 0
			local var_60_5 = 0.975

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1021].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(320042013)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 39 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 39)

				if (39 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 39)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042013", "story_v_out_320042.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_320042", "320042013", "story_v_out_320042.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_320042", "320042013", "story_v_out_320042.awb")

						arg_57_1:RecordAudio("320042013", var_60_11)
						arg_57_1:RecordAudio("320042013", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_320042", "320042013", "story_v_out_320042.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_320042", "320042013", "story_v_out_320042.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play320042014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 320042014
		arg_61_1.duration_ = 8.3

		local var_61_0 = {
			zh = 7.833,
			ja = 8.3
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
				arg_61_0:Play320042015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1020ui_story = arg_61_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1020ui_story, Vector3.New(0.7, -0.85, -6.25), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1020ui_story"].transform.position).z)
				arg_61_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1020ui_story"].transform.localEulerAngles = arg_61_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0.7, -0.85, -6.25)
				arg_61_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1020ui_story"].transform.position).z)
				arg_61_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1020ui_story"].transform.localEulerAngles = arg_61_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["1020ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1020ui_story == nil then
				arg_61_1.var_.characterEffect1020ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect1020ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect1020ui_story then
				arg_61_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action484")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_64_4 = arg_61_1.actors_["10100ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect10100ui_story == nil then
				arg_61_1.var_.characterEffect10100ui_story = var_64_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_5 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_5 and not isNil(var_64_4) then
				if arg_61_1.var_.characterEffect10100ui_story and not isNil(var_64_4) then
					arg_61_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10100ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_5)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_5 and arg_61_1.time_ < 0 + var_64_5 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect10100ui_story then
				arg_61_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10100ui_story.fillRatio = 0.5
			end

			local var_64_6 = 0
			local var_64_7 = 0.95

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(320042014)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 38 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 38)

				if (38 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 38)) > 0 and var_64_7 < var_64_11 then
					arg_61_1.talkMaxDuration = var_64_11

					if var_64_11 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042014", "story_v_out_320042.awb") ~= 0 then
					local var_64_12 = manager.audio:GetVoiceLength("story_v_out_320042", "320042014", "story_v_out_320042.awb") / 1000

					if var_64_12 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_6
					end

					if var_64_8.prefab_name ~= "" and arg_61_1.actors_[var_64_8.prefab_name] ~= nil then
						local var_64_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_8.prefab_name].transform, "story_v_out_320042", "320042014", "story_v_out_320042.awb")

						arg_61_1:RecordAudio("320042014", var_64_13)
						arg_61_1:RecordAudio("320042014", var_64_13)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_320042", "320042014", "story_v_out_320042.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_320042", "320042014", "story_v_out_320042.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_14 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_14 and arg_61_1.time_ < var_64_6 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play320042015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 320042015
		arg_65_1.duration_ = 9.43

		local var_65_0 = {
			zh = 7.466,
			ja = 9.433
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
				arg_65_0:Play320042016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action443")
			end

			local var_68_0 = 0
			local var_68_1 = 0.875

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_2 = arg_65_1:GetWordFromCfg(320042015)
				local var_68_3 = arg_65_1:FormatText(var_68_2.content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 35 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 35)

				if (35 <= 0 and var_68_1 or var_68_1 * (utf8.len(var_68_3) / 35)) > 0 and var_68_1 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_0
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042015", "story_v_out_320042.awb") ~= 0 then
					local var_68_6 = manager.audio:GetVoiceLength("story_v_out_320042", "320042015", "story_v_out_320042.awb") / 1000

					if var_68_6 + var_68_0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_0
					end

					if var_68_2.prefab_name ~= "" and arg_65_1.actors_[var_68_2.prefab_name] ~= nil then
						local var_68_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_2.prefab_name].transform, "story_v_out_320042", "320042015", "story_v_out_320042.awb")

						arg_65_1:RecordAudio("320042015", var_68_7)
						arg_65_1:RecordAudio("320042015", var_68_7)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_320042", "320042015", "story_v_out_320042.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_320042", "320042015", "story_v_out_320042.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_8 = math.max(var_68_1, arg_65_1.talkMaxDuration)

			if var_68_0 <= arg_65_1.time_ and arg_65_1.time_ < var_68_0 + var_68_8 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_0) / var_68_8

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_0 + var_68_8 and arg_65_1.time_ < var_68_0 + var_68_8 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play320042016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 320042016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play320042017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1020ui_story"]) and arg_69_1.var_.characterEffect1020ui_story == nil then
				arg_69_1.var_.characterEffect1020ui_story = arg_69_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1020ui_story"]) then
				if arg_69_1.var_.characterEffect1020ui_story and not isNil(arg_69_1.actors_["1020ui_story"]) then
					arg_69_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1020ui_story"]) and arg_69_1.var_.characterEffect1020ui_story then
				arg_69_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.125

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(320042016).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 5 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 5)

				if (5 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 5)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play320042017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 320042017
		arg_73_1.duration_ = 6.97

		local var_73_0 = {
			zh = 5.033,
			ja = 6.966
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
				arg_73_0:Play320042018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1020ui_story"]) and arg_73_1.var_.characterEffect1020ui_story == nil then
				arg_73_1.var_.characterEffect1020ui_story = arg_73_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1020ui_story"]) then
				if arg_73_1.var_.characterEffect1020ui_story and not isNil(arg_73_1.actors_["1020ui_story"]) then
					arg_73_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1020ui_story"]) and arg_73_1.var_.characterEffect1020ui_story then
				arg_73_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			local var_76_2 = 0
			local var_76_3 = 0.55

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(320042017)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 22 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 22)

				if (22 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 22)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042017", "story_v_out_320042.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_320042", "320042017", "story_v_out_320042.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_320042", "320042017", "story_v_out_320042.awb")

						arg_73_1:RecordAudio("320042017", var_76_9)
						arg_73_1:RecordAudio("320042017", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_320042", "320042017", "story_v_out_320042.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_320042", "320042017", "story_v_out_320042.awb")
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
	Play320042018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 320042018
		arg_77_1.duration_ = 0.5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"

			SetActive(arg_77_1.choicesGo_, true)

			for iter_78_0, iter_78_1 in ipairs(arg_77_1.choices_) do
				SetActive(iter_78_1.go, iter_78_0 <= 1)
			end

			arg_77_1.choices_[1].txt.text = arg_77_1:FormatText(StoryChoiceCfg[1107].name)
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play320042019(arg_77_1)
			end

			arg_77_1:RecordChoiceLog(320042018, 1107)
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1020ui_story"]) and arg_77_1.var_.characterEffect1020ui_story == nil then
				arg_77_1.var_.characterEffect1020ui_story = arg_77_1.actors_["1020ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1020ui_story"]) then
				if arg_77_1.var_.characterEffect1020ui_story and not isNil(arg_77_1.actors_["1020ui_story"]) then
					arg_77_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_0)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1020ui_story"]) and arg_77_1.var_.characterEffect1020ui_story then
				arg_77_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_80_1 = 0

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			if arg_77_1.time_ >= var_80_1 + 0.5 and arg_77_1.time_ < var_80_1 + 0.5 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play320042019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 320042019
		arg_81_1.duration_ = 7.9

		local var_81_0 = {
			zh = 7.133,
			ja = 7.9
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
				arg_81_0:Play320042020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if arg_81_1.actors_["1089ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1089ui_story"))) then
				local var_84_0 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_81_1.stage_.transform)

				var_84_0.name = "1089ui_story"
				var_84_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["1089ui_story"] = var_84_0

				local var_84_1 = var_84_0:GetComponentInChildren(typeof(CharacterEffect))

				var_84_1.enabled = true

				local var_84_2 = GameObjectTools.GetOrAddComponent(var_84_0, typeof(DynamicBoneHelper))

				if var_84_2 then
					var_84_2:EnableDynamicBone(false)
				end

				arg_81_1:ShowWeapon(var_84_1.transform, false)

				arg_81_1.var_["1089ui_story" .. "Animator"] = var_84_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_81_1.var_["1089ui_story" .. "Animator"].applyRootMotion = true
				arg_81_1.var_["1089ui_story" .. "LipSync"] = var_84_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_84_3 = arg_81_1.actors_["1089ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1089ui_story = var_84_3.localPosition
			end

			local var_84_4 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				var_84_3.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1089ui_story, Vector3.New(-0.7, -1.1, -6.17), (arg_81_1.time_ - 0) / var_84_4)
				var_84_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_3.position).x, (manager.ui.mainCamera.transform.position - var_84_3.position).y, (manager.ui.mainCamera.transform.position - var_84_3.position).z)
				var_84_3.localEulerAngles.z = 0
				var_84_3.localEulerAngles.x = 0
				var_84_3.localEulerAngles = var_84_3.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_3.localPosition = Vector3.New(-0.7, -1.1, -6.17)
				var_84_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_3.position).x, (manager.ui.mainCamera.transform.position - var_84_3.position).y, (manager.ui.mainCamera.transform.position - var_84_3.position).z)
				var_84_3.localEulerAngles.z = 0
				var_84_3.localEulerAngles.x = 0
				var_84_3.localEulerAngles = var_84_3.localEulerAngles
			end

			local var_84_5 = arg_81_1.actors_["1089ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1089ui_story == nil then
				arg_81_1.var_.characterEffect1089ui_story = var_84_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_6 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_6 and not isNil(var_84_5) then
				if arg_81_1.var_.characterEffect1089ui_story and not isNil(var_84_5) then
					arg_81_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_6 and arg_81_1.time_ < 0 + var_84_6 + arg_84_0 and not isNil(var_84_5) and arg_81_1.var_.characterEffect1089ui_story then
				arg_81_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_8 = arg_81_1.actors_["10100ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10100ui_story = var_84_8.localPosition
			end

			local var_84_9 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_9 then
				var_84_8.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10100ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_9)
				var_84_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_8.position).x, (manager.ui.mainCamera.transform.position - var_84_8.position).y, (manager.ui.mainCamera.transform.position - var_84_8.position).z)
				var_84_8.localEulerAngles.z = 0
				var_84_8.localEulerAngles.x = 0
				var_84_8.localEulerAngles = var_84_8.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_9 and arg_81_1.time_ < 0 + var_84_9 + arg_84_0 then
				var_84_8.localPosition = Vector3.New(0, 100, 0)
				var_84_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_8.position).x, (manager.ui.mainCamera.transform.position - var_84_8.position).y, (manager.ui.mainCamera.transform.position - var_84_8.position).z)
				var_84_8.localEulerAngles.z = 0
				var_84_8.localEulerAngles.x = 0
				var_84_8.localEulerAngles = var_84_8.localEulerAngles
			end

			local var_84_10 = 0
			local var_84_11 = 0.725

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_12 = arg_81_1:GetWordFromCfg(320042019)
				local var_84_13 = arg_81_1:FormatText(var_84_12.content)

				arg_81_1.text_.text = var_84_13

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_15 = 29 <= 0 and var_84_11 or var_84_11 * (utf8.len(var_84_13) / 29)

				if (29 <= 0 and var_84_11 or var_84_11 * (utf8.len(var_84_13) / 29)) > 0 and var_84_11 < var_84_15 then
					arg_81_1.talkMaxDuration = var_84_15

					if var_84_15 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_15 + var_84_10
					end
				end

				arg_81_1.text_.text = var_84_13
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042019", "story_v_out_320042.awb") ~= 0 then
					local var_84_16 = manager.audio:GetVoiceLength("story_v_out_320042", "320042019", "story_v_out_320042.awb") / 1000

					if var_84_16 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_16 + var_84_10
					end

					if var_84_12.prefab_name ~= "" and arg_81_1.actors_[var_84_12.prefab_name] ~= nil then
						local var_84_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_12.prefab_name].transform, "story_v_out_320042", "320042019", "story_v_out_320042.awb")

						arg_81_1:RecordAudio("320042019", var_84_17)
						arg_81_1:RecordAudio("320042019", var_84_17)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_320042", "320042019", "story_v_out_320042.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_320042", "320042019", "story_v_out_320042.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_18 = math.max(var_84_11, arg_81_1.talkMaxDuration)

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_18 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_10) / var_84_18

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_10 + var_84_18 and arg_81_1.time_ < var_84_10 + var_84_18 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play320042020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 320042020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play320042021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1089ui_story = arg_85_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1089ui_story"].transform.position).z)
				arg_85_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1089ui_story"].transform.localEulerAngles = arg_85_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1089ui_story"].transform.position).z)
				arg_85_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1089ui_story"].transform.localEulerAngles = arg_85_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1089ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1089ui_story == nil then
				arg_85_1.var_.characterEffect1089ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1089ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_2)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1089ui_story then
				arg_85_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_88_3 = arg_85_1.actors_["1020ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1020ui_story = var_88_3.localPosition
			end

			local var_88_4 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				var_88_3.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_4)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				var_88_3.localPosition = Vector3.New(0, 100, 0)
				var_88_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_3.position).x, (manager.ui.mainCamera.transform.position - var_88_3.position).y, (manager.ui.mainCamera.transform.position - var_88_3.position).z)
				var_88_3.localEulerAngles.z = 0
				var_88_3.localEulerAngles.x = 0
				var_88_3.localEulerAngles = var_88_3.localEulerAngles
			end

			local var_88_5 = arg_85_1.actors_["1020ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect1020ui_story == nil then
				arg_85_1.var_.characterEffect1020ui_story = var_88_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_6 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_6 and not isNil(var_88_5) then
				if arg_85_1.var_.characterEffect1020ui_story and not isNil(var_88_5) then
					arg_85_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_6)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_6 and arg_85_1.time_ < 0 + var_88_6 + arg_88_0 and not isNil(var_88_5) and arg_85_1.var_.characterEffect1020ui_story then
				arg_85_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_88_7 = 0
			local var_88_8 = 1.275

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_7 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_9 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(320042020).content)

				arg_85_1.text_.text = var_88_9

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 51 <= 0 and var_88_8 or var_88_8 * (utf8.len(var_88_9) / 51)

				if (51 <= 0 and var_88_8 or var_88_8 * (utf8.len(var_88_9) / 51)) > 0 and var_88_8 < var_88_11 then
					arg_85_1.talkMaxDuration = var_88_11

					if var_88_11 + var_88_7 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_7
					end
				end

				arg_85_1.text_.text = var_88_9
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_8, arg_85_1.talkMaxDuration)

			if var_88_7 <= arg_85_1.time_ and arg_85_1.time_ < var_88_7 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_7) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_7 + var_88_12 and arg_85_1.time_ < var_88_7 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play320042021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 320042021
		arg_89_1.duration_ = 3.13

		local var_89_0 = {
			zh = 3.133,
			ja = 3.033
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
				arg_89_0:Play320042022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.3

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:GetWordFromCfg(320042021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 12 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 12)

				if (12 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 12)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042021", "story_v_out_320042.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_320042", "320042021", "story_v_out_320042.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_320042", "320042021", "story_v_out_320042.awb")

						arg_89_1:RecordAudio("320042021", var_92_6)
						arg_89_1:RecordAudio("320042021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_320042", "320042021", "story_v_out_320042.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_320042", "320042021", "story_v_out_320042.awb")
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
	Play320042022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 320042022
		arg_93_1.duration_ = 9.97

		local var_93_0 = {
			zh = 9.966,
			ja = 8.5
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
				arg_93_0:Play320042023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1020ui_story = arg_93_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1020ui_story"].transform.position).z)
				arg_93_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1020ui_story"].transform.localEulerAngles = arg_93_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_93_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1020ui_story"].transform.position).z)
				arg_93_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1020ui_story"].transform.localEulerAngles = arg_93_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1020ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1020ui_story == nil then
				arg_93_1.var_.characterEffect1020ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1020ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1020ui_story then
				arg_93_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_96_4 = 0
			local var_96_5 = 1.15

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(320042022)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 46 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 46)

				if (46 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 46)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042022", "story_v_out_320042.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_320042", "320042022", "story_v_out_320042.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_320042", "320042022", "story_v_out_320042.awb")

						arg_93_1:RecordAudio("320042022", var_96_11)
						arg_93_1:RecordAudio("320042022", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_320042", "320042022", "story_v_out_320042.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_320042", "320042022", "story_v_out_320042.awb")
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
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play320042023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 320042023
		arg_97_1.duration_ = 7.13

		local var_97_0 = {
			zh = 4.833,
			ja = 7.133
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
				arg_97_0:Play320042024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020actionlink/1020action467")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_100_0 = 0
			local var_100_1 = 0.45

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_2 = arg_97_1:GetWordFromCfg(320042023)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 18 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 18)

				if (18 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 18)) > 0 and var_100_1 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042023", "story_v_out_320042.awb") ~= 0 then
					local var_100_6 = manager.audio:GetVoiceLength("story_v_out_320042", "320042023", "story_v_out_320042.awb") / 1000

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end

					if var_100_2.prefab_name ~= "" and arg_97_1.actors_[var_100_2.prefab_name] ~= nil then
						local var_100_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_2.prefab_name].transform, "story_v_out_320042", "320042023", "story_v_out_320042.awb")

						arg_97_1:RecordAudio("320042023", var_100_7)
						arg_97_1:RecordAudio("320042023", var_100_7)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_320042", "320042023", "story_v_out_320042.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_320042", "320042023", "story_v_out_320042.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play320042024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 320042024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play320042025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1020ui_story = arg_101_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1020ui_story"].transform.position).z)
				arg_101_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1020ui_story"].transform.localEulerAngles = arg_101_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1020ui_story"].transform.position).z)
				arg_101_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1020ui_story"].transform.localEulerAngles = arg_101_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["1020ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1020ui_story == nil then
				arg_101_1.var_.characterEffect1020ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect1020ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_2)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect1020ui_story then
				arg_101_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_104_3 = 0
			local var_104_4 = 1.025

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_3 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_5 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(320042024).content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 41 <= 0 and var_104_4 or var_104_4 * (utf8.len(var_104_5) / 41)

				if (41 <= 0 and var_104_4 or var_104_4 * (utf8.len(var_104_5) / 41)) > 0 and var_104_4 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_3 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_3
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_4, arg_101_1.talkMaxDuration)

			if var_104_3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_3 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_3) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_3 + var_104_8 and arg_101_1.time_ < var_104_3 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play320042025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 320042025
		arg_105_1.duration_ = 8.4

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play320042026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_0 = 2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				local var_108_1 = Color.New(0.6556604, 0.9454331, 1)

				var_108_1.a = Mathf.Lerp(0, 1, (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.mask_.color = var_108_1
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				local var_108_2 = Color.New(0.6556604, 0.9454331, 1)

				var_108_2.a = 1
				arg_105_1.mask_.color = var_108_2
			end

			local var_108_3 = 2

			if 2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_3 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_4 = 2

			if var_108_3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_3 + var_108_4 then
				local var_108_5 = Color.New(0.654902, 0.945098, 1)

				var_108_5.a = Mathf.Lerp(1, 0, (arg_105_1.time_ - var_108_3) / var_108_4)
				arg_105_1.mask_.color = var_108_5
			end

			if arg_105_1.time_ >= var_108_3 + var_108_4 and arg_105_1.time_ < var_108_3 + var_108_4 + arg_108_0 then
				local var_108_6 = Color.New(0.654902, 0.945098, 1)

				arg_105_1.mask_.enabled = false
				var_108_6.a = 0
				arg_105_1.mask_.color = var_108_6
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_7 = 3.4
			local var_108_8 = 1.55

			if 3.4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_7 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_9 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_9:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(320042025).content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_12 = 62 <= 0 and var_108_8 or var_108_8 * (utf8.len(var_108_10) / 62)

				if (62 <= 0 and var_108_8 or var_108_8 * (utf8.len(var_108_10) / 62)) > 0 and var_108_8 < var_108_12 then
					arg_105_1.talkMaxDuration = var_108_12
					var_108_7 = var_108_7 + 0.3

					if var_108_12 + var_108_7 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_7
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_13 = var_108_7 + 0.3
			local var_108_14 = math.max(var_108_8, arg_105_1.talkMaxDuration)

			if var_108_7 + 0.3 <= arg_105_1.time_ and arg_105_1.time_ < var_108_13 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_13) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_13 + var_108_14 and arg_105_1.time_ < var_108_13 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play320042026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 320042026
		arg_111_1.duration_ = 4.1

		local var_111_0 = {
			zh = 3.1,
			ja = 4.1
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
				arg_111_0:Play320042027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.35

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1032].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangstera")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_1 = arg_111_1:GetWordFromCfg(320042026)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 14 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 14)

				if (14 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 14)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042026", "story_v_out_320042.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_320042", "320042026", "story_v_out_320042.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_320042", "320042026", "story_v_out_320042.awb")

						arg_111_1:RecordAudio("320042026", var_114_6)
						arg_111_1:RecordAudio("320042026", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_320042", "320042026", "story_v_out_320042.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_320042", "320042026", "story_v_out_320042.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play320042027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 320042027
		arg_115_1.duration_ = 12.6

		local var_115_0 = {
			zh = 6.733,
			ja = 12.6
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
				arg_115_0:Play320042028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1020ui_story = arg_115_1.actors_["1020ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["1020ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1020ui_story, Vector3.New(0, -0.85, -6.25), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1020ui_story"].transform.position).z)
				arg_115_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1020ui_story"].transform.localEulerAngles = arg_115_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["1020ui_story"].transform.localPosition = Vector3.New(0, -0.85, -6.25)
				arg_115_1.actors_["1020ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1020ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1020ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1020ui_story"].transform.position).z)
				arg_115_1.actors_["1020ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1020ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1020ui_story"].transform.localEulerAngles = arg_115_1.actors_["1020ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["1020ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1020ui_story == nil then
				arg_115_1.var_.characterEffect1020ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect1020ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect1020ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1020ui_story then
				arg_115_1.var_.characterEffect1020ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/story1020/story1020action/1020action6_1")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1020ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_118_4 = 0
			local var_118_5 = 0.775

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[613].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_6 = arg_115_1:GetWordFromCfg(320042027)
				local var_118_7 = arg_115_1:FormatText(var_118_6.content)

				arg_115_1.text_.text = var_118_7

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 31 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 31)

				if (31 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_7) / 31)) > 0 and var_118_5 < var_118_9 then
					arg_115_1.talkMaxDuration = var_118_9

					if var_118_9 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_9 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_7
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042027", "story_v_out_320042.awb") ~= 0 then
					local var_118_10 = manager.audio:GetVoiceLength("story_v_out_320042", "320042027", "story_v_out_320042.awb") / 1000

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end

					if var_118_6.prefab_name ~= "" and arg_115_1.actors_[var_118_6.prefab_name] ~= nil then
						local var_118_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_6.prefab_name].transform, "story_v_out_320042", "320042027", "story_v_out_320042.awb")

						arg_115_1:RecordAudio("320042027", var_118_11)
						arg_115_1:RecordAudio("320042027", var_118_11)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_320042", "320042027", "story_v_out_320042.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_320042", "320042027", "story_v_out_320042.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_12 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_12 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_4) / var_118_12

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_4 + var_118_12 and arg_115_1.time_ < var_118_4 + var_118_12 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play320042028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 320042028
		arg_119_1.duration_ = 12.87

		local var_119_0 = {
			zh = 12.866,
			ja = 12.5
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
				arg_119_0:Play320042029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if arg_119_1.bgs_.L01f == nil then
				local var_122_0 = Object.Instantiate(arg_119_1.paintGo_)

				var_122_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L01f")
				var_122_0.name = "L01f"
				var_122_0.transform.parent = arg_119_1.stage_.transform
				var_122_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.bgs_.L01f = var_122_0
			end

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= 2 + arg_122_0 then
				local var_122_1 = arg_119_1.bgs_.L01f

				arg_119_1.bgs_.L01f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_122_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_122_2 = var_122_1:GetComponent("SpriteRenderer")

				if var_122_2 and var_122_2.sprite then
					local var_122_3 = 2 * (var_122_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_122_1.transform.localScale = Vector3.New(var_122_3 / var_122_2.sprite.bounds.size.y < var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x and var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x or var_122_3 / var_122_2.sprite.bounds.size.y, var_122_3 / var_122_2.sprite.bounds.size.y < var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x and var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x or var_122_3 / var_122_2.sprite.bounds.size.y, 0)
				end

				for iter_122_0, iter_122_1 in pairs(arg_119_1.bgs_) do
					if iter_122_0 ~= "L01f" then
						iter_122_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_122_4 = 4

			if 4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.allBtn_.enabled = false
			end

			if arg_119_1.time_ >= var_122_4 + 0.3 and arg_119_1.time_ < var_122_4 + 0.3 + arg_122_0 then
				arg_119_1.allBtn_.enabled = true
			end

			local var_122_5 = 0

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_6 = 2

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_6 then
				local var_122_7 = Color.New(0, 0, 0)

				var_122_7.a = Mathf.Lerp(0, 1, (arg_119_1.time_ - var_122_5) / var_122_6)
				arg_119_1.mask_.color = var_122_7
			end

			if arg_119_1.time_ >= var_122_5 + var_122_6 and arg_119_1.time_ < var_122_5 + var_122_6 + arg_122_0 then
				local var_122_8 = Color.New(0, 0, 0)

				var_122_8.a = 1
				arg_119_1.mask_.color = var_122_8
			end

			local var_122_9 = 2

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= var_122_9 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_10 = 2

			if var_122_9 <= arg_119_1.time_ and arg_119_1.time_ < var_122_9 + var_122_10 then
				local var_122_11 = Color.New(0, 0, 0)

				var_122_11.a = Mathf.Lerp(1, 0, (arg_119_1.time_ - var_122_9) / var_122_10)
				arg_119_1.mask_.color = var_122_11
			end

			if arg_119_1.time_ >= var_122_9 + var_122_10 and arg_119_1.time_ < var_122_9 + var_122_10 + arg_122_0 then
				local var_122_12 = Color.New(0, 0, 0)

				arg_119_1.mask_.enabled = false
				var_122_12.a = 0
				arg_119_1.mask_.color = var_122_12
			end

			local var_122_13 = arg_119_1.actors_["1020ui_story"].transform

			if 1.96599999815226 < arg_119_1.time_ and arg_119_1.time_ <= 1.96599999815226 + arg_122_0 then
				arg_119_1.var_.moveOldPos1020ui_story = var_122_13.localPosition
			end

			local var_122_14 = 0.001

			if 1.96599999815226 <= arg_119_1.time_ and arg_119_1.time_ < 1.96599999815226 + var_122_14 then
				var_122_13.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1020ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 1.96599999815226) / var_122_14)
				var_122_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_13.position).x, (manager.ui.mainCamera.transform.position - var_122_13.position).y, (manager.ui.mainCamera.transform.position - var_122_13.position).z)
				var_122_13.localEulerAngles.z = 0
				var_122_13.localEulerAngles.x = 0
				var_122_13.localEulerAngles = var_122_13.localEulerAngles
			end

			if arg_119_1.time_ >= 1.96599999815226 + var_122_14 and arg_119_1.time_ < 1.96599999815226 + var_122_14 + arg_122_0 then
				var_122_13.localPosition = Vector3.New(0, 100, 0)
				var_122_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_13.position).x, (manager.ui.mainCamera.transform.position - var_122_13.position).y, (manager.ui.mainCamera.transform.position - var_122_13.position).z)
				var_122_13.localEulerAngles.z = 0
				var_122_13.localEulerAngles.x = 0
				var_122_13.localEulerAngles = var_122_13.localEulerAngles
			end

			local var_122_15 = arg_119_1.actors_["1020ui_story"]

			if 1.96599999815226 < arg_119_1.time_ and arg_119_1.time_ <= 1.96599999815226 + arg_122_0 and not isNil(var_122_15) and arg_119_1.var_.characterEffect1020ui_story == nil then
				arg_119_1.var_.characterEffect1020ui_story = var_122_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_16 = 0.034000001847744

			if 1.96599999815226 <= arg_119_1.time_ and arg_119_1.time_ < 1.96599999815226 + var_122_16 and not isNil(var_122_15) then
				if arg_119_1.var_.characterEffect1020ui_story and not isNil(var_122_15) then
					arg_119_1.var_.characterEffect1020ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1020ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 1.96599999815226) / var_122_16)
				end
			end

			if arg_119_1.time_ >= 1.96599999815226 + var_122_16 and arg_119_1.time_ < 1.96599999815226 + var_122_16 + arg_122_0 and not isNil(var_122_15) and arg_119_1.var_.characterEffect1020ui_story then
				arg_119_1.var_.characterEffect1020ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1020ui_story.fillRatio = 0.5
			end

			local var_122_17 = arg_119_1.actors_["1089ui_story"].transform

			if 3.8 < arg_119_1.time_ and arg_119_1.time_ <= 3.8 + arg_122_0 then
				arg_119_1.var_.moveOldPos1089ui_story = var_122_17.localPosition
			end

			local var_122_18 = 0.001

			if 3.8 <= arg_119_1.time_ and arg_119_1.time_ < 3.8 + var_122_18 then
				var_122_17.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1089ui_story, Vector3.New(0, -1.1, -6.17), (arg_119_1.time_ - 3.8) / var_122_18)
				var_122_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_17.position).x, (manager.ui.mainCamera.transform.position - var_122_17.position).y, (manager.ui.mainCamera.transform.position - var_122_17.position).z)
				var_122_17.localEulerAngles.z = 0
				var_122_17.localEulerAngles.x = 0
				var_122_17.localEulerAngles = var_122_17.localEulerAngles
			end

			if arg_119_1.time_ >= 3.8 + var_122_18 and arg_119_1.time_ < 3.8 + var_122_18 + arg_122_0 then
				var_122_17.localPosition = Vector3.New(0, -1.1, -6.17)
				var_122_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_17.position).x, (manager.ui.mainCamera.transform.position - var_122_17.position).y, (manager.ui.mainCamera.transform.position - var_122_17.position).z)
				var_122_17.localEulerAngles.z = 0
				var_122_17.localEulerAngles.x = 0
				var_122_17.localEulerAngles = var_122_17.localEulerAngles
			end

			local var_122_19 = arg_119_1.actors_["1089ui_story"]

			if 3.8 < arg_119_1.time_ and arg_119_1.time_ <= 3.8 + arg_122_0 and not isNil(var_122_19) and arg_119_1.var_.characterEffect1089ui_story == nil then
				arg_119_1.var_.characterEffect1089ui_story = var_122_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_20 = 0.200000002980232

			if 3.8 <= arg_119_1.time_ and arg_119_1.time_ < 3.8 + var_122_20 and not isNil(var_122_19) then
				if arg_119_1.var_.characterEffect1089ui_story and not isNil(var_122_19) then
					arg_119_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 3.8 + var_122_20 and arg_119_1.time_ < 3.8 + var_122_20 + arg_122_0 and not isNil(var_122_19) and arg_119_1.var_.characterEffect1089ui_story then
				arg_119_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 3.8 < arg_119_1.time_ and arg_119_1.time_ <= 3.8 + arg_122_0 then
				arg_119_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 3.8 < arg_119_1.time_ and arg_119_1.time_ <= 3.8 + arg_122_0 then
				arg_119_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_22 = 4
			local var_122_23 = 1.05

			if 4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_22 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_24 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_24:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_25 = arg_119_1:GetWordFromCfg(320042028)
				local var_122_26 = arg_119_1:FormatText(var_122_25.content)

				arg_119_1.text_.text = var_122_26

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_28 = 42 <= 0 and var_122_23 or var_122_23 * (utf8.len(var_122_26) / 42)

				if (42 <= 0 and var_122_23 or var_122_23 * (utf8.len(var_122_26) / 42)) > 0 and var_122_23 < var_122_28 then
					arg_119_1.talkMaxDuration = var_122_28
					var_122_22 = var_122_22 + 0.3

					if var_122_28 + var_122_22 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_28 + var_122_22
					end
				end

				arg_119_1.text_.text = var_122_26
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042028", "story_v_out_320042.awb") ~= 0 then
					local var_122_29 = manager.audio:GetVoiceLength("story_v_out_320042", "320042028", "story_v_out_320042.awb") / 1000

					if var_122_29 + var_122_22 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_29 + var_122_22
					end

					if var_122_25.prefab_name ~= "" and arg_119_1.actors_[var_122_25.prefab_name] ~= nil then
						local var_122_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_25.prefab_name].transform, "story_v_out_320042", "320042028", "story_v_out_320042.awb")

						arg_119_1:RecordAudio("320042028", var_122_30)
						arg_119_1:RecordAudio("320042028", var_122_30)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_320042", "320042028", "story_v_out_320042.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_320042", "320042028", "story_v_out_320042.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_31 = var_122_22 + 0.3
			local var_122_32 = math.max(var_122_23, arg_119_1.talkMaxDuration)

			if var_122_22 + 0.3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_31 + var_122_32 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_31) / var_122_32

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_31 + var_122_32 and arg_119_1.time_ < var_122_31 + var_122_32 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1020ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play320042029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 320042029
		arg_125_1.duration_ = 7.9

		local var_125_0 = {
			zh = 5.5,
			ja = 7.9
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
				arg_125_0:Play320042030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_0 = 0
			local var_128_1 = 0.5

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(320042029)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 20 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 20)

				if (20 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 20)) > 0 and var_128_1 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042029", "story_v_out_320042.awb") ~= 0 then
					local var_128_6 = manager.audio:GetVoiceLength("story_v_out_320042", "320042029", "story_v_out_320042.awb") / 1000

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end

					if var_128_2.prefab_name ~= "" and arg_125_1.actors_[var_128_2.prefab_name] ~= nil then
						local var_128_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_2.prefab_name].transform, "story_v_out_320042", "320042029", "story_v_out_320042.awb")

						arg_125_1:RecordAudio("320042029", var_128_7)
						arg_125_1:RecordAudio("320042029", var_128_7)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_320042", "320042029", "story_v_out_320042.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_320042", "320042029", "story_v_out_320042.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_8 and arg_125_1.time_ < var_128_0 + var_128_8 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play320042030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 320042030
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play320042031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1089ui_story = arg_129_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1089ui_story"].transform.position).z)
				arg_129_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1089ui_story"].transform.localEulerAngles = arg_129_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1089ui_story"].transform.position).z)
				arg_129_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1089ui_story"].transform.localEulerAngles = arg_129_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1089ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1089ui_story == nil then
				arg_129_1.var_.characterEffect1089ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1089ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_2)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1089ui_story then
				arg_129_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_132_3 = 0
			local var_132_4 = 0.95

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_3 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_5 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(320042030).content)

				arg_129_1.text_.text = var_132_5

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_7 = 38 <= 0 and var_132_4 or var_132_4 * (utf8.len(var_132_5) / 38)

				if (38 <= 0 and var_132_4 or var_132_4 * (utf8.len(var_132_5) / 38)) > 0 and var_132_4 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_3 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_3
					end
				end

				arg_129_1.text_.text = var_132_5
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_4, arg_129_1.talkMaxDuration)

			if var_132_3 <= arg_129_1.time_ and arg_129_1.time_ < var_132_3 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_3) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_3 + var_132_8 and arg_129_1.time_ < var_132_3 + var_132_8 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play320042031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 320042031
		arg_133_1.duration_ = 5.97

		local var_133_0 = {
			zh = 5.833,
			ja = 5.966
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
				arg_133_0:Play320042032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if arg_133_1.actors_["10102ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10102ui_story"))) then
				local var_136_0 = Object.Instantiate(Asset.Load("Char/" .. "10102ui_story"), arg_133_1.stage_.transform)

				var_136_0.name = "10102ui_story"
				var_136_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_["10102ui_story"] = var_136_0

				local var_136_1 = var_136_0:GetComponentInChildren(typeof(CharacterEffect))

				var_136_1.enabled = true

				local var_136_2 = GameObjectTools.GetOrAddComponent(var_136_0, typeof(DynamicBoneHelper))

				if var_136_2 then
					var_136_2:EnableDynamicBone(false)
				end

				arg_133_1:ShowWeapon(var_136_1.transform, false)

				arg_133_1.var_["10102ui_story" .. "Animator"] = var_136_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_133_1.var_["10102ui_story" .. "Animator"].applyRootMotion = true
				arg_133_1.var_["10102ui_story" .. "LipSync"] = var_136_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_136_3 = arg_133_1.actors_["10102ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10102ui_story = var_136_3.localPosition
			end

			local var_136_4 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 then
				var_136_3.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10102ui_story, Vector3.New(0, -0.985, -6.275), (arg_133_1.time_ - 0) / var_136_4)
				var_136_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_3.position).x, (manager.ui.mainCamera.transform.position - var_136_3.position).y, (manager.ui.mainCamera.transform.position - var_136_3.position).z)
				var_136_3.localEulerAngles.z = 0
				var_136_3.localEulerAngles.x = 0
				var_136_3.localEulerAngles = var_136_3.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 then
				var_136_3.localPosition = Vector3.New(0, -0.985, -6.275)
				var_136_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_3.position).x, (manager.ui.mainCamera.transform.position - var_136_3.position).y, (manager.ui.mainCamera.transform.position - var_136_3.position).z)
				var_136_3.localEulerAngles.z = 0
				var_136_3.localEulerAngles.x = 0
				var_136_3.localEulerAngles = var_136_3.localEulerAngles
			end

			local var_136_5 = arg_133_1.actors_["10102ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.characterEffect10102ui_story == nil then
				arg_133_1.var_.characterEffect10102ui_story = var_136_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_6 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_6 and not isNil(var_136_5) then
				if arg_133_1.var_.characterEffect10102ui_story and not isNil(var_136_5) then
					arg_133_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_6 and arg_133_1.time_ < 0 + var_136_6 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.characterEffect10102ui_story then
				arg_133_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action5_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_136_8 = 0
			local var_136_9 = 0.775

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
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

				local var_136_10 = arg_133_1:GetWordFromCfg(320042031)
				local var_136_11 = arg_133_1:FormatText(var_136_10.content)

				arg_133_1.text_.text = var_136_11

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 31 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 31)

				if (31 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 31)) > 0 and var_136_9 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_11
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042031", "story_v_out_320042.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_320042", "320042031", "story_v_out_320042.awb") / 1000

					if var_136_14 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_8
					end

					if var_136_10.prefab_name ~= "" and arg_133_1.actors_[var_136_10.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_10.prefab_name].transform, "story_v_out_320042", "320042031", "story_v_out_320042.awb")

						arg_133_1:RecordAudio("320042031", var_136_15)
						arg_133_1:RecordAudio("320042031", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_320042", "320042031", "story_v_out_320042.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_320042", "320042031", "story_v_out_320042.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_16 and arg_133_1.time_ < var_136_8 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play320042032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 320042032
		arg_137_1.duration_ = 3.97

		local var_137_0 = {
			zh = 3.966,
			ja = 3.266
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
				arg_137_0:Play320042033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0.4

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(320042032)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 16 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 16)

				if (16 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 16)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042032", "story_v_out_320042.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_320042", "320042032", "story_v_out_320042.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_320042", "320042032", "story_v_out_320042.awb")

						arg_137_1:RecordAudio("320042032", var_140_6)
						arg_137_1:RecordAudio("320042032", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_320042", "320042032", "story_v_out_320042.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_320042", "320042032", "story_v_out_320042.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play320042033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 320042033
		arg_141_1.duration_ = 15.73

		local var_141_0 = {
			zh = 8.966,
			ja = 15.733
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
				arg_141_0:Play320042034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10102ui_story = arg_141_1.actors_["10102ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["10102ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10102ui_story, Vector3.New(-0.7, -0.985, -6.275), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10102ui_story"].transform.position).z)
				arg_141_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10102ui_story"].transform.localEulerAngles = arg_141_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["10102ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.275)
				arg_141_1.actors_["10102ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["10102ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10102ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["10102ui_story"].transform.position).z)
				arg_141_1.actors_["10102ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["10102ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["10102ui_story"].transform.localEulerAngles = arg_141_1.actors_["10102ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["10102ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10102ui_story == nil then
				arg_141_1.var_.characterEffect10102ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect10102ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_141_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_2)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect10102ui_story then
				arg_141_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_141_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_144_3 = arg_141_1.actors_["1089ui_story"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1089ui_story = var_144_3.localPosition
			end

			local var_144_4 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				var_144_3.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1089ui_story, Vector3.New(0.7, -1.1, -6.17), (arg_141_1.time_ - 0) / var_144_4)
				var_144_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_3.position).x, (manager.ui.mainCamera.transform.position - var_144_3.position).y, (manager.ui.mainCamera.transform.position - var_144_3.position).z)
				var_144_3.localEulerAngles.z = 0
				var_144_3.localEulerAngles.x = 0
				var_144_3.localEulerAngles = var_144_3.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				var_144_3.localPosition = Vector3.New(0.7, -1.1, -6.17)
				var_144_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_3.position).x, (manager.ui.mainCamera.transform.position - var_144_3.position).y, (manager.ui.mainCamera.transform.position - var_144_3.position).z)
				var_144_3.localEulerAngles.z = 0
				var_144_3.localEulerAngles.x = 0
				var_144_3.localEulerAngles = var_144_3.localEulerAngles
			end

			local var_144_5 = arg_141_1.actors_["1089ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.characterEffect1089ui_story == nil then
				arg_141_1.var_.characterEffect1089ui_story = var_144_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_6 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_6 and not isNil(var_144_5) then
				if arg_141_1.var_.characterEffect1089ui_story and not isNil(var_144_5) then
					arg_141_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_6 and arg_141_1.time_ < 0 + var_144_6 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.characterEffect1089ui_story then
				arg_141_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_144_8 = 0
			local var_144_9 = 1.15

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_10 = arg_141_1:GetWordFromCfg(320042033)
				local var_144_11 = arg_141_1:FormatText(var_144_10.content)

				arg_141_1.text_.text = var_144_11

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_13 = 46 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 46)

				if (46 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 46)) > 0 and var_144_9 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_11
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042033", "story_v_out_320042.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_out_320042", "320042033", "story_v_out_320042.awb") / 1000

					if var_144_14 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_8
					end

					if var_144_10.prefab_name ~= "" and arg_141_1.actors_[var_144_10.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_10.prefab_name].transform, "story_v_out_320042", "320042033", "story_v_out_320042.awb")

						arg_141_1:RecordAudio("320042033", var_144_15)
						arg_141_1:RecordAudio("320042033", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_320042", "320042033", "story_v_out_320042.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_320042", "320042033", "story_v_out_320042.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_8) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_8 + var_144_16 and arg_141_1.time_ < var_144_8 + var_144_16 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play320042034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 320042034
		arg_145_1.duration_ = 3.53

		local var_145_0 = {
			zh = 3.533,
			ja = 2.066
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
				arg_145_0:Play320042035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_148_0 = 0
			local var_148_1 = 0.35

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:GetWordFromCfg(320042034)
				local var_148_3 = arg_145_1:FormatText(var_148_2.content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 14 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_3) / 14)

				if (14 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_3) / 14)) > 0 and var_148_1 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042034", "story_v_out_320042.awb") ~= 0 then
					local var_148_6 = manager.audio:GetVoiceLength("story_v_out_320042", "320042034", "story_v_out_320042.awb") / 1000

					if var_148_6 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_6 + var_148_0
					end

					if var_148_2.prefab_name ~= "" and arg_145_1.actors_[var_148_2.prefab_name] ~= nil then
						local var_148_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_2.prefab_name].transform, "story_v_out_320042", "320042034", "story_v_out_320042.awb")

						arg_145_1:RecordAudio("320042034", var_148_7)
						arg_145_1:RecordAudio("320042034", var_148_7)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_320042", "320042034", "story_v_out_320042.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_320042", "320042034", "story_v_out_320042.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_8 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_8 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_8

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_8 and arg_145_1.time_ < var_148_0 + var_148_8 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play320042035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 320042035
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play320042036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1089ui_story = arg_149_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1089ui_story"].transform.position).z)
				arg_149_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1089ui_story"].transform.localEulerAngles = arg_149_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_149_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1089ui_story"].transform.position).z)
				arg_149_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1089ui_story"].transform.localEulerAngles = arg_149_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1089ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1089ui_story == nil then
				arg_149_1.var_.characterEffect1089ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1089ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_2)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1089ui_story then
				arg_149_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_152_3 = arg_149_1.actors_["10102ui_story"].transform

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10102ui_story = var_152_3.localPosition
			end

			local var_152_4 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				var_152_3.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_149_1.time_ - 0) / var_152_4)
				var_152_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_3.position).x, (manager.ui.mainCamera.transform.position - var_152_3.position).y, (manager.ui.mainCamera.transform.position - var_152_3.position).z)
				var_152_3.localEulerAngles.z = 0
				var_152_3.localEulerAngles.x = 0
				var_152_3.localEulerAngles = var_152_3.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				var_152_3.localPosition = Vector3.New(0, 100, 0)
				var_152_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_152_3.position).x, (manager.ui.mainCamera.transform.position - var_152_3.position).y, (manager.ui.mainCamera.transform.position - var_152_3.position).z)
				var_152_3.localEulerAngles.z = 0
				var_152_3.localEulerAngles.x = 0
				var_152_3.localEulerAngles = var_152_3.localEulerAngles
			end

			local var_152_5 = arg_149_1.actors_["10102ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.characterEffect10102ui_story == nil then
				arg_149_1.var_.characterEffect10102ui_story = var_152_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_6 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_6 and not isNil(var_152_5) then
				if arg_149_1.var_.characterEffect10102ui_story and not isNil(var_152_5) then
					arg_149_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_6)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_6 and arg_149_1.time_ < 0 + var_152_6 + arg_152_0 and not isNil(var_152_5) and arg_149_1.var_.characterEffect10102ui_story then
				arg_149_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_152_7 = 0
			local var_152_8 = 1.45

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_7 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_9 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(320042035).content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 58 <= 0 and var_152_8 or var_152_8 * (utf8.len(var_152_9) / 58)

				if (58 <= 0 and var_152_8 or var_152_8 * (utf8.len(var_152_9) / 58)) > 0 and var_152_8 < var_152_11 then
					arg_149_1.talkMaxDuration = var_152_11

					if var_152_11 + var_152_7 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_7
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_8, arg_149_1.talkMaxDuration)

			if var_152_7 <= arg_149_1.time_ and arg_149_1.time_ < var_152_7 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_7) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_7 + var_152_12 and arg_149_1.time_ < var_152_7 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play320042036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 320042036
		arg_153_1.duration_ = 8.8

		local var_153_0 = {
			zh = 3.466,
			ja = 8.8
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
				arg_153_0:Play320042037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if arg_153_1.actors_["1056ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1056ui_story"))) then
				local var_156_0 = Object.Instantiate(Asset.Load("Char/" .. "1056ui_story"), arg_153_1.stage_.transform)

				var_156_0.name = "1056ui_story"
				var_156_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.actors_["1056ui_story"] = var_156_0

				local var_156_1 = var_156_0:GetComponentInChildren(typeof(CharacterEffect))

				var_156_1.enabled = true

				local var_156_2 = GameObjectTools.GetOrAddComponent(var_156_0, typeof(DynamicBoneHelper))

				if var_156_2 then
					var_156_2:EnableDynamicBone(false)
				end

				arg_153_1:ShowWeapon(var_156_1.transform, false)

				arg_153_1.var_["1056ui_story" .. "Animator"] = var_156_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_153_1.var_["1056ui_story" .. "Animator"].applyRootMotion = true
				arg_153_1.var_["1056ui_story" .. "LipSync"] = var_156_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_156_3 = arg_153_1.actors_["1056ui_story"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1056ui_story = var_156_3.localPosition
			end

			local var_156_4 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 then
				var_156_3.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_153_1.time_ - 0) / var_156_4)
				var_156_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_3.position).x, (manager.ui.mainCamera.transform.position - var_156_3.position).y, (manager.ui.mainCamera.transform.position - var_156_3.position).z)
				var_156_3.localEulerAngles.z = 0
				var_156_3.localEulerAngles.x = 0
				var_156_3.localEulerAngles = var_156_3.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 then
				var_156_3.localPosition = Vector3.New(0, -1, -5.75)
				var_156_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_156_3.position).x, (manager.ui.mainCamera.transform.position - var_156_3.position).y, (manager.ui.mainCamera.transform.position - var_156_3.position).z)
				var_156_3.localEulerAngles.z = 0
				var_156_3.localEulerAngles.x = 0
				var_156_3.localEulerAngles = var_156_3.localEulerAngles
			end

			local var_156_5 = arg_153_1.actors_["1056ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect1056ui_story == nil then
				arg_153_1.var_.characterEffect1056ui_story = var_156_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_6 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_6 and not isNil(var_156_5) then
				if arg_153_1.var_.characterEffect1056ui_story and not isNil(var_156_5) then
					arg_153_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_6 and arg_153_1.time_ < 0 + var_156_6 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.characterEffect1056ui_story then
				arg_153_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_156_8 = 0
			local var_156_9 = 0.425

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_10 = arg_153_1:GetWordFromCfg(320042036)
				local var_156_11 = arg_153_1:FormatText(var_156_10.content)

				arg_153_1.text_.text = var_156_11

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_13 = 17 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 17)

				if (17 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 17)) > 0 and var_156_9 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_8
					end
				end

				arg_153_1.text_.text = var_156_11
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042036", "story_v_out_320042.awb") ~= 0 then
					local var_156_14 = manager.audio:GetVoiceLength("story_v_out_320042", "320042036", "story_v_out_320042.awb") / 1000

					if var_156_14 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_14 + var_156_8
					end

					if var_156_10.prefab_name ~= "" and arg_153_1.actors_[var_156_10.prefab_name] ~= nil then
						local var_156_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_10.prefab_name].transform, "story_v_out_320042", "320042036", "story_v_out_320042.awb")

						arg_153_1:RecordAudio("320042036", var_156_15)
						arg_153_1:RecordAudio("320042036", var_156_15)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_320042", "320042036", "story_v_out_320042.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_320042", "320042036", "story_v_out_320042.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_16 = math.max(var_156_9, arg_153_1.talkMaxDuration)

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_16 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_8) / var_156_16

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_8 + var_156_16 and arg_153_1.time_ < var_156_8 + var_156_16 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play320042037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 320042037
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play320042038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1056ui_story"]) and arg_157_1.var_.characterEffect1056ui_story == nil then
				arg_157_1.var_.characterEffect1056ui_story = arg_157_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1056ui_story"]) then
				if arg_157_1.var_.characterEffect1056ui_story and not isNil(arg_157_1.actors_["1056ui_story"]) then
					arg_157_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1056ui_story"]) and arg_157_1.var_.characterEffect1056ui_story then
				arg_157_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_160_1 = 0
			local var_160_2 = 1.25

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(320042037).content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 50 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 50)

				if (50 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 50)) > 0 and var_160_2 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_6 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_6 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_6

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_6 and arg_157_1.time_ < var_160_1 + var_160_6 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play320042038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 320042038
		arg_161_1.duration_ = 5.57

		local var_161_0 = {
			zh = 3.833,
			ja = 5.566
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
				arg_161_0:Play320042039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1056ui_story = arg_161_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1056ui_story, Vector3.New(-0.7, -1, -5.75), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1056ui_story"].transform.position).z)
				arg_161_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1056ui_story"].transform.localEulerAngles = arg_161_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -5.75)
				arg_161_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1056ui_story"].transform.position).z)
				arg_161_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1056ui_story"].transform.localEulerAngles = arg_161_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1056ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1056ui_story == nil then
				arg_161_1.var_.characterEffect1056ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1056ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_2)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1056ui_story then
				arg_161_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_164_3 = "1011ui_story"

			if arg_161_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_164_4 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_161_1.stage_.transform)

				var_164_4.name = var_164_3
				var_164_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_[var_164_3] = var_164_4

				local var_164_5 = var_164_4:GetComponentInChildren(typeof(CharacterEffect))

				var_164_5.enabled = true

				local var_164_6 = GameObjectTools.GetOrAddComponent(var_164_4, typeof(DynamicBoneHelper))

				if var_164_6 then
					var_164_6:EnableDynamicBone(false)
				end

				arg_161_1:ShowWeapon(var_164_5.transform, false)

				arg_161_1.var_[var_164_3 .. "Animator"] = var_164_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_161_1.var_[var_164_3 .. "Animator"].applyRootMotion = true
				arg_161_1.var_[var_164_3 .. "LipSync"] = var_164_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_164_7 = arg_161_1.actors_["1011ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1011ui_story = var_164_7.localPosition
			end

			local var_164_8 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_8 then
				var_164_7.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_161_1.time_ - 0) / var_164_8)
				var_164_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_7.position).x, (manager.ui.mainCamera.transform.position - var_164_7.position).y, (manager.ui.mainCamera.transform.position - var_164_7.position).z)
				var_164_7.localEulerAngles.z = 0
				var_164_7.localEulerAngles.x = 0
				var_164_7.localEulerAngles = var_164_7.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_8 and arg_161_1.time_ < 0 + var_164_8 + arg_164_0 then
				var_164_7.localPosition = Vector3.New(0.7, -0.71, -6)
				var_164_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_7.position).x, (manager.ui.mainCamera.transform.position - var_164_7.position).y, (manager.ui.mainCamera.transform.position - var_164_7.position).z)
				var_164_7.localEulerAngles.z = 0
				var_164_7.localEulerAngles.x = 0
				var_164_7.localEulerAngles = var_164_7.localEulerAngles
			end

			local var_164_9 = arg_161_1.actors_["1011ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect1011ui_story == nil then
				arg_161_1.var_.characterEffect1011ui_story = var_164_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_10 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_10 and not isNil(var_164_9) then
				if arg_161_1.var_.characterEffect1011ui_story and not isNil(var_164_9) then
					arg_161_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_10 and arg_161_1.time_ < 0 + var_164_10 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect1011ui_story then
				arg_161_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_12 = 0
			local var_164_13 = 0.325

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_12 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_14 = arg_161_1:GetWordFromCfg(320042038)
				local var_164_15 = arg_161_1:FormatText(var_164_14.content)

				arg_161_1.text_.text = var_164_15

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_17 = 13 <= 0 and var_164_13 or var_164_13 * (utf8.len(var_164_15) / 13)

				if (13 <= 0 and var_164_13 or var_164_13 * (utf8.len(var_164_15) / 13)) > 0 and var_164_13 < var_164_17 then
					arg_161_1.talkMaxDuration = var_164_17

					if var_164_17 + var_164_12 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_17 + var_164_12
					end
				end

				arg_161_1.text_.text = var_164_15
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042038", "story_v_out_320042.awb") ~= 0 then
					local var_164_18 = manager.audio:GetVoiceLength("story_v_out_320042", "320042038", "story_v_out_320042.awb") / 1000

					if var_164_18 + var_164_12 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_18 + var_164_12
					end

					if var_164_14.prefab_name ~= "" and arg_161_1.actors_[var_164_14.prefab_name] ~= nil then
						local var_164_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_14.prefab_name].transform, "story_v_out_320042", "320042038", "story_v_out_320042.awb")

						arg_161_1:RecordAudio("320042038", var_164_19)
						arg_161_1:RecordAudio("320042038", var_164_19)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_320042", "320042038", "story_v_out_320042.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_320042", "320042038", "story_v_out_320042.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_20 = math.max(var_164_13, arg_161_1.talkMaxDuration)

			if var_164_12 <= arg_161_1.time_ and arg_161_1.time_ < var_164_12 + var_164_20 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_12) / var_164_20

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_12 + var_164_20 and arg_161_1.time_ < var_164_12 + var_164_20 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play320042039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 320042039
		arg_165_1.duration_ = 3.27

		local var_165_0 = {
			zh = 2.2,
			ja = 3.266
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
				arg_165_0:Play320042040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["1056ui_story"]) and arg_165_1.var_.characterEffect1056ui_story == nil then
				arg_165_1.var_.characterEffect1056ui_story = arg_165_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_0 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["1056ui_story"]) then
				if arg_165_1.var_.characterEffect1056ui_story and not isNil(arg_165_1.actors_["1056ui_story"]) then
					arg_165_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["1056ui_story"]) and arg_165_1.var_.characterEffect1056ui_story then
				arg_165_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_168_2 = arg_165_1.actors_["1011ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.characterEffect1011ui_story == nil then
				arg_165_1.var_.characterEffect1011ui_story = var_168_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_3 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_3 and not isNil(var_168_2) then
				if arg_165_1.var_.characterEffect1011ui_story and not isNil(var_168_2) then
					arg_165_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_3)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_3 and arg_165_1.time_ < 0 + var_168_3 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.characterEffect1011ui_story then
				arg_165_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_168_4 = 0
			local var_168_5 = 0.1

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(320042039)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 4 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 4)

				if (4 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 4)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042039", "story_v_out_320042.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_320042", "320042039", "story_v_out_320042.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_320042", "320042039", "story_v_out_320042.awb")

						arg_165_1:RecordAudio("320042039", var_168_11)
						arg_165_1:RecordAudio("320042039", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_320042", "320042039", "story_v_out_320042.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_320042", "320042039", "story_v_out_320042.awb")
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
	Play320042040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 320042040
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play320042041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1056ui_story = arg_169_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1056ui_story"].transform.position).z)
				arg_169_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1056ui_story"].transform.localEulerAngles = arg_169_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1056ui_story"].transform.position).z)
				arg_169_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1056ui_story"].transform.localEulerAngles = arg_169_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["1056ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1056ui_story == nil then
				arg_169_1.var_.characterEffect1056ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect1056ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_2)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect1056ui_story then
				arg_169_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_172_3 = arg_169_1.actors_["1011ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1011ui_story = var_172_3.localPosition
			end

			local var_172_4 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				var_172_3.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_4)
				var_172_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_3.position).x, (manager.ui.mainCamera.transform.position - var_172_3.position).y, (manager.ui.mainCamera.transform.position - var_172_3.position).z)
				var_172_3.localEulerAngles.z = 0
				var_172_3.localEulerAngles.x = 0
				var_172_3.localEulerAngles = var_172_3.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				var_172_3.localPosition = Vector3.New(0, 100, 0)
				var_172_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_3.position).x, (manager.ui.mainCamera.transform.position - var_172_3.position).y, (manager.ui.mainCamera.transform.position - var_172_3.position).z)
				var_172_3.localEulerAngles.z = 0
				var_172_3.localEulerAngles.x = 0
				var_172_3.localEulerAngles = var_172_3.localEulerAngles
			end

			local var_172_5 = arg_169_1.actors_["1011ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.characterEffect1011ui_story == nil then
				arg_169_1.var_.characterEffect1011ui_story = var_172_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_6 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_6 and not isNil(var_172_5) then
				if arg_169_1.var_.characterEffect1011ui_story and not isNil(var_172_5) then
					arg_169_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_6)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_6 and arg_169_1.time_ < 0 + var_172_6 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.characterEffect1011ui_story then
				arg_169_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_172_7 = 0
			local var_172_8 = 1.225

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_7 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_9 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(320042040).content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 49 <= 0 and var_172_8 or var_172_8 * (utf8.len(var_172_9) / 49)

				if (49 <= 0 and var_172_8 or var_172_8 * (utf8.len(var_172_9) / 49)) > 0 and var_172_8 < var_172_11 then
					arg_169_1.talkMaxDuration = var_172_11

					if var_172_11 + var_172_7 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_7
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_8, arg_169_1.talkMaxDuration)

			if var_172_7 <= arg_169_1.time_ and arg_169_1.time_ < var_172_7 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_7) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_7 + var_172_12 and arg_169_1.time_ < var_172_7 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play320042041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 320042041
		arg_173_1.duration_ = 5.93

		local var_173_0 = {
			zh = 5.933,
			ja = 4
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
				arg_173_0:Play320042042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1056ui_story = arg_173_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1056ui_story"].transform.position).z)
				arg_173_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1056ui_story"].transform.localEulerAngles = arg_173_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, -1, -5.75)
				arg_173_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1056ui_story"].transform.position).z)
				arg_173_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1056ui_story"].transform.localEulerAngles = arg_173_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1056ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1056ui_story == nil then
				arg_173_1.var_.characterEffect1056ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1056ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1056ui_story then
				arg_173_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action2_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_176_4 = 0
			local var_176_5 = 0.625

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(320042041)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 25 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 25)

				if (25 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 25)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042041", "story_v_out_320042.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_320042", "320042041", "story_v_out_320042.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_320042", "320042041", "story_v_out_320042.awb")

						arg_173_1:RecordAudio("320042041", var_176_11)
						arg_173_1:RecordAudio("320042041", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_320042", "320042041", "story_v_out_320042.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_320042", "320042041", "story_v_out_320042.awb")
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

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play320042042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 320042042
		arg_177_1.duration_ = 11.1

		local var_177_0 = {
			zh = 5.633,
			ja = 11.1
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
				arg_177_0:Play320042043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1056ui_story"]) and arg_177_1.var_.characterEffect1056ui_story == nil then
				arg_177_1.var_.characterEffect1056ui_story = arg_177_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1056ui_story"]) then
				if arg_177_1.var_.characterEffect1056ui_story and not isNil(arg_177_1.actors_["1056ui_story"]) then
					arg_177_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1056ui_story"]) and arg_177_1.var_.characterEffect1056ui_story then
				arg_177_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_180_1 = 0
			local var_180_2 = 0.6

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_3 = arg_177_1:GetWordFromCfg(320042042)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_6 = 24 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_4) / 24)

				if (24 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_4) / 24)) > 0 and var_180_2 < var_180_6 then
					arg_177_1.talkMaxDuration = var_180_6

					if var_180_6 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042042", "story_v_out_320042.awb") ~= 0 then
					local var_180_7 = manager.audio:GetVoiceLength("story_v_out_320042", "320042042", "story_v_out_320042.awb") / 1000

					if var_180_7 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_1
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_320042", "320042042", "story_v_out_320042.awb")

						arg_177_1:RecordAudio("320042042", var_180_8)
						arg_177_1:RecordAudio("320042042", var_180_8)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_320042", "320042042", "story_v_out_320042.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_320042", "320042042", "story_v_out_320042.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_9 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_9 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_9

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_9 and arg_177_1.time_ < var_180_1 + var_180_9 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play320042043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 320042043
		arg_181_1.duration_ = 4.7

		local var_181_0 = {
			zh = 2.9,
			ja = 4.7
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
				arg_181_0:Play320042044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1056ui_story"]) and arg_181_1.var_.characterEffect1056ui_story == nil then
				arg_181_1.var_.characterEffect1056ui_story = arg_181_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1056ui_story"]) then
				if arg_181_1.var_.characterEffect1056ui_story and not isNil(arg_181_1.actors_["1056ui_story"]) then
					arg_181_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1056ui_story"]) and arg_181_1.var_.characterEffect1056ui_story then
				arg_181_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action2_2")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_184_2 = 0
			local var_184_3 = 0.35

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_4 = arg_181_1:GetWordFromCfg(320042043)
				local var_184_5 = arg_181_1:FormatText(var_184_4.content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 14 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 14)

				if (14 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 14)) > 0 and var_184_3 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042043", "story_v_out_320042.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_320042", "320042043", "story_v_out_320042.awb") / 1000

					if var_184_8 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_2
					end

					if var_184_4.prefab_name ~= "" and arg_181_1.actors_[var_184_4.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_4.prefab_name].transform, "story_v_out_320042", "320042043", "story_v_out_320042.awb")

						arg_181_1:RecordAudio("320042043", var_184_9)
						arg_181_1:RecordAudio("320042043", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_320042", "320042043", "story_v_out_320042.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_320042", "320042043", "story_v_out_320042.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_3, arg_181_1.talkMaxDuration)

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_2) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_2 + var_184_10 and arg_181_1.time_ < var_184_2 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play320042044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 320042044
		arg_185_1.duration_ = 11.03

		local var_185_0 = {
			zh = 5.866,
			ja = 11.033
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
				arg_185_0:Play320042045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_188_0 = 0
			local var_188_1 = 0.825

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(320042044)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 33 <= 0 and var_188_1 or var_188_1 * (utf8.len(var_188_3) / 33)

				if (33 <= 0 and var_188_1 or var_188_1 * (utf8.len(var_188_3) / 33)) > 0 and var_188_1 < var_188_5 then
					arg_185_1.talkMaxDuration = var_188_5

					if var_188_5 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042044", "story_v_out_320042.awb") ~= 0 then
					local var_188_6 = manager.audio:GetVoiceLength("story_v_out_320042", "320042044", "story_v_out_320042.awb") / 1000

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end

					if var_188_2.prefab_name ~= "" and arg_185_1.actors_[var_188_2.prefab_name] ~= nil then
						local var_188_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_2.prefab_name].transform, "story_v_out_320042", "320042044", "story_v_out_320042.awb")

						arg_185_1:RecordAudio("320042044", var_188_7)
						arg_185_1:RecordAudio("320042044", var_188_7)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_320042", "320042044", "story_v_out_320042.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_320042", "320042044", "story_v_out_320042.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_8 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_8 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_8

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_8 and arg_185_1.time_ < var_188_0 + var_188_8 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play320042045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 320042045
		arg_189_1.duration_ = 8.33

		local var_189_0 = {
			zh = 3.433,
			ja = 8.333
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
				arg_189_0:Play320042046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1056ui_story = arg_189_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1056ui_story, Vector3.New(-0.7, -1, -5.75), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1056ui_story"].transform.position).z)
				arg_189_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1056ui_story"].transform.localEulerAngles = arg_189_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -5.75)
				arg_189_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1056ui_story"].transform.position).z)
				arg_189_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1056ui_story"].transform.localEulerAngles = arg_189_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1056ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1056ui_story == nil then
				arg_189_1.var_.characterEffect1056ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1056ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_2)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1056ui_story then
				arg_189_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_192_3 = arg_189_1.actors_["10102ui_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10102ui_story = var_192_3.localPosition

				arg_189_1:ShowWeapon(arg_189_1.var_["10102ui_story" .. "Animator"].transform, false)
			end

			local var_192_4 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				var_192_3.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10102ui_story, Vector3.New(0.7, -0.985, -6.275), (arg_189_1.time_ - 0) / var_192_4)
				var_192_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_3.position).x, (manager.ui.mainCamera.transform.position - var_192_3.position).y, (manager.ui.mainCamera.transform.position - var_192_3.position).z)
				var_192_3.localEulerAngles.z = 0
				var_192_3.localEulerAngles.x = 0
				var_192_3.localEulerAngles = var_192_3.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_3.localPosition = Vector3.New(0.7, -0.985, -6.275)
				var_192_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_3.position).x, (manager.ui.mainCamera.transform.position - var_192_3.position).y, (manager.ui.mainCamera.transform.position - var_192_3.position).z)
				var_192_3.localEulerAngles.z = 0
				var_192_3.localEulerAngles.x = 0
				var_192_3.localEulerAngles = var_192_3.localEulerAngles
			end

			local var_192_5 = arg_189_1.actors_["10102ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.characterEffect10102ui_story == nil then
				arg_189_1.var_.characterEffect10102ui_story = var_192_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_6 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_6 and not isNil(var_192_5) then
				if arg_189_1.var_.characterEffect10102ui_story and not isNil(var_192_5) then
					arg_189_1.var_.characterEffect10102ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= 0 + var_192_6 and arg_189_1.time_ < 0 + var_192_6 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.characterEffect10102ui_story then
				arg_189_1.var_.characterEffect10102ui_story.fillFlat = false
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/story10102/story10102action/10102action1_1")
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1:PlayTimeline("10102ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_192_8 = 0
			local var_192_9 = 0.475

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_8 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_10 = arg_189_1:GetWordFromCfg(320042045)
				local var_192_11 = arg_189_1:FormatText(var_192_10.content)

				arg_189_1.text_.text = var_192_11

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_13 = 19 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 19)

				if (19 <= 0 and var_192_9 or var_192_9 * (utf8.len(var_192_11) / 19)) > 0 and var_192_9 < var_192_13 then
					arg_189_1.talkMaxDuration = var_192_13

					if var_192_13 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_8
					end
				end

				arg_189_1.text_.text = var_192_11
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042045", "story_v_out_320042.awb") ~= 0 then
					local var_192_14 = manager.audio:GetVoiceLength("story_v_out_320042", "320042045", "story_v_out_320042.awb") / 1000

					if var_192_14 + var_192_8 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_14 + var_192_8
					end

					if var_192_10.prefab_name ~= "" and arg_189_1.actors_[var_192_10.prefab_name] ~= nil then
						local var_192_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_10.prefab_name].transform, "story_v_out_320042", "320042045", "story_v_out_320042.awb")

						arg_189_1:RecordAudio("320042045", var_192_15)
						arg_189_1:RecordAudio("320042045", var_192_15)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_320042", "320042045", "story_v_out_320042.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_320042", "320042045", "story_v_out_320042.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_16 = math.max(var_192_9, arg_189_1.talkMaxDuration)

			if var_192_8 <= arg_189_1.time_ and arg_189_1.time_ < var_192_8 + var_192_16 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_8) / var_192_16

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_8 + var_192_16 and arg_189_1.time_ < var_192_8 + var_192_16 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play320042046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 320042046
		arg_193_1.duration_ = 9.93

		local var_193_0 = {
			zh = 7.6,
			ja = 9.933
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
				arg_193_0:Play320042047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1056ui_story = arg_193_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1056ui_story, Vector3.New(-0.7, -1, -5.75), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1056ui_story"].transform.position).z)
				arg_193_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1056ui_story"].transform.localEulerAngles = arg_193_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(-0.7, -1, -5.75)
				arg_193_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1056ui_story"].transform.position).z)
				arg_193_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1056ui_story"].transform.localEulerAngles = arg_193_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1056ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1056ui_story == nil then
				arg_193_1.var_.characterEffect1056ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1056ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1056ui_story then
				arg_193_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action6_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_196_4 = arg_193_1.actors_["10102ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_4) and arg_193_1.var_.characterEffect10102ui_story == nil then
				arg_193_1.var_.characterEffect10102ui_story = var_196_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_5 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_5 and not isNil(var_196_4) then
				if arg_193_1.var_.characterEffect10102ui_story and not isNil(var_196_4) then
					arg_193_1.var_.characterEffect10102ui_story.fillFlat = true
					arg_193_1.var_.characterEffect10102ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_5)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_5 and arg_193_1.time_ < 0 + var_196_5 + arg_196_0 and not isNil(var_196_4) and arg_193_1.var_.characterEffect10102ui_story then
				arg_193_1.var_.characterEffect10102ui_story.fillFlat = true
				arg_193_1.var_.characterEffect10102ui_story.fillRatio = 0.5
			end

			local var_196_6 = 0
			local var_196_7 = 0.8

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_8 = arg_193_1:GetWordFromCfg(320042046)
				local var_196_9 = arg_193_1:FormatText(var_196_8.content)

				arg_193_1.text_.text = var_196_9

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 32 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_9) / 32)

				if (32 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_9) / 32)) > 0 and var_196_7 < var_196_11 then
					arg_193_1.talkMaxDuration = var_196_11

					if var_196_11 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_9
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042046", "story_v_out_320042.awb") ~= 0 then
					local var_196_12 = manager.audio:GetVoiceLength("story_v_out_320042", "320042046", "story_v_out_320042.awb") / 1000

					if var_196_12 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_12 + var_196_6
					end

					if var_196_8.prefab_name ~= "" and arg_193_1.actors_[var_196_8.prefab_name] ~= nil then
						local var_196_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_8.prefab_name].transform, "story_v_out_320042", "320042046", "story_v_out_320042.awb")

						arg_193_1:RecordAudio("320042046", var_196_13)
						arg_193_1:RecordAudio("320042046", var_196_13)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_320042", "320042046", "story_v_out_320042.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_320042", "320042046", "story_v_out_320042.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_14 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_14 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_14

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_14 and arg_193_1.time_ < var_196_6 + var_196_14 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play320042047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 320042047
		arg_197_1.duration_ = 9.23

		local var_197_0 = {
			zh = 9.233,
			ja = 9.066
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
				arg_197_0:Play320042048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1056ui_story"]) and arg_197_1.var_.characterEffect1056ui_story == nil then
				arg_197_1.var_.characterEffect1056ui_story = arg_197_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1056ui_story"]) then
				if arg_197_1.var_.characterEffect1056ui_story and not isNil(arg_197_1.actors_["1056ui_story"]) then
					arg_197_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1056ui_story"]) and arg_197_1.var_.characterEffect1056ui_story then
				arg_197_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_200_1 = arg_197_1.actors_["10102ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10102ui_story = var_200_1.localPosition
			end

			local var_200_2 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 then
				var_200_1.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10102ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_2)
				var_200_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_1.position).x, (manager.ui.mainCamera.transform.position - var_200_1.position).y, (manager.ui.mainCamera.transform.position - var_200_1.position).z)
				var_200_1.localEulerAngles.z = 0
				var_200_1.localEulerAngles.x = 0
				var_200_1.localEulerAngles = var_200_1.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 then
				var_200_1.localPosition = Vector3.New(0, 100, 0)
				var_200_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_1.position).x, (manager.ui.mainCamera.transform.position - var_200_1.position).y, (manager.ui.mainCamera.transform.position - var_200_1.position).z)
				var_200_1.localEulerAngles.z = 0
				var_200_1.localEulerAngles.x = 0
				var_200_1.localEulerAngles = var_200_1.localEulerAngles
			end

			local var_200_3 = arg_197_1.actors_["1056ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1056ui_story = var_200_3.localPosition
			end

			local var_200_4 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				var_200_3.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_4)
				var_200_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_3.position).x, (manager.ui.mainCamera.transform.position - var_200_3.position).y, (manager.ui.mainCamera.transform.position - var_200_3.position).z)
				var_200_3.localEulerAngles.z = 0
				var_200_3.localEulerAngles.x = 0
				var_200_3.localEulerAngles = var_200_3.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				var_200_3.localPosition = Vector3.New(0, 100, 0)
				var_200_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_3.position).x, (manager.ui.mainCamera.transform.position - var_200_3.position).y, (manager.ui.mainCamera.transform.position - var_200_3.position).z)
				var_200_3.localEulerAngles.z = 0
				var_200_3.localEulerAngles.x = 0
				var_200_3.localEulerAngles = var_200_3.localEulerAngles
			end

			local var_200_5 = 0
			local var_200_6 = 1.05

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_5 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_7 = arg_197_1:GetWordFromCfg(320042047)
				local var_200_8 = arg_197_1:FormatText(var_200_7.content)

				arg_197_1.text_.text = var_200_8

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_10 = 42 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_8) / 42)

				if (42 <= 0 and var_200_6 or var_200_6 * (utf8.len(var_200_8) / 42)) > 0 and var_200_6 < var_200_10 then
					arg_197_1.talkMaxDuration = var_200_10

					if var_200_10 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_5
					end
				end

				arg_197_1.text_.text = var_200_8
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042047", "story_v_out_320042.awb") ~= 0 then
					local var_200_11 = manager.audio:GetVoiceLength("story_v_out_320042", "320042047", "story_v_out_320042.awb") / 1000

					if var_200_11 + var_200_5 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_5
					end

					if var_200_7.prefab_name ~= "" and arg_197_1.actors_[var_200_7.prefab_name] ~= nil then
						local var_200_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_7.prefab_name].transform, "story_v_out_320042", "320042047", "story_v_out_320042.awb")

						arg_197_1:RecordAudio("320042047", var_200_12)
						arg_197_1:RecordAudio("320042047", var_200_12)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_320042", "320042047", "story_v_out_320042.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_320042", "320042047", "story_v_out_320042.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_13 = math.max(var_200_6, arg_197_1.talkMaxDuration)

			if var_200_5 <= arg_197_1.time_ and arg_197_1.time_ < var_200_5 + var_200_13 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_5) / var_200_13

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_5 + var_200_13 and arg_197_1.time_ < var_200_5 + var_200_13 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10102ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1056ui_story",
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
	Play320042048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 320042048
		arg_201_1.duration_ = 11

		local var_201_0 = {
			zh = 8.966,
			ja = 11
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
				arg_201_0:Play320042049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["1056ui_story"]) and arg_201_1.var_.characterEffect1056ui_story == nil then
				arg_201_1.var_.characterEffect1056ui_story = arg_201_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["1056ui_story"]) then
				if arg_201_1.var_.characterEffect1056ui_story and not isNil(arg_201_1.actors_["1056ui_story"]) then
					arg_201_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["1056ui_story"]) and arg_201_1.var_.characterEffect1056ui_story then
				arg_201_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_204_2 = arg_201_1.actors_["1056ui_story"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1056ui_story = var_204_2.localPosition
			end

			local var_204_3 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 then
				var_204_2.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1056ui_story, Vector3.New(-0.7, -1, -5.75), (arg_201_1.time_ - 0) / var_204_3)
				var_204_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_2.position).x, (manager.ui.mainCamera.transform.position - var_204_2.position).y, (manager.ui.mainCamera.transform.position - var_204_2.position).z)
				var_204_2.localEulerAngles.z = 0
				var_204_2.localEulerAngles.x = 0
				var_204_2.localEulerAngles = var_204_2.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 then
				var_204_2.localPosition = Vector3.New(-0.7, -1, -5.75)
				var_204_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_2.position).x, (manager.ui.mainCamera.transform.position - var_204_2.position).y, (manager.ui.mainCamera.transform.position - var_204_2.position).z)
				var_204_2.localEulerAngles.z = 0
				var_204_2.localEulerAngles.x = 0
				var_204_2.localEulerAngles = var_204_2.localEulerAngles
			end

			local var_204_4 = 0
			local var_204_5 = 0.9

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:GetWordFromCfg(320042048)
				local var_204_7 = arg_201_1:FormatText(var_204_6.content)

				arg_201_1.text_.text = var_204_7

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_9 = 36 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 36)

				if (36 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_7) / 36)) > 0 and var_204_5 < var_204_9 then
					arg_201_1.talkMaxDuration = var_204_9

					if var_204_9 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_9 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_7
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042048", "story_v_out_320042.awb") ~= 0 then
					local var_204_10 = manager.audio:GetVoiceLength("story_v_out_320042", "320042048", "story_v_out_320042.awb") / 1000

					if var_204_10 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_4
					end

					if var_204_6.prefab_name ~= "" and arg_201_1.actors_[var_204_6.prefab_name] ~= nil then
						local var_204_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_6.prefab_name].transform, "story_v_out_320042", "320042048", "story_v_out_320042.awb")

						arg_201_1:RecordAudio("320042048", var_204_11)
						arg_201_1:RecordAudio("320042048", var_204_11)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_320042", "320042048", "story_v_out_320042.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_320042", "320042048", "story_v_out_320042.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_12 = math.max(var_204_5, arg_201_1.talkMaxDuration)

			if var_204_4 <= arg_201_1.time_ and arg_201_1.time_ < var_204_4 + var_204_12 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_4) / var_204_12

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_4 + var_204_12 and arg_201_1.time_ < var_204_4 + var_204_12 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play320042049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 320042049
		arg_205_1.duration_ = 5.4

		local var_205_0 = {
			zh = 3.4,
			ja = 5.4
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
				arg_205_0:Play320042050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1089ui_story = arg_205_1.actors_["1089ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1089ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1089ui_story, Vector3.New(0.7, -1.1, -6.17), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1089ui_story"].transform.position).z)
				arg_205_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1089ui_story"].transform.localEulerAngles = arg_205_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1089ui_story"].transform.localPosition = Vector3.New(0.7, -1.1, -6.17)
				arg_205_1.actors_["1089ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1089ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1089ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1089ui_story"].transform.position).z)
				arg_205_1.actors_["1089ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1089ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1089ui_story"].transform.localEulerAngles = arg_205_1.actors_["1089ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1089ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1089ui_story == nil then
				arg_205_1.var_.characterEffect1089ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 and not isNil(var_208_1) then
				if arg_205_1.var_.characterEffect1089ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1089ui_story then
				arg_205_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_208_4 = arg_205_1.actors_["1056ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect1056ui_story == nil then
				arg_205_1.var_.characterEffect1056ui_story = var_208_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_5 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_5 and not isNil(var_208_4) then
				if arg_205_1.var_.characterEffect1056ui_story and not isNil(var_208_4) then
					arg_205_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_5)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_5 and arg_205_1.time_ < 0 + var_208_5 + arg_208_0 and not isNil(var_208_4) and arg_205_1.var_.characterEffect1056ui_story then
				arg_205_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_208_6 = 0
			local var_208_7 = 0.35

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_6 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_8 = arg_205_1:GetWordFromCfg(320042049)
				local var_208_9 = arg_205_1:FormatText(var_208_8.content)

				arg_205_1.text_.text = var_208_9

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_11 = 14 <= 0 and var_208_7 or var_208_7 * (utf8.len(var_208_9) / 14)

				if (14 <= 0 and var_208_7 or var_208_7 * (utf8.len(var_208_9) / 14)) > 0 and var_208_7 < var_208_11 then
					arg_205_1.talkMaxDuration = var_208_11

					if var_208_11 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_11 + var_208_6
					end
				end

				arg_205_1.text_.text = var_208_9
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042049", "story_v_out_320042.awb") ~= 0 then
					local var_208_12 = manager.audio:GetVoiceLength("story_v_out_320042", "320042049", "story_v_out_320042.awb") / 1000

					if var_208_12 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_12 + var_208_6
					end

					if var_208_8.prefab_name ~= "" and arg_205_1.actors_[var_208_8.prefab_name] ~= nil then
						local var_208_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_8.prefab_name].transform, "story_v_out_320042", "320042049", "story_v_out_320042.awb")

						arg_205_1:RecordAudio("320042049", var_208_13)
						arg_205_1:RecordAudio("320042049", var_208_13)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_320042", "320042049", "story_v_out_320042.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_320042", "320042049", "story_v_out_320042.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_14 = math.max(var_208_7, arg_205_1.talkMaxDuration)

			if var_208_6 <= arg_205_1.time_ and arg_205_1.time_ < var_208_6 + var_208_14 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_6) / var_208_14

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_6 + var_208_14 and arg_205_1.time_ < var_208_6 + var_208_14 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play320042050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 320042050
		arg_209_1.duration_ = 3.1

		local var_209_0 = {
			zh = 2.4,
			ja = 3.1
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
				arg_209_0:Play320042051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1056ui_story"]) and arg_209_1.var_.characterEffect1056ui_story == nil then
				arg_209_1.var_.characterEffect1056ui_story = arg_209_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1056ui_story"]) then
				if arg_209_1.var_.characterEffect1056ui_story and not isNil(arg_209_1.actors_["1056ui_story"]) then
					arg_209_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1056ui_story"]) and arg_209_1.var_.characterEffect1056ui_story then
				arg_209_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action6_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_212_2 = arg_209_1.actors_["1089ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.characterEffect1089ui_story == nil then
				arg_209_1.var_.characterEffect1089ui_story = var_212_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_3 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 and not isNil(var_212_2) then
				if arg_209_1.var_.characterEffect1089ui_story and not isNil(var_212_2) then
					arg_209_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_3)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.characterEffect1089ui_story then
				arg_209_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_212_4 = arg_209_1.actors_["1056ui_story"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1056ui_story = var_212_4.localPosition
			end

			local var_212_5 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_5 then
				var_212_4.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1056ui_story, Vector3.New(-0.7, -1, -5.75), (arg_209_1.time_ - 0) / var_212_5)
				var_212_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_4.position).x, (manager.ui.mainCamera.transform.position - var_212_4.position).y, (manager.ui.mainCamera.transform.position - var_212_4.position).z)
				var_212_4.localEulerAngles.z = 0
				var_212_4.localEulerAngles.x = 0
				var_212_4.localEulerAngles = var_212_4.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_5 and arg_209_1.time_ < 0 + var_212_5 + arg_212_0 then
				var_212_4.localPosition = Vector3.New(-0.7, -1, -5.75)
				var_212_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_212_4.position).x, (manager.ui.mainCamera.transform.position - var_212_4.position).y, (manager.ui.mainCamera.transform.position - var_212_4.position).z)
				var_212_4.localEulerAngles.z = 0
				var_212_4.localEulerAngles.x = 0
				var_212_4.localEulerAngles = var_212_4.localEulerAngles
			end

			local var_212_6 = 0
			local var_212_7 = 0.275

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_8 = arg_209_1:GetWordFromCfg(320042050)
				local var_212_9 = arg_209_1:FormatText(var_212_8.content)

				arg_209_1.text_.text = var_212_9

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_11 = 11 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 11)

				if (11 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_9) / 11)) > 0 and var_212_7 < var_212_11 then
					arg_209_1.talkMaxDuration = var_212_11

					if var_212_11 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_11 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_9
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042050", "story_v_out_320042.awb") ~= 0 then
					local var_212_12 = manager.audio:GetVoiceLength("story_v_out_320042", "320042050", "story_v_out_320042.awb") / 1000

					if var_212_12 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_12 + var_212_6
					end

					if var_212_8.prefab_name ~= "" and arg_209_1.actors_[var_212_8.prefab_name] ~= nil then
						local var_212_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_8.prefab_name].transform, "story_v_out_320042", "320042050", "story_v_out_320042.awb")

						arg_209_1:RecordAudio("320042050", var_212_13)
						arg_209_1:RecordAudio("320042050", var_212_13)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_320042", "320042050", "story_v_out_320042.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_320042", "320042050", "story_v_out_320042.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_14 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_14 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_14

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_14 and arg_209_1.time_ < var_212_6 + var_212_14 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play320042051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 320042051
		arg_213_1.duration_ = 12.13

		local var_213_0 = {
			zh = 10.033,
			ja = 12.133
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
				arg_213_0:Play320042052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1056ui_story = arg_213_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1056ui_story"].transform.position).z)
				arg_213_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1056ui_story"].transform.localEulerAngles = arg_213_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_213_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1056ui_story"].transform.position).z)
				arg_213_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1056ui_story"].transform.localEulerAngles = arg_213_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1056ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1056ui_story == nil then
				arg_213_1.var_.characterEffect1056ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1056ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_2)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1056ui_story then
				arg_213_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_216_3 = arg_213_1.actors_["1089ui_story"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1089ui_story = var_216_3.localPosition
			end

			local var_216_4 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				var_216_3.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1089ui_story, Vector3.New(0, 100, 0), (arg_213_1.time_ - 0) / var_216_4)
				var_216_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_3.position).x, (manager.ui.mainCamera.transform.position - var_216_3.position).y, (manager.ui.mainCamera.transform.position - var_216_3.position).z)
				var_216_3.localEulerAngles.z = 0
				var_216_3.localEulerAngles.x = 0
				var_216_3.localEulerAngles = var_216_3.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				var_216_3.localPosition = Vector3.New(0, 100, 0)
				var_216_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_216_3.position).x, (manager.ui.mainCamera.transform.position - var_216_3.position).y, (manager.ui.mainCamera.transform.position - var_216_3.position).z)
				var_216_3.localEulerAngles.z = 0
				var_216_3.localEulerAngles.x = 0
				var_216_3.localEulerAngles = var_216_3.localEulerAngles
			end

			local var_216_5 = arg_213_1.actors_["1089ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_5) and arg_213_1.var_.characterEffect1089ui_story == nil then
				arg_213_1.var_.characterEffect1089ui_story = var_216_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_6 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_6 and not isNil(var_216_5) then
				if arg_213_1.var_.characterEffect1089ui_story and not isNil(var_216_5) then
					arg_213_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_6 and arg_213_1.time_ < 0 + var_216_6 + arg_216_0 and not isNil(var_216_5) and arg_213_1.var_.characterEffect1089ui_story then
				arg_213_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_216_8 = 0
			local var_216_9 = 1.1

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_10 = arg_213_1:GetWordFromCfg(320042051)
				local var_216_11 = arg_213_1:FormatText(var_216_10.content)

				arg_213_1.text_.text = var_216_11

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_13 = 44 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 44)

				if (44 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 44)) > 0 and var_216_9 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_8
					end
				end

				arg_213_1.text_.text = var_216_11
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042051", "story_v_out_320042.awb") ~= 0 then
					local var_216_14 = manager.audio:GetVoiceLength("story_v_out_320042", "320042051", "story_v_out_320042.awb") / 1000

					if var_216_14 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_8
					end

					if var_216_10.prefab_name ~= "" and arg_213_1.actors_[var_216_10.prefab_name] ~= nil then
						local var_216_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_10.prefab_name].transform, "story_v_out_320042", "320042051", "story_v_out_320042.awb")

						arg_213_1:RecordAudio("320042051", var_216_15)
						arg_213_1:RecordAudio("320042051", var_216_15)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_320042", "320042051", "story_v_out_320042.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_320042", "320042051", "story_v_out_320042.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_16 = math.max(var_216_9, arg_213_1.talkMaxDuration)

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_16 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_8) / var_216_16

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_8 + var_216_16 and arg_213_1.time_ < var_216_8 + var_216_16 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play320042052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 320042052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play320042053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1056ui_story = arg_217_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1056ui_story"].transform.position).z)
				arg_217_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1056ui_story"].transform.localEulerAngles = arg_217_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_217_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1056ui_story"].transform.position).z)
				arg_217_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1056ui_story"].transform.localEulerAngles = arg_217_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["1056ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1056ui_story == nil then
				arg_217_1.var_.characterEffect1056ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect1056ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_2)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect1056ui_story then
				arg_217_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_220_3 = arg_217_1.actors_["1089ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_3) and arg_217_1.var_.characterEffect1089ui_story == nil then
				arg_217_1.var_.characterEffect1089ui_story = var_220_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_4 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 and not isNil(var_220_3) then
				if arg_217_1.var_.characterEffect1089ui_story and not isNil(var_220_3) then
					arg_217_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1089ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_4)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 and not isNil(var_220_3) and arg_217_1.var_.characterEffect1089ui_story then
				arg_217_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1089ui_story.fillRatio = 0.5
			end

			local var_220_5 = 0
			local var_220_6 = 1.4

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_5 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_7 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(320042052).content)

				arg_217_1.text_.text = var_220_7

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_9 = 56 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_7) / 56)

				if (56 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_7) / 56)) > 0 and var_220_6 < var_220_9 then
					arg_217_1.talkMaxDuration = var_220_9

					if var_220_9 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_9 + var_220_5
					end
				end

				arg_217_1.text_.text = var_220_7
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_6, arg_217_1.talkMaxDuration)

			if var_220_5 <= arg_217_1.time_ and arg_217_1.time_ < var_220_5 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_5) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_5 + var_220_10 and arg_217_1.time_ < var_220_5 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play320042053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 320042053
		arg_221_1.duration_ = 11.83

		local var_221_0 = {
			zh = 9,
			ja = 11.833
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
				arg_221_0:Play320042054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1056ui_story = arg_221_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1056ui_story"].transform.position).z)
				arg_221_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1056ui_story"].transform.localEulerAngles = arg_221_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, -1, -5.75)
				arg_221_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1056ui_story"].transform.position).z)
				arg_221_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1056ui_story"].transform.localEulerAngles = arg_221_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["1056ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1056ui_story == nil then
				arg_221_1.var_.characterEffect1056ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect1056ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect1056ui_story then
				arg_221_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_224_4 = 0
			local var_224_5 = 1.15

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_4 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_6 = arg_221_1:GetWordFromCfg(320042053)
				local var_224_7 = arg_221_1:FormatText(var_224_6.content)

				arg_221_1.text_.text = var_224_7

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_9 = 46 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 46)

				if (46 <= 0 and var_224_5 or var_224_5 * (utf8.len(var_224_7) / 46)) > 0 and var_224_5 < var_224_9 then
					arg_221_1.talkMaxDuration = var_224_9

					if var_224_9 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_9 + var_224_4
					end
				end

				arg_221_1.text_.text = var_224_7
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042053", "story_v_out_320042.awb") ~= 0 then
					local var_224_10 = manager.audio:GetVoiceLength("story_v_out_320042", "320042053", "story_v_out_320042.awb") / 1000

					if var_224_10 + var_224_4 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_4
					end

					if var_224_6.prefab_name ~= "" and arg_221_1.actors_[var_224_6.prefab_name] ~= nil then
						local var_224_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_6.prefab_name].transform, "story_v_out_320042", "320042053", "story_v_out_320042.awb")

						arg_221_1:RecordAudio("320042053", var_224_11)
						arg_221_1:RecordAudio("320042053", var_224_11)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_320042", "320042053", "story_v_out_320042.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_320042", "320042053", "story_v_out_320042.awb")
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

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play320042054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 320042054
		arg_225_1.duration_ = 13.9

		local var_225_0 = {
			zh = 12.3,
			ja = 13.9
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
				arg_225_0:Play320042055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1056ui_story"]) and arg_225_1.var_.characterEffect1056ui_story == nil then
				arg_225_1.var_.characterEffect1056ui_story = arg_225_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1056ui_story"]) then
				if arg_225_1.var_.characterEffect1056ui_story and not isNil(arg_225_1.actors_["1056ui_story"]) then
					arg_225_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_0)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1056ui_story"]) and arg_225_1.var_.characterEffect1056ui_story then
				arg_225_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_228_1 = 0
			local var_228_2 = 1.375

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1031].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1089")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_3 = arg_225_1:GetWordFromCfg(320042054)
				local var_228_4 = arg_225_1:FormatText(var_228_3.content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_6 = 55 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_4) / 55)

				if (55 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_4) / 55)) > 0 and var_228_2 < var_228_6 then
					arg_225_1.talkMaxDuration = var_228_6

					if var_228_6 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042054", "story_v_out_320042.awb") ~= 0 then
					local var_228_7 = manager.audio:GetVoiceLength("story_v_out_320042", "320042054", "story_v_out_320042.awb") / 1000

					if var_228_7 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_1
					end

					if var_228_3.prefab_name ~= "" and arg_225_1.actors_[var_228_3.prefab_name] ~= nil then
						local var_228_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_3.prefab_name].transform, "story_v_out_320042", "320042054", "story_v_out_320042.awb")

						arg_225_1:RecordAudio("320042054", var_228_8)
						arg_225_1:RecordAudio("320042054", var_228_8)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_320042", "320042054", "story_v_out_320042.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_320042", "320042054", "story_v_out_320042.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_9 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_9 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_9

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_9 and arg_225_1.time_ < var_228_1 + var_228_9 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play320042055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 320042055
		arg_229_1.duration_ = 11.3

		local var_229_0 = {
			zh = 10.5,
			ja = 11.3
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
				arg_229_0:Play320042056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1056ui_story"]) and arg_229_1.var_.characterEffect1056ui_story == nil then
				arg_229_1.var_.characterEffect1056ui_story = arg_229_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1056ui_story"]) then
				if arg_229_1.var_.characterEffect1056ui_story and not isNil(arg_229_1.actors_["1056ui_story"]) then
					arg_229_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1056ui_story"]) and arg_229_1.var_.characterEffect1056ui_story then
				arg_229_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_232_2 = 0
			local var_232_3 = 1.4

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_4 = arg_229_1:GetWordFromCfg(320042055)
				local var_232_5 = arg_229_1:FormatText(var_232_4.content)

				arg_229_1.text_.text = var_232_5

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_7 = 56 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 56)

				if (56 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 56)) > 0 and var_232_3 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_2
					end
				end

				arg_229_1.text_.text = var_232_5
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042055", "story_v_out_320042.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_320042", "320042055", "story_v_out_320042.awb") / 1000

					if var_232_8 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_2
					end

					if var_232_4.prefab_name ~= "" and arg_229_1.actors_[var_232_4.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_4.prefab_name].transform, "story_v_out_320042", "320042055", "story_v_out_320042.awb")

						arg_229_1:RecordAudio("320042055", var_232_9)
						arg_229_1:RecordAudio("320042055", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_320042", "320042055", "story_v_out_320042.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_320042", "320042055", "story_v_out_320042.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_3, arg_229_1.talkMaxDuration)

			if var_232_2 <= arg_229_1.time_ and arg_229_1.time_ < var_232_2 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_2) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_2 + var_232_10 and arg_229_1.time_ < var_232_2 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play320042056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 320042056
		arg_233_1.duration_ = 6.73

		local var_233_0 = {
			zh = 6.733,
			ja = 5.8
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
				arg_233_0:Play320042057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.8

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_1 = arg_233_1:GetWordFromCfg(320042056)
				local var_236_2 = arg_233_1:FormatText(var_236_1.content)

				arg_233_1.text_.text = var_236_2

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_4 = 32 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 32)

				if (32 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_2) / 32)) > 0 and var_236_0 < var_236_4 then
					arg_233_1.talkMaxDuration = var_236_4

					if var_236_4 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_4 + 0
					end
				end

				arg_233_1.text_.text = var_236_2
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042056", "story_v_out_320042.awb") ~= 0 then
					local var_236_5 = manager.audio:GetVoiceLength("story_v_out_320042", "320042056", "story_v_out_320042.awb") / 1000

					if var_236_5 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_5 + 0
					end

					if var_236_1.prefab_name ~= "" and arg_233_1.actors_[var_236_1.prefab_name] ~= nil then
						local var_236_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_1.prefab_name].transform, "story_v_out_320042", "320042056", "story_v_out_320042.awb")

						arg_233_1:RecordAudio("320042056", var_236_6)
						arg_233_1:RecordAudio("320042056", var_236_6)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_320042", "320042056", "story_v_out_320042.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_320042", "320042056", "story_v_out_320042.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_7 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_7 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_7

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_7 and arg_233_1.time_ < 0 + var_236_7 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play320042057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 320042057
		arg_237_1.duration_ = 6.6

		local var_237_0 = {
			zh = 6.6,
			ja = 6.333
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
				arg_237_0:Play320042058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_240_0 = 0
			local var_240_1 = 0.875

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_2 = arg_237_1:GetWordFromCfg(320042057)
				local var_240_3 = arg_237_1:FormatText(var_240_2.content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 35 <= 0 and var_240_1 or var_240_1 * (utf8.len(var_240_3) / 35)

				if (35 <= 0 and var_240_1 or var_240_1 * (utf8.len(var_240_3) / 35)) > 0 and var_240_1 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042057", "story_v_out_320042.awb") ~= 0 then
					local var_240_6 = manager.audio:GetVoiceLength("story_v_out_320042", "320042057", "story_v_out_320042.awb") / 1000

					if var_240_6 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_0
					end

					if var_240_2.prefab_name ~= "" and arg_237_1.actors_[var_240_2.prefab_name] ~= nil then
						local var_240_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_2.prefab_name].transform, "story_v_out_320042", "320042057", "story_v_out_320042.awb")

						arg_237_1:RecordAudio("320042057", var_240_7)
						arg_237_1:RecordAudio("320042057", var_240_7)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_320042", "320042057", "story_v_out_320042.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_320042", "320042057", "story_v_out_320042.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_8 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_8 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_8

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_8 and arg_237_1.time_ < var_240_0 + var_240_8 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play320042058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 320042058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play320042059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1056ui_story = arg_241_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1056ui_story"].transform.position).z)
				arg_241_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1056ui_story"].transform.localEulerAngles = arg_241_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1056ui_story"].transform.position).z)
				arg_241_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1056ui_story"].transform.localEulerAngles = arg_241_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["1056ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1056ui_story == nil then
				arg_241_1.var_.characterEffect1056ui_story = var_244_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_2 and not isNil(var_244_1) then
				if arg_241_1.var_.characterEffect1056ui_story and not isNil(var_244_1) then
					arg_241_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_241_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_2)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_2 and arg_241_1.time_ < 0 + var_244_2 + arg_244_0 and not isNil(var_244_1) and arg_241_1.var_.characterEffect1056ui_story then
				arg_241_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_241_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_244_3 = 0
			local var_244_4 = 0.85

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_3 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_5 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(320042058).content)

				arg_241_1.text_.text = var_244_5

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_7 = 34 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_5) / 34)

				if (34 <= 0 and var_244_4 or var_244_4 * (utf8.len(var_244_5) / 34)) > 0 and var_244_4 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_3 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_3
					end
				end

				arg_241_1.text_.text = var_244_5
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_8 = math.max(var_244_4, arg_241_1.talkMaxDuration)

			if var_244_3 <= arg_241_1.time_ and arg_241_1.time_ < var_244_3 + var_244_8 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_3) / var_244_8

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_3 + var_244_8 and arg_241_1.time_ < var_244_3 + var_244_8 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play320042059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 320042059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play320042060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 1.175

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(320042059).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 47 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 47)

				if (47 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 47)) > 0 and var_248_0 < var_248_3 then
					arg_245_1.talkMaxDuration = var_248_3

					if var_248_3 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_3 + 0
					end
				end

				arg_245_1.text_.text = var_248_1
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_4 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_4

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play320042060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 320042060
		arg_249_1.duration_ = 7.1

		local var_249_0 = {
			zh = 7.1,
			ja = 3.766
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
				arg_249_0:Play320042061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1056ui_story"]) and arg_249_1.var_.characterEffect1056ui_story == nil then
				arg_249_1.var_.characterEffect1056ui_story = arg_249_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1056ui_story"]) then
				if arg_249_1.var_.characterEffect1056ui_story and not isNil(arg_249_1.actors_["1056ui_story"]) then
					arg_249_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1056ui_story"]) and arg_249_1.var_.characterEffect1056ui_story then
				arg_249_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_252_2 = arg_249_1.actors_["1056ui_story"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos1056ui_story = var_252_2.localPosition
			end

			local var_252_3 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_3 then
				var_252_2.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_249_1.time_ - 0) / var_252_3)
				var_252_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_2.position).x, (manager.ui.mainCamera.transform.position - var_252_2.position).y, (manager.ui.mainCamera.transform.position - var_252_2.position).z)
				var_252_2.localEulerAngles.z = 0
				var_252_2.localEulerAngles.x = 0
				var_252_2.localEulerAngles = var_252_2.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_3 and arg_249_1.time_ < 0 + var_252_3 + arg_252_0 then
				var_252_2.localPosition = Vector3.New(0, -1, -5.75)
				var_252_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_252_2.position).x, (manager.ui.mainCamera.transform.position - var_252_2.position).y, (manager.ui.mainCamera.transform.position - var_252_2.position).z)
				var_252_2.localEulerAngles.z = 0
				var_252_2.localEulerAngles.x = 0
				var_252_2.localEulerAngles = var_252_2.localEulerAngles
			end

			local var_252_4 = 0
			local var_252_5 = 0.475

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(320042060)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 19 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 19)

				if (19 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 19)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042060", "story_v_out_320042.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_320042", "320042060", "story_v_out_320042.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_320042", "320042060", "story_v_out_320042.awb")

						arg_249_1:RecordAudio("320042060", var_252_11)
						arg_249_1:RecordAudio("320042060", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_320042", "320042060", "story_v_out_320042.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_320042", "320042060", "story_v_out_320042.awb")
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
				actorName = "1056ui_story",
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
	Play320042061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 320042061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play320042062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["1056ui_story"]) and arg_253_1.var_.characterEffect1056ui_story == nil then
				arg_253_1.var_.characterEffect1056ui_story = arg_253_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["1056ui_story"]) then
				if arg_253_1.var_.characterEffect1056ui_story and not isNil(arg_253_1.actors_["1056ui_story"]) then
					arg_253_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_253_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["1056ui_story"]) and arg_253_1.var_.characterEffect1056ui_story then
				arg_253_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_253_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 1.15

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

				local var_256_3 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(320042061).content)

				arg_253_1.text_.text = var_256_3

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 46 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 46)

				if (46 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_3) / 46)) > 0 and var_256_2 < var_256_5 then
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
	Play320042062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 320042062
		arg_257_1.duration_ = 2.4

		local var_257_0 = {
			zh = 1.999999999999,
			ja = 2.4
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
				arg_257_0:Play320042063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["1056ui_story"]) and arg_257_1.var_.characterEffect1056ui_story == nil then
				arg_257_1.var_.characterEffect1056ui_story = arg_257_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["1056ui_story"]) then
				if arg_257_1.var_.characterEffect1056ui_story and not isNil(arg_257_1.actors_["1056ui_story"]) then
					arg_257_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["1056ui_story"]) and arg_257_1.var_.characterEffect1056ui_story then
				arg_257_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_260_2 = 0
			local var_260_3 = 0.175

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_4 = arg_257_1:GetWordFromCfg(320042062)
				local var_260_5 = arg_257_1:FormatText(var_260_4.content)

				arg_257_1.text_.text = var_260_5

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_7 = 7 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_5) / 7)

				if (7 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_5) / 7)) > 0 and var_260_3 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_2
					end
				end

				arg_257_1.text_.text = var_260_5
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042062", "story_v_out_320042.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_320042", "320042062", "story_v_out_320042.awb") / 1000

					if var_260_8 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_2
					end

					if var_260_4.prefab_name ~= "" and arg_257_1.actors_[var_260_4.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_4.prefab_name].transform, "story_v_out_320042", "320042062", "story_v_out_320042.awb")

						arg_257_1:RecordAudio("320042062", var_260_9)
						arg_257_1:RecordAudio("320042062", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_320042", "320042062", "story_v_out_320042.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_320042", "320042062", "story_v_out_320042.awb")
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
	Play320042063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 320042063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play320042064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1056ui_story"]) and arg_261_1.var_.characterEffect1056ui_story == nil then
				arg_261_1.var_.characterEffect1056ui_story = arg_261_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1056ui_story"]) then
				if arg_261_1.var_.characterEffect1056ui_story and not isNil(arg_261_1.actors_["1056ui_story"]) then
					arg_261_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_0)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1056ui_story"]) and arg_261_1.var_.characterEffect1056ui_story then
				arg_261_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_264_1 = 0
			local var_264_2 = 1.125

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(320042063).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 45 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 45)

				if (45 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 45)) > 0 and var_264_2 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_1
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_6 = math.max(var_264_2, arg_261_1.talkMaxDuration)

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_6 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_1) / var_264_6

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_1 + var_264_6 and arg_261_1.time_ < var_264_1 + var_264_6 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play320042064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 320042064
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play320042065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 1.2

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(320042064).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 48 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 48)

				if (48 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 48)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play320042065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 320042065
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play320042066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.875

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
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

				local var_272_1 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(320042065).content)

				arg_269_1.text_.text = var_272_1

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_3 = 35 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 35)

				if (35 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 35)) > 0 and var_272_0 < var_272_3 then
					arg_269_1.talkMaxDuration = var_272_3

					if var_272_3 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_3 + 0
					end
				end

				arg_269_1.text_.text = var_272_1
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_4 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_4

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play320042066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 320042066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play320042067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1056ui_story = arg_273_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1056ui_story"].transform.position).z)
				arg_273_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1056ui_story"].transform.localEulerAngles = arg_273_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1056ui_story"].transform.position).z)
				arg_273_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1056ui_story"].transform.localEulerAngles = arg_273_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_276_1 = 0
			local var_276_2 = 0.975

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(320042066).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 39 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 39)

				if (39 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 39)) > 0 and var_276_2 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_6 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_6 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_6

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_6 and arg_273_1.time_ < var_276_1 + var_276_6 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play320042067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 320042067
		arg_277_1.duration_ = 3.6

		local var_277_0 = {
			zh = 3.6,
			ja = 3.566
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
				arg_277_0:Play320042068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1056ui_story"]) and arg_277_1.var_.characterEffect1056ui_story == nil then
				arg_277_1.var_.characterEffect1056ui_story = arg_277_1.actors_["1056ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1056ui_story"]) then
				if arg_277_1.var_.characterEffect1056ui_story and not isNil(arg_277_1.actors_["1056ui_story"]) then
					arg_277_1.var_.characterEffect1056ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1056ui_story"]) and arg_277_1.var_.characterEffect1056ui_story then
				arg_277_1.var_.characterEffect1056ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_280_2 = arg_277_1.actors_["1056ui_story"].transform

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos1056ui_story = var_280_2.localPosition
			end

			local var_280_3 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 then
				var_280_2.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos1056ui_story, Vector3.New(0, -1, -5.75), (arg_277_1.time_ - 0) / var_280_3)
				var_280_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_280_2.position).x, (manager.ui.mainCamera.transform.position - var_280_2.position).y, (manager.ui.mainCamera.transform.position - var_280_2.position).z)
				var_280_2.localEulerAngles.z = 0
				var_280_2.localEulerAngles.x = 0
				var_280_2.localEulerAngles = var_280_2.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 then
				var_280_2.localPosition = Vector3.New(0, -1, -5.75)
				var_280_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_280_2.position).x, (manager.ui.mainCamera.transform.position - var_280_2.position).y, (manager.ui.mainCamera.transform.position - var_280_2.position).z)
				var_280_2.localEulerAngles.z = 0
				var_280_2.localEulerAngles.x = 0
				var_280_2.localEulerAngles = var_280_2.localEulerAngles
			end

			local var_280_4 = 0
			local var_280_5 = 0.4

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(320042067)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 16 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 16)

				if (16 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 16)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042067", "story_v_out_320042.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_out_320042", "320042067", "story_v_out_320042.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_out_320042", "320042067", "story_v_out_320042.awb")

						arg_277_1:RecordAudio("320042067", var_280_11)
						arg_277_1:RecordAudio("320042067", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_320042", "320042067", "story_v_out_320042.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_320042", "320042067", "story_v_out_320042.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_12 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_12 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_12

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_12 and arg_277_1.time_ < var_280_4 + var_280_12 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_277_1:InitPlayNodeList()
	end,
	Play320042068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 320042068
		arg_281_1.duration_ = 8.1

		local var_281_0 = {
			zh = 4.966,
			ja = 8.1
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play320042069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/story1056/story1056action/1056action1_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1056ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_284_0 = 0
			local var_284_1 = 0.6

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(320042068)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 24 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 24)

				if (24 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 24)) > 0 and var_284_1 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_320042", "320042068", "story_v_out_320042.awb") ~= 0 then
					local var_284_6 = manager.audio:GetVoiceLength("story_v_out_320042", "320042068", "story_v_out_320042.awb") / 1000

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end

					if var_284_2.prefab_name ~= "" and arg_281_1.actors_[var_284_2.prefab_name] ~= nil then
						local var_284_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_2.prefab_name].transform, "story_v_out_320042", "320042068", "story_v_out_320042.awb")

						arg_281_1:RecordAudio("320042068", var_284_7)
						arg_281_1:RecordAudio("320042068", var_284_7)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_320042", "320042068", "story_v_out_320042.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_320042", "320042068", "story_v_out_320042.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_8 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_8 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_8

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_8 and arg_281_1.time_ < var_284_0 + var_284_8 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play320042069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 320042069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
			arg_285_1.auto_ = false
		end

		function arg_285_1.playNext_(arg_287_0)
			arg_285_1.onStoryFinished_()
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1056ui_story = arg_285_1.actors_["1056ui_story"].transform.localPosition
			end

			local var_288_0 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 then
				arg_285_1.actors_["1056ui_story"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1056ui_story, Vector3.New(0, 100, 0), (arg_285_1.time_ - 0) / var_288_0)
				arg_285_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1056ui_story"].transform.position).z)
				arg_285_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1056ui_story"].transform.localEulerAngles = arg_285_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 then
				arg_285_1.actors_["1056ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_285_1.actors_["1056ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_285_1.actors_["1056ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1056ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_285_1.actors_["1056ui_story"].transform.position).z)
				arg_285_1.actors_["1056ui_story"].transform.localEulerAngles.z = 0
				arg_285_1.actors_["1056ui_story"].transform.localEulerAngles.x = 0
				arg_285_1.actors_["1056ui_story"].transform.localEulerAngles = arg_285_1.actors_["1056ui_story"].transform.localEulerAngles
			end

			local var_288_1 = arg_285_1.actors_["1056ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1056ui_story == nil then
				arg_285_1.var_.characterEffect1056ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect1056ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect1056ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1056ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_2)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect1056ui_story then
				arg_285_1.var_.characterEffect1056ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1056ui_story.fillRatio = 0.5
			end

			local var_288_3 = 0
			local var_288_4 = 1

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_3 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_5 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(320042069).content)

				arg_285_1.text_.text = var_288_5

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_7 = 40 <= 0 and var_288_4 or var_288_4 * (utf8.len(var_288_5) / 40)

				if (40 <= 0 and var_288_4 or var_288_4 * (utf8.len(var_288_5) / 40)) > 0 and var_288_4 < var_288_7 then
					arg_285_1.talkMaxDuration = var_288_7

					if var_288_7 + var_288_3 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_7 + var_288_3
					end
				end

				arg_285_1.text_.text = var_288_5
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_8 = math.max(var_288_4, arg_285_1.talkMaxDuration)

			if var_288_3 <= arg_285_1.time_ and arg_285_1.time_ < var_288_3 + var_288_8 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_3) / var_288_8

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_3 + var_288_8 and arg_285_1.time_ < var_288_3 + var_288_8 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_285_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/XS0101",
		"TextureConfig/Background/L02f",
		"TextureConfig/Background/L01f"
	},
	voices = {
		"story_v_out_320042.awb"
	}
}
