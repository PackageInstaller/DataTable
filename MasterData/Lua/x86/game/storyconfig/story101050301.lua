return {
	Play105031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 105031001
		arg_1_1.duration_ = 4.8

		local var_1_0 = {
			ja = 4.3,
			ko = 4.333,
			zh = 4.8,
			en = 4.7
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
				arg_1_0:Play105031002(arg_1_1)
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_4 = "S0506a"

			if arg_1_1.bgs_.S0506a == nil then
				local var_4_5 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_4)
				var_4_5.name = var_4_4
				var_4_5.transform.parent = arg_1_1.stage_.transform
				var_4_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_4] = var_4_5
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_6 = arg_1_1.bgs_.S0506a:GetComponent("SpriteRenderer")

				if var_4_6 then
					arg_1_1.var_.alphaOldValueS0506a = var_4_6.color.a
					arg_1_1.var_.alphaMatValueS0506a = var_4_6
				end

				arg_1_1.var_.alphaOldValueS0506a = 0
			end

			local var_4_7 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_7 then
				if arg_1_1.var_.alphaMatValueS0506a then
					arg_1_1.var_.alphaMatValueS0506a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueS0506a, 1, (arg_1_1.time_ - 0) / var_4_7)
					arg_1_1.var_.alphaMatValueS0506a.color = arg_1_1.var_.alphaMatValueS0506a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_7 and arg_1_1.time_ < 0 + var_4_7 + arg_4_0 and arg_1_1.var_.alphaMatValueS0506a then
				arg_1_1.var_.alphaMatValueS0506a.color.a = 1
				arg_1_1.var_.alphaMatValueS0506a.color = arg_1_1.var_.alphaMatValueS0506a.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_8 = arg_1_1.bgs_.S0506a

				arg_1_1.bgs_.S0506a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_9 = var_4_8:GetComponent("SpriteRenderer")

				if var_4_9 and var_4_9.sprite then
					local var_4_10 = 2 * (var_4_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_8.transform.localScale = Vector3.New(var_4_10 / var_4_9.sprite.bounds.size.y < var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x and var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x or var_4_10 / var_4_9.sprite.bounds.size.y, var_4_10 / var_4_9.sprite.bounds.size.y < var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x and var_4_10 * manager.ui.mainCameraCom_.aspect / var_4_9.sprite.bounds.size.x or var_4_10 / var_4_9.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "S0506a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_11 = manager.ui.mainCamera.transform

			if 1.4 < arg_1_1.time_ and arg_1_1.time_ <= 1.4 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_11.localPosition
			end

			local var_4_12 = 0.6

			if 1.4 <= arg_1_1.time_ and arg_1_1.time_ < 1.4 + var_4_12 then
				local var_4_13, var_4_14 = math.modf((arg_1_1.time_ - 1.4) / 0.066)

				var_4_11.localPosition = Vector3.New(var_4_14 * 0.13, var_4_14 * 0.13, var_4_14 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 1.4 + var_4_12 and arg_1_1.time_ < 1.4 + var_4_12 + arg_4_0 then
				var_4_11.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_15 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_15 + 2 and arg_1_1.time_ < var_4_15 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 0.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:GetWordFromCfg(105031001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 10 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 10)

				if (10 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 10)) > 0 and var_4_17 < var_4_22 then
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

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031001", "story_v_out_105031.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_out_105031", "105031001", "story_v_out_105031.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_out_105031", "105031001", "story_v_out_105031.awb")

						arg_1_1:RecordAudio("105031001", var_4_24)
						arg_1_1:RecordAudio("105031001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_105031", "105031001", "story_v_out_105031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_105031", "105031001", "story_v_out_105031.awb")
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

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play105031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 105031002
		arg_8_1.duration_ = 6.5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play105031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.shakeOldPosMainCamera = manager.ui.mainCamera.transform.localPosition
			end

			local var_11_0 = 0.600000023841858

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 then
				local var_11_1, var_11_2 = math.modf((arg_8_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_11_2 * 0.13, var_11_2 * 0.13, var_11_2 * 0.13) + arg_8_1.var_.shakeOldPosMainCamera
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 then
				manager.ui.mainCamera.transform.localPosition = arg_8_1.var_.shakeOldPosMainCamera
			end

			local var_11_3 = 0

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_3 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = true

				arg_8_1:SetGaussion(false)
			end

			local var_11_4 = 1.5

			if var_11_3 <= arg_8_1.time_ and arg_8_1.time_ < var_11_3 + var_11_4 then
				local var_11_5 = Color.New(1, 1, 1)

				var_11_5.a = Mathf.Lerp(0, 1, (arg_8_1.time_ - var_11_3) / var_11_4)
				arg_8_1.mask_.color = var_11_5
			end

			if arg_8_1.time_ >= var_11_3 + var_11_4 and arg_8_1.time_ < var_11_3 + var_11_4 + arg_11_0 then
				local var_11_6 = Color.New(1, 1, 1)

				var_11_6.a = 1
				arg_8_1.mask_.color = var_11_6
			end

			local var_11_7 = 1.5

			if 1.5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_7 + arg_11_0 then
				arg_8_1.mask_.enabled = true
				arg_8_1.mask_.raycastTarget = false

				arg_8_1:SetGaussion(false)
			end

			local var_11_8 = 1.5

			if var_11_7 <= arg_8_1.time_ and arg_8_1.time_ < var_11_7 + var_11_8 then
				local var_11_9 = Color.New(1, 1, 1)

				var_11_9.a = Mathf.Lerp(1, 0, (arg_8_1.time_ - var_11_7) / var_11_8)
				arg_8_1.mask_.color = var_11_9
			end

			if arg_8_1.time_ >= var_11_7 + var_11_8 and arg_8_1.time_ < var_11_7 + var_11_8 + arg_11_0 then
				local var_11_10 = Color.New(1, 1, 1)

				arg_8_1.mask_.enabled = false
				var_11_10.a = 0
				arg_8_1.mask_.color = var_11_10
			end

			local var_11_11 = "STwhite"

			if arg_8_1.bgs_.STwhite == nil then
				local var_11_12 = Object.Instantiate(arg_8_1.paintGo_)

				var_11_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_11_11)
				var_11_12.name = var_11_11
				var_11_12.transform.parent = arg_8_1.stage_.transform
				var_11_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.bgs_[var_11_11] = var_11_12
			end

			local var_11_13 = arg_8_1.bgs_.STwhite.transform

			if 1.5 < arg_8_1.time_ and arg_8_1.time_ <= 1.5 + arg_11_0 then
				arg_8_1.var_.moveOldPosSTwhite = var_11_13.localPosition
				var_11_13.localScale = Vector3.New(12, 12, 12)
			end

			local var_11_14 = 0.001

			if 1.5 <= arg_8_1.time_ and arg_8_1.time_ < 1.5 + var_11_14 then
				var_11_13.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPosSTwhite, Vector3.New(0, 0, 0), (arg_8_1.time_ - 1.5) / var_11_14)
			end

			if arg_8_1.time_ >= 1.5 + var_11_14 and arg_8_1.time_ < 1.5 + var_11_14 + arg_11_0 then
				var_11_13.localPosition = Vector3.New(0, 0, 0)
			end

			if arg_8_1.frameCnt_ <= 1 then
				arg_8_1.dialog_:SetActive(false)
			end

			local var_11_15 = 1.5
			local var_11_16 = 0.15

			if 1.5 < arg_8_1.time_ and arg_8_1.time_ <= var_11_15 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0

				arg_8_1.dialog_:SetActive(true)

				arg_8_1.dialogCg_.alpha = 0

				local var_11_17 = LeanTween.value(arg_8_1.dialog_, 0, 1, 0.3)

				var_11_17:setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
					arg_8_1.dialogCg_.alpha = arg_12_0
				end))
				var_11_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_8_1.dialog_)
					var_11_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_8_1.duration_ = arg_8_1.duration_ + 0.3

				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_18 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(105031002).content)

				arg_8_1.text_.text = var_11_18

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_20 = 6 <= 0 and var_11_16 or var_11_16 * (utf8.len(var_11_18) / 6)

				if (6 <= 0 and var_11_16 or var_11_16 * (utf8.len(var_11_18) / 6)) > 0 and var_11_16 < var_11_20 then
					arg_8_1.talkMaxDuration = var_11_20
					var_11_15 = var_11_15 + 0.3

					if var_11_20 + var_11_15 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_20 + var_11_15
					end
				end

				arg_8_1.text_.text = var_11_18
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_21 = var_11_15 + 0.3
			local var_11_22 = math.max(var_11_16, arg_8_1.talkMaxDuration)

			if var_11_15 + 0.3 <= arg_8_1.time_ and arg_8_1.time_ < var_11_21 + var_11_22 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_21) / var_11_22

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_21 + var_11_22 and arg_8_1.time_ < var_11_21 + var_11_22 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play105031003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 105031003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play105031004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.shakeOldPosMainCamera = manager.ui.mainCamera.transform.localPosition
			end

			local var_17_0 = 0.600000023841858

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_0 then
				local var_17_1, var_17_2 = math.modf((arg_14_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_17_2 * 0.13, var_17_2 * 0.13, var_17_2 * 0.13) + arg_14_1.var_.shakeOldPosMainCamera
			end

			if arg_14_1.time_ >= 0 + var_17_0 and arg_14_1.time_ < 0 + var_17_0 + arg_17_0 then
				manager.ui.mainCamera.transform.localPosition = arg_14_1.var_.shakeOldPosMainCamera
			end

			local var_17_3 = 0
			local var_17_4 = 0.3

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_3 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_5 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(105031003).content)

				arg_14_1.text_.text = var_17_5

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_7 = 12 <= 0 and var_17_4 or var_17_4 * (utf8.len(var_17_5) / 12)

				if (12 <= 0 and var_17_4 or var_17_4 * (utf8.len(var_17_5) / 12)) > 0 and var_17_4 < var_17_7 then
					arg_14_1.talkMaxDuration = var_17_7

					if var_17_7 + var_17_3 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_7 + var_17_3
					end
				end

				arg_14_1.text_.text = var_17_5
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_8 = math.max(var_17_4, arg_14_1.talkMaxDuration)

			if var_17_3 <= arg_14_1.time_ and arg_14_1.time_ < var_17_3 + var_17_8 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_3) / var_17_8

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_3 + var_17_8 and arg_14_1.time_ < var_17_3 + var_17_8 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play105031004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 105031004
		arg_18_1.duration_ = 8.2

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play105031005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1:AudioAction("play", "effect", "se_story_5", "se_story_5_horseattack", "")
			end

			local var_21_1 = 0

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_2 = 1.5

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 then
				local var_21_3 = Color.New(1, 1, 1)

				var_21_3.a = Mathf.Lerp(1, 0, (arg_18_1.time_ - var_21_1) / var_21_2)
				arg_18_1.mask_.color = var_21_3
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 then
				local var_21_4 = Color.New(1, 1, 1)

				arg_18_1.mask_.enabled = false
				var_21_4.a = 0
				arg_18_1.mask_.color = var_21_4
			end

			local var_21_5 = "S0506"

			if arg_18_1.bgs_.S0506 == nil then
				local var_21_6 = Object.Instantiate(arg_18_1.paintGo_)

				var_21_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_21_5)
				var_21_6.name = var_21_5
				var_21_6.transform.parent = arg_18_1.stage_.transform
				var_21_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.bgs_[var_21_5] = var_21_6
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				local var_21_7 = arg_18_1.bgs_.S0506

				arg_18_1.bgs_.S0506.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_21_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_21_8 = var_21_7:GetComponent("SpriteRenderer")

				if var_21_8 and var_21_8.sprite then
					local var_21_9 = 2 * (var_21_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_21_7.transform.localScale = Vector3.New(var_21_9 / var_21_8.sprite.bounds.size.y < var_21_9 * manager.ui.mainCameraCom_.aspect / var_21_8.sprite.bounds.size.x and var_21_9 * manager.ui.mainCameraCom_.aspect / var_21_8.sprite.bounds.size.x or var_21_9 / var_21_8.sprite.bounds.size.y, var_21_9 / var_21_8.sprite.bounds.size.y < var_21_9 * manager.ui.mainCameraCom_.aspect / var_21_8.sprite.bounds.size.x and var_21_9 * manager.ui.mainCameraCom_.aspect / var_21_8.sprite.bounds.size.x or var_21_9 / var_21_8.sprite.bounds.size.y, 0)
				end

				for iter_21_0, iter_21_1 in pairs(arg_18_1.bgs_) do
					if iter_21_0 ~= "S0506" then
						iter_21_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_21_10 = arg_18_1.bgs_.S0506.transform

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPosS0506 = var_21_10.localPosition
				var_21_10.localScale = Vector3.New(1.4, 1.4, 1.4)
			end

			local var_21_11 = 3.2

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_11 then
				var_21_10.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPosS0506, Vector3.New(3.8, -1.2, 10), (arg_18_1.time_ - 0) / var_21_11)
			end

			if arg_18_1.time_ >= 0 + var_21_11 and arg_18_1.time_ < 0 + var_21_11 + arg_21_0 then
				var_21_10.localPosition = Vector3.New(3.8, -1.2, 10)
			end

			local var_21_12 = manager.ui.mainCamera.transform

			if 2.8 < arg_18_1.time_ and arg_18_1.time_ <= 2.8 + arg_21_0 then
				arg_18_1.var_.shakeOldPos = var_21_12.localPosition
			end

			local var_21_13 = 0.6

			if 2.8 <= arg_18_1.time_ and arg_18_1.time_ < 2.8 + var_21_13 then
				local var_21_14, var_21_15 = math.modf((arg_18_1.time_ - 2.8) / 0.066)

				var_21_12.localPosition = Vector3.New(var_21_15 * 0.13, var_21_15 * 0.13, var_21_15 * 0.13) + arg_18_1.var_.shakeOldPos
			end

			if arg_18_1.time_ >= 2.8 + var_21_13 and arg_18_1.time_ < 2.8 + var_21_13 + arg_21_0 then
				var_21_12.localPosition = arg_18_1.var_.shakeOldPos
			end

			local var_21_16 = 0

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_16 + arg_21_0 then
				arg_18_1.allBtn_.enabled = false
			end

			if arg_18_1.time_ >= var_21_16 + 3.2 and arg_18_1.time_ < var_21_16 + 3.2 + arg_21_0 then
				arg_18_1.allBtn_.enabled = true
			end

			local var_21_17 = 3.2
			local var_21_18 = 1.025

			if 3.2 < arg_18_1.time_ and arg_18_1.time_ <= var_21_17 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_19 = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(105031004).content)

				arg_18_1.text_.text = var_21_19

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_21 = 41 <= 0 and var_21_18 or var_21_18 * (utf8.len(var_21_19) / 41)

				if (41 <= 0 and var_21_18 or var_21_18 * (utf8.len(var_21_19) / 41)) > 0 and var_21_18 < var_21_21 then
					arg_18_1.talkMaxDuration = var_21_21

					if var_21_21 + var_21_17 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_21 + var_21_17
					end
				end

				arg_18_1.text_.text = var_21_19
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_22 = math.max(var_21_18, arg_18_1.talkMaxDuration)

			if var_21_17 <= arg_18_1.time_ and arg_18_1.time_ < var_21_17 + var_21_22 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_17) / var_21_22

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_17 + var_21_22 and arg_18_1.time_ < var_21_17 + var_21_22 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0506",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play105031005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 105031005
		arg_22_1.duration_ = 6.93

		local var_22_0 = {
			ja = 5.333,
			ko = 5.033,
			zh = 6.666,
			en = 6.933
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play105031006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.6

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_1 = arg_22_1:GetWordFromCfg(105031005)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 24 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 24)

				if (24 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 24)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031005", "story_v_out_105031.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_out_105031", "105031005", "story_v_out_105031.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_out_105031", "105031005", "story_v_out_105031.awb")

						arg_22_1:RecordAudio("105031005", var_25_6)
						arg_22_1:RecordAudio("105031005", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_105031", "105031005", "story_v_out_105031.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_105031", "105031005", "story_v_out_105031.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_7 = math.max(var_25_0, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_7 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - 0) / var_25_7

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_7 and arg_22_1.time_ < 0 + var_25_7 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play105031006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 105031006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play105031007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 1.075

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_1 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(105031006).content)

				arg_26_1.text_.text = var_29_1

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_3 = 43 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_1) / 43)

				if (43 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_1) / 43)) > 0 and var_29_0 < var_29_3 then
					arg_26_1.talkMaxDuration = var_29_3

					if var_29_3 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_3 + 0
					end
				end

				arg_26_1.text_.text = var_29_1
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_4 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_4 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_4

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_4 and arg_26_1.time_ < 0 + var_29_4 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play105031007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 105031007
		arg_30_1.duration_ = 8.1

		local var_30_0 = {
			ja = 8.1,
			ko = 5.466,
			zh = 5.666,
			en = 5.866
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play105031008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if arg_30_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_33_0 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_30_1.stage_.transform)

				var_33_0.name = "1036ui_story"
				var_33_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.actors_["1036ui_story"] = var_33_0

				local var_33_1 = var_33_0:GetComponentInChildren(typeof(CharacterEffect))

				var_33_1.enabled = true

				local var_33_2 = GameObjectTools.GetOrAddComponent(var_33_0, typeof(DynamicBoneHelper))

				if var_33_2 then
					var_33_2:EnableDynamicBone(false)
				end

				arg_30_1:ShowWeapon(var_33_1.transform, false)

				arg_30_1.var_["1036ui_story" .. "Animator"] = var_33_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_30_1.var_["1036ui_story" .. "Animator"].applyRootMotion = true
				arg_30_1.var_["1036ui_story" .. "LipSync"] = var_33_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_33_3 = arg_30_1.actors_["1036ui_story"]

			if 3 < arg_30_1.time_ and arg_30_1.time_ <= 3 + arg_33_0 and not isNil(var_33_3) and arg_30_1.var_.characterEffect1036ui_story == nil then
				arg_30_1.var_.characterEffect1036ui_story = var_33_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_4 = 0.1

			if 3 <= arg_30_1.time_ and arg_30_1.time_ < 3 + var_33_4 and not isNil(var_33_3) then
				if arg_30_1.var_.characterEffect1036ui_story and not isNil(var_33_3) then
					arg_30_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= 3 + var_33_4 and arg_30_1.time_ < 3 + var_33_4 + arg_33_0 and not isNil(var_33_3) and arg_30_1.var_.characterEffect1036ui_story then
				arg_30_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_33_6 = arg_30_1.actors_["1036ui_story"].transform

			if 3 < arg_30_1.time_ and arg_30_1.time_ <= 3 + arg_33_0 then
				arg_30_1.var_.moveOldPos1036ui_story = var_33_6.localPosition
			end

			local var_33_7 = 0.001

			if 3 <= arg_30_1.time_ and arg_30_1.time_ < 3 + var_33_7 then
				var_33_6.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1036ui_story, Vector3.New(-0.7, -1.09, -5.78), (arg_30_1.time_ - 3) / var_33_7)
				var_33_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_33_6.position).x, (manager.ui.mainCamera.transform.position - var_33_6.position).y, (manager.ui.mainCamera.transform.position - var_33_6.position).z)
				var_33_6.localEulerAngles.z = 0
				var_33_6.localEulerAngles.x = 0
				var_33_6.localEulerAngles = var_33_6.localEulerAngles
			end

			if arg_30_1.time_ >= 3 + var_33_7 and arg_30_1.time_ < 3 + var_33_7 + arg_33_0 then
				var_33_6.localPosition = Vector3.New(-0.7, -1.09, -5.78)
				var_33_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_33_6.position).x, (manager.ui.mainCamera.transform.position - var_33_6.position).y, (manager.ui.mainCamera.transform.position - var_33_6.position).z)
				var_33_6.localEulerAngles.z = 0
				var_33_6.localEulerAngles.x = 0
				var_33_6.localEulerAngles = var_33_6.localEulerAngles
			end

			if 3 < arg_30_1.time_ and arg_30_1.time_ <= 3 + arg_33_0 then
				arg_30_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action2_1")
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				local var_33_8 = arg_30_1.bgs_.S0506:GetComponent("SpriteRenderer")

				if var_33_8 then
					arg_30_1.var_.alphaOldValueS0506 = var_33_8.color.a
					arg_30_1.var_.alphaMatValueS0506 = var_33_8
				end

				arg_30_1.var_.alphaOldValueS0506 = 1
			end

			local var_33_9 = 1.5

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_9 then
				if arg_30_1.var_.alphaMatValueS0506 then
					arg_30_1.var_.alphaMatValueS0506.color.a = Mathf.Lerp(arg_30_1.var_.alphaOldValueS0506, 0, (arg_30_1.time_ - 0) / var_33_9)
					arg_30_1.var_.alphaMatValueS0506.color = arg_30_1.var_.alphaMatValueS0506.color
				end
			end

			if arg_30_1.time_ >= 0 + var_33_9 and arg_30_1.time_ < 0 + var_33_9 + arg_33_0 and arg_30_1.var_.alphaMatValueS0506 then
				arg_30_1.var_.alphaMatValueS0506.color.a = 0
				arg_30_1.var_.alphaMatValueS0506.color = arg_30_1.var_.alphaMatValueS0506.color
			end

			local var_33_10 = "B04f"

			if arg_30_1.bgs_.B04f == nil then
				local var_33_11 = Object.Instantiate(arg_30_1.paintGo_)

				var_33_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_33_10)
				var_33_11.name = var_33_10
				var_33_11.transform.parent = arg_30_1.stage_.transform
				var_33_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.bgs_[var_33_10] = var_33_11
			end

			if 1.5 < arg_30_1.time_ and arg_30_1.time_ <= 1.5 + arg_33_0 then
				local var_33_12 = arg_30_1.bgs_.B04f:GetComponent("SpriteRenderer")

				if var_33_12 then
					arg_30_1.var_.alphaOldValueB04f = var_33_12.color.a
					arg_30_1.var_.alphaMatValueB04f = var_33_12
				end

				arg_30_1.var_.alphaOldValueB04f = 0
			end

			local var_33_13 = 1.5

			if 1.5 <= arg_30_1.time_ and arg_30_1.time_ < 1.5 + var_33_13 then
				if arg_30_1.var_.alphaMatValueB04f then
					arg_30_1.var_.alphaMatValueB04f.color.a = Mathf.Lerp(arg_30_1.var_.alphaOldValueB04f, 1, (arg_30_1.time_ - 1.5) / var_33_13)
					arg_30_1.var_.alphaMatValueB04f.color = arg_30_1.var_.alphaMatValueB04f.color
				end
			end

			if arg_30_1.time_ >= 1.5 + var_33_13 and arg_30_1.time_ < 1.5 + var_33_13 + arg_33_0 and arg_30_1.var_.alphaMatValueB04f then
				arg_30_1.var_.alphaMatValueB04f.color.a = 1
				arg_30_1.var_.alphaMatValueB04f.color = arg_30_1.var_.alphaMatValueB04f.color
			end

			if 1.5 < arg_30_1.time_ and arg_30_1.time_ <= 1.5 + arg_33_0 then
				local var_33_14 = arg_30_1.bgs_.B04f

				arg_30_1.bgs_.B04f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_33_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_33_15 = var_33_14:GetComponent("SpriteRenderer")

				if var_33_15 and var_33_15.sprite then
					local var_33_16 = 2 * (var_33_14.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_33_14.transform.localScale = Vector3.New(var_33_16 / var_33_15.sprite.bounds.size.y < var_33_16 * manager.ui.mainCameraCom_.aspect / var_33_15.sprite.bounds.size.x and var_33_16 * manager.ui.mainCameraCom_.aspect / var_33_15.sprite.bounds.size.x or var_33_16 / var_33_15.sprite.bounds.size.y, var_33_16 / var_33_15.sprite.bounds.size.y < var_33_16 * manager.ui.mainCameraCom_.aspect / var_33_15.sprite.bounds.size.x and var_33_16 * manager.ui.mainCameraCom_.aspect / var_33_15.sprite.bounds.size.x or var_33_16 / var_33_15.sprite.bounds.size.y, 0)
				end

				for iter_33_0, iter_33_1 in pairs(arg_30_1.bgs_) do
					if iter_33_0 ~= "B04f" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_33_17 = 0

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_17 + arg_33_0 then
				arg_30_1.allBtn_.enabled = false
			end

			if arg_30_1.time_ >= var_33_17 + 3 and arg_30_1.time_ < var_33_17 + 3 + arg_33_0 then
				arg_30_1.allBtn_.enabled = true
			end

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_33_18 = 3
			local var_33_19 = 0.325

			if 3 < arg_30_1.time_ and arg_30_1.time_ <= var_33_18 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_20 = arg_30_1:GetWordFromCfg(105031007)
				local var_33_21 = arg_30_1:FormatText(var_33_20.content)

				arg_30_1.text_.text = var_33_21

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_23 = 13 <= 0 and var_33_19 or var_33_19 * (utf8.len(var_33_21) / 13)

				if (13 <= 0 and var_33_19 or var_33_19 * (utf8.len(var_33_21) / 13)) > 0 and var_33_19 < var_33_23 then
					arg_30_1.talkMaxDuration = var_33_23

					if var_33_23 + var_33_18 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_23 + var_33_18
					end
				end

				arg_30_1.text_.text = var_33_21
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031007", "story_v_out_105031.awb") ~= 0 then
					local var_33_24 = manager.audio:GetVoiceLength("story_v_out_105031", "105031007", "story_v_out_105031.awb") / 1000

					if var_33_24 + var_33_18 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_24 + var_33_18
					end

					if var_33_20.prefab_name ~= "" and arg_30_1.actors_[var_33_20.prefab_name] ~= nil then
						local var_33_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_20.prefab_name].transform, "story_v_out_105031", "105031007", "story_v_out_105031.awb")

						arg_30_1:RecordAudio("105031007", var_33_25)
						arg_30_1:RecordAudio("105031007", var_33_25)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_105031", "105031007", "story_v_out_105031.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_105031", "105031007", "story_v_out_105031.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_26 = math.max(var_33_19, arg_30_1.talkMaxDuration)

			if var_33_18 <= arg_30_1.time_ and arg_30_1.time_ < var_33_18 + var_33_26 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_18) / var_33_26

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_18 + var_33_26 and arg_30_1.time_ < var_33_18 + var_33_26 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play105031008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 105031008
		arg_34_1.duration_ = 8.37

		local var_34_0 = {
			ja = 6.966,
			ko = 7.333,
			zh = 8.366,
			en = 7.1
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play105031009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if arg_34_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_37_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_34_1.stage_.transform)

				var_37_0.name = "1019ui_story"
				var_37_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.actors_["1019ui_story"] = var_37_0

				local var_37_1 = var_37_0:GetComponentInChildren(typeof(CharacterEffect))

				var_37_1.enabled = true

				local var_37_2 = GameObjectTools.GetOrAddComponent(var_37_0, typeof(DynamicBoneHelper))

				if var_37_2 then
					var_37_2:EnableDynamicBone(false)
				end

				arg_34_1:ShowWeapon(var_37_1.transform, false)

				arg_34_1.var_["1019ui_story" .. "Animator"] = var_37_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_34_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_34_1.var_["1019ui_story" .. "LipSync"] = var_37_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_37_3 = arg_34_1.actors_["1019ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_3) and arg_34_1.var_.characterEffect1019ui_story == nil then
				arg_34_1.var_.characterEffect1019ui_story = var_37_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_4 = 0.1

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 and not isNil(var_37_3) then
				if arg_34_1.var_.characterEffect1019ui_story and not isNil(var_37_3) then
					arg_34_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 and not isNil(var_37_3) and arg_34_1.var_.characterEffect1019ui_story then
				arg_34_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_37_6 = arg_34_1.actors_["1036ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_6) and arg_34_1.var_.characterEffect1036ui_story == nil then
				arg_34_1.var_.characterEffect1036ui_story = var_37_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_7 = 0.1

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_7 and not isNil(var_37_6) then
				if arg_34_1.var_.characterEffect1036ui_story and not isNil(var_37_6) then
					arg_34_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_34_1.time_ - 0) / var_37_7)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_7 and arg_34_1.time_ < 0 + var_37_7 + arg_37_0 and not isNil(var_37_6) and arg_34_1.var_.characterEffect1036ui_story then
				arg_34_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_37_8 = arg_34_1.actors_["1019ui_story"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1019ui_story = var_37_8.localPosition
			end

			local var_37_9 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_9 then
				var_37_8.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_34_1.time_ - 0) / var_37_9)
				var_37_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_8.position).x, (manager.ui.mainCamera.transform.position - var_37_8.position).y, (manager.ui.mainCamera.transform.position - var_37_8.position).z)
				var_37_8.localEulerAngles.z = 0
				var_37_8.localEulerAngles.x = 0
				var_37_8.localEulerAngles = var_37_8.localEulerAngles
			end

			if arg_34_1.time_ >= 0 + var_37_9 and arg_34_1.time_ < 0 + var_37_9 + arg_37_0 then
				var_37_8.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_37_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_37_8.position).x, (manager.ui.mainCamera.transform.position - var_37_8.position).y, (manager.ui.mainCamera.transform.position - var_37_8.position).z)
				var_37_8.localEulerAngles.z = 0
				var_37_8.localEulerAngles.x = 0
				var_37_8.localEulerAngles = var_37_8.localEulerAngles
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_37_10 = 0
			local var_37_11 = 0.975

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_10 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_12 = arg_34_1:GetWordFromCfg(105031008)
				local var_37_13 = arg_34_1:FormatText(var_37_12.content)

				arg_34_1.text_.text = var_37_13

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_15 = 39 <= 0 and var_37_11 or var_37_11 * (utf8.len(var_37_13) / 39)

				if (39 <= 0 and var_37_11 or var_37_11 * (utf8.len(var_37_13) / 39)) > 0 and var_37_11 < var_37_15 then
					arg_34_1.talkMaxDuration = var_37_15

					if var_37_15 + var_37_10 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_15 + var_37_10
					end
				end

				arg_34_1.text_.text = var_37_13
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031008", "story_v_out_105031.awb") ~= 0 then
					local var_37_16 = manager.audio:GetVoiceLength("story_v_out_105031", "105031008", "story_v_out_105031.awb") / 1000

					if var_37_16 + var_37_10 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_16 + var_37_10
					end

					if var_37_12.prefab_name ~= "" and arg_34_1.actors_[var_37_12.prefab_name] ~= nil then
						local var_37_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_12.prefab_name].transform, "story_v_out_105031", "105031008", "story_v_out_105031.awb")

						arg_34_1:RecordAudio("105031008", var_37_17)
						arg_34_1:RecordAudio("105031008", var_37_17)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_105031", "105031008", "story_v_out_105031.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_105031", "105031008", "story_v_out_105031.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_18 = math.max(var_37_11, arg_34_1.talkMaxDuration)

			if var_37_10 <= arg_34_1.time_ and arg_34_1.time_ < var_37_10 + var_37_18 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_10) / var_37_18

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_10 + var_37_18 and arg_34_1.time_ < var_37_10 + var_37_18 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
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

		arg_34_1:InitPlayNodeList()
	end,
	Play105031009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 105031009
		arg_38_1.duration_ = 5.03

		local var_38_0 = {
			ja = 5,
			ko = 5,
			zh = 4.933,
			en = 5.033
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
				arg_38_0:Play105031010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["1036ui_story"]) and arg_38_1.var_.characterEffect1036ui_story == nil then
				arg_38_1.var_.characterEffect1036ui_story = arg_38_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.1

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["1036ui_story"]) then
				if arg_38_1.var_.characterEffect1036ui_story and not isNil(arg_38_1.actors_["1036ui_story"]) then
					arg_38_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["1036ui_story"]) and arg_38_1.var_.characterEffect1036ui_story then
				arg_38_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_41_2 = arg_38_1.actors_["1019ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.characterEffect1019ui_story == nil then
				arg_38_1.var_.characterEffect1019ui_story = var_41_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_3 = 0.1

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_3 and not isNil(var_41_2) then
				if arg_38_1.var_.characterEffect1019ui_story and not isNil(var_41_2) then
					arg_38_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_3)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_3 and arg_38_1.time_ < 0 + var_41_3 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.characterEffect1019ui_story then
				arg_38_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_41_4 = 0
			local var_41_5 = 0.625

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_6 = arg_38_1:GetWordFromCfg(105031009)
				local var_41_7 = arg_38_1:FormatText(var_41_6.content)

				arg_38_1.text_.text = var_41_7

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_9 = 25 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 25)

				if (25 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 25)) > 0 and var_41_5 < var_41_9 then
					arg_38_1.talkMaxDuration = var_41_9

					if var_41_9 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_4
					end
				end

				arg_38_1.text_.text = var_41_7
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031009", "story_v_out_105031.awb") ~= 0 then
					local var_41_10 = manager.audio:GetVoiceLength("story_v_out_105031", "105031009", "story_v_out_105031.awb") / 1000

					if var_41_10 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_4
					end

					if var_41_6.prefab_name ~= "" and arg_38_1.actors_[var_41_6.prefab_name] ~= nil then
						local var_41_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_6.prefab_name].transform, "story_v_out_105031", "105031009", "story_v_out_105031.awb")

						arg_38_1:RecordAudio("105031009", var_41_11)
						arg_38_1:RecordAudio("105031009", var_41_11)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_105031", "105031009", "story_v_out_105031.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_105031", "105031009", "story_v_out_105031.awb")
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
	Play105031010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 105031010
		arg_42_1.duration_ = 10.9

		local var_42_0 = {
			ja = 5.5,
			ko = 8,
			zh = 8.633,
			en = 10.9
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
				arg_42_0:Play105031011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if arg_42_1.actors_["10001_tpose"] == nil and not isNil((Asset.Load("Char/" .. "10001_tpose"))) then
				local var_45_0 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_42_1.stage_.transform)

				var_45_0.name = "10001_tpose"
				var_45_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_42_1.actors_["10001_tpose"] = var_45_0

				local var_45_1 = var_45_0:GetComponentInChildren(typeof(CharacterEffect))

				var_45_1.enabled = true

				local var_45_2 = GameObjectTools.GetOrAddComponent(var_45_0, typeof(DynamicBoneHelper))

				if var_45_2 then
					var_45_2:EnableDynamicBone(false)
				end

				arg_42_1:ShowWeapon(var_45_1.transform, false)

				arg_42_1.var_["10001_tpose" .. "Animator"] = var_45_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_42_1.var_["10001_tpose" .. "Animator"].applyRootMotion = true
				arg_42_1.var_["10001_tpose" .. "LipSync"] = var_45_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_45_3 = arg_42_1.actors_["10001_tpose"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_3) and arg_42_1.var_.characterEffect10001_tpose == nil then
				arg_42_1.var_.characterEffect10001_tpose = var_45_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_4 = 0.1

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 and not isNil(var_45_3) then
				if arg_42_1.var_.characterEffect10001_tpose and not isNil(var_45_3) then
					arg_42_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 and not isNil(var_45_3) and arg_42_1.var_.characterEffect10001_tpose then
				arg_42_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_45_6 = arg_42_1.actors_["1036ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_6) and arg_42_1.var_.characterEffect1036ui_story == nil then
				arg_42_1.var_.characterEffect1036ui_story = var_45_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_7 = 0.1

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 and not isNil(var_45_6) then
				if arg_42_1.var_.characterEffect1036ui_story and not isNil(var_45_6) then
					arg_42_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_7)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 and not isNil(var_45_6) and arg_42_1.var_.characterEffect1036ui_story then
				arg_42_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_45_8 = arg_42_1.actors_["1036ui_story"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos1036ui_story = var_45_8.localPosition
			end

			local var_45_9 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_9 then
				var_45_8.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_42_1.time_ - 0) / var_45_9)
				var_45_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_8.position).x, (manager.ui.mainCamera.transform.position - var_45_8.position).y, (manager.ui.mainCamera.transform.position - var_45_8.position).z)
				var_45_8.localEulerAngles.z = 0
				var_45_8.localEulerAngles.x = 0
				var_45_8.localEulerAngles = var_45_8.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_9 and arg_42_1.time_ < 0 + var_45_9 + arg_45_0 then
				var_45_8.localPosition = Vector3.New(0, 100, 0)
				var_45_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_8.position).x, (manager.ui.mainCamera.transform.position - var_45_8.position).y, (manager.ui.mainCamera.transform.position - var_45_8.position).z)
				var_45_8.localEulerAngles.z = 0
				var_45_8.localEulerAngles.x = 0
				var_45_8.localEulerAngles = var_45_8.localEulerAngles
			end

			local var_45_10 = arg_42_1.actors_["1019ui_story"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos1019ui_story = var_45_10.localPosition
			end

			local var_45_11 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_11 then
				var_45_10.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_42_1.time_ - 0) / var_45_11)
				var_45_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_10.position).x, (manager.ui.mainCamera.transform.position - var_45_10.position).y, (manager.ui.mainCamera.transform.position - var_45_10.position).z)
				var_45_10.localEulerAngles.z = 0
				var_45_10.localEulerAngles.x = 0
				var_45_10.localEulerAngles = var_45_10.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_11 and arg_42_1.time_ < 0 + var_45_11 + arg_45_0 then
				var_45_10.localPosition = Vector3.New(0, 100, 0)
				var_45_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_10.position).x, (manager.ui.mainCamera.transform.position - var_45_10.position).y, (manager.ui.mainCamera.transform.position - var_45_10.position).z)
				var_45_10.localEulerAngles.z = 0
				var_45_10.localEulerAngles.x = 0
				var_45_10.localEulerAngles = var_45_10.localEulerAngles
			end

			local var_45_12 = arg_42_1.actors_["10001_tpose"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos10001_tpose = var_45_12.localPosition

				local var_45_13 = GameObjectTools.GetOrAddComponent(var_45_12.gameObject, typeof(DynamicBoneHelper))

				if var_45_13 then
					var_45_13:EnableDynamicBone(false)
				end
			end

			local var_45_14 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_14 then
				var_45_12.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10001_tpose, Vector3.New(0, -1.23, -5.8), (arg_42_1.time_ - 0) / var_45_14)
				var_45_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_12.position).x, (manager.ui.mainCamera.transform.position - var_45_12.position).y, (manager.ui.mainCamera.transform.position - var_45_12.position).z)
				var_45_12.localEulerAngles.z = 0
				var_45_12.localEulerAngles.x = 0
				var_45_12.localEulerAngles = var_45_12.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_14 and arg_42_1.time_ < 0 + var_45_14 + arg_45_0 then
				var_45_12.localPosition = Vector3.New(0, -1.23, -5.8)
				var_45_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_12.position).x, (manager.ui.mainCamera.transform.position - var_45_12.position).y, (manager.ui.mainCamera.transform.position - var_45_12.position).z)
				var_45_12.localEulerAngles.z = 0
				var_45_12.localEulerAngles.x = 0
				var_45_12.localEulerAngles = var_45_12.localEulerAngles

				local var_45_15 = GameObjectTools.GetOrAddComponent(var_45_12.gameObject, typeof(DynamicBoneHelper))

				if var_45_15 then
					var_45_15:EnableDynamicBone(true)
				end
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action4_1")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_45_16 = 0
			local var_45_17 = 1.05

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_16 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_18 = arg_42_1:GetWordFromCfg(105031010)
				local var_45_19 = arg_42_1:FormatText(var_45_18.content)

				arg_42_1.text_.text = var_45_19

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_21 = 42 <= 0 and var_45_17 or var_45_17 * (utf8.len(var_45_19) / 42)

				if (42 <= 0 and var_45_17 or var_45_17 * (utf8.len(var_45_19) / 42)) > 0 and var_45_17 < var_45_21 then
					arg_42_1.talkMaxDuration = var_45_21

					if var_45_21 + var_45_16 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_21 + var_45_16
					end
				end

				arg_42_1.text_.text = var_45_19
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031010", "story_v_out_105031.awb") ~= 0 then
					local var_45_22 = manager.audio:GetVoiceLength("story_v_out_105031", "105031010", "story_v_out_105031.awb") / 1000

					if var_45_22 + var_45_16 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_22 + var_45_16
					end

					if var_45_18.prefab_name ~= "" and arg_42_1.actors_[var_45_18.prefab_name] ~= nil then
						local var_45_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_18.prefab_name].transform, "story_v_out_105031", "105031010", "story_v_out_105031.awb")

						arg_42_1:RecordAudio("105031010", var_45_23)
						arg_42_1:RecordAudio("105031010", var_45_23)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_105031", "105031010", "story_v_out_105031.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_105031", "105031010", "story_v_out_105031.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_24 = math.max(var_45_17, arg_42_1.talkMaxDuration)

			if var_45_16 <= arg_42_1.time_ and arg_42_1.time_ < var_45_16 + var_45_24 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_16) / var_45_24

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_16 + var_45_24 and arg_42_1.time_ < var_45_16 + var_45_24 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
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

		arg_42_1:InitPlayNodeList()
	end,
	Play105031011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 105031011
		arg_46_1.duration_ = 4.57

		local var_46_0 = {
			ja = 4.5,
			ko = 4.466,
			zh = 3.7,
			en = 4.566
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
				arg_46_0:Play105031012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_49_0 = 0
			local var_49_1 = 0.475

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_2 = arg_46_1:GetWordFromCfg(105031011)
				local var_49_3 = arg_46_1:FormatText(var_49_2.content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 19 <= 0 and var_49_1 or var_49_1 * (utf8.len(var_49_3) / 19)

				if (19 <= 0 and var_49_1 or var_49_1 * (utf8.len(var_49_3) / 19)) > 0 and var_49_1 < var_49_5 then
					arg_46_1.talkMaxDuration = var_49_5

					if var_49_5 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + var_49_0
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031011", "story_v_out_105031.awb") ~= 0 then
					local var_49_6 = manager.audio:GetVoiceLength("story_v_out_105031", "105031011", "story_v_out_105031.awb") / 1000

					if var_49_6 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_6 + var_49_0
					end

					if var_49_2.prefab_name ~= "" and arg_46_1.actors_[var_49_2.prefab_name] ~= nil then
						local var_49_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_2.prefab_name].transform, "story_v_out_105031", "105031011", "story_v_out_105031.awb")

						arg_46_1:RecordAudio("105031011", var_49_7)
						arg_46_1:RecordAudio("105031011", var_49_7)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_105031", "105031011", "story_v_out_105031.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_105031", "105031011", "story_v_out_105031.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_8 = math.max(var_49_1, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_8 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_0) / var_49_8

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_8 and arg_46_1.time_ < var_49_0 + var_49_8 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play105031012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 105031012
		arg_50_1.duration_ = 2.1

		local var_50_0 = {
			ja = 2.1,
			ko = 1.1,
			zh = 1.333,
			en = 1
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
				arg_50_0:Play105031013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["1019ui_story"]) and arg_50_1.var_.characterEffect1019ui_story == nil then
				arg_50_1.var_.characterEffect1019ui_story = arg_50_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.1

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["1019ui_story"]) then
				if arg_50_1.var_.characterEffect1019ui_story and not isNil(arg_50_1.actors_["1019ui_story"]) then
					arg_50_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["1019ui_story"]) and arg_50_1.var_.characterEffect1019ui_story then
				arg_50_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_53_2 = arg_50_1.actors_["10001_tpose"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect10001_tpose == nil then
				arg_50_1.var_.characterEffect10001_tpose = var_53_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_3 = 0.1

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_3 and not isNil(var_53_2) then
				if arg_50_1.var_.characterEffect10001_tpose and not isNil(var_53_2) then
					arg_50_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_50_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_3)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_3 and arg_50_1.time_ < 0 + var_53_3 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect10001_tpose then
				arg_50_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_50_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_53_4 = arg_50_1.actors_["10001_tpose"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos10001_tpose = var_53_4.localPosition

				local var_53_5 = GameObjectTools.GetOrAddComponent(var_53_4.gameObject, typeof(DynamicBoneHelper))

				if var_53_5 then
					var_53_5:EnableDynamicBone(false)
				end
			end

			local var_53_6 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_6 then
				var_53_4.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_50_1.time_ - 0) / var_53_6)
				var_53_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_4.position).x, (manager.ui.mainCamera.transform.position - var_53_4.position).y, (manager.ui.mainCamera.transform.position - var_53_4.position).z)
				var_53_4.localEulerAngles.z = 0
				var_53_4.localEulerAngles.x = 0
				var_53_4.localEulerAngles = var_53_4.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_6 and arg_50_1.time_ < 0 + var_53_6 + arg_53_0 then
				var_53_4.localPosition = Vector3.New(0, 100, 0)
				var_53_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_4.position).x, (manager.ui.mainCamera.transform.position - var_53_4.position).y, (manager.ui.mainCamera.transform.position - var_53_4.position).z)
				var_53_4.localEulerAngles.z = 0
				var_53_4.localEulerAngles.x = 0
				var_53_4.localEulerAngles = var_53_4.localEulerAngles

				local var_53_7 = GameObjectTools.GetOrAddComponent(var_53_4.gameObject, typeof(DynamicBoneHelper))

				if var_53_7 then
					var_53_7:EnableDynamicBone(true)
				end
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_53_8 = 0
			local var_53_9 = 0.075

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_8 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_10 = arg_50_1:GetWordFromCfg(105031012)
				local var_53_11 = arg_50_1:FormatText(var_53_10.content)

				arg_50_1.text_.text = var_53_11

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_13 = 3 <= 0 and var_53_9 or var_53_9 * (utf8.len(var_53_11) / 3)

				if (3 <= 0 and var_53_9 or var_53_9 * (utf8.len(var_53_11) / 3)) > 0 and var_53_9 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_8 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_8
					end
				end

				arg_50_1.text_.text = var_53_11
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031012", "story_v_out_105031.awb") ~= 0 then
					local var_53_14 = manager.audio:GetVoiceLength("story_v_out_105031", "105031012", "story_v_out_105031.awb") / 1000

					if var_53_14 + var_53_8 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_8
					end

					if var_53_10.prefab_name ~= "" and arg_50_1.actors_[var_53_10.prefab_name] ~= nil then
						local var_53_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_10.prefab_name].transform, "story_v_out_105031", "105031012", "story_v_out_105031.awb")

						arg_50_1:RecordAudio("105031012", var_53_15)
						arg_50_1:RecordAudio("105031012", var_53_15)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_105031", "105031012", "story_v_out_105031.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_105031", "105031012", "story_v_out_105031.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_16 = math.max(var_53_9, arg_50_1.talkMaxDuration)

			if var_53_8 <= arg_50_1.time_ and arg_50_1.time_ < var_53_8 + var_53_16 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_8) / var_53_16

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_8 + var_53_16 and arg_50_1.time_ < var_53_8 + var_53_16 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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

		arg_50_1:InitPlayNodeList()
	end,
	Play105031013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 105031013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play105031014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1019ui_story"]) and arg_54_1.var_.characterEffect1019ui_story == nil then
				arg_54_1.var_.characterEffect1019ui_story = arg_54_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.1

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1019ui_story"]) then
				if arg_54_1.var_.characterEffect1019ui_story and not isNil(arg_54_1.actors_["1019ui_story"]) then
					arg_54_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_0)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1019ui_story"]) and arg_54_1.var_.characterEffect1019ui_story then
				arg_54_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_57_1 = 0
			local var_57_2 = 0.575

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_3 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(105031013).content)

				arg_54_1.text_.text = var_57_3

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_5 = 23 <= 0 and var_57_2 or var_57_2 * (utf8.len(var_57_3) / 23)

				if (23 <= 0 and var_57_2 or var_57_2 * (utf8.len(var_57_3) / 23)) > 0 and var_57_2 < var_57_5 then
					arg_54_1.talkMaxDuration = var_57_5

					if var_57_5 + var_57_1 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + var_57_1
					end
				end

				arg_54_1.text_.text = var_57_3
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_6 = math.max(var_57_2, arg_54_1.talkMaxDuration)

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_6 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_1) / var_57_6

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_1 + var_57_6 and arg_54_1.time_ < var_57_1 + var_57_6 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play105031014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 105031014
		arg_58_1.duration_ = 8.37

		local var_58_0 = {
			ja = 6.266,
			ko = 8.366,
			zh = 5.8,
			en = 6.233
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
				arg_58_0:Play105031015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0.8

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_1 = arg_58_1:GetWordFromCfg(105031014)
				local var_61_2 = arg_58_1:FormatText(var_61_1.content)

				arg_58_1.text_.text = var_61_2

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_4 = 32 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 32)

				if (32 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_2) / 32)) > 0 and var_61_0 < var_61_4 then
					arg_58_1.talkMaxDuration = var_61_4

					if var_61_4 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_4 + 0
					end
				end

				arg_58_1.text_.text = var_61_2
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031014", "story_v_out_105031.awb") ~= 0 then
					local var_61_5 = manager.audio:GetVoiceLength("story_v_out_105031", "105031014", "story_v_out_105031.awb") / 1000

					if var_61_5 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_5 + 0
					end

					if var_61_1.prefab_name ~= "" and arg_58_1.actors_[var_61_1.prefab_name] ~= nil then
						local var_61_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_1.prefab_name].transform, "story_v_out_105031", "105031014", "story_v_out_105031.awb")

						arg_58_1:RecordAudio("105031014", var_61_6)
						arg_58_1:RecordAudio("105031014", var_61_6)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_105031", "105031014", "story_v_out_105031.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_105031", "105031014", "story_v_out_105031.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_7 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_7

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play105031015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 105031015
		arg_62_1.duration_ = 8.73

		local var_62_0 = {
			ja = 8.733,
			ko = 6.733,
			zh = 5.966,
			en = 6.366
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
				arg_62_0:Play105031016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.825

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_1 = arg_62_1:GetWordFromCfg(105031015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 33 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 33)

				if (33 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 33)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031015", "story_v_out_105031.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_105031", "105031015", "story_v_out_105031.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_105031", "105031015", "story_v_out_105031.awb")

						arg_62_1:RecordAudio("105031015", var_65_6)
						arg_62_1:RecordAudio("105031015", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_105031", "105031015", "story_v_out_105031.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_105031", "105031015", "story_v_out_105031.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play105031016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 105031016
		arg_66_1.duration_ = 2

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play105031017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1019ui_story"]) and arg_66_1.var_.characterEffect1019ui_story == nil then
				arg_66_1.var_.characterEffect1019ui_story = arg_66_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1019ui_story"]) then
				if arg_66_1.var_.characterEffect1019ui_story and not isNil(arg_66_1.actors_["1019ui_story"]) then
					arg_66_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1019ui_story"]) and arg_66_1.var_.characterEffect1019ui_story then
				arg_66_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_69_2 = arg_66_1.actors_["1019ui_story"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos1019ui_story = var_69_2.localPosition
			end

			local var_69_3 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_3 then
				var_69_2.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_66_1.time_ - 0) / var_69_3)
				var_69_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_2.position).x, (manager.ui.mainCamera.transform.position - var_69_2.position).y, (manager.ui.mainCamera.transform.position - var_69_2.position).z)
				var_69_2.localEulerAngles.z = 0
				var_69_2.localEulerAngles.x = 0
				var_69_2.localEulerAngles = var_69_2.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_3 and arg_66_1.time_ < 0 + var_69_3 + arg_69_0 then
				var_69_2.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_69_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_2.position).x, (manager.ui.mainCamera.transform.position - var_69_2.position).y, (manager.ui.mainCamera.transform.position - var_69_2.position).z)
				var_69_2.localEulerAngles.z = 0
				var_69_2.localEulerAngles.x = 0
				var_69_2.localEulerAngles = var_69_2.localEulerAngles
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action4_1")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_69_4 = 0
			local var_69_5 = 0.075

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_6 = arg_66_1:GetWordFromCfg(105031016)
				local var_69_7 = arg_66_1:FormatText(var_69_6.content)

				arg_66_1.text_.text = var_69_7

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_9 = 3 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 3)

				if (3 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 3)) > 0 and var_69_5 < var_69_9 then
					arg_66_1.talkMaxDuration = var_69_9

					if var_69_9 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_4
					end
				end

				arg_66_1.text_.text = var_69_7
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031016", "story_v_out_105031.awb") ~= 0 then
					local var_69_10 = manager.audio:GetVoiceLength("story_v_out_105031", "105031016", "story_v_out_105031.awb") / 1000

					if var_69_10 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_10 + var_69_4
					end

					if var_69_6.prefab_name ~= "" and arg_66_1.actors_[var_69_6.prefab_name] ~= nil then
						local var_69_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_6.prefab_name].transform, "story_v_out_105031", "105031016", "story_v_out_105031.awb")

						arg_66_1:RecordAudio("105031016", var_69_11)
						arg_66_1:RecordAudio("105031016", var_69_11)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_105031", "105031016", "story_v_out_105031.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_105031", "105031016", "story_v_out_105031.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_12 = math.max(var_69_5, arg_66_1.talkMaxDuration)

			if var_69_4 <= arg_66_1.time_ and arg_66_1.time_ < var_69_4 + var_69_12 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_4) / var_69_12

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_4 + var_69_12 and arg_66_1.time_ < var_69_4 + var_69_12 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
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

		arg_66_1:InitPlayNodeList()
	end,
	Play105031017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 105031017
		arg_70_1.duration_ = 2

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play105031018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if arg_70_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_73_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_70_1.stage_.transform)

				var_73_0.name = "1011ui_story"
				var_73_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.actors_["1011ui_story"] = var_73_0

				local var_73_1 = var_73_0:GetComponentInChildren(typeof(CharacterEffect))

				var_73_1.enabled = true

				local var_73_2 = GameObjectTools.GetOrAddComponent(var_73_0, typeof(DynamicBoneHelper))

				if var_73_2 then
					var_73_2:EnableDynamicBone(false)
				end

				arg_70_1:ShowWeapon(var_73_1.transform, false)

				arg_70_1.var_["1011ui_story" .. "Animator"] = var_73_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_70_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_70_1.var_["1011ui_story" .. "LipSync"] = var_73_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_73_3 = arg_70_1.actors_["1011ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_3) and arg_70_1.var_.characterEffect1011ui_story == nil then
				arg_70_1.var_.characterEffect1011ui_story = var_73_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_4 = 0.1

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 and not isNil(var_73_3) then
				if arg_70_1.var_.characterEffect1011ui_story and not isNil(var_73_3) then
					arg_70_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 and not isNil(var_73_3) and arg_70_1.var_.characterEffect1011ui_story then
				arg_70_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_73_6 = arg_70_1.actors_["1019ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_6) and arg_70_1.var_.characterEffect1019ui_story == nil then
				arg_70_1.var_.characterEffect1019ui_story = var_73_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_7 = 0.1

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 and not isNil(var_73_6) then
				if arg_70_1.var_.characterEffect1019ui_story and not isNil(var_73_6) then
					arg_70_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_7)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 and not isNil(var_73_6) and arg_70_1.var_.characterEffect1019ui_story then
				arg_70_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_73_8 = arg_70_1.actors_["1011ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1011ui_story = var_73_8.localPosition
			end

			local var_73_9 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_9 then
				var_73_8.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_70_1.time_ - 0) / var_73_9)
				var_73_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_8.position).x, (manager.ui.mainCamera.transform.position - var_73_8.position).y, (manager.ui.mainCamera.transform.position - var_73_8.position).z)
				var_73_8.localEulerAngles.z = 0
				var_73_8.localEulerAngles.x = 0
				var_73_8.localEulerAngles = var_73_8.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_9 and arg_70_1.time_ < 0 + var_73_9 + arg_73_0 then
				var_73_8.localPosition = Vector3.New(0.7, -0.71, -6)
				var_73_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_8.position).x, (manager.ui.mainCamera.transform.position - var_73_8.position).y, (manager.ui.mainCamera.transform.position - var_73_8.position).z)
				var_73_8.localEulerAngles.z = 0
				var_73_8.localEulerAngles.x = 0
				var_73_8.localEulerAngles = var_73_8.localEulerAngles
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_73_10 = 0
			local var_73_11 = 0.125

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_12 = arg_70_1:GetWordFromCfg(105031017)
				local var_73_13 = arg_70_1:FormatText(var_73_12.content)

				arg_70_1.text_.text = var_73_13

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_15 = 5 <= 0 and var_73_11 or var_73_11 * (utf8.len(var_73_13) / 5)

				if (5 <= 0 and var_73_11 or var_73_11 * (utf8.len(var_73_13) / 5)) > 0 and var_73_11 < var_73_15 then
					arg_70_1.talkMaxDuration = var_73_15

					if var_73_15 + var_73_10 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_15 + var_73_10
					end
				end

				arg_70_1.text_.text = var_73_13
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031017", "story_v_out_105031.awb") ~= 0 then
					local var_73_16 = manager.audio:GetVoiceLength("story_v_out_105031", "105031017", "story_v_out_105031.awb") / 1000

					if var_73_16 + var_73_10 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_16 + var_73_10
					end

					if var_73_12.prefab_name ~= "" and arg_70_1.actors_[var_73_12.prefab_name] ~= nil then
						local var_73_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_12.prefab_name].transform, "story_v_out_105031", "105031017", "story_v_out_105031.awb")

						arg_70_1:RecordAudio("105031017", var_73_17)
						arg_70_1:RecordAudio("105031017", var_73_17)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_105031", "105031017", "story_v_out_105031.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_105031", "105031017", "story_v_out_105031.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_18 = math.max(var_73_11, arg_70_1.talkMaxDuration)

			if var_73_10 <= arg_70_1.time_ and arg_70_1.time_ < var_73_10 + var_73_18 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_10) / var_73_18

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_10 + var_73_18 and arg_70_1.time_ < var_73_10 + var_73_18 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play105031018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 105031018
		arg_74_1.duration_ = 4.07

		local var_74_0 = {
			ja = 3.466,
			ko = 2.933,
			zh = 4.066,
			en = 2.766
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
				arg_74_0:Play105031019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1011ui_story"]) and arg_74_1.var_.characterEffect1011ui_story == nil then
				arg_74_1.var_.characterEffect1011ui_story = arg_74_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.1

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1011ui_story"]) then
				if arg_74_1.var_.characterEffect1011ui_story and not isNil(arg_74_1.actors_["1011ui_story"]) then
					arg_74_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_0)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1011ui_story"]) and arg_74_1.var_.characterEffect1011ui_story then
				arg_74_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_77_1 = arg_74_1.actors_["1019ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1019ui_story = var_77_1.localPosition
			end

			local var_77_2 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_2 then
				var_77_1.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_74_1.time_ - 0) / var_77_2)
				var_77_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_1.position).x, (manager.ui.mainCamera.transform.position - var_77_1.position).y, (manager.ui.mainCamera.transform.position - var_77_1.position).z)
				var_77_1.localEulerAngles.z = 0
				var_77_1.localEulerAngles.x = 0
				var_77_1.localEulerAngles = var_77_1.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_2 and arg_74_1.time_ < 0 + var_77_2 + arg_77_0 then
				var_77_1.localPosition = Vector3.New(0, 100, 0)
				var_77_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_1.position).x, (manager.ui.mainCamera.transform.position - var_77_1.position).y, (manager.ui.mainCamera.transform.position - var_77_1.position).z)
				var_77_1.localEulerAngles.z = 0
				var_77_1.localEulerAngles.x = 0
				var_77_1.localEulerAngles = var_77_1.localEulerAngles
			end

			local var_77_3 = arg_74_1.actors_["1011ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1011ui_story = var_77_3.localPosition
			end

			local var_77_4 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				var_77_3.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_74_1.time_ - 0) / var_77_4)
				var_77_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_3.position).x, (manager.ui.mainCamera.transform.position - var_77_3.position).y, (manager.ui.mainCamera.transform.position - var_77_3.position).z)
				var_77_3.localEulerAngles.z = 0
				var_77_3.localEulerAngles.x = 0
				var_77_3.localEulerAngles = var_77_3.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
				var_77_3.localPosition = Vector3.New(0, 100, 0)
				var_77_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_3.position).x, (manager.ui.mainCamera.transform.position - var_77_3.position).y, (manager.ui.mainCamera.transform.position - var_77_3.position).z)
				var_77_3.localEulerAngles.z = 0
				var_77_3.localEulerAngles.x = 0
				var_77_3.localEulerAngles = var_77_3.localEulerAngles
			end

			local var_77_5 = 0
			local var_77_6 = 0.3

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Noviher")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_7 = arg_74_1:GetWordFromCfg(105031018)
				local var_77_8 = arg_74_1:FormatText(var_77_7.content)

				arg_74_1.text_.text = var_77_8

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_10 = 12 <= 0 and var_77_6 or var_77_6 * (utf8.len(var_77_8) / 12)

				if (12 <= 0 and var_77_6 or var_77_6 * (utf8.len(var_77_8) / 12)) > 0 and var_77_6 < var_77_10 then
					arg_74_1.talkMaxDuration = var_77_10

					if var_77_10 + var_77_5 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_5
					end
				end

				arg_74_1.text_.text = var_77_8
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031018", "story_v_out_105031.awb") ~= 0 then
					local var_77_11 = manager.audio:GetVoiceLength("story_v_out_105031", "105031018", "story_v_out_105031.awb") / 1000

					if var_77_11 + var_77_5 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_11 + var_77_5
					end

					if var_77_7.prefab_name ~= "" and arg_74_1.actors_[var_77_7.prefab_name] ~= nil then
						local var_77_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_7.prefab_name].transform, "story_v_out_105031", "105031018", "story_v_out_105031.awb")

						arg_74_1:RecordAudio("105031018", var_77_12)
						arg_74_1:RecordAudio("105031018", var_77_12)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_105031", "105031018", "story_v_out_105031.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_105031", "105031018", "story_v_out_105031.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_13 = math.max(var_77_6, arg_74_1.talkMaxDuration)

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_13 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_5) / var_77_13

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_5 + var_77_13 and arg_74_1.time_ < var_77_5 + var_77_13 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play105031019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 105031019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play105031020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.shakeOldPosMainCamera = manager.ui.mainCamera.transform.localPosition
			end

			local var_81_0 = 0.600000023841858

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 then
				local var_81_1, var_81_2 = math.modf((arg_78_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_81_2 * 0.13, var_81_2 * 0.13, var_81_2 * 0.13) + arg_78_1.var_.shakeOldPosMainCamera
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 then
				manager.ui.mainCamera.transform.localPosition = arg_78_1.var_.shakeOldPosMainCamera
			end

			local var_81_3 = 0
			local var_81_4 = 0.7

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

				local var_81_5 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(105031019).content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 28 <= 0 and var_81_4 or var_81_4 * (utf8.len(var_81_5) / 28)

				if (28 <= 0 and var_81_4 or var_81_4 * (utf8.len(var_81_5) / 28)) > 0 and var_81_4 < var_81_7 then
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

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play105031020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 105031020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play105031021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 1.425

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_1 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(105031020).content)

				arg_82_1.text_.text = var_85_1

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_3 = 57 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 57)

				if (57 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 57)) > 0 and var_85_0 < var_85_3 then
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
	Play105031021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 105031021
		arg_86_1.duration_ = 3.67

		local var_86_0 = {
			ja = 3.666,
			ko = 1.866,
			zh = 1.933,
			en = 1.833
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
				arg_86_0:Play105031022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.15

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_1 = arg_86_1:GetWordFromCfg(105031021)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 6 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 6)

				if (6 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 6)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031021", "story_v_out_105031.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_105031", "105031021", "story_v_out_105031.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_105031", "105031021", "story_v_out_105031.awb")

						arg_86_1:RecordAudio("105031021", var_89_6)
						arg_86_1:RecordAudio("105031021", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_105031", "105031021", "story_v_out_105031.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_105031", "105031021", "story_v_out_105031.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play105031022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 105031022
		arg_90_1.duration_ = 2.77

		local var_90_0 = {
			ja = 2.766,
			ko = 2.133,
			zh = 1.999999999999,
			en = 1.999999999999
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
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play105031023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if arg_90_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_93_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_90_1.stage_.transform)

				var_93_0.name = "1084ui_story"
				var_93_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_90_1.actors_["1084ui_story"] = var_93_0

				local var_93_1 = var_93_0:GetComponentInChildren(typeof(CharacterEffect))

				var_93_1.enabled = true

				local var_93_2 = GameObjectTools.GetOrAddComponent(var_93_0, typeof(DynamicBoneHelper))

				if var_93_2 then
					var_93_2:EnableDynamicBone(false)
				end

				arg_90_1:ShowWeapon(var_93_1.transform, false)

				arg_90_1.var_["1084ui_story" .. "Animator"] = var_93_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_90_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_90_1.var_["1084ui_story" .. "LipSync"] = var_93_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_93_3 = arg_90_1.actors_["1084ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_3) and arg_90_1.var_.characterEffect1084ui_story == nil then
				arg_90_1.var_.characterEffect1084ui_story = var_93_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_4 = 0.1

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 and not isNil(var_93_3) then
				if arg_90_1.var_.characterEffect1084ui_story and not isNil(var_93_3) then
					arg_90_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 and not isNil(var_93_3) and arg_90_1.var_.characterEffect1084ui_story then
				arg_90_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_93_6 = arg_90_1.actors_["1084ui_story"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1084ui_story = var_93_6.localPosition

				arg_90_1:ShowWeapon(arg_90_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_93_7 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				var_93_6.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_90_1.time_ - 0) / var_93_7)
				var_93_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_6.position).x, (manager.ui.mainCamera.transform.position - var_93_6.position).y, (manager.ui.mainCamera.transform.position - var_93_6.position).z)
				var_93_6.localEulerAngles.z = 0
				var_93_6.localEulerAngles.x = 0
				var_93_6.localEulerAngles = var_93_6.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				var_93_6.localPosition = Vector3.New(0, -0.97, -6)
				var_93_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_6.position).x, (manager.ui.mainCamera.transform.position - var_93_6.position).y, (manager.ui.mainCamera.transform.position - var_93_6.position).z)
				var_93_6.localEulerAngles.z = 0
				var_93_6.localEulerAngles.x = 0
				var_93_6.localEulerAngles = var_93_6.localEulerAngles
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_93_8 = 0
			local var_93_9 = 0.125

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_8 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_10 = arg_90_1:GetWordFromCfg(105031022)
				local var_93_11 = arg_90_1:FormatText(var_93_10.content)

				arg_90_1.text_.text = var_93_11

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_13 = 5 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_11) / 5)

				if (5 <= 0 and var_93_9 or var_93_9 * (utf8.len(var_93_11) / 5)) > 0 and var_93_9 < var_93_13 then
					arg_90_1.talkMaxDuration = var_93_13

					if var_93_13 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_13 + var_93_8
					end
				end

				arg_90_1.text_.text = var_93_11
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031022", "story_v_out_105031.awb") ~= 0 then
					local var_93_14 = manager.audio:GetVoiceLength("story_v_out_105031", "105031022", "story_v_out_105031.awb") / 1000

					if var_93_14 + var_93_8 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_14 + var_93_8
					end

					if var_93_10.prefab_name ~= "" and arg_90_1.actors_[var_93_10.prefab_name] ~= nil then
						local var_93_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_10.prefab_name].transform, "story_v_out_105031", "105031022", "story_v_out_105031.awb")

						arg_90_1:RecordAudio("105031022", var_93_15)
						arg_90_1:RecordAudio("105031022", var_93_15)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_105031", "105031022", "story_v_out_105031.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_105031", "105031022", "story_v_out_105031.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_16 = math.max(var_93_9, arg_90_1.talkMaxDuration)

			if var_93_8 <= arg_90_1.time_ and arg_90_1.time_ < var_93_8 + var_93_16 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_8) / var_93_16

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_8 + var_93_16 and arg_90_1.time_ < var_93_8 + var_93_16 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play105031023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 105031023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play105031024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1084ui_story"]) and arg_94_1.var_.characterEffect1084ui_story == nil then
				arg_94_1.var_.characterEffect1084ui_story = arg_94_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["1084ui_story"]) then
				if arg_94_1.var_.characterEffect1084ui_story and not isNil(arg_94_1.actors_["1084ui_story"]) then
					arg_94_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_0)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["1084ui_story"]) and arg_94_1.var_.characterEffect1084ui_story then
				arg_94_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_97_1 = arg_94_1.actors_["1084ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1084ui_story = var_97_1.localPosition
			end

			local var_97_2 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_2 then
				var_97_1.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_94_1.time_ - 0) / var_97_2)
				var_97_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_1.position).x, (manager.ui.mainCamera.transform.position - var_97_1.position).y, (manager.ui.mainCamera.transform.position - var_97_1.position).z)
				var_97_1.localEulerAngles.z = 0
				var_97_1.localEulerAngles.x = 0
				var_97_1.localEulerAngles = var_97_1.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_2 and arg_94_1.time_ < 0 + var_97_2 + arg_97_0 then
				var_97_1.localPosition = Vector3.New(0, 100, 0)
				var_97_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_1.position).x, (manager.ui.mainCamera.transform.position - var_97_1.position).y, (manager.ui.mainCamera.transform.position - var_97_1.position).z)
				var_97_1.localEulerAngles.z = 0
				var_97_1.localEulerAngles.x = 0
				var_97_1.localEulerAngles = var_97_1.localEulerAngles
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_2")
			end

			local var_97_3 = 0
			local var_97_4 = 1.4

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_3 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_5 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(105031023).content)

				arg_94_1.text_.text = var_97_5

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_7 = 55 <= 0 and var_97_4 or var_97_4 * (utf8.len(var_97_5) / 55)

				if (55 <= 0 and var_97_4 or var_97_4 * (utf8.len(var_97_5) / 55)) > 0 and var_97_4 < var_97_7 then
					arg_94_1.talkMaxDuration = var_97_7

					if var_97_7 + var_97_3 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_7 + var_97_3
					end
				end

				arg_94_1.text_.text = var_97_5
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_8 = math.max(var_97_4, arg_94_1.talkMaxDuration)

			if var_97_3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_3 + var_97_8 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_3) / var_97_8

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_3 + var_97_8 and arg_94_1.time_ < var_97_3 + var_97_8 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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

		arg_94_1:InitPlayNodeList()
	end,
	Play105031024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 105031024
		arg_98_1.duration_ = 3.33

		local var_98_0 = {
			ja = 3.333,
			ko = 2.7,
			zh = 2.6,
			en = 2.933
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
				arg_98_0:Play105031025(arg_98_1)
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

			local var_101_2 = arg_98_1.actors_["1084ui_story"].transform

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1084ui_story = var_101_2.localPosition

				arg_98_1:ShowWeapon(arg_98_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_101_3 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_3 then
				var_101_2.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_98_1.time_ - 0) / var_101_3)
				var_101_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_2.position).x, (manager.ui.mainCamera.transform.position - var_101_2.position).y, (manager.ui.mainCamera.transform.position - var_101_2.position).z)
				var_101_2.localEulerAngles.z = 0
				var_101_2.localEulerAngles.x = 0
				var_101_2.localEulerAngles = var_101_2.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_3 and arg_98_1.time_ < 0 + var_101_3 + arg_101_0 then
				var_101_2.localPosition = Vector3.New(0, -0.97, -6)
				var_101_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_101_2.position).x, (manager.ui.mainCamera.transform.position - var_101_2.position).y, (manager.ui.mainCamera.transform.position - var_101_2.position).z)
				var_101_2.localEulerAngles.z = 0
				var_101_2.localEulerAngles.x = 0
				var_101_2.localEulerAngles = var_101_2.localEulerAngles
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_101_4 = 0
			local var_101_5 = 0.225

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
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_6 = arg_98_1:GetWordFromCfg(105031024)
				local var_101_7 = arg_98_1:FormatText(var_101_6.content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 9 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 9)

				if (9 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 9)) > 0 and var_101_5 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031024", "story_v_out_105031.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_105031", "105031024", "story_v_out_105031.awb") / 1000

					if var_101_10 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_4
					end

					if var_101_6.prefab_name ~= "" and arg_98_1.actors_[var_101_6.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_6.prefab_name].transform, "story_v_out_105031", "105031024", "story_v_out_105031.awb")

						arg_98_1:RecordAudio("105031024", var_101_11)
						arg_98_1:RecordAudio("105031024", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_105031", "105031024", "story_v_out_105031.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_105031", "105031024", "story_v_out_105031.awb")
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

		arg_98_1.nodeConfigList_ = {
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

		arg_98_1:InitPlayNodeList()
	end,
	Play105031025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 105031025
		arg_102_1.duration_ = 5.5

		local var_102_0 = {
			ja = 5.5,
			ko = 4.433,
			zh = 3.733,
			en = 5.433
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
				arg_102_0:Play105031026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1036ui_story"]) and arg_102_1.var_.characterEffect1036ui_story == nil then
				arg_102_1.var_.characterEffect1036ui_story = arg_102_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1036ui_story"]) then
				if arg_102_1.var_.characterEffect1036ui_story and not isNil(arg_102_1.actors_["1036ui_story"]) then
					arg_102_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1036ui_story"]) and arg_102_1.var_.characterEffect1036ui_story then
				arg_102_1.var_.characterEffect1036ui_story.fillFlat = false
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

			local var_105_4 = arg_102_1.actors_["1084ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1084ui_story = var_105_4.localPosition
			end

			local var_105_5 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_5 then
				var_105_4.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_102_1.time_ - 0) / var_105_5)
				var_105_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_4.position).x, (manager.ui.mainCamera.transform.position - var_105_4.position).y, (manager.ui.mainCamera.transform.position - var_105_4.position).z)
				var_105_4.localEulerAngles.z = 0
				var_105_4.localEulerAngles.x = 0
				var_105_4.localEulerAngles = var_105_4.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_5 and arg_102_1.time_ < 0 + var_105_5 + arg_105_0 then
				var_105_4.localPosition = Vector3.New(0, -0.97, -6)
				var_105_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_4.position).x, (manager.ui.mainCamera.transform.position - var_105_4.position).y, (manager.ui.mainCamera.transform.position - var_105_4.position).z)
				var_105_4.localEulerAngles.z = 0
				var_105_4.localEulerAngles.x = 0
				var_105_4.localEulerAngles = var_105_4.localEulerAngles
			end

			local var_105_6 = arg_102_1.actors_["1084ui_story"].transform

			if 0.033 < arg_102_1.time_ and arg_102_1.time_ <= 0.033 + arg_105_0 then
				arg_102_1.var_.moveOldPos1084ui_story = var_105_6.localPosition
			end

			local var_105_7 = 0.5

			if 0.033 <= arg_102_1.time_ and arg_102_1.time_ < 0.033 + var_105_7 then
				var_105_6.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_102_1.time_ - 0.033) / var_105_7)
				var_105_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_6.position).x, (manager.ui.mainCamera.transform.position - var_105_6.position).y, (manager.ui.mainCamera.transform.position - var_105_6.position).z)
				var_105_6.localEulerAngles.z = 0
				var_105_6.localEulerAngles.x = 0
				var_105_6.localEulerAngles = var_105_6.localEulerAngles
			end

			if arg_102_1.time_ >= 0.033 + var_105_7 and arg_102_1.time_ < 0.033 + var_105_7 + arg_105_0 then
				var_105_6.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_105_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_6.position).x, (manager.ui.mainCamera.transform.position - var_105_6.position).y, (manager.ui.mainCamera.transform.position - var_105_6.position).z)
				var_105_6.localEulerAngles.z = 0
				var_105_6.localEulerAngles.x = 0
				var_105_6.localEulerAngles = var_105_6.localEulerAngles
			end

			local var_105_8 = arg_102_1.actors_["1036ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1036ui_story = var_105_8.localPosition
			end

			local var_105_9 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_9 then
				var_105_8.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1036ui_story, Vector3.New(0.7, -1.09, -5.78), (arg_102_1.time_ - 0) / var_105_9)
				var_105_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_8.position).x, (manager.ui.mainCamera.transform.position - var_105_8.position).y, (manager.ui.mainCamera.transform.position - var_105_8.position).z)
				var_105_8.localEulerAngles.z = 0
				var_105_8.localEulerAngles.x = 0
				var_105_8.localEulerAngles = var_105_8.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_9 and arg_102_1.time_ < 0 + var_105_9 + arg_105_0 then
				var_105_8.localPosition = Vector3.New(0.7, -1.09, -5.78)
				var_105_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_8.position).x, (manager.ui.mainCamera.transform.position - var_105_8.position).y, (manager.ui.mainCamera.transform.position - var_105_8.position).z)
				var_105_8.localEulerAngles.z = 0
				var_105_8.localEulerAngles.x = 0
				var_105_8.localEulerAngles = var_105_8.localEulerAngles
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action2_1")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_105_10 = 0
			local var_105_11 = 0.5

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_12 = arg_102_1:GetWordFromCfg(105031025)
				local var_105_13 = arg_102_1:FormatText(var_105_12.content)

				arg_102_1.text_.text = var_105_13

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_15 = 19 <= 0 and var_105_11 or var_105_11 * (utf8.len(var_105_13) / 19)

				if (19 <= 0 and var_105_11 or var_105_11 * (utf8.len(var_105_13) / 19)) > 0 and var_105_11 < var_105_15 then
					arg_102_1.talkMaxDuration = var_105_15

					if var_105_15 + var_105_10 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_15 + var_105_10
					end
				end

				arg_102_1.text_.text = var_105_13
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031025", "story_v_out_105031.awb") ~= 0 then
					local var_105_16 = manager.audio:GetVoiceLength("story_v_out_105031", "105031025", "story_v_out_105031.awb") / 1000

					if var_105_16 + var_105_10 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_16 + var_105_10
					end

					if var_105_12.prefab_name ~= "" and arg_102_1.actors_[var_105_12.prefab_name] ~= nil then
						local var_105_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_12.prefab_name].transform, "story_v_out_105031", "105031025", "story_v_out_105031.awb")

						arg_102_1:RecordAudio("105031025", var_105_17)
						arg_102_1:RecordAudio("105031025", var_105_17)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_105031", "105031025", "story_v_out_105031.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_105031", "105031025", "story_v_out_105031.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_18 = math.max(var_105_11, arg_102_1.talkMaxDuration)

			if var_105_10 <= arg_102_1.time_ and arg_102_1.time_ < var_105_10 + var_105_18 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_10) / var_105_18

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_10 + var_105_18 and arg_102_1.time_ < var_105_10 + var_105_18 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
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

		arg_102_1:InitPlayNodeList()
	end,
	Play105031026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 105031026
		arg_106_1.duration_ = 10.27

		local var_106_0 = {
			ja = 10.266,
			ko = 6.233,
			zh = 5.433,
			en = 7.233
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play105031027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1036ui_story"]) and arg_106_1.var_.characterEffect1036ui_story == nil then
				arg_106_1.var_.characterEffect1036ui_story = arg_106_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.1

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1036ui_story"]) then
				if arg_106_1.var_.characterEffect1036ui_story and not isNil(arg_106_1.actors_["1036ui_story"]) then
					arg_106_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_0)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1036ui_story"]) and arg_106_1.var_.characterEffect1036ui_story then
				arg_106_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_109_1 = 0
			local var_109_2 = 0.5

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:GetWordFromCfg(105031026)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_6 = 19 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_4) / 19)

				if (19 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_4) / 19)) > 0 and var_109_2 < var_109_6 then
					arg_106_1.talkMaxDuration = var_109_6

					if var_109_6 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_6 + var_109_1
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031026", "story_v_out_105031.awb") ~= 0 then
					local var_109_7 = manager.audio:GetVoiceLength("story_v_out_105031", "105031026", "story_v_out_105031.awb") / 1000

					if var_109_7 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_1
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_105031", "105031026", "story_v_out_105031.awb")

						arg_106_1:RecordAudio("105031026", var_109_8)
						arg_106_1:RecordAudio("105031026", var_109_8)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_105031", "105031026", "story_v_out_105031.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_105031", "105031026", "story_v_out_105031.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_9 = math.max(var_109_2, arg_106_1.talkMaxDuration)

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_9 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_1) / var_109_9

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_1 + var_109_9 and arg_106_1.time_ < var_109_1 + var_109_9 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play105031027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 105031027
		arg_110_1.duration_ = 5.87

		local var_110_0 = {
			ja = 5.866,
			ko = 3.366,
			zh = 3.7,
			en = 4.366
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
				arg_110_0:Play105031028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1019ui_story"]) and arg_110_1.var_.characterEffect1019ui_story == nil then
				arg_110_1.var_.characterEffect1019ui_story = arg_110_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.1

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1019ui_story"]) then
				if arg_110_1.var_.characterEffect1019ui_story and not isNil(arg_110_1.actors_["1019ui_story"]) then
					arg_110_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1019ui_story"]) and arg_110_1.var_.characterEffect1019ui_story then
				arg_110_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_113_2 = arg_110_1.actors_["1036ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1036ui_story = var_113_2.localPosition
			end

			local var_113_3 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_3 then
				var_113_2.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 0) / var_113_3)
				var_113_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_2.position).x, (manager.ui.mainCamera.transform.position - var_113_2.position).y, (manager.ui.mainCamera.transform.position - var_113_2.position).z)
				var_113_2.localEulerAngles.z = 0
				var_113_2.localEulerAngles.x = 0
				var_113_2.localEulerAngles = var_113_2.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_3 and arg_110_1.time_ < 0 + var_113_3 + arg_113_0 then
				var_113_2.localPosition = Vector3.New(0, 100, 0)
				var_113_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_2.position).x, (manager.ui.mainCamera.transform.position - var_113_2.position).y, (manager.ui.mainCamera.transform.position - var_113_2.position).z)
				var_113_2.localEulerAngles.z = 0
				var_113_2.localEulerAngles.x = 0
				var_113_2.localEulerAngles = var_113_2.localEulerAngles
			end

			local var_113_4 = arg_110_1.actors_["1019ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1019ui_story = var_113_4.localPosition
			end

			local var_113_5 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_5 then
				var_113_4.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_110_1.time_ - 0) / var_113_5)
				var_113_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_4.position).x, (manager.ui.mainCamera.transform.position - var_113_4.position).y, (manager.ui.mainCamera.transform.position - var_113_4.position).z)
				var_113_4.localEulerAngles.z = 0
				var_113_4.localEulerAngles.x = 0
				var_113_4.localEulerAngles = var_113_4.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_5 and arg_110_1.time_ < 0 + var_113_5 + arg_113_0 then
				var_113_4.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_113_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_4.position).x, (manager.ui.mainCamera.transform.position - var_113_4.position).y, (manager.ui.mainCamera.transform.position - var_113_4.position).z)
				var_113_4.localEulerAngles.z = 0
				var_113_4.localEulerAngles.x = 0
				var_113_4.localEulerAngles = var_113_4.localEulerAngles
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_113_6 = 0
			local var_113_7 = 0.3

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_8 = arg_110_1:GetWordFromCfg(105031027)
				local var_113_9 = arg_110_1:FormatText(var_113_8.content)

				arg_110_1.text_.text = var_113_9

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_11 = 12 <= 0 and var_113_7 or var_113_7 * (utf8.len(var_113_9) / 12)

				if (12 <= 0 and var_113_7 or var_113_7 * (utf8.len(var_113_9) / 12)) > 0 and var_113_7 < var_113_11 then
					arg_110_1.talkMaxDuration = var_113_11

					if var_113_11 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_11 + var_113_6
					end
				end

				arg_110_1.text_.text = var_113_9
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031027", "story_v_out_105031.awb") ~= 0 then
					local var_113_12 = manager.audio:GetVoiceLength("story_v_out_105031", "105031027", "story_v_out_105031.awb") / 1000

					if var_113_12 + var_113_6 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_12 + var_113_6
					end

					if var_113_8.prefab_name ~= "" and arg_110_1.actors_[var_113_8.prefab_name] ~= nil then
						local var_113_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_8.prefab_name].transform, "story_v_out_105031", "105031027", "story_v_out_105031.awb")

						arg_110_1:RecordAudio("105031027", var_113_13)
						arg_110_1:RecordAudio("105031027", var_113_13)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_105031", "105031027", "story_v_out_105031.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_105031", "105031027", "story_v_out_105031.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_14 = math.max(var_113_7, arg_110_1.talkMaxDuration)

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_14 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_6) / var_113_14

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_6 + var_113_14 and arg_110_1.time_ < var_113_6 + var_113_14 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
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

		arg_110_1:InitPlayNodeList()
	end,
	Play105031028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 105031028
		arg_114_1.duration_ = 5.07

		local var_114_0 = {
			ja = 5.066,
			ko = 4.233,
			zh = 4.2,
			en = 4.366
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
				arg_114_0:Play105031029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1084ui_story"]) and arg_114_1.var_.characterEffect1084ui_story == nil then
				arg_114_1.var_.characterEffect1084ui_story = arg_114_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.1

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1084ui_story"]) then
				if arg_114_1.var_.characterEffect1084ui_story and not isNil(arg_114_1.actors_["1084ui_story"]) then
					arg_114_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1084ui_story"]) and arg_114_1.var_.characterEffect1084ui_story then
				arg_114_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_117_2 = arg_114_1.actors_["1019ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1019ui_story == nil then
				arg_114_1.var_.characterEffect1019ui_story = var_117_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_3 = 0.1

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_3 and not isNil(var_117_2) then
				if arg_114_1.var_.characterEffect1019ui_story and not isNil(var_117_2) then
					arg_114_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_3)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_3 and arg_114_1.time_ < 0 + var_117_3 + arg_117_0 and not isNil(var_117_2) and arg_114_1.var_.characterEffect1019ui_story then
				arg_114_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4913")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_117_4 = 0
			local var_117_5 = 0.5

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_6 = arg_114_1:GetWordFromCfg(105031028)
				local var_117_7 = arg_114_1:FormatText(var_117_6.content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 20 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 20)

				if (20 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 20)) > 0 and var_117_5 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031028", "story_v_out_105031.awb") ~= 0 then
					local var_117_10 = manager.audio:GetVoiceLength("story_v_out_105031", "105031028", "story_v_out_105031.awb") / 1000

					if var_117_10 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_4
					end

					if var_117_6.prefab_name ~= "" and arg_114_1.actors_[var_117_6.prefab_name] ~= nil then
						local var_117_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_6.prefab_name].transform, "story_v_out_105031", "105031028", "story_v_out_105031.awb")

						arg_114_1:RecordAudio("105031028", var_117_11)
						arg_114_1:RecordAudio("105031028", var_117_11)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_105031", "105031028", "story_v_out_105031.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_105031", "105031028", "story_v_out_105031.awb")
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
	Play105031029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 105031029
		arg_118_1.duration_ = 4.57

		local var_118_0 = {
			ja = 1.999999999999,
			ko = 3.433,
			zh = 4.566,
			en = 3.166
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
				arg_118_0:Play105031030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1019ui_story"]) and arg_118_1.var_.characterEffect1019ui_story == nil then
				arg_118_1.var_.characterEffect1019ui_story = arg_118_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.1

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1019ui_story"]) then
				if arg_118_1.var_.characterEffect1019ui_story and not isNil(arg_118_1.actors_["1019ui_story"]) then
					arg_118_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1019ui_story"]) and arg_118_1.var_.characterEffect1019ui_story then
				arg_118_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_121_2 = arg_118_1.actors_["1084ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_3 = 0.1

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_3 and not isNil(var_121_2) then
				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_2) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_3)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_3 and arg_118_1.time_ < 0 + var_121_3 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_121_4 = 0
			local var_121_5 = 0.35

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(105031029)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 14 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 14)

				if (14 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 14)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031029", "story_v_out_105031.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_out_105031", "105031029", "story_v_out_105031.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_out_105031", "105031029", "story_v_out_105031.awb")

						arg_118_1:RecordAudio("105031029", var_121_11)
						arg_118_1:RecordAudio("105031029", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_105031", "105031029", "story_v_out_105031.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_105031", "105031029", "story_v_out_105031.awb")
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
	Play105031030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 105031030
		arg_122_1.duration_ = 20.1

		local var_122_0 = {
			ja = 20.1,
			ko = 10.033,
			zh = 13.333,
			en = 13.466
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play105031031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1019ui_story"]) and arg_122_1.var_.characterEffect1019ui_story == nil then
				arg_122_1.var_.characterEffect1019ui_story = arg_122_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.1

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1019ui_story"]) then
				if arg_122_1.var_.characterEffect1019ui_story and not isNil(arg_122_1.actors_["1019ui_story"]) then
					arg_122_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1019ui_story"]) and arg_122_1.var_.characterEffect1019ui_story then
				arg_122_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_125_2 = arg_122_1.actors_["1011ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect1011ui_story == nil then
				arg_122_1.var_.characterEffect1011ui_story = var_125_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_3 = 0.1

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_3 and not isNil(var_125_2) then
				if arg_122_1.var_.characterEffect1011ui_story and not isNil(var_125_2) then
					arg_122_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_3)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_3 and arg_122_1.time_ < 0 + var_125_3 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect1011ui_story then
				arg_122_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_125_4 = 0
			local var_125_5 = 1.6

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:GetWordFromCfg(105031030)
				local var_125_7 = arg_122_1:FormatText(var_125_6.content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_9 = 64 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 64)

				if (64 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 64)) > 0 and var_125_5 < var_125_9 then
					arg_122_1.talkMaxDuration = var_125_9

					if var_125_9 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031030", "story_v_out_105031.awb") ~= 0 then
					local var_125_10 = manager.audio:GetVoiceLength("story_v_out_105031", "105031030", "story_v_out_105031.awb") / 1000

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end

					if var_125_6.prefab_name ~= "" and arg_122_1.actors_[var_125_6.prefab_name] ~= nil then
						local var_125_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_6.prefab_name].transform, "story_v_out_105031", "105031030", "story_v_out_105031.awb")

						arg_122_1:RecordAudio("105031030", var_125_11)
						arg_122_1:RecordAudio("105031030", var_125_11)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_105031", "105031030", "story_v_out_105031.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_105031", "105031030", "story_v_out_105031.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_12 = math.max(var_125_5, arg_122_1.talkMaxDuration)

			if var_125_4 <= arg_122_1.time_ and arg_122_1.time_ < var_125_4 + var_125_12 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_4) / var_125_12

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_4 + var_125_12 and arg_122_1.time_ < var_125_4 + var_125_12 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play105031031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 105031031
		arg_126_1.duration_ = 16.7

		local var_126_0 = {
			ja = 16.7,
			ko = 9.533,
			zh = 13.333,
			en = 13.7
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
				arg_126_0:Play105031032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1019ui_story"]) and arg_126_1.var_.characterEffect1019ui_story == nil then
				arg_126_1.var_.characterEffect1019ui_story = arg_126_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.1

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1019ui_story"]) then
				if arg_126_1.var_.characterEffect1019ui_story and not isNil(arg_126_1.actors_["1019ui_story"]) then
					arg_126_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_0)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1019ui_story"]) and arg_126_1.var_.characterEffect1019ui_story then
				arg_126_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_129_1 = arg_126_1.actors_["1019ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1019ui_story = var_129_1.localPosition
			end

			local var_129_2 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_2 then
				var_129_1.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_2)
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

			local var_129_3 = arg_126_1.actors_["1084ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1084ui_story = var_129_3.localPosition
			end

			local var_129_4 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 then
				var_129_3.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_4)
				var_129_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_3.position).x, (manager.ui.mainCamera.transform.position - var_129_3.position).y, (manager.ui.mainCamera.transform.position - var_129_3.position).z)
				var_129_3.localEulerAngles.z = 0
				var_129_3.localEulerAngles.x = 0
				var_129_3.localEulerAngles = var_129_3.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 then
				var_129_3.localPosition = Vector3.New(0, 100, 0)
				var_129_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_3.position).x, (manager.ui.mainCamera.transform.position - var_129_3.position).y, (manager.ui.mainCamera.transform.position - var_129_3.position).z)
				var_129_3.localEulerAngles.z = 0
				var_129_3.localEulerAngles.x = 0
				var_129_3.localEulerAngles = var_129_3.localEulerAngles
			end

			local var_129_5 = 0
			local var_129_6 = 1.225

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_7 = arg_126_1:GetWordFromCfg(105031031)
				local var_129_8 = arg_126_1:FormatText(var_129_7.content)

				arg_126_1.text_.text = var_129_8

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_10 = 49 <= 0 and var_129_6 or var_129_6 * (utf8.len(var_129_8) / 49)

				if (49 <= 0 and var_129_6 or var_129_6 * (utf8.len(var_129_8) / 49)) > 0 and var_129_6 < var_129_10 then
					arg_126_1.talkMaxDuration = var_129_10

					if var_129_10 + var_129_5 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_10 + var_129_5
					end
				end

				arg_126_1.text_.text = var_129_8
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031031", "story_v_out_105031.awb") ~= 0 then
					local var_129_11 = manager.audio:GetVoiceLength("story_v_out_105031", "105031031", "story_v_out_105031.awb") / 1000

					if var_129_11 + var_129_5 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_11 + var_129_5
					end

					if var_129_7.prefab_name ~= "" and arg_126_1.actors_[var_129_7.prefab_name] ~= nil then
						local var_129_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_7.prefab_name].transform, "story_v_out_105031", "105031031", "story_v_out_105031.awb")

						arg_126_1:RecordAudio("105031031", var_129_12)
						arg_126_1:RecordAudio("105031031", var_129_12)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_105031", "105031031", "story_v_out_105031.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_105031", "105031031", "story_v_out_105031.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_13 = math.max(var_129_6, arg_126_1.talkMaxDuration)

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_13 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_5) / var_129_13

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_5 + var_129_13 and arg_126_1.time_ < var_129_5 + var_129_13 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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

		arg_126_1:InitPlayNodeList()
	end,
	Play105031032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 105031032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play105031033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPosB04f = arg_130_1.bgs_.B04f.transform.localPosition
			end

			local var_133_0 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 then
				arg_130_1.bgs_.B04f.transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPosB04f, Vector3.New(0, -100, 10), (arg_130_1.time_ - 0) / var_133_0)
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 then
				arg_130_1.bgs_.B04f.transform.localPosition = Vector3.New(0, -100, 10)
			end

			local var_133_1 = "S0501"

			if arg_130_1.bgs_.S0501 == nil then
				local var_133_2 = Object.Instantiate(arg_130_1.paintGo_)

				var_133_2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_133_1)
				var_133_2.name = var_133_1
				var_133_2.transform.parent = arg_130_1.stage_.transform
				var_133_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.bgs_[var_133_1] = var_133_2
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				local var_133_3 = arg_130_1.bgs_.S0501

				arg_130_1.bgs_.S0501.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_133_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_133_4 = var_133_3:GetComponent("SpriteRenderer")

				if var_133_4 and var_133_4.sprite then
					local var_133_5 = 2 * (var_133_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_133_3.transform.localScale = Vector3.New(var_133_5 / var_133_4.sprite.bounds.size.y < var_133_5 * manager.ui.mainCameraCom_.aspect / var_133_4.sprite.bounds.size.x and var_133_5 * manager.ui.mainCameraCom_.aspect / var_133_4.sprite.bounds.size.x or var_133_5 / var_133_4.sprite.bounds.size.y, var_133_5 / var_133_4.sprite.bounds.size.y < var_133_5 * manager.ui.mainCameraCom_.aspect / var_133_4.sprite.bounds.size.x and var_133_5 * manager.ui.mainCameraCom_.aspect / var_133_4.sprite.bounds.size.x or var_133_5 / var_133_4.sprite.bounds.size.y, 0)
				end

				for iter_133_0, iter_133_1 in pairs(arg_130_1.bgs_) do
					if iter_133_0 ~= "S0501" then
						iter_133_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_133_6 = 0
			local var_133_7 = 1.525

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_8 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(105031032).content)

				arg_130_1.text_.text = var_133_8

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_10 = 61 <= 0 and var_133_7 or var_133_7 * (utf8.len(var_133_8) / 61)

				if (61 <= 0 and var_133_7 or var_133_7 * (utf8.len(var_133_8) / 61)) > 0 and var_133_7 < var_133_10 then
					arg_130_1.talkMaxDuration = var_133_10

					if var_133_10 + var_133_6 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_6
					end
				end

				arg_130_1.text_.text = var_133_8
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_11 = math.max(var_133_7, arg_130_1.talkMaxDuration)

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_11 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_6) / var_133_11

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_6 + var_133_11 and arg_130_1.time_ < var_133_6 + var_133_11 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B04f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play105031033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 105031033
		arg_134_1.duration_ = 4.57

		local var_134_0 = {
			ja = 4.566,
			ko = 2.633,
			zh = 2.2,
			en = 3.066
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
				arg_134_0:Play105031034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0.2

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_1 = arg_134_1:GetWordFromCfg(105031033)
				local var_137_2 = arg_134_1:FormatText(var_137_1.content)

				arg_134_1.text_.text = var_137_2

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_4 = 8 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 8)

				if (8 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_2) / 8)) > 0 and var_137_0 < var_137_4 then
					arg_134_1.talkMaxDuration = var_137_4

					if var_137_4 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_4 + 0
					end
				end

				arg_134_1.text_.text = var_137_2
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031033", "story_v_out_105031.awb") ~= 0 then
					local var_137_5 = manager.audio:GetVoiceLength("story_v_out_105031", "105031033", "story_v_out_105031.awb") / 1000

					if var_137_5 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + 0
					end

					if var_137_1.prefab_name ~= "" and arg_134_1.actors_[var_137_1.prefab_name] ~= nil then
						local var_137_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_1.prefab_name].transform, "story_v_out_105031", "105031033", "story_v_out_105031.awb")

						arg_134_1:RecordAudio("105031033", var_137_6)
						arg_134_1:RecordAudio("105031033", var_137_6)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_105031", "105031033", "story_v_out_105031.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_105031", "105031033", "story_v_out_105031.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_7 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_7 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_7

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_7 and arg_134_1.time_ < 0 + var_137_7 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play105031034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 105031034
		arg_138_1.duration_ = 3.27

		local var_138_0 = {
			ja = 2.566,
			ko = 2.133,
			zh = 3.1,
			en = 3.266
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
				arg_138_0:Play105031035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0.175

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_1 = arg_138_1:GetWordFromCfg(105031034)
				local var_141_2 = arg_138_1:FormatText(var_141_1.content)

				arg_138_1.text_.text = var_141_2

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_4 = 7 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 7)

				if (7 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 7)) > 0 and var_141_0 < var_141_4 then
					arg_138_1.talkMaxDuration = var_141_4

					if var_141_4 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_4 + 0
					end
				end

				arg_138_1.text_.text = var_141_2
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031034", "story_v_out_105031.awb") ~= 0 then
					local var_141_5 = manager.audio:GetVoiceLength("story_v_out_105031", "105031034", "story_v_out_105031.awb") / 1000

					if var_141_5 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + 0
					end

					if var_141_1.prefab_name ~= "" and arg_138_1.actors_[var_141_1.prefab_name] ~= nil then
						local var_141_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_1.prefab_name].transform, "story_v_out_105031", "105031034", "story_v_out_105031.awb")

						arg_138_1:RecordAudio("105031034", var_141_6)
						arg_138_1:RecordAudio("105031034", var_141_6)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_105031", "105031034", "story_v_out_105031.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_105031", "105031034", "story_v_out_105031.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_7 = math.max(var_141_0, arg_138_1.talkMaxDuration)

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_7 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - 0) / var_141_7

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= 0 + var_141_7 and arg_138_1.time_ < 0 + var_141_7 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play105031035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 105031035
		arg_142_1.duration_ = 8.53

		local var_142_0 = {
			ja = 8.533,
			ko = 6,
			zh = 5.866,
			en = 6.366
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
				arg_142_0:Play105031036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0.8

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_1 = arg_142_1:GetWordFromCfg(105031035)
				local var_145_2 = arg_142_1:FormatText(var_145_1.content)

				arg_142_1.text_.text = var_145_2

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_4 = 31 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 31)

				if (31 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 31)) > 0 and var_145_0 < var_145_4 then
					arg_142_1.talkMaxDuration = var_145_4

					if var_145_4 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_4 + 0
					end
				end

				arg_142_1.text_.text = var_145_2
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031035", "story_v_out_105031.awb") ~= 0 then
					local var_145_5 = manager.audio:GetVoiceLength("story_v_out_105031", "105031035", "story_v_out_105031.awb") / 1000

					if var_145_5 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + 0
					end

					if var_145_1.prefab_name ~= "" and arg_142_1.actors_[var_145_1.prefab_name] ~= nil then
						local var_145_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_1.prefab_name].transform, "story_v_out_105031", "105031035", "story_v_out_105031.awb")

						arg_142_1:RecordAudio("105031035", var_145_6)
						arg_142_1:RecordAudio("105031035", var_145_6)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_105031", "105031035", "story_v_out_105031.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_105031", "105031035", "story_v_out_105031.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_7 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_7 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_7

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_7 and arg_142_1.time_ < 0 + var_145_7 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play105031036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 105031036
		arg_146_1.duration_ = 2.1

		local var_146_0 = {
			ja = 1.833,
			ko = 2.1,
			zh = 1.733,
			en = 1.7
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
				arg_146_0:Play105031037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 0.175

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_1 = arg_146_1:GetWordFromCfg(105031036)
				local var_149_2 = arg_146_1:FormatText(var_149_1.content)

				arg_146_1.text_.text = var_149_2

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_4 = 7 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 7)

				if (7 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_2) / 7)) > 0 and var_149_0 < var_149_4 then
					arg_146_1.talkMaxDuration = var_149_4

					if var_149_4 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_4 + 0
					end
				end

				arg_146_1.text_.text = var_149_2
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031036", "story_v_out_105031.awb") ~= 0 then
					local var_149_5 = manager.audio:GetVoiceLength("story_v_out_105031", "105031036", "story_v_out_105031.awb") / 1000

					if var_149_5 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + 0
					end

					if var_149_1.prefab_name ~= "" and arg_146_1.actors_[var_149_1.prefab_name] ~= nil then
						local var_149_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_1.prefab_name].transform, "story_v_out_105031", "105031036", "story_v_out_105031.awb")

						arg_146_1:RecordAudio("105031036", var_149_6)
						arg_146_1:RecordAudio("105031036", var_149_6)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_105031", "105031036", "story_v_out_105031.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_105031", "105031036", "story_v_out_105031.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_7 = math.max(var_149_0, arg_146_1.talkMaxDuration)

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_7 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - 0) / var_149_7

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= 0 + var_149_7 and arg_146_1.time_ < 0 + var_149_7 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play105031037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 105031037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play105031038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.95

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_1 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(105031037).content)

				arg_150_1.text_.text = var_153_1

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_3 = 38 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 38)

				if (38 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 38)) > 0 and var_153_0 < var_153_3 then
					arg_150_1.talkMaxDuration = var_153_3

					if var_153_3 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_3 + 0
					end
				end

				arg_150_1.text_.text = var_153_1
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_4 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_4

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play105031038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 105031038
		arg_154_1.duration_ = 2.47

		local var_154_0 = {
			ja = 2.166,
			ko = 2.466,
			zh = 2.033,
			en = 2.3
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
				arg_154_0:Play105031039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0.225

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_1 = arg_154_1:GetWordFromCfg(105031038)
				local var_157_2 = arg_154_1:FormatText(var_157_1.content)

				arg_154_1.text_.text = var_157_2

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_4 = 9 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 9)

				if (9 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_2) / 9)) > 0 and var_157_0 < var_157_4 then
					arg_154_1.talkMaxDuration = var_157_4

					if var_157_4 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_4 + 0
					end
				end

				arg_154_1.text_.text = var_157_2
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031038", "story_v_out_105031.awb") ~= 0 then
					local var_157_5 = manager.audio:GetVoiceLength("story_v_out_105031", "105031038", "story_v_out_105031.awb") / 1000

					if var_157_5 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + 0
					end

					if var_157_1.prefab_name ~= "" and arg_154_1.actors_[var_157_1.prefab_name] ~= nil then
						local var_157_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_1.prefab_name].transform, "story_v_out_105031", "105031038", "story_v_out_105031.awb")

						arg_154_1:RecordAudio("105031038", var_157_6)
						arg_154_1:RecordAudio("105031038", var_157_6)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_105031", "105031038", "story_v_out_105031.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_105031", "105031038", "story_v_out_105031.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_7 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_7 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_7

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_7 and arg_154_1.time_ < 0 + var_157_7 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play105031039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 105031039
		arg_158_1.duration_ = 4.6

		local var_158_0 = {
			ja = 4.6,
			ko = 3.833,
			zh = 2.9,
			en = 3.466
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
				arg_158_0:Play105031040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0.375

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_1 = arg_158_1:GetWordFromCfg(105031039)
				local var_161_2 = arg_158_1:FormatText(var_161_1.content)

				arg_158_1.text_.text = var_161_2

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 15 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 15)

				if (15 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 15)) > 0 and var_161_0 < var_161_4 then
					arg_158_1.talkMaxDuration = var_161_4

					if var_161_4 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_4 + 0
					end
				end

				arg_158_1.text_.text = var_161_2
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031039", "story_v_out_105031.awb") ~= 0 then
					local var_161_5 = manager.audio:GetVoiceLength("story_v_out_105031", "105031039", "story_v_out_105031.awb") / 1000

					if var_161_5 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + 0
					end

					if var_161_1.prefab_name ~= "" and arg_158_1.actors_[var_161_1.prefab_name] ~= nil then
						local var_161_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_1.prefab_name].transform, "story_v_out_105031", "105031039", "story_v_out_105031.awb")

						arg_158_1:RecordAudio("105031039", var_161_6)
						arg_158_1:RecordAudio("105031039", var_161_6)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_105031", "105031039", "story_v_out_105031.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_105031", "105031039", "story_v_out_105031.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_7 and arg_158_1.time_ < 0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play105031040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 105031040
		arg_162_1.duration_ = 2.6

		local var_162_0 = {
			ja = 2.366,
			ko = 1.8,
			zh = 2.6,
			en = 1.8
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
				arg_162_0:Play105031041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0.2

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, true)
				arg_162_1.iconController_:SetSelectedState("hero")

				arg_162_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_162_1.callingController_:SetSelectedState("normal")

				arg_162_1.keyicon_.color = Color.New(1, 1, 1)
				arg_162_1.icon_.color = Color.New(1, 1, 1)

				local var_165_1 = arg_162_1:GetWordFromCfg(105031040)
				local var_165_2 = arg_162_1:FormatText(var_165_1.content)

				arg_162_1.text_.text = var_165_2

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 8 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 8)

				if (8 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 8)) > 0 and var_165_0 < var_165_4 then
					arg_162_1.talkMaxDuration = var_165_4

					if var_165_4 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_4 + 0
					end
				end

				arg_162_1.text_.text = var_165_2
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031040", "story_v_out_105031.awb") ~= 0 then
					local var_165_5 = manager.audio:GetVoiceLength("story_v_out_105031", "105031040", "story_v_out_105031.awb") / 1000

					if var_165_5 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + 0
					end

					if var_165_1.prefab_name ~= "" and arg_162_1.actors_[var_165_1.prefab_name] ~= nil then
						local var_165_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_1.prefab_name].transform, "story_v_out_105031", "105031040", "story_v_out_105031.awb")

						arg_162_1:RecordAudio("105031040", var_165_6)
						arg_162_1:RecordAudio("105031040", var_165_6)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_105031", "105031040", "story_v_out_105031.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_105031", "105031040", "story_v_out_105031.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_7 and arg_162_1.time_ < 0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play105031041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 105031041
		arg_166_1.duration_ = 7.8

		local var_166_0 = {
			ja = 6.2,
			ko = 7.633,
			zh = 6.733,
			en = 7.8
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
				arg_166_0:Play105031042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			local var_169_0 = 0.85

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_1 = arg_166_1:GetWordFromCfg(105031041)
				local var_169_2 = arg_166_1:FormatText(var_169_1.content)

				arg_166_1.text_.text = var_169_2

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_4 = 34 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_2) / 34)

				if (34 <= 0 and var_169_0 or var_169_0 * (utf8.len(var_169_2) / 34)) > 0 and var_169_0 < var_169_4 then
					arg_166_1.talkMaxDuration = var_169_4

					if var_169_4 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_4 + 0
					end
				end

				arg_166_1.text_.text = var_169_2
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031041", "story_v_out_105031.awb") ~= 0 then
					local var_169_5 = manager.audio:GetVoiceLength("story_v_out_105031", "105031041", "story_v_out_105031.awb") / 1000

					if var_169_5 + 0 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_5 + 0
					end

					if var_169_1.prefab_name ~= "" and arg_166_1.actors_[var_169_1.prefab_name] ~= nil then
						local var_169_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_1.prefab_name].transform, "story_v_out_105031", "105031041", "story_v_out_105031.awb")

						arg_166_1:RecordAudio("105031041", var_169_6)
						arg_166_1:RecordAudio("105031041", var_169_6)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_105031", "105031041", "story_v_out_105031.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_105031", "105031041", "story_v_out_105031.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_7 = math.max(var_169_0, arg_166_1.talkMaxDuration)

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_7 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - 0) / var_169_7

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= 0 + var_169_7 and arg_166_1.time_ < 0 + var_169_7 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play105031042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 105031042
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play105031043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:AudioAction("play", "effect", "se_story_5", "se_story_5_brain", "")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_173_2 = arg_170_1.bgs_.S0501.transform

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPosS0501 = var_173_2.localPosition
			end

			local var_173_3 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_3 then
				var_173_2.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPosS0501, Vector3.New(0, -100, 10), (arg_170_1.time_ - 0) / var_173_3)
			end

			if arg_170_1.time_ >= 0 + var_173_3 and arg_170_1.time_ < 0 + var_173_3 + arg_173_0 then
				var_173_2.localPosition = Vector3.New(0, -100, 10)
			end

			local var_173_4 = "STblack"

			if arg_170_1.bgs_.STblack == nil then
				local var_173_5 = Object.Instantiate(arg_170_1.paintGo_)

				var_173_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_173_4)
				var_173_5.name = var_173_4
				var_173_5.transform.parent = arg_170_1.stage_.transform
				var_173_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_170_1.bgs_[var_173_4] = var_173_5
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				local var_173_6 = arg_170_1.bgs_.STblack

				arg_170_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_173_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_173_7 = var_173_6:GetComponent("SpriteRenderer")

				if var_173_7 and var_173_7.sprite then
					local var_173_8 = 2 * (var_173_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_173_6.transform.localScale = Vector3.New(var_173_8 / var_173_7.sprite.bounds.size.y < var_173_8 * manager.ui.mainCameraCom_.aspect / var_173_7.sprite.bounds.size.x and var_173_8 * manager.ui.mainCameraCom_.aspect / var_173_7.sprite.bounds.size.x or var_173_8 / var_173_7.sprite.bounds.size.y, var_173_8 / var_173_7.sprite.bounds.size.y < var_173_8 * manager.ui.mainCameraCom_.aspect / var_173_7.sprite.bounds.size.x and var_173_8 * manager.ui.mainCameraCom_.aspect / var_173_7.sprite.bounds.size.x or var_173_8 / var_173_7.sprite.bounds.size.y, 0)
				end

				for iter_173_0, iter_173_1 in pairs(arg_170_1.bgs_) do
					if iter_173_0 ~= "STblack" then
						iter_173_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_173_9 = 0
			local var_173_10 = 0.15

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_9 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_11 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(105031042).content)

				arg_170_1.text_.text = var_173_11

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_13 = 6 <= 0 and var_173_10 or var_173_10 * (utf8.len(var_173_11) / 6)

				if (6 <= 0 and var_173_10 or var_173_10 * (utf8.len(var_173_11) / 6)) > 0 and var_173_10 < var_173_13 then
					arg_170_1.talkMaxDuration = var_173_13

					if var_173_13 + var_173_9 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_13 + var_173_9
					end
				end

				arg_170_1.text_.text = var_173_11
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_14 = math.max(var_173_10, arg_170_1.talkMaxDuration)

			if var_173_9 <= arg_170_1.time_ and arg_170_1.time_ < var_173_9 + var_173_14 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_9) / var_173_14

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_9 + var_173_14 and arg_170_1.time_ < var_173_9 + var_173_14 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0501",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play105031043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 105031043
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play105031044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1:AudioAction("play", "effect", "se_story_5", "se_story_5_cup", "")
			end

			local var_177_1 = arg_174_1.bgs_.STblack.transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPosSTblack = var_177_1.localPosition
			end

			local var_177_2 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_2 then
				var_177_1.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPosSTblack, Vector3.New(0, -100, 10), (arg_174_1.time_ - 0) / var_177_2)
			end

			if arg_174_1.time_ >= 0 + var_177_2 and arg_174_1.time_ < 0 + var_177_2 + arg_177_0 then
				var_177_1.localPosition = Vector3.New(0, -100, 10)
			end

			local var_177_3 = "A00"

			if arg_174_1.bgs_.A00 == nil then
				local var_177_4 = Object.Instantiate(arg_174_1.paintGo_)

				var_177_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_177_3)
				var_177_4.name = var_177_3
				var_177_4.transform.parent = arg_174_1.stage_.transform
				var_177_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_174_1.bgs_[var_177_3] = var_177_4
			end

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				local var_177_5 = arg_174_1.bgs_.A00

				arg_174_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_177_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_177_6 = var_177_5:GetComponent("SpriteRenderer")

				if var_177_6 and var_177_6.sprite then
					local var_177_7 = 2 * (var_177_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_177_5.transform.localScale = Vector3.New(var_177_7 / var_177_6.sprite.bounds.size.y < var_177_7 * manager.ui.mainCameraCom_.aspect / var_177_6.sprite.bounds.size.x and var_177_7 * manager.ui.mainCameraCom_.aspect / var_177_6.sprite.bounds.size.x or var_177_7 / var_177_6.sprite.bounds.size.y, var_177_7 / var_177_6.sprite.bounds.size.y < var_177_7 * manager.ui.mainCameraCom_.aspect / var_177_6.sprite.bounds.size.x and var_177_7 * manager.ui.mainCameraCom_.aspect / var_177_6.sprite.bounds.size.x or var_177_7 / var_177_6.sprite.bounds.size.y, 0)
				end

				for iter_177_0, iter_177_1 in pairs(arg_174_1.bgs_) do
					if iter_177_0 ~= "A00" then
						iter_177_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_177_8 = 0
			local var_177_9 = 0.025

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_8 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_10 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(105031043).content)

				arg_174_1.text_.text = var_177_10

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_12 = 1 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_10) / 1)

				if (1 <= 0 and var_177_9 or var_177_9 * (utf8.len(var_177_10) / 1)) > 0 and var_177_9 < var_177_12 then
					arg_174_1.talkMaxDuration = var_177_12

					if var_177_12 + var_177_8 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_12 + var_177_8
					end
				end

				arg_174_1.text_.text = var_177_10
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_13 = math.max(var_177_9, arg_174_1.talkMaxDuration)

			if var_177_8 <= arg_174_1.time_ and arg_174_1.time_ < var_177_8 + var_177_13 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_8) / var_177_13

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_8 + var_177_13 and arg_174_1.time_ < var_177_8 + var_177_13 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STblack",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play105031044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 105031044
		arg_178_1.duration_ = 3.27

		local var_178_0 = {
			ja = 2.933,
			ko = 2.533,
			zh = 2.8,
			en = 3.266
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
				arg_178_0:Play105031045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:AudioAction("play", "music", "bgm_story_office", "bgm_story_office", "bgm_story_office")

				local var_181_2 = manager.audio:GetAudioName("bgm_story_office", "bgm_story_office")

				if "" ~= "" then
					if arg_178_1.bgmTxt_.text ~= var_181_2 and arg_178_1.bgmTxt_.text ~= "" then
						if arg_178_1.bgmTxt2_.text ~= "" then
							arg_178_1.bgmTxt_.text = arg_178_1.bgmTxt2_.text
						end

						arg_178_1.bgmTxt2_.text = var_181_2

						arg_178_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_178_1.bgmTxt_.text = var_181_2
						arg_178_1.bgmTxt2_.text = var_181_2
					end

					if arg_178_1.bgmTimer then
						arg_178_1.bgmTimer:Stop()

						arg_178_1.bgmTimer = nil
					end

					if arg_178_1.settingData.show_music_name == 1 then
						arg_178_1.musicController:SetSelectedState("show")
						arg_178_1.musicAnimator_:Play("open", 0, 0)

						if arg_178_1.settingData.music_time ~= 0 then
							arg_178_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_178_1.settingData.music_time), function()
								if arg_178_1 == nil or isNil(arg_178_1.bgmTxt_) then
									return
								end

								arg_178_1.musicController:SetSelectedState("hide")
								arg_178_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_181_3 = 0
			local var_181_4 = 0.225

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_3 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_5 = arg_178_1:GetWordFromCfg(105031044)
				local var_181_6 = arg_178_1:FormatText(var_181_5.content)

				arg_178_1.text_.text = var_181_6

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_8 = 9 <= 0 and var_181_4 or var_181_4 * (utf8.len(var_181_6) / 9)

				if (9 <= 0 and var_181_4 or var_181_4 * (utf8.len(var_181_6) / 9)) > 0 and var_181_4 < var_181_8 then
					arg_178_1.talkMaxDuration = var_181_8

					if var_181_8 + var_181_3 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_3
					end
				end

				arg_178_1.text_.text = var_181_6
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031044", "story_v_out_105031.awb") ~= 0 then
					local var_181_9 = manager.audio:GetVoiceLength("story_v_out_105031", "105031044", "story_v_out_105031.awb") / 1000

					if var_181_9 + var_181_3 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_9 + var_181_3
					end

					if var_181_5.prefab_name ~= "" and arg_178_1.actors_[var_181_5.prefab_name] ~= nil then
						local var_181_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_5.prefab_name].transform, "story_v_out_105031", "105031044", "story_v_out_105031.awb")

						arg_178_1:RecordAudio("105031044", var_181_10)
						arg_178_1:RecordAudio("105031044", var_181_10)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_105031", "105031044", "story_v_out_105031.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_105031", "105031044", "story_v_out_105031.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_11 = math.max(var_181_4, arg_178_1.talkMaxDuration)

			if var_181_3 <= arg_178_1.time_ and arg_178_1.time_ < var_181_3 + var_181_11 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_3) / var_181_11

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_3 + var_181_11 and arg_178_1.time_ < var_181_3 + var_181_11 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play105031045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 105031045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play105031046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 1.425

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(105031045).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 56 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 56)

				if (56 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 56)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play105031046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 105031046
		arg_187_1.duration_ = 4.07

		local var_187_0 = {
			ja = 4.066,
			ko = 2.4,
			zh = 2.733,
			en = 3.266
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play105031047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.325

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_1 = arg_187_1:GetWordFromCfg(105031046)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 13 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 13)

				if (13 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 13)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031046", "story_v_out_105031.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_105031", "105031046", "story_v_out_105031.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_105031", "105031046", "story_v_out_105031.awb")

						arg_187_1:RecordAudio("105031046", var_190_6)
						arg_187_1:RecordAudio("105031046", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_105031", "105031046", "story_v_out_105031.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_105031", "105031046", "story_v_out_105031.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play105031047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 105031047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play105031048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.2

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(105031047).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 8 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 8)

				if (8 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 8)) > 0 and var_194_0 < var_194_3 then
					arg_191_1.talkMaxDuration = var_194_3

					if var_194_3 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_3 + 0
					end
				end

				arg_191_1.text_.text = var_194_1
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_4 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_4

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play105031048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 105031048
		arg_195_1.duration_ = 1.8

		local var_195_0 = {
			ja = 1.8,
			ko = 1.233,
			zh = 1.3,
			en = 1.733
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play105031049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.1

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:GetWordFromCfg(105031048)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 4 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 4)

				if (4 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 4)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031048", "story_v_out_105031.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_105031", "105031048", "story_v_out_105031.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_105031", "105031048", "story_v_out_105031.awb")

						arg_195_1:RecordAudio("105031048", var_198_6)
						arg_195_1:RecordAudio("105031048", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_105031", "105031048", "story_v_out_105031.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_105031", "105031048", "story_v_out_105031.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play105031049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 105031049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play105031050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.8

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(105031049).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 32 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 32)

				if (32 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 32)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play105031050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 105031050
		arg_203_1.duration_ = 7.77

		local var_203_0 = {
			ja = 7.766,
			ko = 3.4,
			zh = 4.566,
			en = 5.766
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play105031051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.65

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_1 = arg_203_1:GetWordFromCfg(105031050)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 26 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 26)

				if (26 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 26)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105031", "105031050", "story_v_out_105031.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_105031", "105031050", "story_v_out_105031.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_105031", "105031050", "story_v_out_105031.awb")

						arg_203_1:RecordAudio("105031050", var_206_6)
						arg_203_1:RecordAudio("105031050", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_105031", "105031050", "story_v_out_105031.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_105031", "105031050", "story_v_out_105031.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play105031051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 105031051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
			arg_207_1.auto_ = false
		end

		function arg_207_1.playNext_(arg_209_0)
			arg_207_1.onStoryFinished_()
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.45

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(105031051).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 17 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 17)

				if (17 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 17)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/S0506a",
		"TextureConfig/Background/S0506",
		"TextureConfig/Background/B04f",
		"TextureConfig/Background/S0501",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_out_105031.awb"
	}
}
