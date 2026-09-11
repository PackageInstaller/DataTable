return {
	Play305072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 305072001
		arg_1_1.duration_ = 11.2

		local var_1_0 = {
			zh = 8.16633333333333,
			ja = 11.1993333333333
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
				arg_1_0:Play305072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B12 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B12")
				var_4_0.name = "B12"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B12 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B12

				arg_1_1.bgs_.B12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B12" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v0_battleground", "bgm_story_v0_battleground", "bgm_story_v0_battleground.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_story_v0_battleground", "bgm_story_v0_battleground")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_14 = 1.23333333333333
			local var_4_15 = 0.65

			if 1.23333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_17 = arg_1_1:GetWordFromCfg(305072001)
				local var_4_18 = arg_1_1:FormatText(var_4_17.content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 26 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 26)

				if (26 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_18) / 26)) > 0 and var_4_15 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_14 = var_4_14 + 0.3

					if var_4_20 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072001", "story_v_out_305072.awb") ~= 0 then
					local var_4_21 = manager.audio:GetVoiceLength("story_v_out_305072", "305072001", "story_v_out_305072.awb") / 1000

					if var_4_21 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_14
					end

					if var_4_17.prefab_name ~= "" and arg_1_1.actors_[var_4_17.prefab_name] ~= nil then
						local var_4_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_17.prefab_name].transform, "story_v_out_305072", "305072001", "story_v_out_305072.awb")

						arg_1_1:RecordAudio("305072001", var_4_22)
						arg_1_1:RecordAudio("305072001", var_4_22)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_305072", "305072001", "story_v_out_305072.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_305072", "305072001", "story_v_out_305072.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_14 + 0.3
			local var_4_24 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_24

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_24 and arg_1_1.time_ < var_4_23 + var_4_24 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play305072002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 305072002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play305072003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.125

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(305072002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 5 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 5)

				if (5 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 5)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play305072003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 305072003
		arg_12_1.duration_ = 6.37

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play305072004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				local var_15_0 = arg_12_1.var_.effect烦烦烦

				if not arg_12_1.var_.effect烦烦烦 then
					var_15_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), manager.ui.mainCamera.transform)
					var_15_0.name = "烦烦烦"
					arg_12_1.var_.effect烦烦烦 = var_15_0
				else
					var_15_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_15_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_15_0.transform.localScale = Vector3.New(var_15_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_15_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_15_0.transform.localScale.z)
			end

			local var_15_2 = 0

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			if arg_12_1.time_ >= var_15_2 + 2 and arg_12_1.time_ < var_15_2 + 2 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_3 = 1.36666666666667
			local var_15_4 = 1.2

			if 1.36666666666667 < arg_12_1.time_ and arg_12_1.time_ <= var_15_3 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_5 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_5:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_6 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(305072003).content)

				arg_12_1.text_.text = var_15_6

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_8 = 48 <= 0 and var_15_4 or var_15_4 * (utf8.len(var_15_6) / 48)

				if (48 <= 0 and var_15_4 or var_15_4 * (utf8.len(var_15_6) / 48)) > 0 and var_15_4 < var_15_8 then
					arg_12_1.talkMaxDuration = var_15_8
					var_15_3 = var_15_3 + 0.3

					if var_15_8 + var_15_3 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_3
					end
				end

				arg_12_1.text_.text = var_15_6
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_9 = var_15_3 + 0.3
			local var_15_10 = math.max(var_15_4, arg_12_1.talkMaxDuration)

			if var_15_3 + 0.3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_9 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_9) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_9 + var_15_10 and arg_12_1.time_ < var_15_9 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.56666666666667,
				amplitudeGain = 0.4,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play305072004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 305072004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play305072005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0.2 < arg_18_1.time_ and arg_18_1.time_ <= 0.2 + arg_21_0 then
				arg_18_1:AudioAction("play", "effect", "se_story_152", "se_story_152_metal", "")
			end

			local var_21_1 = 0
			local var_21_2 = 1.275

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_3 = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(305072004).content)

				arg_18_1.text_.text = var_21_3

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 51 <= 0 and var_21_2 or var_21_2 * (utf8.len(var_21_3) / 51)

				if (51 <= 0 and var_21_2 or var_21_2 * (utf8.len(var_21_3) / 51)) > 0 and var_21_2 < var_21_5 then
					arg_18_1.talkMaxDuration = var_21_5

					if var_21_5 + var_21_1 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + var_21_1
					end
				end

				arg_18_1.text_.text = var_21_3
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_6 = math.max(var_21_2, arg_18_1.talkMaxDuration)

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_6 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_1) / var_21_6

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_1 + var_21_6 and arg_18_1.time_ < var_21_1 + var_21_6 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play305072005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 305072005
		arg_22_1.duration_ = 13.53

		local var_22_0 = {
			zh = 10.433,
			ja = 13.533
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
				arg_22_0:Play305072006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.7

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

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_1 = arg_22_1:GetWordFromCfg(305072005)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 28 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 28)

				if (28 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 28)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072005", "story_v_out_305072.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_out_305072", "305072005", "story_v_out_305072.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_out_305072", "305072005", "story_v_out_305072.awb")

						arg_22_1:RecordAudio("305072005", var_25_6)
						arg_22_1:RecordAudio("305072005", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_305072", "305072005", "story_v_out_305072.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_305072", "305072005", "story_v_out_305072.awb")
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
	Play305072006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 305072006
		arg_26_1.duration_ = 7.7

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play305072007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_9000

			if arg_26_1.bgs_.S0505 == nil then
				local var_29_0 = Object.Instantiate(arg_26_1.paintGo_)

				var_29_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0505")
				var_29_0.name = "S0505"
				var_29_0.transform.parent = arg_26_1.stage_.transform
				var_29_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_26_1.bgs_.S0505 = var_29_0
			end

			if 0.7 < arg_26_1.time_ and arg_26_1.time_ <= 0.7 + arg_29_0 then
				local var_29_1 = arg_26_1.bgs_.S0505

				arg_26_1.bgs_.S0505.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_29_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_29_2 = var_29_1:GetComponent("SpriteRenderer")

				if var_29_2 and var_29_2.sprite then
					local var_29_3 = 2 * (var_29_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_29_1.transform.localScale = Vector3.New(var_29_3 / var_29_2.sprite.bounds.size.y < var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x and var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x or var_29_3 / var_29_2.sprite.bounds.size.y, var_29_3 / var_29_2.sprite.bounds.size.y < var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x and var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x or var_29_3 / var_29_2.sprite.bounds.size.y, 0)
				end

				for iter_29_0, iter_29_1 in pairs(arg_26_1.bgs_) do
					if iter_29_0 ~= "S0505" then
						iter_29_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_29_4 = 0

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.allBtn_.enabled = false
			end

			if arg_26_1.time_ >= var_29_4 + 0.3 and arg_26_1.time_ < var_29_4 + 0.3 + arg_29_0 then
				arg_26_1.allBtn_.enabled = true
			end

			local var_29_5 = 0

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_5 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_6 = 0.7

			if var_29_5 <= arg_26_1.time_ and arg_26_1.time_ < var_29_5 + var_29_6 then
				local var_29_7 = Color.New(0, 0, 0)

				var_29_7.a = Mathf.Lerp(0, 1, (arg_26_1.time_ - var_29_5) / var_29_6)
				arg_26_1.mask_.color = var_29_7
			end

			if arg_26_1.time_ >= var_29_5 + var_29_6 and arg_26_1.time_ < var_29_5 + var_29_6 + arg_29_0 then
				local var_29_8 = Color.New(0, 0, 0)

				var_29_8.a = 1
				arg_26_1.mask_.color = var_29_8
			end

			local var_29_9 = 0.7

			if 0.7 < arg_26_1.time_ and arg_26_1.time_ <= var_29_9 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_10 = 1.56666666666667

			if var_29_9 <= arg_26_1.time_ and arg_26_1.time_ < var_29_9 + var_29_10 then
				local var_29_11 = Color.New(0, 0, 0)

				var_29_11.a = Mathf.Lerp(1, 0, (arg_26_1.time_ - var_29_9) / var_29_10)
				arg_26_1.mask_.color = var_29_11
			end

			if arg_26_1.time_ >= var_29_9 + var_29_10 and arg_26_1.time_ < var_29_9 + var_29_10 + arg_29_0 then
				local var_29_12 = Color.New(0, 0, 0)

				arg_26_1.mask_.enabled = false
				var_29_12.a = 0
				arg_26_1.mask_.color = var_29_12
			end

			if 0.766666666666667 < arg_26_1.time_ and arg_26_1.time_ <= 0.766666666666667 + arg_29_0 then
				local var_29_13 = arg_26_1.var_.effect热热

				if not arg_26_1.var_.effect热热 then
					var_29_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_burning_1"), manager.ui.mainCamera.transform)
					var_29_13.name = "热热"
					arg_26_1.var_.effect热热 = var_29_13
				else
					var_29_13.transform:SetParent(var_29_9000)
				end

				var_29_13.transform.localPosition = Vector3.New(0, 0, -0.01)
				var_29_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_29_13.transform.localScale = Vector3.New(var_29_13.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_29_13.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_29_13.transform.localScale.z)
			end

			local var_29_15 = arg_26_1.bgs_.S0505.transform

			if 0.7 < arg_26_1.time_ and arg_26_1.time_ <= 0.7 + arg_29_0 then
				arg_26_1.var_.moveOldPosS0505 = var_29_15.localPosition
			end

			local var_29_16 = 1.76666666666667

			if 0.7 <= arg_26_1.time_ and arg_26_1.time_ < 0.7 + var_29_16 then
				var_29_15.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPosS0505, Vector3.New(0, 1, 9.59), (arg_26_1.time_ - 0.7) / var_29_16)
			end

			if arg_26_1.time_ >= 0.7 + var_29_16 and arg_26_1.time_ < 0.7 + var_29_16 + arg_29_0 then
				var_29_15.localPosition = Vector3.New(0, 1, 9.59)
			end

			if 0.7 < arg_26_1.time_ and arg_26_1.time_ <= 0.7 + arg_29_0 then
				if arg_26_1.var_.effect烦烦烦 then
					Object.Destroy(arg_26_1.var_.effect烦烦烦)

					arg_26_1.var_.effect烦烦烦 = nil
				end
			end

			if 0.6 < arg_26_1.time_ and arg_26_1.time_ <= 0.6 + arg_29_0 then
				arg_26_1:AudioAction("play", "effect", "se_story_143", "se_story_143_organic02", "")
			end

			if arg_26_1.frameCnt_ <= 1 then
				arg_26_1.dialog_:SetActive(false)
			end

			local var_29_19 = 2.7
			local var_29_20 = 0.75

			if 2.7 < arg_26_1.time_ and arg_26_1.time_ <= var_29_19 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				arg_26_1.dialog_:SetActive(true)

				arg_26_1.dialogCg_.alpha = 0

				local var_29_21 = LeanTween.value(arg_26_1.dialog_, 0, 1, 0.3)

				var_29_21:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_26_1.dialogCg_.alpha = arg_30_0
				end))
				var_29_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_26_1.dialog_)
					var_29_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_26_1.duration_ = arg_26_1.duration_ + 0.3

				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_22 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(305072006).content)

				arg_26_1.text_.text = var_29_22

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_24 = 30 <= 0 and var_29_20 or var_29_20 * (utf8.len(var_29_22) / 30)

				if (30 <= 0 and var_29_20 or var_29_20 * (utf8.len(var_29_22) / 30)) > 0 and var_29_20 < var_29_24 then
					arg_26_1.talkMaxDuration = var_29_24
					var_29_19 = var_29_19 + 0.3

					if var_29_24 + var_29_19 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_24 + var_29_19
					end
				end

				arg_26_1.text_.text = var_29_22
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_25 = var_29_19 + 0.3
			local var_29_26 = math.max(var_29_20, arg_26_1.talkMaxDuration)

			if var_29_19 + 0.3 <= arg_26_1.time_ and arg_26_1.time_ < var_29_25 + var_29_26 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_25) / var_29_26

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_25 + var_29_26 and arg_26_1.time_ < var_29_25 + var_29_26 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "S0505",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.76666666666667,
				startTime = 0.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1.75, 5.23),
					endPos = Vector3.New(0, 1, 9.59),
					easeType = LeanTweenType.easeInOutQuart
				}
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play305072007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 305072007
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play305072008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 1.225

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(305072007).content)

				arg_32_1.text_.text = var_35_1

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_3 = 49 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 49)

				if (49 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 49)) > 0 and var_35_0 < var_35_3 then
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
	Play305072008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 305072008
		arg_36_1.duration_ = 1.33

		local var_36_0 = {
			zh = 1.3,
			ja = 1.333
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
				arg_36_0:Play305072009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if arg_36_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_39_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_36_1.stage_.transform)

				var_39_0.name = "1084ui_story"
				var_39_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1084ui_story"] = var_39_0

				local var_39_1 = var_39_0:GetComponentInChildren(typeof(CharacterEffect))

				var_39_1.enabled = true

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end

				arg_36_1:ShowWeapon(var_39_1.transform, false)

				arg_36_1.var_["1084ui_story" .. "Animator"] = var_39_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_36_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_36_1.var_["1084ui_story" .. "LipSync"] = var_39_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_39_3 = arg_36_1.actors_["1084ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_4 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 and not isNil(var_39_3) then
				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_3) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_39_6 = 0
			local var_39_7 = 0.1

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_8 = arg_36_1:GetWordFromCfg(305072008)
				local var_39_9 = arg_36_1:FormatText(var_39_8.content)

				arg_36_1.text_.text = var_39_9

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 4 <= 0 and var_39_7 or var_39_7 * (utf8.len(var_39_9) / 4)

				if (4 <= 0 and var_39_7 or var_39_7 * (utf8.len(var_39_9) / 4)) > 0 and var_39_7 < var_39_11 then
					arg_36_1.talkMaxDuration = var_39_11

					if var_39_11 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_11 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_9
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072008", "story_v_out_305072.awb") ~= 0 then
					local var_39_12 = manager.audio:GetVoiceLength("story_v_out_305072", "305072008", "story_v_out_305072.awb") / 1000

					if var_39_12 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_12 + var_39_6
					end

					if var_39_8.prefab_name ~= "" and arg_36_1.actors_[var_39_8.prefab_name] ~= nil then
						local var_39_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_8.prefab_name].transform, "story_v_out_305072", "305072008", "story_v_out_305072.awb")

						arg_36_1:RecordAudio("305072008", var_39_13)
						arg_36_1:RecordAudio("305072008", var_39_13)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_305072", "305072008", "story_v_out_305072.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_305072", "305072008", "story_v_out_305072.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_14 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_14 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_14

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_14 and arg_36_1.time_ < var_39_6 + var_39_14 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play305072009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 305072009
		arg_40_1.duration_ = 6.53

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play305072010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_9001
			local var_43_9000

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1084ui_story"]) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = arg_40_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1084ui_story"]) then
				if arg_40_1.var_.characterEffect1084ui_story and not isNil(arg_40_1.actors_["1084ui_story"]) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1084ui_story"]) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				local var_43_1 = arg_40_1.var_.effectsssfsssf

				if not arg_40_1.var_.effectsssfsssf then
					var_43_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boguang"), manager.ui.mainCamera.transform)
					var_43_1.name = "sssf"
					arg_40_1.var_.effectsssfsssf = var_43_1
				else
					var_43_1.transform:SetParent(var_43_9001)
				end

				var_43_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_43_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_43_1.transform.localScale = Vector3.New(var_43_1.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_43_1.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_43_1.transform.localScale.z)
			end

			if 1.28333333333333 < arg_40_1.time_ and arg_40_1.time_ <= 1.28333333333333 + arg_43_0 then
				if arg_40_1.var_.effectsssfsssf then
					Object.Destroy(arg_40_1.var_.effectsssfsssf)

					arg_40_1.var_.effectsssfsssf = nil
				end
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				local var_43_4 = arg_40_1.var_.effect13233

				if not arg_40_1.var_.effect13233 then
					var_43_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang05"), manager.ui.mainCamera.transform)
					var_43_4.name = "13233"
					arg_40_1.var_.effect13233 = var_43_4
				else
					var_43_4.transform:SetParent(var_43_9000)
				end

				var_43_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_43_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.5 < arg_40_1.time_ and arg_40_1.time_ <= 2.5 + arg_43_0 then
				if arg_40_1.var_.effect13233 then
					Object.Destroy(arg_40_1.var_.effect13233)

					arg_40_1.var_.effect13233 = nil
				end
			end

			local var_43_7 = 0

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_7 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			if arg_40_1.time_ >= var_43_7 + 3.275 and arg_40_1.time_ < var_43_7 + 3.275 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end

			local var_43_8 = 0.723045398015529

			if 0.723045398015529 < arg_40_1.time_ and arg_40_1.time_ <= var_43_8 + arg_43_0 then
				arg_40_1.mask_.enabled = true
				arg_40_1.mask_.raycastTarget = true

				arg_40_1:SetGaussion(false)
			end

			local var_43_9 = 0.443621268651138

			if var_43_8 <= arg_40_1.time_ and arg_40_1.time_ < var_43_8 + var_43_9 then
				local var_43_10 = Color.New(1, 1, 1)

				var_43_10.a = Mathf.Lerp(1, 0, (arg_40_1.time_ - var_43_8) / var_43_9)
				arg_40_1.mask_.color = var_43_10
			end

			if arg_40_1.time_ >= var_43_8 + var_43_9 and arg_40_1.time_ < var_43_8 + var_43_9 + arg_43_0 then
				local var_43_11 = Color.New(1, 1, 1)

				arg_40_1.mask_.enabled = false
				var_43_11.a = 0
				arg_40_1.mask_.color = var_43_11
			end

			if arg_40_1.frameCnt_ <= 1 then
				arg_40_1.dialog_:SetActive(false)
			end

			local var_43_12 = 1.53333333333333
			local var_43_13 = 1.275

			if 1.53333333333333 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0

				arg_40_1.dialog_:SetActive(true)

				arg_40_1.dialogCg_.alpha = 0

				local var_43_14 = LeanTween.value(arg_40_1.dialog_, 0, 1, 0.3)

				var_43_14:setOnUpdate(LuaHelper.FloatAction(function(arg_44_0)
					arg_40_1.dialogCg_.alpha = arg_44_0
				end))
				var_43_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_40_1.dialog_)
					var_43_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_40_1.duration_ = arg_40_1.duration_ + 0.3

				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_15 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(305072009).content)

				arg_40_1.text_.text = var_43_15

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 51 <= 0 and var_43_13 or var_43_13 * (utf8.len(var_43_15) / 51)

				if (51 <= 0 and var_43_13 or var_43_13 * (utf8.len(var_43_15) / 51)) > 0 and var_43_13 < var_43_17 then
					arg_40_1.talkMaxDuration = var_43_17
					var_43_12 = var_43_12 + 0.3

					if var_43_17 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_17 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_15
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_18 = var_43_12 + 0.3
			local var_43_19 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 + 0.3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_18 + var_43_19 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_18) / var_43_19

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_18 + var_43_19 and arg_40_1.time_ < var_43_18 + var_43_19 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D Wobble",
				duration = 1.76666666368643,
				amplitudeGain = 0.1,
				startTime = 0.733333336313565,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play305072010 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 305072010
		arg_46_1.duration_ = 5.91

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play305072011(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_9000

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				local var_49_0 = arg_46_1.var_.effect刚刚

				if not arg_46_1.var_.effect刚刚 then
					var_49_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_explosion"), manager.ui.mainCamera.transform)
					var_49_0.name = "刚刚"
					arg_46_1.var_.effect刚刚 = var_49_0
				else
					var_49_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_49_0.transform.localPosition = Vector3.New(-0.75, 0.1, -3.27)
				var_49_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_49_0.transform.localScale = Vector3.New(var_49_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_49_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_49_0.transform.localScale.z)
			end

			if 1.9 < arg_46_1.time_ and arg_46_1.time_ <= 1.9 + arg_49_0 then
				if arg_46_1.var_.effect刚刚 then
					Object.Destroy(arg_46_1.var_.effect刚刚)

					arg_46_1.var_.effect刚刚 = nil
				end
			end

			if 0.3 < arg_46_1.time_ and arg_46_1.time_ <= 0.3 + arg_49_0 then
				local var_49_3 = arg_46_1.var_.effect刚刚1

				if not arg_46_1.var_.effect刚刚1 then
					var_49_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_explosion"), manager.ui.mainCamera.transform)
					var_49_3.name = "刚刚1"
					arg_46_1.var_.effect刚刚1 = var_49_3
				else
					var_49_3.transform:SetParent(var_49_9000)
				end

				var_49_3.transform.localPosition = Vector3.New(0.99, -1.39, -2.62)
				var_49_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_49_3.transform.localScale = Vector3.New(var_49_3.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_49_3.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_49_3.transform.localScale.z)
			end

			if 2.4 < arg_46_1.time_ and arg_46_1.time_ <= 2.4 + arg_49_0 then
				if arg_46_1.var_.effect刚刚1 then
					Object.Destroy(arg_46_1.var_.effect刚刚1)

					arg_46_1.var_.effect刚刚1 = nil
				end
			end

			local var_49_6 = 0

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.allBtn_.enabled = false
			end

			if arg_46_1.time_ >= var_49_6 + 1.46666666666667 and arg_46_1.time_ < var_49_6 + 1.46666666666667 + arg_49_0 then
				arg_46_1.allBtn_.enabled = true
			end

			if 0.2 < arg_46_1.time_ and arg_46_1.time_ <= 0.2 + arg_49_0 then
				arg_46_1:AudioAction("play", "effect", "se_story_152", "se_story_152_attack", "")
			end

			if arg_46_1.frameCnt_ <= 1 then
				arg_46_1.dialog_:SetActive(false)
			end

			local var_49_8 = 0.912192109506577
			local var_49_9 = 1.6

			if 0.912192109506577 < arg_46_1.time_ and arg_46_1.time_ <= var_49_8 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				arg_46_1.dialog_:SetActive(true)

				arg_46_1.dialogCg_.alpha = 0

				local var_49_10 = LeanTween.value(arg_46_1.dialog_, 0, 1, 0.3)

				var_49_10:setOnUpdate(LuaHelper.FloatAction(function(arg_50_0)
					arg_46_1.dialogCg_.alpha = arg_50_0
				end))
				var_49_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_46_1.dialog_)
					var_49_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_46_1.duration_ = arg_46_1.duration_ + 0.3

				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_11 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(305072010).content)

				arg_46_1.text_.text = var_49_11

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_13 = 64 <= 0 and var_49_9 or var_49_9 * (utf8.len(var_49_11) / 64)

				if (64 <= 0 and var_49_9 or var_49_9 * (utf8.len(var_49_11) / 64)) > 0 and var_49_9 < var_49_13 then
					arg_46_1.talkMaxDuration = var_49_13
					var_49_8 = var_49_8 + 0.3

					if var_49_13 + var_49_8 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_13 + var_49_8
					end
				end

				arg_46_1.text_.text = var_49_11
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_14 = var_49_8 + 0.3
			local var_49_15 = math.max(var_49_9, arg_46_1.talkMaxDuration)

			if var_49_8 + 0.3 <= arg_46_1.time_ and arg_46_1.time_ < var_49_14 + var_49_15 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_14) / var_49_15

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_14 + var_49_15 and arg_46_1.time_ < var_49_14 + var_49_15 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play305072011 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 305072011
		arg_52_1.duration_ = 21.07

		local var_52_0 = {
			zh = 10.133,
			ja = 21.066
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
				arg_52_0:Play305072012(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.9

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:GetWordFromCfg(305072011)
				local var_55_2 = arg_52_1:FormatText(var_55_1.content)

				arg_52_1.text_.text = var_55_2

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 36 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 36)

				if (36 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 36)) > 0 and var_55_0 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end

				arg_52_1.text_.text = var_55_2
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072011", "story_v_out_305072.awb") ~= 0 then
					local var_55_5 = manager.audio:GetVoiceLength("story_v_out_305072", "305072011", "story_v_out_305072.awb") / 1000

					if var_55_5 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + 0
					end

					if var_55_1.prefab_name ~= "" and arg_52_1.actors_[var_55_1.prefab_name] ~= nil then
						local var_55_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_1.prefab_name].transform, "story_v_out_305072", "305072011", "story_v_out_305072.awb")

						arg_52_1:RecordAudio("305072011", var_55_6)
						arg_52_1:RecordAudio("305072011", var_55_6)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_305072", "305072011", "story_v_out_305072.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_305072", "305072011", "story_v_out_305072.awb")
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
	Play305072012 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 305072012
		arg_56_1.duration_ = 6.2

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play305072013(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				local var_59_0 = arg_56_1.var_.effect烦烦烦

				if not arg_56_1.var_.effect烦烦烦 then
					var_59_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error03_keep"), manager.ui.mainCamera.transform)
					var_59_0.name = "烦烦烦"
					arg_56_1.var_.effect烦烦烦 = var_59_0
				else
					var_59_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_59_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_59_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_59_0.transform.localScale = Vector3.New(var_59_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_59_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_59_0.transform.localScale.z)
			end

			local var_59_2 = 0

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			if arg_56_1.time_ >= var_59_2 + 1.46666666666667 and arg_56_1.time_ < var_59_2 + 1.46666666666667 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_3 = 1.2
			local var_59_4 = 1.4

			if 1.2 < arg_56_1.time_ and arg_56_1.time_ <= var_59_3 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_5 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_5:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(305072012).content)

				arg_56_1.text_.text = var_59_6

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_8 = 56 <= 0 and var_59_4 or var_59_4 * (utf8.len(var_59_6) / 56)

				if (56 <= 0 and var_59_4 or var_59_4 * (utf8.len(var_59_6) / 56)) > 0 and var_59_4 < var_59_8 then
					arg_56_1.talkMaxDuration = var_59_8
					var_59_3 = var_59_3 + 0.3

					if var_59_8 + var_59_3 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_3
					end
				end

				arg_56_1.text_.text = var_59_6
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_9 = var_59_3 + 0.3
			local var_59_10 = math.max(var_59_4, arg_56_1.talkMaxDuration)

			if var_59_3 + 0.3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_9 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_9) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_9 + var_59_10 and arg_56_1.time_ < var_59_9 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play305072013 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 305072013
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play305072014(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 1.525

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(305072013).content)

				arg_62_1.text_.text = var_65_1

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_3 = 61 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 61)

				if (61 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 61)) > 0 and var_65_0 < var_65_3 then
					arg_62_1.talkMaxDuration = var_65_3

					if var_65_3 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_3 + 0
					end
				end

				arg_62_1.text_.text = var_65_1
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_4 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_4

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play305072014 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 305072014
		arg_66_1.duration_ = 2.97

		local var_66_0 = {
			zh = 2.233,
			ja = 2.966
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
				arg_66_0:Play305072015(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if arg_66_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_69_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_66_1.stage_.transform)

				var_69_0.name = "1019ui_story"
				var_69_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.actors_["1019ui_story"] = var_69_0

				local var_69_1 = var_69_0:GetComponentInChildren(typeof(CharacterEffect))

				var_69_1.enabled = true

				local var_69_2 = GameObjectTools.GetOrAddComponent(var_69_0, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(false)
				end

				arg_66_1:ShowWeapon(var_69_1.transform, false)

				arg_66_1.var_["1019ui_story" .. "Animator"] = var_69_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_66_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_66_1.var_["1019ui_story" .. "LipSync"] = var_69_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_69_3 = arg_66_1.actors_["1019ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_3) and arg_66_1.var_.characterEffect1019ui_story == nil then
				arg_66_1.var_.characterEffect1019ui_story = var_69_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_4 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 and not isNil(var_69_3) then
				if arg_66_1.var_.characterEffect1019ui_story and not isNil(var_69_3) then
					arg_66_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 and not isNil(var_69_3) and arg_66_1.var_.characterEffect1019ui_story then
				arg_66_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_69_6 = 0
			local var_69_7 = 0.275

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
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

				local var_69_8 = arg_66_1:GetWordFromCfg(305072014)
				local var_69_9 = arg_66_1:FormatText(var_69_8.content)

				arg_66_1.text_.text = var_69_9

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 11 <= 0 and var_69_7 or var_69_7 * (utf8.len(var_69_9) / 11)

				if (11 <= 0 and var_69_7 or var_69_7 * (utf8.len(var_69_9) / 11)) > 0 and var_69_7 < var_69_11 then
					arg_66_1.talkMaxDuration = var_69_11

					if var_69_11 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_11 + var_69_6
					end
				end

				arg_66_1.text_.text = var_69_9
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072014", "story_v_out_305072.awb") ~= 0 then
					local var_69_12 = manager.audio:GetVoiceLength("story_v_out_305072", "305072014", "story_v_out_305072.awb") / 1000

					if var_69_12 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_12 + var_69_6
					end

					if var_69_8.prefab_name ~= "" and arg_66_1.actors_[var_69_8.prefab_name] ~= nil then
						local var_69_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_8.prefab_name].transform, "story_v_out_305072", "305072014", "story_v_out_305072.awb")

						arg_66_1:RecordAudio("305072014", var_69_13)
						arg_66_1:RecordAudio("305072014", var_69_13)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_305072", "305072014", "story_v_out_305072.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_305072", "305072014", "story_v_out_305072.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_14 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_14 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_14

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_14 and arg_66_1.time_ < var_69_6 + var_69_14 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play305072015 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 305072015
		arg_70_1.duration_ = 3.1

		local var_70_0 = {
			zh = 3.1,
			ja = 1.699999999999
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
				arg_70_0:Play305072016(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1084ui_story"]) and arg_70_1.var_.characterEffect1084ui_story == nil then
				arg_70_1.var_.characterEffect1084ui_story = arg_70_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1084ui_story"]) then
				if arg_70_1.var_.characterEffect1084ui_story and not isNil(arg_70_1.actors_["1084ui_story"]) then
					arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1084ui_story"]) and arg_70_1.var_.characterEffect1084ui_story then
				arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_73_2 = arg_70_1.actors_["1019ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect1019ui_story == nil then
				arg_70_1.var_.characterEffect1019ui_story = var_73_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_3 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 and not isNil(var_73_2) then
				if arg_70_1.var_.characterEffect1019ui_story and not isNil(var_73_2) then
					arg_70_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_3)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect1019ui_story then
				arg_70_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0.2 < arg_70_1.time_ and arg_70_1.time_ <= 0.2 + arg_73_0 then
				arg_70_1:AudioAction("play", "effect", "se_story_5", "se_story_5_lastcharge", "")
			end

			if 0.7 < arg_70_1.time_ and arg_70_1.time_ <= 0.7 + arg_73_0 then
				arg_70_1:AudioAction("play", "effect", "se_story_5", "se_story_5_lastcharge_loop", "")
			end

			local var_73_6 = 0
			local var_73_7 = 0.325

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_8 = arg_70_1:GetWordFromCfg(305072015)
				local var_73_9 = arg_70_1:FormatText(var_73_8.content)

				arg_70_1.text_.text = var_73_9

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 13 <= 0 and var_73_7 or var_73_7 * (utf8.len(var_73_9) / 13)

				if (13 <= 0 and var_73_7 or var_73_7 * (utf8.len(var_73_9) / 13)) > 0 and var_73_7 < var_73_11 then
					arg_70_1.talkMaxDuration = var_73_11

					if var_73_11 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_11 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_9
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072015", "story_v_out_305072.awb") ~= 0 then
					local var_73_12 = manager.audio:GetVoiceLength("story_v_out_305072", "305072015", "story_v_out_305072.awb") / 1000

					if var_73_12 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_12 + var_73_6
					end

					if var_73_8.prefab_name ~= "" and arg_70_1.actors_[var_73_8.prefab_name] ~= nil then
						local var_73_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_8.prefab_name].transform, "story_v_out_305072", "305072015", "story_v_out_305072.awb")

						arg_70_1:RecordAudio("305072015", var_73_13)
						arg_70_1:RecordAudio("305072015", var_73_13)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_305072", "305072015", "story_v_out_305072.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_305072", "305072015", "story_v_out_305072.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_14 and arg_70_1.time_ < var_73_6 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play305072016 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 305072016
		arg_74_1.duration_ = 4.7

		local var_74_0 = {
			zh = 4.7,
			ja = 1.333
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
				arg_74_0:Play305072017(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.55

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_1 = arg_74_1:GetWordFromCfg(305072016)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 22 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 22)

				if (22 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 22)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072016", "story_v_out_305072.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_out_305072", "305072016", "story_v_out_305072.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_out_305072", "305072016", "story_v_out_305072.awb")

						arg_74_1:RecordAudio("305072016", var_77_6)
						arg_74_1:RecordAudio("305072016", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_305072", "305072016", "story_v_out_305072.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_305072", "305072016", "story_v_out_305072.awb")
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
	Play305072017 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 305072017
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play305072018(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1084ui_story"]) and arg_78_1.var_.characterEffect1084ui_story == nil then
				arg_78_1.var_.characterEffect1084ui_story = arg_78_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1084ui_story"]) then
				if arg_78_1.var_.characterEffect1084ui_story and not isNil(arg_78_1.actors_["1084ui_story"]) then
					arg_78_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_0)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1084ui_story"]) and arg_78_1.var_.characterEffect1084ui_story then
				arg_78_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0.2 < arg_78_1.time_ and arg_78_1.time_ <= 0.2 + arg_81_0 then
				arg_78_1:AudioAction("stop", "effect", "se_story_5", "se_story_5_lastcharge_loop", "")
			end

			if 0.2 < arg_78_1.time_ and arg_78_1.time_ <= 0.2 + arg_81_0 then
				arg_78_1:AudioAction("play", "effect", "se_story_5", "se_story_5_laststrike", "")
			end

			local var_81_3 = 0
			local var_81_4 = 0.775

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

				local var_81_5 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(305072017).content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 31 <= 0 and var_81_4 or var_81_4 * (utf8.len(var_81_5) / 31)

				if (31 <= 0 and var_81_4 or var_81_4 * (utf8.len(var_81_5) / 31)) > 0 and var_81_4 < var_81_7 then
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
	Play305072018 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 305072018
		arg_82_1.duration_ = 10.3

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play305072019(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_9001
			local var_85_9000

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				local var_85_0 = arg_82_1.var_.effect恶趣味

				if not arg_82_1.var_.effect恶趣味 then
					var_85_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang07"), manager.ui.mainCamera.transform)
					var_85_0.name = "恶趣味"
					arg_82_1.var_.effect恶趣味 = var_85_0
				else
					var_85_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_85_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_85_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_85_0.transform.localScale = Vector3.New(var_85_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_85_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_85_0.transform.localScale.z)
			end

			if 3.1 < arg_82_1.time_ and arg_82_1.time_ <= 3.1 + arg_85_0 then
				if arg_82_1.var_.effect恶趣味 then
					Object.Destroy(arg_82_1.var_.effect恶趣味)

					arg_82_1.var_.effect恶趣味 = nil
				end
			end

			local var_85_3 = 1.63931569838896

			if 1.63931569838896 < arg_82_1.time_ and arg_82_1.time_ <= var_85_3 + arg_85_0 then
				arg_82_1.mask_.enabled = true
				arg_82_1.mask_.raycastTarget = true

				arg_82_1:SetGaussion(false)
			end

			local var_85_4 = 0.460218196641653

			if var_85_3 <= arg_82_1.time_ and arg_82_1.time_ < var_85_3 + var_85_4 then
				local var_85_5 = Color.New(1, 1, 1)

				var_85_5.a = Mathf.Lerp(1, 0, (arg_82_1.time_ - var_85_3) / var_85_4)
				arg_82_1.mask_.color = var_85_5
			end

			if arg_82_1.time_ >= var_85_3 + var_85_4 and arg_82_1.time_ < var_85_3 + var_85_4 + arg_85_0 then
				local var_85_6 = Color.New(1, 1, 1)

				arg_82_1.mask_.enabled = false
				var_85_6.a = 0
				arg_82_1.mask_.color = var_85_6
			end

			local var_85_7 = 2.09953389503062

			if 2.09953389503062 < arg_82_1.time_ and arg_82_1.time_ <= var_85_7 + arg_85_0 then
				arg_82_1.mask_.enabled = true
				arg_82_1.mask_.raycastTarget = true

				arg_82_1:SetGaussion(false)
			end

			local var_85_8 = 0.460218196641653

			if var_85_7 <= arg_82_1.time_ and arg_82_1.time_ < var_85_7 + var_85_8 then
				local var_85_9 = Color.New(1, 1, 1)

				var_85_9.a = Mathf.Lerp(1, 0, (arg_82_1.time_ - var_85_7) / var_85_8)
				arg_82_1.mask_.color = var_85_9
			end

			if arg_82_1.time_ >= var_85_7 + var_85_8 and arg_82_1.time_ < var_85_7 + var_85_8 + arg_85_0 then
				local var_85_10 = Color.New(1, 1, 1)

				arg_82_1.mask_.enabled = false
				var_85_10.a = 0
				arg_82_1.mask_.color = var_85_10
			end

			if 2 < arg_82_1.time_ and arg_82_1.time_ <= 2 + arg_85_0 then
				if arg_82_1.var_.effect烦烦烦 then
					Object.Destroy(arg_82_1.var_.effect烦烦烦)

					arg_82_1.var_.effect烦烦烦 = nil
				end
			end

			if 2.55975209167227 < arg_82_1.time_ and arg_82_1.time_ <= 2.55975209167227 + arg_85_0 then
				local var_85_12 = arg_82_1.var_.effect112336

				if not arg_82_1.var_.effect112336 then
					var_85_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redtwister_out"), manager.ui.mainCamera.transform)
					var_85_12.name = "112336"
					arg_82_1.var_.effect112336 = var_85_12
				else
					var_85_12.transform:SetParent(var_85_9001)
				end

				var_85_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_85_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 5.2 < arg_82_1.time_ and arg_82_1.time_ <= 5.2 + arg_85_0 then
				if arg_82_1.var_.effect112336 then
					Object.Destroy(arg_82_1.var_.effect112336)

					arg_82_1.var_.effect112336 = nil
				end
			end

			if 2.8 < arg_82_1.time_ and arg_82_1.time_ <= 2.8 + arg_85_0 then
				local var_85_15 = arg_82_1.var_.effect不不不

				if not arg_82_1.var_.effect不不不 then
					var_85_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), manager.ui.mainCamera.transform)
					var_85_15.name = "不不不"
					arg_82_1.var_.effect不不不 = var_85_15
				else
					var_85_15.transform:SetParent(var_85_9000)
				end

				var_85_15.transform.localPosition = Vector3.New(0, 0.1, -1.73)
				var_85_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_85_15.transform.localScale = Vector3.New(var_85_15.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_85_15.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_85_15.transform.localScale.z)
			end

			if 5.35096293420841 < arg_82_1.time_ and arg_82_1.time_ <= 5.35096293420841 + arg_85_0 then
				if arg_82_1.var_.effect不不不 then
					Object.Destroy(arg_82_1.var_.effect不不不)

					arg_82_1.var_.effect不不不 = nil
				end
			end

			if 2.8 < arg_82_1.time_ and arg_82_1.time_ <= 2.8 + arg_85_0 then
				if arg_82_1.var_.effect热热 then
					Object.Destroy(arg_82_1.var_.effect热热)

					arg_82_1.var_.effect热热 = nil
				end
			end

			local var_85_19 = 0

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_19 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			if arg_82_1.time_ >= var_85_19 + 5.46666666666667 and arg_82_1.time_ < var_85_19 + 5.46666666666667 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end

			local var_85_20 = arg_82_1.bgs_.S0505.transform

			if 3.3402479053475 < arg_82_1.time_ and arg_82_1.time_ <= 3.3402479053475 + arg_85_0 then
				arg_82_1.var_.moveOldPosS0505 = var_85_20.localPosition
			end

			local var_85_21 = 1.5597520946525

			if 3.3402479053475 <= arg_82_1.time_ and arg_82_1.time_ < 3.3402479053475 + var_85_21 then
				var_85_20.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPosS0505, Vector3.New(0, 0.1, 4.11), (arg_82_1.time_ - 3.3402479053475) / var_85_21)
			end

			if arg_82_1.time_ >= 3.3402479053475 + var_85_21 and arg_82_1.time_ < 3.3402479053475 + var_85_21 + arg_85_0 then
				var_85_20.localPosition = Vector3.New(0, 0.1, 4.11)
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_explosion", "")
			end

			if arg_82_1.frameCnt_ <= 1 then
				arg_82_1.dialog_:SetActive(false)
			end

			local var_85_24 = 5.3
			local var_85_25 = 1.7

			if 5.3 < arg_82_1.time_ and arg_82_1.time_ <= var_85_24 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				arg_82_1.dialog_:SetActive(true)

				arg_82_1.dialogCg_.alpha = 0

				local var_85_26 = LeanTween.value(arg_82_1.dialog_, 0, 1, 0.3)

				var_85_26:setOnUpdate(LuaHelper.FloatAction(function(arg_86_0)
					arg_82_1.dialogCg_.alpha = arg_86_0
				end))
				var_85_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_82_1.dialog_)
					var_85_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_82_1.duration_ = arg_82_1.duration_ + 0.3

				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_27 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(305072018).content)

				arg_82_1.text_.text = var_85_27

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_29 = 68 <= 0 and var_85_25 or var_85_25 * (utf8.len(var_85_27) / 68)

				if (68 <= 0 and var_85_25 or var_85_25 * (utf8.len(var_85_27) / 68)) > 0 and var_85_25 < var_85_29 then
					arg_82_1.talkMaxDuration = var_85_29
					var_85_24 = var_85_24 + 0.3

					if var_85_29 + var_85_24 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_29 + var_85_24
					end
				end

				arg_82_1.text_.text = var_85_27
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_30 = var_85_24 + 0.3
			local var_85_31 = math.max(var_85_25, arg_82_1.talkMaxDuration)

			if var_85_24 + 0.3 <= arg_82_1.time_ and arg_82_1.time_ < var_85_30 + var_85_31 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_30) / var_85_31

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_30 + var_85_31 and arg_82_1.time_ < var_85_30 + var_85_31 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0505",
				frequency = 10,
				className = "StoryShakeNode",
				duration = 1.69684893920397,
				startTime = 1.00244506166006,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.BACKGROUND,
				offset = Vector3.New(0.05, 0.05, 0.1)
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "S0505",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.5597520946525,
				startTime = 3.3402479053475,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.59),
					endPos = Vector3.New(0, 0.1, 4.11),
					easeType = LeanTweenType.easeInOutQuart
				}
			},
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 1.3402479053475,
				amplitudeGain = 1,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play305072019 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 305072019
		arg_88_1.duration_ = 10.8

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play305072020(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 2.36666666666667 < arg_88_1.time_ and arg_88_1.time_ <= 2.36666666666667 + arg_91_0 then
				local var_91_0 = arg_88_1.bgs_.B12

				arg_88_1.bgs_.B12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_91_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_1 = var_91_0:GetComponent("SpriteRenderer")

				if var_91_1 and var_91_1.sprite then
					local var_91_2 = 2 * (var_91_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_91_0.transform.localScale = Vector3.New(var_91_2 / var_91_1.sprite.bounds.size.y < var_91_2 * manager.ui.mainCameraCom_.aspect / var_91_1.sprite.bounds.size.x and var_91_2 * manager.ui.mainCameraCom_.aspect / var_91_1.sprite.bounds.size.x or var_91_2 / var_91_1.sprite.bounds.size.y, var_91_2 / var_91_1.sprite.bounds.size.y < var_91_2 * manager.ui.mainCameraCom_.aspect / var_91_1.sprite.bounds.size.x and var_91_2 * manager.ui.mainCameraCom_.aspect / var_91_1.sprite.bounds.size.x or var_91_2 / var_91_1.sprite.bounds.size.y, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "B12" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_91_3 = 0

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_3 + arg_91_0 then
				arg_88_1.allBtn_.enabled = false
			end

			if arg_88_1.time_ >= var_91_3 + 0.3 and arg_88_1.time_ < var_91_3 + 0.3 + arg_91_0 then
				arg_88_1.allBtn_.enabled = true
			end

			local var_91_4 = 0

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_5 = 2.36666666666667

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_5 then
				local var_91_6 = Color.New(0.9433962, 0.9433962, 0.9433962)

				var_91_6.a = Mathf.Lerp(0, 1, (arg_88_1.time_ - var_91_4) / var_91_5)
				arg_88_1.mask_.color = var_91_6
			end

			if arg_88_1.time_ >= var_91_4 + var_91_5 and arg_88_1.time_ < var_91_4 + var_91_5 + arg_91_0 then
				local var_91_7 = Color.New(0.9433962, 0.9433962, 0.9433962)

				var_91_7.a = 1
				arg_88_1.mask_.color = var_91_7
			end

			local var_91_8 = 2.36666666666667

			if 2.36666666666667 < arg_88_1.time_ and arg_88_1.time_ <= var_91_8 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_9 = 2.53333333333333

			if var_91_8 <= arg_88_1.time_ and arg_88_1.time_ < var_91_8 + var_91_9 then
				local var_91_10 = Color.New(0.9433962, 0.9433962, 0.9433962)

				var_91_10.a = Mathf.Lerp(1, 0, (arg_88_1.time_ - var_91_8) / var_91_9)
				arg_88_1.mask_.color = var_91_10
			end

			if arg_88_1.time_ >= var_91_8 + var_91_9 and arg_88_1.time_ < var_91_8 + var_91_9 + arg_91_0 then
				local var_91_11 = Color.New(0.9433962, 0.9433962, 0.9433962)

				arg_88_1.mask_.enabled = false
				var_91_11.a = 0
				arg_88_1.mask_.color = var_91_11
			end

			local var_91_12 = 4.6

			if 4.6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_12 + arg_91_0 then
				arg_88_1.allBtn_.enabled = false
			end

			if arg_88_1.time_ >= var_91_12 + 1.96666666666667 and arg_88_1.time_ < var_91_12 + 1.96666666666667 + arg_91_0 then
				arg_88_1.allBtn_.enabled = true
			end

			if 1 < arg_88_1.time_ and arg_88_1.time_ <= 1 + arg_91_0 then
				arg_88_1:AudioAction("play", "music", "bgm_activity_5_2_story_source", "bgm_activity_5_2_story_source", "bgm_activity_5_2_story_source.awb")

				local var_91_15 = manager.audio:GetAudioName("bgm_activity_5_2_story_source", "bgm_activity_5_2_story_source")

				if "" ~= "" then
					if arg_88_1.bgmTxt_.text ~= var_91_15 and arg_88_1.bgmTxt_.text ~= "" then
						if arg_88_1.bgmTxt2_.text ~= "" then
							arg_88_1.bgmTxt_.text = arg_88_1.bgmTxt2_.text
						end

						arg_88_1.bgmTxt2_.text = var_91_15

						arg_88_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_88_1.bgmTxt_.text = var_91_15
						arg_88_1.bgmTxt2_.text = var_91_15
					end

					if arg_88_1.bgmTimer then
						arg_88_1.bgmTimer:Stop()

						arg_88_1.bgmTimer = nil
					end

					if arg_88_1.settingData.show_music_name == 1 then
						arg_88_1.musicController:SetSelectedState("show")
						arg_88_1.musicAnimator_:Play("open", 0, 0)

						if arg_88_1.settingData.music_time ~= 0 then
							arg_88_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_88_1.settingData.music_time), function()
								if arg_88_1 == nil or isNil(arg_88_1.bgmTxt_) then
									return
								end

								arg_88_1.musicController:SetSelectedState("hide")
								arg_88_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_16 = 5.8
			local var_91_17 = 1.4

			if 5.8 < arg_88_1.time_ and arg_88_1.time_ <= var_91_16 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_18 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_18:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_88_1.dialogCg_.alpha = arg_93_0
				end))
				var_91_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_19 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(305072019).content)

				arg_88_1.text_.text = var_91_19

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_21 = 56 <= 0 and var_91_17 or var_91_17 * (utf8.len(var_91_19) / 56)

				if (56 <= 0 and var_91_17 or var_91_17 * (utf8.len(var_91_19) / 56)) > 0 and var_91_17 < var_91_21 then
					arg_88_1.talkMaxDuration = var_91_21
					var_91_16 = var_91_16 + 0.3

					if var_91_21 + var_91_16 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_21 + var_91_16
					end
				end

				arg_88_1.text_.text = var_91_19
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_22 = var_91_16 + 0.3
			local var_91_23 = math.max(var_91_17, arg_88_1.talkMaxDuration)

			if var_91_16 + 0.3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_22 + var_91_23 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_22) / var_91_23

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_22 + var_91_23 and arg_88_1.time_ < var_91_22 + var_91_23 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play305072020 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 305072020
		arg_95_1.duration_ = 4.6

		local var_95_0 = {
			zh = 4.6,
			ja = 1.999999999999
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
				arg_95_0:Play305072021(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1084ui_story = arg_95_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1084ui_story"].transform.position).z)
				arg_95_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1084ui_story"].transform.localEulerAngles = arg_95_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_95_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1084ui_story"].transform.position).z)
				arg_95_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1084ui_story"].transform.localEulerAngles = arg_95_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["1084ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1084ui_story == nil then
				arg_95_1.var_.characterEffect1084ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1084ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1084ui_story then
				arg_95_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_98_4 = 0
			local var_98_5 = 0.225

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(305072020)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 9 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 9)

				if (9 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 9)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072020", "story_v_out_305072.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_out_305072", "305072020", "story_v_out_305072.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_out_305072", "305072020", "story_v_out_305072.awb")

						arg_95_1:RecordAudio("305072020", var_98_11)
						arg_95_1:RecordAudio("305072020", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_305072", "305072020", "story_v_out_305072.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_305072", "305072020", "story_v_out_305072.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play305072021 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 305072021
		arg_99_1.duration_ = 4.53

		local var_99_0 = {
			zh = 2.666,
			ja = 4.533
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
				arg_99_0:Play305072022(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1019ui_story = arg_99_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1019ui_story"].transform.position).z)
				arg_99_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1019ui_story"].transform.localEulerAngles = arg_99_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.9)
				arg_99_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1019ui_story"].transform.position).z)
				arg_99_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1019ui_story"].transform.localEulerAngles = arg_99_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["1019ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1019ui_story == nil then
				arg_99_1.var_.characterEffect1019ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect1019ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1019ui_story then
				arg_99_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_102_4 = arg_99_1.actors_["1084ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.characterEffect1084ui_story == nil then
				arg_99_1.var_.characterEffect1084ui_story = var_102_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_5 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_5 and not isNil(var_102_4) then
				if arg_99_1.var_.characterEffect1084ui_story and not isNil(var_102_4) then
					arg_99_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_5)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_5 and arg_99_1.time_ < 0 + var_102_5 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.characterEffect1084ui_story then
				arg_99_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_102_6 = 0
			local var_102_7 = 0.25

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_8 = arg_99_1:GetWordFromCfg(305072021)
				local var_102_9 = arg_99_1:FormatText(var_102_8.content)

				arg_99_1.text_.text = var_102_9

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_11 = 10 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 10)

				if (10 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 10)) > 0 and var_102_7 < var_102_11 then
					arg_99_1.talkMaxDuration = var_102_11

					if var_102_11 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_11 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_9
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072021", "story_v_out_305072.awb") ~= 0 then
					local var_102_12 = manager.audio:GetVoiceLength("story_v_out_305072", "305072021", "story_v_out_305072.awb") / 1000

					if var_102_12 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_12 + var_102_6
					end

					if var_102_8.prefab_name ~= "" and arg_99_1.actors_[var_102_8.prefab_name] ~= nil then
						local var_102_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_8.prefab_name].transform, "story_v_out_305072", "305072021", "story_v_out_305072.awb")

						arg_99_1:RecordAudio("305072021", var_102_13)
						arg_99_1:RecordAudio("305072021", var_102_13)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_305072", "305072021", "story_v_out_305072.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_305072", "305072021", "story_v_out_305072.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_14 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_14 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_14

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_14 and arg_99_1.time_ < var_102_6 + var_102_14 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play305072022 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 305072022
		arg_103_1.duration_ = 6.53

		local var_103_0 = {
			zh = 6.533,
			ja = 1.999999999999
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
				arg_103_0:Play305072023(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1084ui_story"]) and arg_103_1.var_.characterEffect1084ui_story == nil then
				arg_103_1.var_.characterEffect1084ui_story = arg_103_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1084ui_story"]) then
				if arg_103_1.var_.characterEffect1084ui_story and not isNil(arg_103_1.actors_["1084ui_story"]) then
					arg_103_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1084ui_story"]) and arg_103_1.var_.characterEffect1084ui_story then
				arg_103_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_106_2 = arg_103_1.actors_["1019ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.characterEffect1019ui_story == nil then
				arg_103_1.var_.characterEffect1019ui_story = var_106_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_3 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_3 and not isNil(var_106_2) then
				if arg_103_1.var_.characterEffect1019ui_story and not isNil(var_106_2) then
					arg_103_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_3)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_3 and arg_103_1.time_ < 0 + var_106_3 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.characterEffect1019ui_story then
				arg_103_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_106_4 = 0
			local var_106_5 = 0.7

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(305072022)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 28 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 28)

				if (28 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 28)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072022", "story_v_out_305072.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_out_305072", "305072022", "story_v_out_305072.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_out_305072", "305072022", "story_v_out_305072.awb")

						arg_103_1:RecordAudio("305072022", var_106_11)
						arg_103_1:RecordAudio("305072022", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_305072", "305072022", "story_v_out_305072.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_305072", "305072022", "story_v_out_305072.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_12 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_12 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_12

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_12 and arg_103_1.time_ < var_106_4 + var_106_12 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play305072023 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 305072023
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play305072024(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1084ui_story"]) and arg_107_1.var_.characterEffect1084ui_story == nil then
				arg_107_1.var_.characterEffect1084ui_story = arg_107_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1084ui_story"]) then
				if arg_107_1.var_.characterEffect1084ui_story and not isNil(arg_107_1.actors_["1084ui_story"]) then
					arg_107_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1084ui_story"]) and arg_107_1.var_.characterEffect1084ui_story then
				arg_107_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_110_1 = 0
			local var_110_2 = 0.575

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_3 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(305072023).content)

				arg_107_1.text_.text = var_110_3

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 23 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 23)

				if (23 <= 0 and var_110_2 or var_110_2 * (utf8.len(var_110_3) / 23)) > 0 and var_110_2 < var_110_5 then
					arg_107_1.talkMaxDuration = var_110_5

					if var_110_5 + var_110_1 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + var_110_1
					end
				end

				arg_107_1.text_.text = var_110_3
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_6 = math.max(var_110_2, arg_107_1.talkMaxDuration)

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_6 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_1) / var_110_6

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_1 + var_110_6 and arg_107_1.time_ < var_110_1 + var_110_6 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play305072024 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 305072024
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play305072025(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1084ui_story = arg_111_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_114_0 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 then
				arg_111_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_0)
				arg_111_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1084ui_story"].transform.position).z)
				arg_111_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1084ui_story"].transform.localEulerAngles = arg_111_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 then
				arg_111_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_111_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_111_1.actors_["1084ui_story"].transform.position).z)
				arg_111_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_111_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_111_1.actors_["1084ui_story"].transform.localEulerAngles = arg_111_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_114_1 = arg_111_1.actors_["1019ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1019ui_story = var_114_1.localPosition
			end

			local var_114_2 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 then
				var_114_1.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_2)
				var_114_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_1.position).x, (manager.ui.mainCamera.transform.position - var_114_1.position).y, (manager.ui.mainCamera.transform.position - var_114_1.position).z)
				var_114_1.localEulerAngles.z = 0
				var_114_1.localEulerAngles.x = 0
				var_114_1.localEulerAngles = var_114_1.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 then
				var_114_1.localPosition = Vector3.New(0, 100, 0)
				var_114_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_1.position).x, (manager.ui.mainCamera.transform.position - var_114_1.position).y, (manager.ui.mainCamera.transform.position - var_114_1.position).z)
				var_114_1.localEulerAngles.z = 0
				var_114_1.localEulerAngles.x = 0
				var_114_1.localEulerAngles = var_114_1.localEulerAngles
			end

			local var_114_3 = 0
			local var_114_4 = 1.175

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_3 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_5 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(305072024).content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 47 <= 0 and var_114_4 or var_114_4 * (utf8.len(var_114_5) / 47)

				if (47 <= 0 and var_114_4 or var_114_4 * (utf8.len(var_114_5) / 47)) > 0 and var_114_4 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_3 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_3
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_8 = math.max(var_114_4, arg_111_1.talkMaxDuration)

			if var_114_3 <= arg_111_1.time_ and arg_111_1.time_ < var_114_3 + var_114_8 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_3) / var_114_8

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_3 + var_114_8 and arg_111_1.time_ < var_114_3 + var_114_8 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play305072025 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 305072025
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play305072026(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.625

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_1 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(305072025).content)

				arg_115_1.text_.text = var_118_1

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_3 = 25 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 25)

				if (25 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 25)) > 0 and var_118_0 < var_118_3 then
					arg_115_1.talkMaxDuration = var_118_3

					if var_118_3 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_3 + 0
					end
				end

				arg_115_1.text_.text = var_118_1
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_4 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_4

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play305072026 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 305072026
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play305072027(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.5

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(305072026).content)

				arg_119_1.text_.text = var_122_1

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_3 = 20 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 20)

				if (20 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 20)) > 0 and var_122_0 < var_122_3 then
					arg_119_1.talkMaxDuration = var_122_3

					if var_122_3 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_3 + 0
					end
				end

				arg_119_1.text_.text = var_122_1
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_4 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_4

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play305072027 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 305072027
		arg_123_1.duration_ = 8.57

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play305072028(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if arg_123_1.bgs_.S0507 == nil then
				local var_126_0 = Object.Instantiate(arg_123_1.paintGo_)

				var_126_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0507")
				var_126_0.name = "S0507"
				var_126_0.transform.parent = arg_123_1.stage_.transform
				var_126_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.bgs_.S0507 = var_126_0
			end

			if 2 < arg_123_1.time_ and arg_123_1.time_ <= 2 + arg_126_0 then
				local var_126_1 = arg_123_1.bgs_.S0507

				arg_123_1.bgs_.S0507.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_126_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_126_2 = var_126_1:GetComponent("SpriteRenderer")

				if var_126_2 and var_126_2.sprite then
					local var_126_3 = 2 * (var_126_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_126_1.transform.localScale = Vector3.New(var_126_3 / var_126_2.sprite.bounds.size.y < var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x and var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x or var_126_3 / var_126_2.sprite.bounds.size.y, var_126_3 / var_126_2.sprite.bounds.size.y < var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x and var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x or var_126_3 / var_126_2.sprite.bounds.size.y, 0)
				end

				for iter_126_0, iter_126_1 in pairs(arg_123_1.bgs_) do
					if iter_126_0 ~= "S0507" then
						iter_126_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_126_4 = 0

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.allBtn_.enabled = false
			end

			if arg_123_1.time_ >= var_126_4 + 0.3 and arg_123_1.time_ < var_126_4 + 0.3 + arg_126_0 then
				arg_123_1.allBtn_.enabled = true
			end

			local var_126_5 = 0

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_6 = 2

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_6 then
				local var_126_7 = Color.New(0, 0, 0)

				var_126_7.a = Mathf.Lerp(0, 1, (arg_123_1.time_ - var_126_5) / var_126_6)
				arg_123_1.mask_.color = var_126_7
			end

			if arg_123_1.time_ >= var_126_5 + var_126_6 and arg_123_1.time_ < var_126_5 + var_126_6 + arg_126_0 then
				local var_126_8 = Color.New(0, 0, 0)

				var_126_8.a = 1
				arg_123_1.mask_.color = var_126_8
			end

			local var_126_9 = 2

			if 2 < arg_123_1.time_ and arg_123_1.time_ <= var_126_9 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_10 = 2

			if var_126_9 <= arg_123_1.time_ and arg_123_1.time_ < var_126_9 + var_126_10 then
				local var_126_11 = Color.New(0, 0, 0)

				var_126_11.a = Mathf.Lerp(1, 0, (arg_123_1.time_ - var_126_9) / var_126_10)
				arg_123_1.mask_.color = var_126_11
			end

			if arg_123_1.time_ >= var_126_9 + var_126_10 and arg_123_1.time_ < var_126_9 + var_126_10 + arg_126_0 then
				local var_126_12 = Color.New(0, 0, 0)

				arg_123_1.mask_.enabled = false
				var_126_12.a = 0
				arg_123_1.mask_.color = var_126_12
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_13 = 3.56666666666667
			local var_126_14 = 1

			if 3.56666666666667 < arg_123_1.time_ and arg_123_1.time_ <= var_126_13 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_15 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_15:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_16 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(305072027).content)

				arg_123_1.text_.text = var_126_16

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_18 = 40 <= 0 and var_126_14 or var_126_14 * (utf8.len(var_126_16) / 40)

				if (40 <= 0 and var_126_14 or var_126_14 * (utf8.len(var_126_16) / 40)) > 0 and var_126_14 < var_126_18 then
					arg_123_1.talkMaxDuration = var_126_18
					var_126_13 = var_126_13 + 0.3

					if var_126_18 + var_126_13 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_18 + var_126_13
					end
				end

				arg_123_1.text_.text = var_126_16
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_19 = var_126_13 + 0.3
			local var_126_20 = math.max(var_126_14, arg_123_1.talkMaxDuration)

			if var_126_13 + 0.3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_19 + var_126_20 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_19) / var_126_20

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_19 + var_126_20 and arg_123_1.time_ < var_126_19 + var_126_20 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play305072028 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 305072028
		arg_129_1.duration_ = 5.4

		local var_129_0 = {
			zh = 3.566,
			ja = 5.4
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
				arg_129_0:Play305072029(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if arg_129_1.actors_["1013ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1013ui_story"))) then
				local var_132_0 = Object.Instantiate(Asset.Load("Char/" .. "1013ui_story"), arg_129_1.stage_.transform)

				var_132_0.name = "1013ui_story"
				var_132_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.actors_["1013ui_story"] = var_132_0

				local var_132_1 = var_132_0:GetComponentInChildren(typeof(CharacterEffect))

				var_132_1.enabled = true

				local var_132_2 = GameObjectTools.GetOrAddComponent(var_132_0, typeof(DynamicBoneHelper))

				if var_132_2 then
					var_132_2:EnableDynamicBone(false)
				end

				arg_129_1:ShowWeapon(var_132_1.transform, false)

				arg_129_1.var_["1013ui_story" .. "Animator"] = var_132_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_129_1.var_["1013ui_story" .. "Animator"].applyRootMotion = true
				arg_129_1.var_["1013ui_story" .. "LipSync"] = var_132_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_132_3 = arg_129_1.actors_["1013ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_3) and arg_129_1.var_.characterEffect1013ui_story == nil then
				arg_129_1.var_.characterEffect1013ui_story = var_132_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_4 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 and not isNil(var_132_3) then
				if arg_129_1.var_.characterEffect1013ui_story and not isNil(var_132_3) then
					arg_129_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 and not isNil(var_132_3) and arg_129_1.var_.characterEffect1013ui_story then
				arg_129_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_132_6 = 0
			local var_132_7 = 0.475

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(305072028)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 19 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 19)

				if (19 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 19)) > 0 and var_132_7 < var_132_11 then
					arg_129_1.talkMaxDuration = var_132_11

					if var_132_11 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072028", "story_v_out_305072.awb") ~= 0 then
					local var_132_12 = manager.audio:GetVoiceLength("story_v_out_305072", "305072028", "story_v_out_305072.awb") / 1000

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end

					if var_132_8.prefab_name ~= "" and arg_129_1.actors_[var_132_8.prefab_name] ~= nil then
						local var_132_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_8.prefab_name].transform, "story_v_out_305072", "305072028", "story_v_out_305072.awb")

						arg_129_1:RecordAudio("305072028", var_132_13)
						arg_129_1:RecordAudio("305072028", var_132_13)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_305072", "305072028", "story_v_out_305072.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_305072", "305072028", "story_v_out_305072.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play305072029 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 305072029
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play305072030(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1013ui_story"]) and arg_133_1.var_.characterEffect1013ui_story == nil then
				arg_133_1.var_.characterEffect1013ui_story = arg_133_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1013ui_story"]) then
				if arg_133_1.var_.characterEffect1013ui_story and not isNil(arg_133_1.actors_["1013ui_story"]) then
					arg_133_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1013ui_story"]) and arg_133_1.var_.characterEffect1013ui_story then
				arg_133_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_136_1 = 0
			local var_136_2 = 1.5

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(305072029).content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 60 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 60)

				if (60 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 60)) > 0 and var_136_2 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_6 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_6 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_6

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_6 and arg_133_1.time_ < var_136_1 + var_136_6 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play305072030 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 305072030
		arg_137_1.duration_ = 6.9

		local var_137_0 = {
			zh = 3.366,
			ja = 6.9
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
				arg_137_0:Play305072031(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if arg_137_1.actors_["10002ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10002ui_story"))) then
				local var_140_0 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_137_1.stage_.transform)

				var_140_0.name = "10002ui_story"
				var_140_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["10002ui_story"] = var_140_0

				local var_140_1 = var_140_0:GetComponentInChildren(typeof(CharacterEffect))

				var_140_1.enabled = true

				local var_140_2 = GameObjectTools.GetOrAddComponent(var_140_0, typeof(DynamicBoneHelper))

				if var_140_2 then
					var_140_2:EnableDynamicBone(false)
				end

				arg_137_1:ShowWeapon(var_140_1.transform, false)

				arg_137_1.var_["10002ui_story" .. "Animator"] = var_140_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_137_1.var_["10002ui_story" .. "Animator"].applyRootMotion = true
				arg_137_1.var_["10002ui_story" .. "LipSync"] = var_140_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_140_3 = arg_137_1.actors_["10002ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_3) and arg_137_1.var_.characterEffect10002ui_story == nil then
				arg_137_1.var_.characterEffect10002ui_story = var_140_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_4 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 and not isNil(var_140_3) then
				if arg_137_1.var_.characterEffect10002ui_story and not isNil(var_140_3) then
					arg_137_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 and not isNil(var_140_3) and arg_137_1.var_.characterEffect10002ui_story then
				arg_137_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_140_6 = 0
			local var_140_7 = 0.4

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_8 = arg_137_1:GetWordFromCfg(305072030)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 16 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 16)

				if (16 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 16)) > 0 and var_140_7 < var_140_11 then
					arg_137_1.talkMaxDuration = var_140_11

					if var_140_11 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072030", "story_v_out_305072.awb") ~= 0 then
					local var_140_12 = manager.audio:GetVoiceLength("story_v_out_305072", "305072030", "story_v_out_305072.awb") / 1000

					if var_140_12 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_6
					end

					if var_140_8.prefab_name ~= "" and arg_137_1.actors_[var_140_8.prefab_name] ~= nil then
						local var_140_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_8.prefab_name].transform, "story_v_out_305072", "305072030", "story_v_out_305072.awb")

						arg_137_1:RecordAudio("305072030", var_140_13)
						arg_137_1:RecordAudio("305072030", var_140_13)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_305072", "305072030", "story_v_out_305072.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_305072", "305072030", "story_v_out_305072.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play305072031 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 305072031
		arg_141_1.duration_ = 8.2

		local var_141_0 = {
			zh = 5.7,
			ja = 8.2
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
				arg_141_0:Play305072032(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0.725

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:GetWordFromCfg(305072031)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 29 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 29)

				if (29 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 29)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072031", "story_v_out_305072.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_305072", "305072031", "story_v_out_305072.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_305072", "305072031", "story_v_out_305072.awb")

						arg_141_1:RecordAudio("305072031", var_144_6)
						arg_141_1:RecordAudio("305072031", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_305072", "305072031", "story_v_out_305072.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_305072", "305072031", "story_v_out_305072.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play305072032 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 305072032
		arg_145_1.duration_ = 7.57

		local var_145_0 = {
			zh = 4.8,
			ja = 7.566
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
				arg_145_0:Play305072033(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1013ui_story"]) and arg_145_1.var_.characterEffect1013ui_story == nil then
				arg_145_1.var_.characterEffect1013ui_story = arg_145_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1013ui_story"]) then
				if arg_145_1.var_.characterEffect1013ui_story and not isNil(arg_145_1.actors_["1013ui_story"]) then
					arg_145_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1013ui_story"]) and arg_145_1.var_.characterEffect1013ui_story then
				arg_145_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_148_2 = arg_145_1.actors_["10002ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect10002ui_story == nil then
				arg_145_1.var_.characterEffect10002ui_story = var_148_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_3 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.characterEffect10002ui_story and not isNil(var_148_2) then
					arg_145_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_145_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_3)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.characterEffect10002ui_story then
				arg_145_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_145_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_148_4 = 0
			local var_148_5 = 0.6

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_6 = arg_145_1:GetWordFromCfg(305072032)
				local var_148_7 = arg_145_1:FormatText(var_148_6.content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 24 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 24)

				if (24 <= 0 and var_148_5 or var_148_5 * (utf8.len(var_148_7) / 24)) > 0 and var_148_5 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_4
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072032", "story_v_out_305072.awb") ~= 0 then
					local var_148_10 = manager.audio:GetVoiceLength("story_v_out_305072", "305072032", "story_v_out_305072.awb") / 1000

					if var_148_10 + var_148_4 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_4
					end

					if var_148_6.prefab_name ~= "" and arg_145_1.actors_[var_148_6.prefab_name] ~= nil then
						local var_148_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_6.prefab_name].transform, "story_v_out_305072", "305072032", "story_v_out_305072.awb")

						arg_145_1:RecordAudio("305072032", var_148_11)
						arg_145_1:RecordAudio("305072032", var_148_11)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_305072", "305072032", "story_v_out_305072.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_305072", "305072032", "story_v_out_305072.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_12 = math.max(var_148_5, arg_145_1.talkMaxDuration)

			if var_148_4 <= arg_145_1.time_ and arg_145_1.time_ < var_148_4 + var_148_12 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_4) / var_148_12

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_4 + var_148_12 and arg_145_1.time_ < var_148_4 + var_148_12 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play305072033 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 305072033
		arg_149_1.duration_ = 8.2

		local var_149_0 = {
			zh = 6.966,
			ja = 8.2
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
				arg_149_0:Play305072034(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10002ui_story"]) and arg_149_1.var_.characterEffect10002ui_story == nil then
				arg_149_1.var_.characterEffect10002ui_story = arg_149_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_0 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10002ui_story"]) then
				if arg_149_1.var_.characterEffect10002ui_story and not isNil(arg_149_1.actors_["10002ui_story"]) then
					arg_149_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10002ui_story"]) and arg_149_1.var_.characterEffect10002ui_story then
				arg_149_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_152_2 = arg_149_1.actors_["1013ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1013ui_story == nil then
				arg_149_1.var_.characterEffect1013ui_story = var_152_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_3 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_3 and not isNil(var_152_2) then
				if arg_149_1.var_.characterEffect1013ui_story and not isNil(var_152_2) then
					arg_149_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_3)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_3 and arg_149_1.time_ < 0 + var_152_3 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.characterEffect1013ui_story then
				arg_149_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_152_4 = 0
			local var_152_5 = 0.95

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:GetWordFromCfg(305072033)
				local var_152_7 = arg_149_1:FormatText(var_152_6.content)

				arg_149_1.text_.text = var_152_7

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_9 = 38 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 38)

				if (38 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_7) / 38)) > 0 and var_152_5 < var_152_9 then
					arg_149_1.talkMaxDuration = var_152_9

					if var_152_9 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_9 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_7
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072033", "story_v_out_305072.awb") ~= 0 then
					local var_152_10 = manager.audio:GetVoiceLength("story_v_out_305072", "305072033", "story_v_out_305072.awb") / 1000

					if var_152_10 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_4
					end

					if var_152_6.prefab_name ~= "" and arg_149_1.actors_[var_152_6.prefab_name] ~= nil then
						local var_152_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_6.prefab_name].transform, "story_v_out_305072", "305072033", "story_v_out_305072.awb")

						arg_149_1:RecordAudio("305072033", var_152_11)
						arg_149_1:RecordAudio("305072033", var_152_11)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_305072", "305072033", "story_v_out_305072.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_305072", "305072033", "story_v_out_305072.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_12 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_12 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_12

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_12 and arg_149_1.time_ < var_152_4 + var_152_12 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play305072034 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 305072034
		arg_153_1.duration_ = 7.03

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play305072035(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_9000

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10002ui_story"]) and arg_153_1.var_.characterEffect10002ui_story == nil then
				arg_153_1.var_.characterEffect10002ui_story = arg_153_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10002ui_story"]) then
				if arg_153_1.var_.characterEffect10002ui_story and not isNil(arg_153_1.actors_["10002ui_story"]) then
					arg_153_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10002ui_story"]) and arg_153_1.var_.characterEffect10002ui_story then
				arg_153_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_156_1 = arg_153_1.bgs_.S0507.transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPosS0507 = var_156_1.localPosition
			end

			local var_156_2 = 1.8

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 then
				var_156_1.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPosS0507, Vector3.New(0, 0.56, 7), (arg_153_1.time_ - 0) / var_156_2)
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 then
				var_156_1.localPosition = Vector3.New(0, 0.56, 7)
			end

			if 0.6 < arg_153_1.time_ and arg_153_1.time_ <= 0.6 + arg_156_0 then
				local var_156_3 = arg_153_1.var_.effect忍忍忍人

				if not arg_153_1.var_.effect忍忍忍人 then
					var_156_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_datablock_white"), manager.ui.mainCamera.transform)
					var_156_3.name = "忍忍忍人"
					arg_153_1.var_.effect忍忍忍人 = var_156_3
				else
					var_156_3.transform:SetParent(var_156_9000)
				end

				var_156_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_156_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.73572979485616 < arg_153_1.time_ and arg_153_1.time_ <= 4.73572979485616 + arg_156_0 then
				if arg_153_1.var_.effect忍忍忍人 then
					Object.Destroy(arg_153_1.var_.effect忍忍忍人)

					arg_153_1.var_.effect忍忍忍人 = nil
				end
			end

			local var_156_6 = 0

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				arg_153_1.allBtn_.enabled = false
			end

			if arg_153_1.time_ >= var_156_6 + 2.03333333333333 and arg_153_1.time_ < var_156_6 + 2.03333333333333 + arg_156_0 then
				arg_153_1.allBtn_.enabled = true
			end

			if arg_153_1.frameCnt_ <= 1 then
				arg_153_1.dialog_:SetActive(false)
			end

			local var_156_7 = 2.03333333333333
			local var_156_8 = 1.425

			if 2.03333333333333 < arg_153_1.time_ and arg_153_1.time_ <= var_156_7 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				arg_153_1.dialog_:SetActive(true)

				arg_153_1.dialogCg_.alpha = 0

				local var_156_9 = LeanTween.value(arg_153_1.dialog_, 0, 1, 0.3)

				var_156_9:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_153_1.dialogCg_.alpha = arg_157_0
				end))
				var_156_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_153_1.dialog_)
					var_156_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_153_1.duration_ = arg_153_1.duration_ + 0.3

				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_10 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(305072034).content)

				arg_153_1.text_.text = var_156_10

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_12 = 57 <= 0 and var_156_8 or var_156_8 * (utf8.len(var_156_10) / 57)

				if (57 <= 0 and var_156_8 or var_156_8 * (utf8.len(var_156_10) / 57)) > 0 and var_156_8 < var_156_12 then
					arg_153_1.talkMaxDuration = var_156_12
					var_156_7 = var_156_7 + 0.3

					if var_156_12 + var_156_7 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_12 + var_156_7
					end
				end

				arg_153_1.text_.text = var_156_10
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_13 = var_156_7 + 0.3
			local var_156_14 = math.max(var_156_8, arg_153_1.talkMaxDuration)

			if var_156_7 + 0.3 <= arg_153_1.time_ and arg_153_1.time_ < var_156_13 + var_156_14 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_13) / var_156_14

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_13 + var_156_14 and arg_153_1.time_ < var_156_13 + var_156_14 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "S0507",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.8,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 0.56, 7),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play305072035 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 305072035
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play305072036(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.25

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(305072035).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 50 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 50)

				if (50 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 50)) > 0 and var_162_0 < var_162_3 then
					arg_159_1.talkMaxDuration = var_162_3

					if var_162_3 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_3 + 0
					end
				end

				arg_159_1.text_.text = var_162_1
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_4 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_4

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play305072036 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 305072036
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play305072037(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.85

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(305072036).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 34 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 34)

				if (34 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 34)) > 0 and var_166_0 < var_166_3 then
					arg_163_1.talkMaxDuration = var_166_3

					if var_166_3 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_3 + 0
					end
				end

				arg_163_1.text_.text = var_166_1
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_4 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_4 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_4

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_4 and arg_163_1.time_ < 0 + var_166_4 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play305072037 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 305072037
		arg_167_1.duration_ = 5.87

		local var_167_0 = {
			zh = 5.866,
			ja = 4.4
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play305072038(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["10002ui_story"]) and arg_167_1.var_.characterEffect10002ui_story == nil then
				arg_167_1.var_.characterEffect10002ui_story = arg_167_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["10002ui_story"]) then
				if arg_167_1.var_.characterEffect10002ui_story and not isNil(arg_167_1.actors_["10002ui_story"]) then
					arg_167_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["10002ui_story"]) and arg_167_1.var_.characterEffect10002ui_story then
				arg_167_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_170_2 = 0
			local var_170_3 = 0.375

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_4 = arg_167_1:GetWordFromCfg(305072037)
				local var_170_5 = arg_167_1:FormatText(var_170_4.content)

				arg_167_1.text_.text = var_170_5

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_7 = 15 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 15)

				if (15 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 15)) > 0 and var_170_3 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_5
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072037", "story_v_out_305072.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_305072", "305072037", "story_v_out_305072.awb") / 1000

					if var_170_8 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_2
					end

					if var_170_4.prefab_name ~= "" and arg_167_1.actors_[var_170_4.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_4.prefab_name].transform, "story_v_out_305072", "305072037", "story_v_out_305072.awb")

						arg_167_1:RecordAudio("305072037", var_170_9)
						arg_167_1:RecordAudio("305072037", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_305072", "305072037", "story_v_out_305072.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_305072", "305072037", "story_v_out_305072.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_3, arg_167_1.talkMaxDuration)

			if var_170_2 <= arg_167_1.time_ and arg_167_1.time_ < var_170_2 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_2) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_2 + var_170_10 and arg_167_1.time_ < var_170_2 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play305072038 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 305072038
		arg_171_1.duration_ = 4.43

		local var_171_0 = {
			zh = 3.5,
			ja = 4.433
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play305072039(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1013ui_story"]) and arg_171_1.var_.characterEffect1013ui_story == nil then
				arg_171_1.var_.characterEffect1013ui_story = arg_171_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1013ui_story"]) then
				if arg_171_1.var_.characterEffect1013ui_story and not isNil(arg_171_1.actors_["1013ui_story"]) then
					arg_171_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1013ui_story"]) and arg_171_1.var_.characterEffect1013ui_story then
				arg_171_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_174_2 = arg_171_1.actors_["10002ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.characterEffect10002ui_story == nil then
				arg_171_1.var_.characterEffect10002ui_story = var_174_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_3 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.characterEffect10002ui_story and not isNil(var_174_2) then
					arg_171_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_3)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.characterEffect10002ui_story then
				arg_171_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_174_4 = 0
			local var_174_5 = 0.325

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(305072038)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 13 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 13)

				if (13 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 13)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072038", "story_v_out_305072.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_out_305072", "305072038", "story_v_out_305072.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_out_305072", "305072038", "story_v_out_305072.awb")

						arg_171_1:RecordAudio("305072038", var_174_11)
						arg_171_1:RecordAudio("305072038", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_305072", "305072038", "story_v_out_305072.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_305072", "305072038", "story_v_out_305072.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_12 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_12 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_12

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_12 and arg_171_1.time_ < var_174_4 + var_174_12 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play305072039 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 305072039
		arg_175_1.duration_ = 9.9

		local var_175_0 = {
			zh = 9.4,
			ja = 9.9
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play305072040(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["10002ui_story"]) and arg_175_1.var_.characterEffect10002ui_story == nil then
				arg_175_1.var_.characterEffect10002ui_story = arg_175_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["10002ui_story"]) then
				if arg_175_1.var_.characterEffect10002ui_story and not isNil(arg_175_1.actors_["10002ui_story"]) then
					arg_175_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["10002ui_story"]) and arg_175_1.var_.characterEffect10002ui_story then
				arg_175_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_178_2 = arg_175_1.actors_["1013ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.characterEffect1013ui_story == nil then
				arg_175_1.var_.characterEffect1013ui_story = var_178_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_3 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.characterEffect1013ui_story and not isNil(var_178_2) then
					arg_175_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_3)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.characterEffect1013ui_story then
				arg_175_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_178_4 = 0
			local var_178_5 = 0.625

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:GetWordFromCfg(305072039)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 25 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 25)

				if (25 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 25)) > 0 and var_178_5 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072039", "story_v_out_305072.awb") ~= 0 then
					local var_178_10 = manager.audio:GetVoiceLength("story_v_out_305072", "305072039", "story_v_out_305072.awb") / 1000

					if var_178_10 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_4
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_out_305072", "305072039", "story_v_out_305072.awb")

						arg_175_1:RecordAudio("305072039", var_178_11)
						arg_175_1:RecordAudio("305072039", var_178_11)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_305072", "305072039", "story_v_out_305072.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_305072", "305072039", "story_v_out_305072.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_12 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_12 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_12

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_12 and arg_175_1.time_ < var_178_4 + var_178_12 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play305072040 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 305072040
		arg_179_1.duration_ = 18.67

		local var_179_0 = {
			zh = 11.666,
			ja = 18.666
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play305072041(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 1.05

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:GetWordFromCfg(305072040)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 42 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 42)

				if (42 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 42)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072040", "story_v_out_305072.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_out_305072", "305072040", "story_v_out_305072.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_out_305072", "305072040", "story_v_out_305072.awb")

						arg_179_1:RecordAudio("305072040", var_182_6)
						arg_179_1:RecordAudio("305072040", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_305072", "305072040", "story_v_out_305072.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_305072", "305072040", "story_v_out_305072.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play305072041 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 305072041
		arg_183_1.duration_ = 12.5

		local var_183_0 = {
			zh = 10.333,
			ja = 12.5
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play305072042(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.875

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(305072041)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 35 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 35)

				if (35 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 35)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072041", "story_v_out_305072.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_305072", "305072041", "story_v_out_305072.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_305072", "305072041", "story_v_out_305072.awb")

						arg_183_1:RecordAudio("305072041", var_186_6)
						arg_183_1:RecordAudio("305072041", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_305072", "305072041", "story_v_out_305072.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_305072", "305072041", "story_v_out_305072.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play305072042 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 305072042
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play305072043(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["10002ui_story"]) and arg_187_1.var_.characterEffect10002ui_story == nil then
				arg_187_1.var_.characterEffect10002ui_story = arg_187_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["10002ui_story"]) then
				if arg_187_1.var_.characterEffect10002ui_story and not isNil(arg_187_1.actors_["10002ui_story"]) then
					arg_187_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["10002ui_story"]) and arg_187_1.var_.characterEffect10002ui_story then
				arg_187_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0
			local var_190_2 = 0.55

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_3 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(305072042).content)

				arg_187_1.text_.text = var_190_3

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_5 = 22 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 22)

				if (22 <= 0 and var_190_2 or var_190_2 * (utf8.len(var_190_3) / 22)) > 0 and var_190_2 < var_190_5 then
					arg_187_1.talkMaxDuration = var_190_5

					if var_190_5 + var_190_1 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + var_190_1
					end
				end

				arg_187_1.text_.text = var_190_3
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_6 = math.max(var_190_2, arg_187_1.talkMaxDuration)

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_6 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_1) / var_190_6

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_1 + var_190_6 and arg_187_1.time_ < var_190_1 + var_190_6 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play305072043 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 305072043
		arg_191_1.duration_ = 5.97

		local var_191_0 = {
			zh = 4.3,
			ja = 5.966
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play305072044(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["10002ui_story"]) and arg_191_1.var_.characterEffect10002ui_story == nil then
				arg_191_1.var_.characterEffect10002ui_story = arg_191_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["10002ui_story"]) then
				if arg_191_1.var_.characterEffect10002ui_story and not isNil(arg_191_1.actors_["10002ui_story"]) then
					arg_191_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["10002ui_story"]) and arg_191_1.var_.characterEffect10002ui_story then
				arg_191_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_194_2 = 0
			local var_194_3 = 0.425

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(305072043)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 17 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 17)

				if (17 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 17)) > 0 and var_194_3 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_2
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072043", "story_v_out_305072.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_305072", "305072043", "story_v_out_305072.awb") / 1000

					if var_194_8 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_2
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_out_305072", "305072043", "story_v_out_305072.awb")

						arg_191_1:RecordAudio("305072043", var_194_9)
						arg_191_1:RecordAudio("305072043", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_305072", "305072043", "story_v_out_305072.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_305072", "305072043", "story_v_out_305072.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_3, arg_191_1.talkMaxDuration)

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_2) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_2 + var_194_10 and arg_191_1.time_ < var_194_2 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play305072044 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 305072044
		arg_195_1.duration_ = 5.77

		local var_195_0 = {
			zh = 3.366,
			ja = 5.766
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
				arg_195_0:Play305072045(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1013ui_story"]) and arg_195_1.var_.characterEffect1013ui_story == nil then
				arg_195_1.var_.characterEffect1013ui_story = arg_195_1.actors_["1013ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1013ui_story"]) then
				if arg_195_1.var_.characterEffect1013ui_story and not isNil(arg_195_1.actors_["1013ui_story"]) then
					arg_195_1.var_.characterEffect1013ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1013ui_story"]) and arg_195_1.var_.characterEffect1013ui_story then
				arg_195_1.var_.characterEffect1013ui_story.fillFlat = false
			end

			local var_198_2 = arg_195_1.actors_["10002ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.characterEffect10002ui_story == nil then
				arg_195_1.var_.characterEffect10002ui_story = var_198_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_3 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_3 and not isNil(var_198_2) then
				if arg_195_1.var_.characterEffect10002ui_story and not isNil(var_198_2) then
					arg_195_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_3)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_3 and arg_195_1.time_ < 0 + var_198_3 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.characterEffect10002ui_story then
				arg_195_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			local var_198_4 = 0
			local var_198_5 = 0.375

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[35].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:GetWordFromCfg(305072044)
				local var_198_7 = arg_195_1:FormatText(var_198_6.content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 15 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 15)

				if (15 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 15)) > 0 and var_198_5 < var_198_9 then
					arg_195_1.talkMaxDuration = var_198_9

					if var_198_9 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072044", "story_v_out_305072.awb") ~= 0 then
					local var_198_10 = manager.audio:GetVoiceLength("story_v_out_305072", "305072044", "story_v_out_305072.awb") / 1000

					if var_198_10 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_4
					end

					if var_198_6.prefab_name ~= "" and arg_195_1.actors_[var_198_6.prefab_name] ~= nil then
						local var_198_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_6.prefab_name].transform, "story_v_out_305072", "305072044", "story_v_out_305072.awb")

						arg_195_1:RecordAudio("305072044", var_198_11)
						arg_195_1:RecordAudio("305072044", var_198_11)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_305072", "305072044", "story_v_out_305072.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_305072", "305072044", "story_v_out_305072.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_12 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_12 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_12

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_12 and arg_195_1.time_ < var_198_4 + var_198_12 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play305072045 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 305072045
		arg_199_1.duration_ = 11.1

		local var_199_0 = {
			zh = 11.1,
			ja = 9
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play305072046(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["10002ui_story"]) and arg_199_1.var_.characterEffect10002ui_story == nil then
				arg_199_1.var_.characterEffect10002ui_story = arg_199_1.actors_["10002ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["10002ui_story"]) then
				if arg_199_1.var_.characterEffect10002ui_story and not isNil(arg_199_1.actors_["10002ui_story"]) then
					arg_199_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["10002ui_story"]) and arg_199_1.var_.characterEffect10002ui_story then
				arg_199_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_202_2 = arg_199_1.actors_["1013ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.characterEffect1013ui_story == nil then
				arg_199_1.var_.characterEffect1013ui_story = var_202_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_3 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.characterEffect1013ui_story and not isNil(var_202_2) then
					arg_199_1.var_.characterEffect1013ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1013ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_3)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.characterEffect1013ui_story then
				arg_199_1.var_.characterEffect1013ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1013ui_story.fillRatio = 0.5
			end

			local var_202_4 = 0
			local var_202_5 = 0.725

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(305072045)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 29 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 29)

				if (29 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 29)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072045", "story_v_out_305072.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_out_305072", "305072045", "story_v_out_305072.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_out_305072", "305072045", "story_v_out_305072.awb")

						arg_199_1:RecordAudio("305072045", var_202_11)
						arg_199_1:RecordAudio("305072045", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_305072", "305072045", "story_v_out_305072.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_305072", "305072045", "story_v_out_305072.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play305072046 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 305072046
		arg_203_1.duration_ = 7.63

		local var_203_0 = {
			zh = 7.633,
			ja = 5.366
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
				arg_203_0:Play305072047(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.425

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[39].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:GetWordFromCfg(305072046)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 17 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 17)

				if (17 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 17)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072046", "story_v_out_305072.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_305072", "305072046", "story_v_out_305072.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_305072", "305072046", "story_v_out_305072.awb")

						arg_203_1:RecordAudio("305072046", var_206_6)
						arg_203_1:RecordAudio("305072046", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_305072", "305072046", "story_v_out_305072.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_305072", "305072046", "story_v_out_305072.awb")
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
	Play305072047 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 305072047
		arg_207_1.duration_ = 8.23

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play305072048(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if arg_207_1.bgs_.B06b == nil then
				local var_210_0 = Object.Instantiate(arg_207_1.paintGo_)

				var_210_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B06b")
				var_210_0.name = "B06b"
				var_210_0.transform.parent = arg_207_1.stage_.transform
				var_210_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.bgs_.B06b = var_210_0
			end

			if 1.999999999999 < arg_207_1.time_ and arg_207_1.time_ <= 1.999999999999 + arg_210_0 then
				local var_210_1 = arg_207_1.bgs_.B06b

				arg_207_1.bgs_.B06b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_210_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_2 = var_210_1:GetComponent("SpriteRenderer")

				if var_210_2 and var_210_2.sprite then
					local var_210_3 = 2 * (var_210_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_210_1.transform.localScale = Vector3.New(var_210_3 / var_210_2.sprite.bounds.size.y < var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x and var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x or var_210_3 / var_210_2.sprite.bounds.size.y, var_210_3 / var_210_2.sprite.bounds.size.y < var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x and var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x or var_210_3 / var_210_2.sprite.bounds.size.y, 0)
				end

				for iter_210_0, iter_210_1 in pairs(arg_207_1.bgs_) do
					if iter_210_0 ~= "B06b" then
						iter_210_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_210_4 = 0

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.allBtn_.enabled = false
			end

			if arg_207_1.time_ >= var_210_4 + 0.3 and arg_207_1.time_ < var_210_4 + 0.3 + arg_210_0 then
				arg_207_1.allBtn_.enabled = true
			end

			local var_210_5 = 0

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_6 = 2

			if var_210_5 <= arg_207_1.time_ and arg_207_1.time_ < var_210_5 + var_210_6 then
				local var_210_7 = Color.New(0, 0, 0)

				var_210_7.a = Mathf.Lerp(0, 1, (arg_207_1.time_ - var_210_5) / var_210_6)
				arg_207_1.mask_.color = var_210_7
			end

			if arg_207_1.time_ >= var_210_5 + var_210_6 and arg_207_1.time_ < var_210_5 + var_210_6 + arg_210_0 then
				local var_210_8 = Color.New(0, 0, 0)

				var_210_8.a = 1
				arg_207_1.mask_.color = var_210_8
			end

			local var_210_9 = 2

			if 2 < arg_207_1.time_ and arg_207_1.time_ <= var_210_9 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_10 = 2

			if var_210_9 <= arg_207_1.time_ and arg_207_1.time_ < var_210_9 + var_210_10 then
				local var_210_11 = Color.New(0, 0, 0)

				var_210_11.a = Mathf.Lerp(1, 0, (arg_207_1.time_ - var_210_9) / var_210_10)
				arg_207_1.mask_.color = var_210_11
			end

			if arg_207_1.time_ >= var_210_9 + var_210_10 and arg_207_1.time_ < var_210_9 + var_210_10 + arg_210_0 then
				local var_210_12 = Color.New(0, 0, 0)

				arg_207_1.mask_.enabled = false
				var_210_12.a = 0
				arg_207_1.mask_.color = var_210_12
			end

			local var_210_13 = arg_207_1.actors_["10002ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_13) and arg_207_1.var_.characterEffect10002ui_story == nil then
				arg_207_1.var_.characterEffect10002ui_story = var_210_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_14 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_14 and not isNil(var_210_13) then
				if arg_207_1.var_.characterEffect10002ui_story and not isNil(var_210_13) then
					arg_207_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10002ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_14)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_14 and arg_207_1.time_ < 0 + var_210_14 + arg_210_0 and not isNil(var_210_13) and arg_207_1.var_.characterEffect10002ui_story then
				arg_207_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10002ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_207_1.time_ and arg_207_1.time_ <= 1.2 + arg_210_0 then
				arg_207_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drone03", "")
			end

			if 0.2 < arg_207_1.time_ and arg_207_1.time_ <= 0.2 + arg_210_0 then
				arg_207_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if arg_207_1.frameCnt_ <= 1 then
				arg_207_1.dialog_:SetActive(false)
			end

			local var_210_17 = 3.23333333333333
			local var_210_18 = 1.55

			if 3.23333333333333 < arg_207_1.time_ and arg_207_1.time_ <= var_210_17 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				arg_207_1.dialog_:SetActive(true)

				arg_207_1.dialogCg_.alpha = 0

				local var_210_19 = LeanTween.value(arg_207_1.dialog_, 0, 1, 0.3)

				var_210_19:setOnUpdate(LuaHelper.FloatAction(function(arg_211_0)
					arg_207_1.dialogCg_.alpha = arg_211_0
				end))
				var_210_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_207_1.dialog_)
					var_210_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_207_1.duration_ = arg_207_1.duration_ + 0.3

				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_20 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(305072047).content)

				arg_207_1.text_.text = var_210_20

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_22 = 62 <= 0 and var_210_18 or var_210_18 * (utf8.len(var_210_20) / 62)

				if (62 <= 0 and var_210_18 or var_210_18 * (utf8.len(var_210_20) / 62)) > 0 and var_210_18 < var_210_22 then
					arg_207_1.talkMaxDuration = var_210_22
					var_210_17 = var_210_17 + 0.3

					if var_210_22 + var_210_17 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_22 + var_210_17
					end
				end

				arg_207_1.text_.text = var_210_20
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_23 = var_210_17 + 0.3
			local var_210_24 = math.max(var_210_18, arg_207_1.talkMaxDuration)

			if var_210_17 + 0.3 <= arg_207_1.time_ and arg_207_1.time_ < var_210_23 + var_210_24 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_23) / var_210_24

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_23 + var_210_24 and arg_207_1.time_ < var_210_23 + var_210_24 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play305072048 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 305072048
		arg_213_1.duration_ = 3.93

		local var_213_0 = {
			zh = 1.999999999999,
			ja = 3.933
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
				arg_213_0:Play305072049(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1019ui_story = arg_213_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1019ui_story"].transform.position).z)
				arg_213_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1019ui_story"].transform.localEulerAngles = arg_213_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_213_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1019ui_story"].transform.position).z)
				arg_213_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1019ui_story"].transform.localEulerAngles = arg_213_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1019ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1019ui_story == nil then
				arg_213_1.var_.characterEffect1019ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1019ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1019ui_story then
				arg_213_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_216_4 = 0
			local var_216_5 = 0.175

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(305072048)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 7 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 7)

				if (7 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 7)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072048", "story_v_out_305072.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_out_305072", "305072048", "story_v_out_305072.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_out_305072", "305072048", "story_v_out_305072.awb")

						arg_213_1:RecordAudio("305072048", var_216_11)
						arg_213_1:RecordAudio("305072048", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_305072", "305072048", "story_v_out_305072.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_305072", "305072048", "story_v_out_305072.awb")
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

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play305072049 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 305072049
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play305072050(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1019ui_story"]) and arg_217_1.var_.characterEffect1019ui_story == nil then
				arg_217_1.var_.characterEffect1019ui_story = arg_217_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1019ui_story"]) then
				if arg_217_1.var_.characterEffect1019ui_story and not isNil(arg_217_1.actors_["1019ui_story"]) then
					arg_217_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1019ui_story"]) and arg_217_1.var_.characterEffect1019ui_story then
				arg_217_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_220_1 = 0
			local var_220_2 = 0.45

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(305072049).content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 18 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 18)

				if (18 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_3) / 18)) > 0 and var_220_2 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_1
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_6 = math.max(var_220_2, arg_217_1.talkMaxDuration)

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_6 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_1) / var_220_6

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_1 + var_220_6 and arg_217_1.time_ < var_220_1 + var_220_6 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play305072050 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 305072050
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play305072051(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos1019ui_story = arg_221_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1019ui_story"].transform.position).z)
				arg_221_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1019ui_story"].transform.localEulerAngles = arg_221_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["1019ui_story"].transform.position).z)
				arg_221_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["1019ui_story"].transform.localEulerAngles = arg_221_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if 1 < arg_221_1.time_ and arg_221_1.time_ <= 1 + arg_224_0 then
				arg_221_1:AudioAction("play", "effect", "se_story_140", "se_story_140_door_push", "")
			end

			local var_224_2 = 0
			local var_224_3 = 1.25

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_4 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(305072050).content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_6 = 50 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_4) / 50)

				if (50 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_4) / 50)) > 0 and var_224_3 < var_224_6 then
					arg_221_1.talkMaxDuration = var_224_6

					if var_224_6 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_6 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_7 and arg_221_1.time_ < var_224_2 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play305072051 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 305072051
		arg_225_1.duration_ = 3.57

		local var_225_0 = {
			zh = 3.066,
			ja = 3.566
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
				arg_225_0:Play305072052(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if arg_225_1.actors_["10001_tpose"] == nil and not isNil((Asset.Load("Char/" .. "10001_tpose"))) then
				local var_228_0 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_225_1.stage_.transform)

				var_228_0.name = "10001_tpose"
				var_228_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_225_1.actors_["10001_tpose"] = var_228_0

				local var_228_1 = var_228_0:GetComponentInChildren(typeof(CharacterEffect))

				var_228_1.enabled = true

				local var_228_2 = GameObjectTools.GetOrAddComponent(var_228_0, typeof(DynamicBoneHelper))

				if var_228_2 then
					var_228_2:EnableDynamicBone(false)
				end

				arg_225_1:ShowWeapon(var_228_1.transform, false)

				arg_225_1.var_["10001_tpose" .. "Animator"] = var_228_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_225_1.var_["10001_tpose" .. "Animator"].applyRootMotion = true
				arg_225_1.var_["10001_tpose" .. "LipSync"] = var_228_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_228_3 = arg_225_1.actors_["10001_tpose"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10001_tpose = var_228_3.localPosition

				local var_228_4 = GameObjectTools.GetOrAddComponent(var_228_3.gameObject, typeof(DynamicBoneHelper))

				if var_228_4 then
					var_228_4:EnableDynamicBone(false)
				end
			end

			local var_228_5 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_5 then
				var_228_3.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10001_tpose, Vector3.New(-0.7, -1.23, -5.8), (arg_225_1.time_ - 0) / var_228_5)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_5 and arg_225_1.time_ < 0 + var_228_5 + arg_228_0 then
				var_228_3.localPosition = Vector3.New(-0.7, -1.23, -5.8)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles

				local var_228_6 = GameObjectTools.GetOrAddComponent(var_228_3.gameObject, typeof(DynamicBoneHelper))

				if var_228_6 then
					var_228_6:EnableDynamicBone(true)
				end
			end

			local var_228_7 = arg_225_1.actors_["10001_tpose"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.characterEffect10001_tpose == nil then
				arg_225_1.var_.characterEffect10001_tpose = var_228_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_8 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_8 and not isNil(var_228_7) then
				if arg_225_1.var_.characterEffect10001_tpose and not isNil(var_228_7) then
					arg_225_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_8 and arg_225_1.time_ < 0 + var_228_8 + arg_228_0 and not isNil(var_228_7) and arg_225_1.var_.characterEffect10001_tpose then
				arg_225_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action3_1")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_228_10 = 0
			local var_228_11 = 0.225

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_10 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_12 = arg_225_1:GetWordFromCfg(305072051)
				local var_228_13 = arg_225_1:FormatText(var_228_12.content)

				arg_225_1.text_.text = var_228_13

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_15 = 9 <= 0 and var_228_11 or var_228_11 * (utf8.len(var_228_13) / 9)

				if (9 <= 0 and var_228_11 or var_228_11 * (utf8.len(var_228_13) / 9)) > 0 and var_228_11 < var_228_15 then
					arg_225_1.talkMaxDuration = var_228_15

					if var_228_15 + var_228_10 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_15 + var_228_10
					end
				end

				arg_225_1.text_.text = var_228_13
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072051", "story_v_out_305072.awb") ~= 0 then
					local var_228_16 = manager.audio:GetVoiceLength("story_v_out_305072", "305072051", "story_v_out_305072.awb") / 1000

					if var_228_16 + var_228_10 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_16 + var_228_10
					end

					if var_228_12.prefab_name ~= "" and arg_225_1.actors_[var_228_12.prefab_name] ~= nil then
						local var_228_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_12.prefab_name].transform, "story_v_out_305072", "305072051", "story_v_out_305072.awb")

						arg_225_1:RecordAudio("305072051", var_228_17)
						arg_225_1:RecordAudio("305072051", var_228_17)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_305072", "305072051", "story_v_out_305072.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_305072", "305072051", "story_v_out_305072.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_18 = math.max(var_228_11, arg_225_1.talkMaxDuration)

			if var_228_10 <= arg_225_1.time_ and arg_225_1.time_ < var_228_10 + var_228_18 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_10) / var_228_18

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_10 + var_228_18 and arg_225_1.time_ < var_228_10 + var_228_18 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play305072052 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 305072052
		arg_229_1.duration_ = 4.23

		local var_229_0 = {
			zh = 4.233,
			ja = 3.3
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
				arg_229_0:Play305072053(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if arg_229_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_232_0 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_229_1.stage_.transform)

				var_232_0.name = "1148ui_story"
				var_232_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_229_1.actors_["1148ui_story"] = var_232_0

				local var_232_1 = var_232_0:GetComponentInChildren(typeof(CharacterEffect))

				var_232_1.enabled = true

				local var_232_2 = GameObjectTools.GetOrAddComponent(var_232_0, typeof(DynamicBoneHelper))

				if var_232_2 then
					var_232_2:EnableDynamicBone(false)
				end

				arg_229_1:ShowWeapon(var_232_1.transform, false)

				arg_229_1.var_["1148ui_story" .. "Animator"] = var_232_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_229_1.var_["1148ui_story" .. "Animator"].applyRootMotion = true
				arg_229_1.var_["1148ui_story" .. "LipSync"] = var_232_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_232_3 = arg_229_1.actors_["1148ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1148ui_story = var_232_3.localPosition
			end

			local var_232_4 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				var_232_3.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_229_1.time_ - 0) / var_232_4)
				var_232_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_3.position).x, (manager.ui.mainCamera.transform.position - var_232_3.position).y, (manager.ui.mainCamera.transform.position - var_232_3.position).z)
				var_232_3.localEulerAngles.z = 0
				var_232_3.localEulerAngles.x = 0
				var_232_3.localEulerAngles = var_232_3.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				var_232_3.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_232_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_3.position).x, (manager.ui.mainCamera.transform.position - var_232_3.position).y, (manager.ui.mainCamera.transform.position - var_232_3.position).z)
				var_232_3.localEulerAngles.z = 0
				var_232_3.localEulerAngles.x = 0
				var_232_3.localEulerAngles = var_232_3.localEulerAngles
			end

			local var_232_5 = arg_229_1.actors_["1148ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_5) and arg_229_1.var_.characterEffect1148ui_story == nil then
				arg_229_1.var_.characterEffect1148ui_story = var_232_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_6 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_6 and not isNil(var_232_5) then
				if arg_229_1.var_.characterEffect1148ui_story and not isNil(var_232_5) then
					arg_229_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_6 and arg_229_1.time_ < 0 + var_232_6 + arg_232_0 and not isNil(var_232_5) and arg_229_1.var_.characterEffect1148ui_story then
				arg_229_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_232_8 = arg_229_1.actors_["10001_tpose"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_8) and arg_229_1.var_.characterEffect10001_tpose == nil then
				arg_229_1.var_.characterEffect10001_tpose = var_232_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_9 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_9 and not isNil(var_232_8) then
				if arg_229_1.var_.characterEffect10001_tpose and not isNil(var_232_8) then
					arg_229_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_229_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_9)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_9 and arg_229_1.time_ < 0 + var_232_9 + arg_232_0 and not isNil(var_232_8) and arg_229_1.var_.characterEffect10001_tpose then
				arg_229_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_229_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_232_10 = 0
			local var_232_11 = 0.35

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_12 = arg_229_1:GetWordFromCfg(305072052)
				local var_232_13 = arg_229_1:FormatText(var_232_12.content)

				arg_229_1.text_.text = var_232_13

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_15 = 14 <= 0 and var_232_11 or var_232_11 * (utf8.len(var_232_13) / 14)

				if (14 <= 0 and var_232_11 or var_232_11 * (utf8.len(var_232_13) / 14)) > 0 and var_232_11 < var_232_15 then
					arg_229_1.talkMaxDuration = var_232_15

					if var_232_15 + var_232_10 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_15 + var_232_10
					end
				end

				arg_229_1.text_.text = var_232_13
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072052", "story_v_out_305072.awb") ~= 0 then
					local var_232_16 = manager.audio:GetVoiceLength("story_v_out_305072", "305072052", "story_v_out_305072.awb") / 1000

					if var_232_16 + var_232_10 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_16 + var_232_10
					end

					if var_232_12.prefab_name ~= "" and arg_229_1.actors_[var_232_12.prefab_name] ~= nil then
						local var_232_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_12.prefab_name].transform, "story_v_out_305072", "305072052", "story_v_out_305072.awb")

						arg_229_1:RecordAudio("305072052", var_232_17)
						arg_229_1:RecordAudio("305072052", var_232_17)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_305072", "305072052", "story_v_out_305072.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_305072", "305072052", "story_v_out_305072.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_18 = math.max(var_232_11, arg_229_1.talkMaxDuration)

			if var_232_10 <= arg_229_1.time_ and arg_229_1.time_ < var_232_10 + var_232_18 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_10) / var_232_18

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_10 + var_232_18 and arg_229_1.time_ < var_232_10 + var_232_18 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play305072053 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 305072053
		arg_233_1.duration_ = 9.37

		local var_233_0 = {
			zh = 5.966,
			ja = 9.366
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
				arg_233_0:Play305072054(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["10001_tpose"]) and arg_233_1.var_.characterEffect10001_tpose == nil then
				arg_233_1.var_.characterEffect10001_tpose = arg_233_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["10001_tpose"]) then
				if arg_233_1.var_.characterEffect10001_tpose and not isNil(arg_233_1.actors_["10001_tpose"]) then
					arg_233_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["10001_tpose"]) and arg_233_1.var_.characterEffect10001_tpose then
				arg_233_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_236_2 = arg_233_1.actors_["1148ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect1148ui_story == nil then
				arg_233_1.var_.characterEffect1148ui_story = var_236_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_3 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_3 and not isNil(var_236_2) then
				if arg_233_1.var_.characterEffect1148ui_story and not isNil(var_236_2) then
					arg_233_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_3)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_3 and arg_233_1.time_ < 0 + var_236_3 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect1148ui_story then
				arg_233_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_236_4 = 0
			local var_236_5 = 0.575

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(305072053)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 23 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 23)

				if (23 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 23)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072053", "story_v_out_305072.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_out_305072", "305072053", "story_v_out_305072.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_out_305072", "305072053", "story_v_out_305072.awb")

						arg_233_1:RecordAudio("305072053", var_236_11)
						arg_233_1:RecordAudio("305072053", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_305072", "305072053", "story_v_out_305072.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_305072", "305072053", "story_v_out_305072.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_12 and arg_233_1.time_ < var_236_4 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play305072054 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 305072054
		arg_237_1.duration_ = 16.47

		local var_237_0 = {
			zh = 12,
			ja = 16.466
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
				arg_237_0:Play305072055(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action434")
			end

			local var_240_0 = 0
			local var_240_1 = 1.3

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[24].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_2 = arg_237_1:GetWordFromCfg(305072054)
				local var_240_3 = arg_237_1:FormatText(var_240_2.content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 52 <= 0 and var_240_1 or var_240_1 * (utf8.len(var_240_3) / 52)

				if (52 <= 0 and var_240_1 or var_240_1 * (utf8.len(var_240_3) / 52)) > 0 and var_240_1 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072054", "story_v_out_305072.awb") ~= 0 then
					local var_240_6 = manager.audio:GetVoiceLength("story_v_out_305072", "305072054", "story_v_out_305072.awb") / 1000

					if var_240_6 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_6 + var_240_0
					end

					if var_240_2.prefab_name ~= "" and arg_237_1.actors_[var_240_2.prefab_name] ~= nil then
						local var_240_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_2.prefab_name].transform, "story_v_out_305072", "305072054", "story_v_out_305072.awb")

						arg_237_1:RecordAudio("305072054", var_240_7)
						arg_237_1:RecordAudio("305072054", var_240_7)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_305072", "305072054", "story_v_out_305072.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_305072", "305072054", "story_v_out_305072.awb")
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
	Play305072055 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 305072055
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play305072056(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos1148ui_story = arg_241_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1148ui_story"].transform.position).z)
				arg_241_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1148ui_story"].transform.localEulerAngles = arg_241_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_241_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["1148ui_story"].transform.position).z)
				arg_241_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["1148ui_story"].transform.localEulerAngles = arg_241_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_244_1 = arg_241_1.actors_["10001_tpose"].transform

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos10001_tpose = var_244_1.localPosition

				local var_244_2 = GameObjectTools.GetOrAddComponent(var_244_1.gameObject, typeof(DynamicBoneHelper))

				if var_244_2 then
					var_244_2:EnableDynamicBone(false)
				end
			end

			local var_244_3 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 then
				var_244_1.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_241_1.time_ - 0) / var_244_3)
				var_244_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_1.position).x, (manager.ui.mainCamera.transform.position - var_244_1.position).y, (manager.ui.mainCamera.transform.position - var_244_1.position).z)
				var_244_1.localEulerAngles.z = 0
				var_244_1.localEulerAngles.x = 0
				var_244_1.localEulerAngles = var_244_1.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 then
				var_244_1.localPosition = Vector3.New(0, 100, 0)
				var_244_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_244_1.position).x, (manager.ui.mainCamera.transform.position - var_244_1.position).y, (manager.ui.mainCamera.transform.position - var_244_1.position).z)
				var_244_1.localEulerAngles.z = 0
				var_244_1.localEulerAngles.x = 0
				var_244_1.localEulerAngles = var_244_1.localEulerAngles

				local var_244_4 = GameObjectTools.GetOrAddComponent(var_244_1.gameObject, typeof(DynamicBoneHelper))

				if var_244_4 then
					var_244_4:EnableDynamicBone(true)
				end
			end

			local var_244_5 = arg_241_1.actors_["10001_tpose"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_5) and arg_241_1.var_.characterEffect10001_tpose == nil then
				arg_241_1.var_.characterEffect10001_tpose = var_244_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_6 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_6 and not isNil(var_244_5) then
				if arg_241_1.var_.characterEffect10001_tpose and not isNil(var_244_5) then
					arg_241_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_241_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_6)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_6 and arg_241_1.time_ < 0 + var_244_6 + arg_244_0 and not isNil(var_244_5) and arg_241_1.var_.characterEffect10001_tpose then
				arg_241_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_241_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_244_7 = 0
			local var_244_8 = 1.8

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_7 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, false)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_9 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(305072055).content)

				arg_241_1.text_.text = var_244_9

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_11 = 72 <= 0 and var_244_8 or var_244_8 * (utf8.len(var_244_9) / 72)

				if (72 <= 0 and var_244_8 or var_244_8 * (utf8.len(var_244_9) / 72)) > 0 and var_244_8 < var_244_11 then
					arg_241_1.talkMaxDuration = var_244_11

					if var_244_11 + var_244_7 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_11 + var_244_7
					end
				end

				arg_241_1.text_.text = var_244_9
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_12 = math.max(var_244_8, arg_241_1.talkMaxDuration)

			if var_244_7 <= arg_241_1.time_ and arg_241_1.time_ < var_244_7 + var_244_12 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_7) / var_244_12

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_7 + var_244_12 and arg_241_1.time_ < var_244_7 + var_244_12 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 2,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 0.799999997019768,
				amplitudeGain = 0.3,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play305072056 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 305072056
		arg_245_1.duration_ = 6.52

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play305072057(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_9001
			local var_248_9000

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				local var_248_0 = arg_245_1.var_.effectsssfsssf1

				if not arg_245_1.var_.effectsssfsssf1 then
					var_248_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boguang"), manager.ui.mainCamera.transform)
					var_248_0.name = "sssf1"
					arg_245_1.var_.effectsssfsssf1 = var_248_0
				else
					var_248_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_248_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_248_0.transform.localScale = Vector3.New(var_248_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_248_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_248_0.transform.localScale.z)
			end

			if 1.28333333333333 < arg_245_1.time_ and arg_245_1.time_ <= 1.28333333333333 + arg_248_0 then
				if arg_245_1.var_.effectsssfsssf1 then
					Object.Destroy(arg_245_1.var_.effectsssfsssf1)

					arg_245_1.var_.effectsssfsssf1 = nil
				end
			end

			if 0.466666666666667 < arg_245_1.time_ and arg_245_1.time_ <= 0.466666666666667 + arg_248_0 then
				local var_248_3 = arg_245_1.var_.effect2131

				if not arg_245_1.var_.effect2131 then
					var_248_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_248_3.name = "2131"
					arg_245_1.var_.effect2131 = var_248_3
				else
					var_248_3.transform:SetParent(var_248_9001)
				end

				var_248_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_248_3.transform.localScale = Vector3.New(var_248_3.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_248_3.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_248_3.transform.localScale.z)
			end

			if 1.9 < arg_245_1.time_ and arg_245_1.time_ <= 1.9 + arg_248_0 then
				if arg_245_1.var_.effect2131 then
					Object.Destroy(arg_245_1.var_.effect2131)

					arg_245_1.var_.effect2131 = nil
				end
			end

			if 0.166666666666667 < arg_245_1.time_ and arg_245_1.time_ <= 0.166666666666667 + arg_248_0 then
				local var_248_6 = arg_245_1.var_.effect烦烦烦33

				if not arg_245_1.var_.effect烦烦烦33 then
					var_248_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang04"), manager.ui.mainCamera.transform)
					var_248_6.name = "烦烦烦33"
					arg_245_1.var_.effect烦烦烦33 = var_248_6
				else
					var_248_6.transform:SetParent(var_248_9000)
				end

				var_248_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_248_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.9 < arg_245_1.time_ and arg_245_1.time_ <= 1.9 + arg_248_0 then
				if arg_245_1.var_.effect烦烦烦33 then
					Object.Destroy(arg_245_1.var_.effect烦烦烦33)

					arg_245_1.var_.effect烦烦烦33 = nil
				end
			end

			local var_248_9 = 0

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_9 + arg_248_0 then
				arg_245_1.allBtn_.enabled = false
			end

			if arg_245_1.time_ >= var_248_9 + 1.7 and arg_245_1.time_ < var_248_9 + 1.7 + arg_248_0 then
				arg_245_1.allBtn_.enabled = true
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_11 = 1.52402014564723
			local var_248_12 = 1.25

			if 1.52402014564723 < arg_245_1.time_ and arg_245_1.time_ <= var_248_11 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_13 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_13:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_14 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(305072056).content)

				arg_245_1.text_.text = var_248_14

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_16 = 50 <= 0 and var_248_12 or var_248_12 * (utf8.len(var_248_14) / 50)

				if (50 <= 0 and var_248_12 or var_248_12 * (utf8.len(var_248_14) / 50)) > 0 and var_248_12 < var_248_16 then
					arg_245_1.talkMaxDuration = var_248_16
					var_248_11 = var_248_11 + 0.3

					if var_248_16 + var_248_11 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_16 + var_248_11
					end
				end

				arg_245_1.text_.text = var_248_14
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_17 = var_248_11 + 0.3
			local var_248_18 = math.max(var_248_12, arg_245_1.talkMaxDuration)

			if var_248_11 + 0.3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_17 + var_248_18 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_17) / var_248_18

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_17 + var_248_18 and arg_245_1.time_ < var_248_17 + var_248_18 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play305072057 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 305072057
		arg_251_1.duration_ = 2

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play305072058(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos10001_tpose = arg_251_1.actors_["10001_tpose"].transform.localPosition

				local var_254_0 = GameObjectTools.GetOrAddComponent(arg_251_1.actors_["10001_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_254_0 then
					var_254_0:EnableDynamicBone(false)
				end
			end

			local var_254_1 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_1 then
				arg_251_1.actors_["10001_tpose"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_251_1.time_ - 0) / var_254_1)
				arg_251_1.actors_["10001_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["10001_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10001_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10001_tpose"].transform.position).z)
				arg_251_1.actors_["10001_tpose"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["10001_tpose"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["10001_tpose"].transform.localEulerAngles = arg_251_1.actors_["10001_tpose"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_1 and arg_251_1.time_ < 0 + var_254_1 + arg_254_0 then
				arg_251_1.actors_["10001_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_251_1.actors_["10001_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["10001_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10001_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10001_tpose"].transform.position).z)
				arg_251_1.actors_["10001_tpose"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["10001_tpose"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["10001_tpose"].transform.localEulerAngles = arg_251_1.actors_["10001_tpose"].transform.localEulerAngles

				local var_254_2 = GameObjectTools.GetOrAddComponent(arg_251_1.actors_["10001_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_254_2 then
					var_254_2:EnableDynamicBone(true)
				end
			end

			local var_254_3 = arg_251_1.actors_["10001_tpose"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_3) and arg_251_1.var_.characterEffect10001_tpose == nil then
				arg_251_1.var_.characterEffect10001_tpose = var_254_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_4 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 and not isNil(var_254_3) then
				if arg_251_1.var_.characterEffect10001_tpose and not isNil(var_254_3) then
					arg_251_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 and not isNil(var_254_3) and arg_251_1.var_.characterEffect10001_tpose then
				arg_251_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action1_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			if 0.333333333333333 < arg_251_1.time_ and arg_251_1.time_ <= 0.333333333333333 + arg_254_0 then
				arg_251_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_254_8 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_251_1.bgmTxt_.text ~= var_254_8 and arg_251_1.bgmTxt_.text ~= "" then
						if arg_251_1.bgmTxt2_.text ~= "" then
							arg_251_1.bgmTxt_.text = arg_251_1.bgmTxt2_.text
						end

						arg_251_1.bgmTxt2_.text = var_254_8

						arg_251_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_251_1.bgmTxt_.text = var_254_8
						arg_251_1.bgmTxt2_.text = var_254_8
					end

					if arg_251_1.bgmTimer then
						arg_251_1.bgmTimer:Stop()

						arg_251_1.bgmTimer = nil
					end

					if arg_251_1.settingData.show_music_name == 1 then
						arg_251_1.musicController:SetSelectedState("show")
						arg_251_1.musicAnimator_:Play("open", 0, 0)

						if arg_251_1.settingData.music_time ~= 0 then
							arg_251_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_251_1.settingData.music_time), function()
								if arg_251_1 == nil or isNil(arg_251_1.bgmTxt_) then
									return
								end

								arg_251_1.musicController:SetSelectedState("hide")
								arg_251_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_254_9 = 0
			local var_254_10 = 0.075

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_9 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1560].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_11 = arg_251_1:GetWordFromCfg(305072057)
				local var_254_12 = arg_251_1:FormatText(var_254_11.content)

				arg_251_1.text_.text = var_254_12

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_14 = 3 <= 0 and var_254_10 or var_254_10 * (utf8.len(var_254_12) / 3)

				if (3 <= 0 and var_254_10 or var_254_10 * (utf8.len(var_254_12) / 3)) > 0 and var_254_10 < var_254_14 then
					arg_251_1.talkMaxDuration = var_254_14

					if var_254_14 + var_254_9 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_14 + var_254_9
					end
				end

				arg_251_1.text_.text = var_254_12
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072057", "story_v_out_305072.awb") ~= 0 then
					local var_254_15 = manager.audio:GetVoiceLength("story_v_out_305072", "305072057", "story_v_out_305072.awb") / 1000

					if var_254_15 + var_254_9 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_15 + var_254_9
					end

					if var_254_11.prefab_name ~= "" and arg_251_1.actors_[var_254_11.prefab_name] ~= nil then
						local var_254_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_11.prefab_name].transform, "story_v_out_305072", "305072057", "story_v_out_305072.awb")

						arg_251_1:RecordAudio("305072057", var_254_16)
						arg_251_1:RecordAudio("305072057", var_254_16)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_305072", "305072057", "story_v_out_305072.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_305072", "305072057", "story_v_out_305072.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_17 = math.max(var_254_10, arg_251_1.talkMaxDuration)

			if var_254_9 <= arg_251_1.time_ and arg_251_1.time_ < var_254_9 + var_254_17 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_9) / var_254_17

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_9 + var_254_17 and arg_251_1.time_ < var_254_9 + var_254_17 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play305072058 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 305072058
		arg_256_1.duration_ = 9.9

		local var_256_0 = {
			zh = 9.9,
			ja = 1.999999999999
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play305072059(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["1084ui_story"]) and arg_256_1.var_.characterEffect1084ui_story == nil then
				arg_256_1.var_.characterEffect1084ui_story = arg_256_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_0 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["1084ui_story"]) then
				if arg_256_1.var_.characterEffect1084ui_story and not isNil(arg_256_1.actors_["1084ui_story"]) then
					arg_256_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["1084ui_story"]) and arg_256_1.var_.characterEffect1084ui_story then
				arg_256_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_259_2 = arg_256_1.actors_["1084ui_story"].transform

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos1084ui_story = var_259_2.localPosition
			end

			local var_259_3 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_3 then
				var_259_2.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_256_1.time_ - 0) / var_259_3)
				var_259_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_259_2.position).x, (manager.ui.mainCamera.transform.position - var_259_2.position).y, (manager.ui.mainCamera.transform.position - var_259_2.position).z)
				var_259_2.localEulerAngles.z = 0
				var_259_2.localEulerAngles.x = 0
				var_259_2.localEulerAngles = var_259_2.localEulerAngles
			end

			if arg_256_1.time_ >= 0 + var_259_3 and arg_256_1.time_ < 0 + var_259_3 + arg_259_0 then
				var_259_2.localPosition = Vector3.New(0, -0.97, -6)
				var_259_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_259_2.position).x, (manager.ui.mainCamera.transform.position - var_259_2.position).y, (manager.ui.mainCamera.transform.position - var_259_2.position).z)
				var_259_2.localEulerAngles.z = 0
				var_259_2.localEulerAngles.x = 0
				var_259_2.localEulerAngles = var_259_2.localEulerAngles
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_259_4 = 0
			local var_259_5 = 0.925

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_6 = arg_256_1:GetWordFromCfg(305072058)
				local var_259_7 = arg_256_1:FormatText(var_259_6.content)

				arg_256_1.text_.text = var_259_7

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_9 = 37 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 37)

				if (37 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 37)) > 0 and var_259_5 < var_259_9 then
					arg_256_1.talkMaxDuration = var_259_9

					if var_259_9 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_9 + var_259_4
					end
				end

				arg_256_1.text_.text = var_259_7
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072058", "story_v_out_305072.awb") ~= 0 then
					local var_259_10 = manager.audio:GetVoiceLength("story_v_out_305072", "305072058", "story_v_out_305072.awb") / 1000

					if var_259_10 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_4
					end

					if var_259_6.prefab_name ~= "" and arg_256_1.actors_[var_259_6.prefab_name] ~= nil then
						local var_259_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_6.prefab_name].transform, "story_v_out_305072", "305072058", "story_v_out_305072.awb")

						arg_256_1:RecordAudio("305072058", var_259_11)
						arg_256_1:RecordAudio("305072058", var_259_11)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_305072", "305072058", "story_v_out_305072.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_305072", "305072058", "story_v_out_305072.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_12 = math.max(var_259_5, arg_256_1.talkMaxDuration)

			if var_259_4 <= arg_256_1.time_ and arg_256_1.time_ < var_259_4 + var_259_12 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_4) / var_259_12

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_4 + var_259_12 and arg_256_1.time_ < var_259_4 + var_259_12 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play305072059 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 305072059
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play305072060(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["1084ui_story"]) and arg_260_1.var_.characterEffect1084ui_story == nil then
				arg_260_1.var_.characterEffect1084ui_story = arg_260_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_0 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["1084ui_story"]) then
				if arg_260_1.var_.characterEffect1084ui_story and not isNil(arg_260_1.actors_["1084ui_story"]) then
					arg_260_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_260_1.time_ - 0) / var_263_0)
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["1084ui_story"]) and arg_260_1.var_.characterEffect1084ui_story then
				arg_260_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_263_1 = 0
			local var_263_2 = 0.675

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_3 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(305072059).content)

				arg_260_1.text_.text = var_263_3

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 27 <= 0 and var_263_2 or var_263_2 * (utf8.len(var_263_3) / 27)

				if (27 <= 0 and var_263_2 or var_263_2 * (utf8.len(var_263_3) / 27)) > 0 and var_263_2 < var_263_5 then
					arg_260_1.talkMaxDuration = var_263_5

					if var_263_5 + var_263_1 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + var_263_1
					end
				end

				arg_260_1.text_.text = var_263_3
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_6 = math.max(var_263_2, arg_260_1.talkMaxDuration)

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_6 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_1) / var_263_6

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_1 + var_263_6 and arg_260_1.time_ < var_263_1 + var_263_6 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play305072060 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 305072060
		arg_264_1.duration_ = 5.4

		local var_264_0 = {
			zh = 4.266,
			ja = 5.4
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play305072061(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["10001_tpose"]) and arg_264_1.var_.characterEffect10001_tpose == nil then
				arg_264_1.var_.characterEffect10001_tpose = arg_264_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_0 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["10001_tpose"]) then
				if arg_264_1.var_.characterEffect10001_tpose and not isNil(arg_264_1.actors_["10001_tpose"]) then
					arg_264_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["10001_tpose"]) and arg_264_1.var_.characterEffect10001_tpose then
				arg_264_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_267_2 = 0
			local var_267_3 = 0.275

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_2 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[1560].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_4 = arg_264_1:GetWordFromCfg(305072060)
				local var_267_5 = arg_264_1:FormatText(var_267_4.content)

				arg_264_1.text_.text = var_267_5

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_7 = 11 <= 0 and var_267_3 or var_267_3 * (utf8.len(var_267_5) / 11)

				if (11 <= 0 and var_267_3 or var_267_3 * (utf8.len(var_267_5) / 11)) > 0 and var_267_3 < var_267_7 then
					arg_264_1.talkMaxDuration = var_267_7

					if var_267_7 + var_267_2 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_7 + var_267_2
					end
				end

				arg_264_1.text_.text = var_267_5
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072060", "story_v_out_305072.awb") ~= 0 then
					local var_267_8 = manager.audio:GetVoiceLength("story_v_out_305072", "305072060", "story_v_out_305072.awb") / 1000

					if var_267_8 + var_267_2 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_8 + var_267_2
					end

					if var_267_4.prefab_name ~= "" and arg_264_1.actors_[var_267_4.prefab_name] ~= nil then
						local var_267_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_4.prefab_name].transform, "story_v_out_305072", "305072060", "story_v_out_305072.awb")

						arg_264_1:RecordAudio("305072060", var_267_9)
						arg_264_1:RecordAudio("305072060", var_267_9)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_305072", "305072060", "story_v_out_305072.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_305072", "305072060", "story_v_out_305072.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_10 = math.max(var_267_3, arg_264_1.talkMaxDuration)

			if var_267_2 <= arg_264_1.time_ and arg_264_1.time_ < var_267_2 + var_267_10 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_2) / var_267_10

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_2 + var_267_10 and arg_264_1.time_ < var_267_2 + var_267_10 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play305072061 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 305072061
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play305072062(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["10001_tpose"]) and arg_268_1.var_.characterEffect10001_tpose == nil then
				arg_268_1.var_.characterEffect10001_tpose = arg_268_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["10001_tpose"]) then
				if arg_268_1.var_.characterEffect10001_tpose and not isNil(arg_268_1.actors_["10001_tpose"]) then
					arg_268_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_268_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_268_1.time_ - 0) / var_271_0)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["10001_tpose"]) and arg_268_1.var_.characterEffect10001_tpose then
				arg_268_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_268_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_271_1 = arg_268_1.actors_["1084ui_story"].transform

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos1084ui_story = var_271_1.localPosition
			end

			local var_271_2 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_2 then
				var_271_1.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_268_1.time_ - 0) / var_271_2)
				var_271_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_271_1.position).x, (manager.ui.mainCamera.transform.position - var_271_1.position).y, (manager.ui.mainCamera.transform.position - var_271_1.position).z)
				var_271_1.localEulerAngles.z = 0
				var_271_1.localEulerAngles.x = 0
				var_271_1.localEulerAngles = var_271_1.localEulerAngles
			end

			if arg_268_1.time_ >= 0 + var_271_2 and arg_268_1.time_ < 0 + var_271_2 + arg_271_0 then
				var_271_1.localPosition = Vector3.New(0, 100, 0)
				var_271_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_271_1.position).x, (manager.ui.mainCamera.transform.position - var_271_1.position).y, (manager.ui.mainCamera.transform.position - var_271_1.position).z)
				var_271_1.localEulerAngles.z = 0
				var_271_1.localEulerAngles.x = 0
				var_271_1.localEulerAngles = var_271_1.localEulerAngles
			end

			local var_271_3 = 0
			local var_271_4 = 1.15

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_3 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_5 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(305072061).content)

				arg_268_1.text_.text = var_271_5

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_7 = 46 <= 0 and var_271_4 or var_271_4 * (utf8.len(var_271_5) / 46)

				if (46 <= 0 and var_271_4 or var_271_4 * (utf8.len(var_271_5) / 46)) > 0 and var_271_4 < var_271_7 then
					arg_268_1.talkMaxDuration = var_271_7

					if var_271_7 + var_271_3 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_3
					end
				end

				arg_268_1.text_.text = var_271_5
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_8 = math.max(var_271_4, arg_268_1.talkMaxDuration)

			if var_271_3 <= arg_268_1.time_ and arg_268_1.time_ < var_271_3 + var_271_8 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_3) / var_271_8

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_3 + var_271_8 and arg_268_1.time_ < var_271_3 + var_271_8 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play305072062 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 305072062
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play305072063(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 1.375

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_1 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(305072062).content)

				arg_272_1.text_.text = var_275_1

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_3 = 55 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 55)

				if (55 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 55)) > 0 and var_275_0 < var_275_3 then
					arg_272_1.talkMaxDuration = var_275_3

					if var_275_3 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_3 + 0
					end
				end

				arg_272_1.text_.text = var_275_1
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_4 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_4 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_4

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_4 and arg_272_1.time_ < 0 + var_275_4 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play305072063 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 305072063
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play305072064(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 1.125

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_1 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(305072063).content)

				arg_276_1.text_.text = var_279_1

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_3 = 45 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_1) / 45)

				if (45 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_1) / 45)) > 0 and var_279_0 < var_279_3 then
					arg_276_1.talkMaxDuration = var_279_3

					if var_279_3 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_3 + 0
					end
				end

				arg_276_1.text_.text = var_279_1
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_4 = math.max(var_279_0, arg_276_1.talkMaxDuration)

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_4 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - 0) / var_279_4

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= 0 + var_279_4 and arg_276_1.time_ < 0 + var_279_4 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play305072064 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 305072064
		arg_280_1.duration_ = 10.67

		local var_280_0 = {
			zh = 8.166,
			ja = 10.666
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play305072065(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0.6

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[1560].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10001")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_1 = arg_280_1:GetWordFromCfg(305072064)
				local var_283_2 = arg_280_1:FormatText(var_283_1.content)

				arg_280_1.text_.text = var_283_2

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_4 = 24 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_2) / 24)

				if (24 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_2) / 24)) > 0 and var_283_0 < var_283_4 then
					arg_280_1.talkMaxDuration = var_283_4

					if var_283_4 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_4 + 0
					end
				end

				arg_280_1.text_.text = var_283_2
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072064", "story_v_out_305072.awb") ~= 0 then
					local var_283_5 = manager.audio:GetVoiceLength("story_v_out_305072", "305072064", "story_v_out_305072.awb") / 1000

					if var_283_5 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_5 + 0
					end

					if var_283_1.prefab_name ~= "" and arg_280_1.actors_[var_283_1.prefab_name] ~= nil then
						local var_283_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_1.prefab_name].transform, "story_v_out_305072", "305072064", "story_v_out_305072.awb")

						arg_280_1:RecordAudio("305072064", var_283_6)
						arg_280_1:RecordAudio("305072064", var_283_6)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_305072", "305072064", "story_v_out_305072.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_305072", "305072064", "story_v_out_305072.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_7 = math.max(var_283_0, arg_280_1.talkMaxDuration)

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_7 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - 0) / var_283_7

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= 0 + var_283_7 and arg_280_1.time_ < 0 + var_283_7 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play305072065 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 305072065
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play305072066(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["10001_tpose"]) and arg_284_1.var_.characterEffect10001_tpose == nil then
				arg_284_1.var_.characterEffect10001_tpose = arg_284_1.actors_["10001_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_0 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["10001_tpose"]) then
				if arg_284_1.var_.characterEffect10001_tpose and not isNil(arg_284_1.actors_["10001_tpose"]) then
					arg_284_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_284_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_284_1.time_ - 0) / var_287_0)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["10001_tpose"]) and arg_284_1.var_.characterEffect10001_tpose then
				arg_284_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_284_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_287_1 = 0
			local var_287_2 = 0.3

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_3 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(305072065).content)

				arg_284_1.text_.text = var_287_3

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_5 = 12 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_3) / 12)

				if (12 <= 0 and var_287_2 or var_287_2 * (utf8.len(var_287_3) / 12)) > 0 and var_287_2 < var_287_5 then
					arg_284_1.talkMaxDuration = var_287_5

					if var_287_5 + var_287_1 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + var_287_1
					end
				end

				arg_284_1.text_.text = var_287_3
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_6 = math.max(var_287_2, arg_284_1.talkMaxDuration)

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_6 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_1) / var_287_6

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_1 + var_287_6 and arg_284_1.time_ < var_287_1 + var_287_6 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play305072066 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 305072066
		arg_288_1.duration_ = 9.2

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play305072067(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_9004
			local var_291_9003
			local var_291_9002
			local var_291_9001
			local var_291_9000

			if arg_288_1.actors_["10045ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10045ui_story"))) then
				local var_291_0 = Object.Instantiate(Asset.Load("Char/" .. "10045ui_story"), arg_288_1.stage_.transform)

				var_291_0.name = "10045ui_story"
				var_291_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_288_1.actors_["10045ui_story"] = var_291_0

				local var_291_1 = var_291_0:GetComponentInChildren(typeof(CharacterEffect))

				var_291_1.enabled = true

				local var_291_2 = GameObjectTools.GetOrAddComponent(var_291_0, typeof(DynamicBoneHelper))

				if var_291_2 then
					var_291_2:EnableDynamicBone(false)
				end

				arg_288_1:ShowWeapon(var_291_1.transform, false)

				arg_288_1.var_["10045ui_story" .. "Animator"] = var_291_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_288_1.var_["10045ui_story" .. "Animator"].applyRootMotion = true
				arg_288_1.var_["10045ui_story" .. "LipSync"] = var_291_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_291_3 = arg_288_1.actors_["10045ui_story"].transform

			if 0.833333333333333 < arg_288_1.time_ and arg_288_1.time_ <= 0.833333333333333 + arg_291_0 then
				arg_288_1.var_.moveOldPos10045ui_story = var_291_3.localPosition
			end

			local var_291_4 = 0.001

			if 0.833333333333333 <= arg_288_1.time_ and arg_288_1.time_ < 0.833333333333333 + var_291_4 then
				var_291_3.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10045ui_story, Vector3.New(0, -1.18, -6.05), (arg_288_1.time_ - 0.833333333333333) / var_291_4)
				var_291_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_3.position).x, (manager.ui.mainCamera.transform.position - var_291_3.position).y, (manager.ui.mainCamera.transform.position - var_291_3.position).z)
				var_291_3.localEulerAngles.z = 0
				var_291_3.localEulerAngles.x = 0
				var_291_3.localEulerAngles = var_291_3.localEulerAngles
			end

			if arg_288_1.time_ >= 0.833333333333333 + var_291_4 and arg_288_1.time_ < 0.833333333333333 + var_291_4 + arg_291_0 then
				var_291_3.localPosition = Vector3.New(0, -1.18, -6.05)
				var_291_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_3.position).x, (manager.ui.mainCamera.transform.position - var_291_3.position).y, (manager.ui.mainCamera.transform.position - var_291_3.position).z)
				var_291_3.localEulerAngles.z = 0
				var_291_3.localEulerAngles.x = 0
				var_291_3.localEulerAngles = var_291_3.localEulerAngles
			end

			local var_291_5 = arg_288_1.actors_["10001_tpose"].transform

			if 0.833333333333333 < arg_288_1.time_ and arg_288_1.time_ <= 0.833333333333333 + arg_291_0 then
				arg_288_1.var_.moveOldPos10001_tpose = var_291_5.localPosition

				local var_291_6 = GameObjectTools.GetOrAddComponent(var_291_5.gameObject, typeof(DynamicBoneHelper))

				if var_291_6 then
					var_291_6:EnableDynamicBone(false)
				end
			end

			local var_291_7 = 0.001

			if 0.833333333333333 <= arg_288_1.time_ and arg_288_1.time_ < 0.833333333333333 + var_291_7 then
				var_291_5.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_288_1.time_ - 0.833333333333333) / var_291_7)
				var_291_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_5.position).x, (manager.ui.mainCamera.transform.position - var_291_5.position).y, (manager.ui.mainCamera.transform.position - var_291_5.position).z)
				var_291_5.localEulerAngles.z = 0
				var_291_5.localEulerAngles.x = 0
				var_291_5.localEulerAngles = var_291_5.localEulerAngles
			end

			if arg_288_1.time_ >= 0.833333333333333 + var_291_7 and arg_288_1.time_ < 0.833333333333333 + var_291_7 + arg_291_0 then
				var_291_5.localPosition = Vector3.New(0, 100, 0)
				var_291_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_5.position).x, (manager.ui.mainCamera.transform.position - var_291_5.position).y, (manager.ui.mainCamera.transform.position - var_291_5.position).z)
				var_291_5.localEulerAngles.z = 0
				var_291_5.localEulerAngles.x = 0
				var_291_5.localEulerAngles = var_291_5.localEulerAngles

				local var_291_8 = GameObjectTools.GetOrAddComponent(var_291_5.gameObject, typeof(DynamicBoneHelper))

				if var_291_8 then
					var_291_8:EnableDynamicBone(true)
				end
			end

			local var_291_9 = arg_288_1.actors_["10045ui_story"]

			if 0.833333333333333 < arg_288_1.time_ and arg_288_1.time_ <= 0.833333333333333 + arg_291_0 and not isNil(var_291_9) and arg_288_1.var_.characterEffect10045ui_story == nil then
				arg_288_1.var_.characterEffect10045ui_story = var_291_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_10 = 0.200000002980232

			if 0.833333333333333 <= arg_288_1.time_ and arg_288_1.time_ < 0.833333333333333 + var_291_10 and not isNil(var_291_9) then
				if arg_288_1.var_.characterEffect10045ui_story and not isNil(var_291_9) then
					arg_288_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0.833333333333333 + var_291_10 and arg_288_1.time_ < 0.833333333333333 + var_291_10 + arg_291_0 and not isNil(var_291_9) and arg_288_1.var_.characterEffect10045ui_story then
				arg_288_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			if 0.833333333333333 < arg_288_1.time_ and arg_288_1.time_ <= 0.833333333333333 + arg_291_0 then
				arg_288_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action2_1")
			end

			if 0.833333333333333 < arg_288_1.time_ and arg_288_1.time_ <= 0.833333333333333 + arg_291_0 then
				arg_288_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0.833333333333333 < arg_288_1.time_ and arg_288_1.time_ <= 0.833333333333333 + arg_291_0 then
				local var_291_12 = arg_288_1.var_.effect字体

				if not arg_288_1.var_.effect字体 then
					var_291_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_erro2_big"), manager.ui.mainCamera.transform)
					var_291_12.name = "字体"
					arg_288_1.var_.effect字体 = var_291_12
				else
					var_291_12.transform:SetParent(var_291_9004)
				end

				var_291_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_291_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_291_12.transform.localScale = Vector3.New(var_291_12.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_291_12.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_291_12.transform.localScale.z)
			end

			if 2.8056731352893 < arg_288_1.time_ and arg_288_1.time_ <= 2.8056731352893 + arg_291_0 then
				if arg_288_1.var_.effect字体 then
					Object.Destroy(arg_288_1.var_.effect字体)

					arg_288_1.var_.effect字体 = nil
				end
			end

			if 1.23898159852251 < arg_288_1.time_ and arg_288_1.time_ <= 1.23898159852251 + arg_291_0 then
				local var_291_15 = arg_288_1.var_.effect不不不啊啊

				if not arg_288_1.var_.effect不不不啊啊 then
					var_291_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_moviemask"), manager.ui.mainCamera.transform)
					var_291_15.name = "不不不啊啊"
					arg_288_1.var_.effect不不不啊啊 = var_291_15
				else
					var_291_15.transform:SetParent(var_291_9003)
				end

				var_291_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_291_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_291_15.transform.localScale = Vector3.New(var_291_15.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_291_15.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_291_15.transform.localScale.z)
			end

			if 2.96666666666667 < arg_288_1.time_ and arg_288_1.time_ <= 2.96666666666667 + arg_291_0 then
				local var_291_17 = arg_288_1.var_.effect办法

				if not arg_288_1.var_.effect办法 then
					var_291_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_out"), manager.ui.mainCamera.transform)
					var_291_17.name = "办法"
					arg_288_1.var_.effect办法 = var_291_17
				else
					var_291_17.transform:SetParent(var_291_9002)
				end

				var_291_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_291_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_291_17.transform.localScale = Vector3.New(var_291_17.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_291_17.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_291_17.transform.localScale.z)
			end

			if 6.36666666666666 < arg_288_1.time_ and arg_288_1.time_ <= 6.36666666666666 + arg_291_0 then
				if arg_288_1.var_.effect办法 then
					Object.Destroy(arg_288_1.var_.effect办法)

					arg_288_1.var_.effect办法 = nil
				end
			end

			local var_291_20 = 0

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_20 + arg_291_0 then
				arg_288_1.mask_.enabled = true
				arg_288_1.mask_.raycastTarget = true

				arg_288_1:SetGaussion(false)
			end

			local var_291_21 = 0.876965401228517

			if var_291_20 <= arg_288_1.time_ and arg_288_1.time_ < var_291_20 + var_291_21 then
				local var_291_22 = Color.New(0, 0, 0)

				var_291_22.a = Mathf.Lerp(1, 0, (arg_288_1.time_ - var_291_20) / var_291_21)
				arg_288_1.mask_.color = var_291_22
			end

			if arg_288_1.time_ >= var_291_20 + var_291_21 and arg_288_1.time_ < var_291_20 + var_291_21 + arg_291_0 then
				local var_291_23 = Color.New(0, 0, 0)

				arg_288_1.mask_.enabled = false
				var_291_23.a = 0
				arg_288_1.mask_.color = var_291_23
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				local var_291_24 = arg_288_1.var_.effect办法1

				if not arg_288_1.var_.effect办法1 then
					var_291_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), manager.ui.mainCamera.transform)
					var_291_24.name = "办法1"
					arg_288_1.var_.effect办法1 = var_291_24
				else
					var_291_24.transform:SetParent(var_291_9001)
				end

				var_291_24.transform.localPosition = Vector3.New(0, 0, 0)
				var_291_24.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_291_24.transform.localScale = Vector3.New(var_291_24.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_291_24.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_291_24.transform.localScale.z)
			end

			if 3.52590169562027 < arg_288_1.time_ and arg_288_1.time_ <= 3.52590169562027 + arg_291_0 then
				if arg_288_1.var_.effect办法1 then
					Object.Destroy(arg_288_1.var_.effect办法1)

					arg_288_1.var_.effect办法1 = nil
				end
			end

			if 1.86666666666667 < arg_288_1.time_ and arg_288_1.time_ <= 1.86666666666667 + arg_291_0 then
				local var_291_27 = arg_288_1.var_.effect字体1

				if not arg_288_1.var_.effect字体1 then
					var_291_27 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_erro2_big"), manager.ui.mainCamera.transform)
					var_291_27.name = "字体1"
					arg_288_1.var_.effect字体1 = var_291_27
				else
					var_291_27.transform:SetParent(var_291_9000)
				end

				var_291_27.transform.localPosition = Vector3.New(0, -3.85, 0)
				var_291_27.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_291_27.transform.localScale = Vector3.New(var_291_27.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_291_27.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_291_27.transform.localScale.z)
			end

			if 3.83900646862263 < arg_288_1.time_ and arg_288_1.time_ <= 3.83900646862263 + arg_291_0 then
				if arg_288_1.var_.effect字体1 then
					Object.Destroy(arg_288_1.var_.effect字体1)

					arg_288_1.var_.effect字体1 = nil
				end
			end

			if arg_288_1.frameCnt_ <= 1 then
				arg_288_1.dialog_:SetActive(false)
			end

			local var_291_30 = 3.52590169562027
			local var_291_31 = 0.275

			if 3.52590169562027 < arg_288_1.time_ and arg_288_1.time_ <= var_291_30 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0

				arg_288_1.dialog_:SetActive(true)

				arg_288_1.dialogCg_.alpha = 0

				local var_291_32 = LeanTween.value(arg_288_1.dialog_, 0, 1, 0.3)

				var_291_32:setOnUpdate(LuaHelper.FloatAction(function(arg_292_0)
					arg_288_1.dialogCg_.alpha = arg_292_0
				end))
				var_291_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_288_1.dialog_)
					var_291_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_288_1.duration_ = arg_288_1.duration_ + 0.3

				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_33 = arg_288_1:GetWordFromCfg(305072066)
				local var_291_34 = arg_288_1:FormatText(var_291_33.content)

				arg_288_1.text_.text = var_291_34

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_36 = 11 <= 0 and var_291_31 or var_291_31 * (utf8.len(var_291_34) / 11)

				if (11 <= 0 and var_291_31 or var_291_31 * (utf8.len(var_291_34) / 11)) > 0 and var_291_31 < var_291_36 then
					arg_288_1.talkMaxDuration = var_291_36
					var_291_30 = var_291_30 + 0.3

					if var_291_36 + var_291_30 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_36 + var_291_30
					end
				end

				arg_288_1.text_.text = var_291_34
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072066", "story_v_out_305072.awb") ~= 0 then
					local var_291_37 = manager.audio:GetVoiceLength("story_v_out_305072", "305072066", "story_v_out_305072.awb") / 1000

					if var_291_37 + var_291_30 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_37 + var_291_30
					end

					if var_291_33.prefab_name ~= "" and arg_288_1.actors_[var_291_33.prefab_name] ~= nil then
						local var_291_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_33.prefab_name].transform, "story_v_out_305072", "305072066", "story_v_out_305072.awb")

						arg_288_1:RecordAudio("305072066", var_291_38)
						arg_288_1:RecordAudio("305072066", var_291_38)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_305072", "305072066", "story_v_out_305072.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_305072", "305072066", "story_v_out_305072.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_39 = var_291_30 + 0.3
			local var_291_40 = math.max(var_291_31, arg_288_1.talkMaxDuration)

			if var_291_30 + 0.3 <= arg_288_1.time_ and arg_288_1.time_ < var_291_39 + var_291_40 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_39) / var_291_40

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_39 + var_291_40 and arg_288_1.time_ < var_291_39 + var_291_40 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.833333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10001_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.833333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play305072067 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 305072067
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play305072068(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["10045ui_story"]) and arg_294_1.var_.characterEffect10045ui_story == nil then
				arg_294_1.var_.characterEffect10045ui_story = arg_294_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_0 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["10045ui_story"]) then
				if arg_294_1.var_.characterEffect10045ui_story and not isNil(arg_294_1.actors_["10045ui_story"]) then
					arg_294_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_294_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_294_1.time_ - 0) / var_297_0)
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["10045ui_story"]) and arg_294_1.var_.characterEffect10045ui_story then
				arg_294_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_294_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			local var_297_1 = 0
			local var_297_2 = 1.25

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_3 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(305072067).content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 50 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 50)

				if (50 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 50)) > 0 and var_297_2 < var_297_5 then
					arg_294_1.talkMaxDuration = var_297_5

					if var_297_5 + var_297_1 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + var_297_1
					end
				end

				arg_294_1.text_.text = var_297_3
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_6 = math.max(var_297_2, arg_294_1.talkMaxDuration)

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_6 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_1) / var_297_6

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_1 + var_297_6 and arg_294_1.time_ < var_297_1 + var_297_6 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play305072068 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 305072068
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play305072069(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				local var_301_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_301_0 then
					var_301_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_301_0.radialBlurScale = 0
					var_301_0.radialBlurGradient = 1
					var_301_0.radialBlurIntensity = 1

					if nil then
						var_301_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_301_1 = 1.22493380075321

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_1 then
				local var_301_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_301_2 then
					var_301_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_301_2.radialBlurScale = Mathf.Lerp(0, 1, (arg_298_1.time_ - 0) / var_301_1)
					var_301_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_298_1.time_ - 0) / var_301_1)
					var_301_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_298_1.time_ - 0) / var_301_1)
				end
			end

			if arg_298_1.time_ >= 0 + var_301_1 and arg_298_1.time_ < 0 + var_301_1 + arg_301_0 then
				local var_301_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_301_3 then
					var_301_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_301_3.radialBlurScale = 1
					var_301_3.radialBlurGradient = 1
					var_301_3.radialBlurIntensity = 1
				end
			end

			local var_301_4 = 0

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_4 + arg_301_0 then
				arg_298_1.allBtn_.enabled = false
			end

			if arg_298_1.time_ >= var_301_4 + 1.525 and arg_298_1.time_ < var_301_4 + 1.525 + arg_301_0 then
				arg_298_1.allBtn_.enabled = true
			end

			local var_301_5 = 0
			local var_301_6 = 1.525

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_5 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_7 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(305072068).content)

				arg_298_1.text_.text = var_301_7

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_9 = 61 <= 0 and var_301_6 or var_301_6 * (utf8.len(var_301_7) / 61)

				if (61 <= 0 and var_301_6 or var_301_6 * (utf8.len(var_301_7) / 61)) > 0 and var_301_6 < var_301_9 then
					arg_298_1.talkMaxDuration = var_301_9

					if var_301_9 + var_301_5 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_9 + var_301_5
					end
				end

				arg_298_1.text_.text = var_301_7
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_10 = math.max(var_301_6, arg_298_1.talkMaxDuration)

			if var_301_5 <= arg_298_1.time_ and arg_298_1.time_ < var_301_5 + var_301_10 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_5) / var_301_10

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_5 + var_301_10 and arg_298_1.time_ < var_301_5 + var_301_10 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play305072069 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 305072069
		arg_302_1.duration_ = 9.7

		local var_302_0 = {
			zh = 5.766,
			ja = 9.7
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play305072070(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(arg_302_1.actors_["10045ui_story"]) and arg_302_1.var_.characterEffect10045ui_story == nil then
				arg_302_1.var_.characterEffect10045ui_story = arg_302_1.actors_["10045ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_0 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 and not isNil(arg_302_1.actors_["10045ui_story"]) then
				if arg_302_1.var_.characterEffect10045ui_story and not isNil(arg_302_1.actors_["10045ui_story"]) then
					arg_302_1.var_.characterEffect10045ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 and not isNil(arg_302_1.actors_["10045ui_story"]) and arg_302_1.var_.characterEffect10045ui_story then
				arg_302_1.var_.characterEffect10045ui_story.fillFlat = false
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/story10045/story10045action/10045action2_2")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_305_2 = 0
			local var_305_3 = 0.475

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_2 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_4 = arg_302_1:GetWordFromCfg(305072069)
				local var_305_5 = arg_302_1:FormatText(var_305_4.content)

				arg_302_1.text_.text = var_305_5

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_7 = 19 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_5) / 19)

				if (19 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_5) / 19)) > 0 and var_305_3 < var_305_7 then
					arg_302_1.talkMaxDuration = var_305_7

					if var_305_7 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_7 + var_305_2
					end
				end

				arg_302_1.text_.text = var_305_5
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072069", "story_v_out_305072.awb") ~= 0 then
					local var_305_8 = manager.audio:GetVoiceLength("story_v_out_305072", "305072069", "story_v_out_305072.awb") / 1000

					if var_305_8 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_8 + var_305_2
					end

					if var_305_4.prefab_name ~= "" and arg_302_1.actors_[var_305_4.prefab_name] ~= nil then
						local var_305_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_4.prefab_name].transform, "story_v_out_305072", "305072069", "story_v_out_305072.awb")

						arg_302_1:RecordAudio("305072069", var_305_9)
						arg_302_1:RecordAudio("305072069", var_305_9)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_305072", "305072069", "story_v_out_305072.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_305072", "305072069", "story_v_out_305072.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_10 = math.max(var_305_3, arg_302_1.talkMaxDuration)

			if var_305_2 <= arg_302_1.time_ and arg_302_1.time_ < var_305_2 + var_305_10 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_2) / var_305_10

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_2 + var_305_10 and arg_302_1.time_ < var_305_2 + var_305_10 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play305072070 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 305072070
		arg_306_1.duration_ = 7.57

		local var_306_0 = {
			zh = 7.566,
			ja = 4.9
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play305072071(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0.675

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_1 = arg_306_1:GetWordFromCfg(305072070)
				local var_309_2 = arg_306_1:FormatText(var_309_1.content)

				arg_306_1.text_.text = var_309_2

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 27 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 27)

				if (27 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 27)) > 0 and var_309_0 < var_309_4 then
					arg_306_1.talkMaxDuration = var_309_4

					if var_309_4 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_4 + 0
					end
				end

				arg_306_1.text_.text = var_309_2
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072070", "story_v_out_305072.awb") ~= 0 then
					local var_309_5 = manager.audio:GetVoiceLength("story_v_out_305072", "305072070", "story_v_out_305072.awb") / 1000

					if var_309_5 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + 0
					end

					if var_309_1.prefab_name ~= "" and arg_306_1.actors_[var_309_1.prefab_name] ~= nil then
						local var_309_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_1.prefab_name].transform, "story_v_out_305072", "305072070", "story_v_out_305072.awb")

						arg_306_1:RecordAudio("305072070", var_309_6)
						arg_306_1:RecordAudio("305072070", var_309_6)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_305072", "305072070", "story_v_out_305072.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_305072", "305072070", "story_v_out_305072.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_7 and arg_306_1.time_ < 0 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play305072071 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 305072071
		arg_310_1.duration_ = 8.3

		local var_310_0 = {
			zh = 7.833,
			ja = 8.3
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play305072072(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:PlayTimeline("10045ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_313_0 = arg_310_1.actors_["10045ui_story"].transform

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos10045ui_story = var_313_0.localPosition
			end

			local var_313_1 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_1 then
				var_313_0.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos10045ui_story, Vector3.New(0, 100, 0), (arg_310_1.time_ - 0) / var_313_1)
				var_313_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_313_0.position).x, (manager.ui.mainCamera.transform.position - var_313_0.position).y, (manager.ui.mainCamera.transform.position - var_313_0.position).z)
				var_313_0.localEulerAngles.z = 0
				var_313_0.localEulerAngles.x = 0
				var_313_0.localEulerAngles = var_313_0.localEulerAngles
			end

			if arg_310_1.time_ >= 0 + var_313_1 and arg_310_1.time_ < 0 + var_313_1 + arg_313_0 then
				var_313_0.localPosition = Vector3.New(0, 100, 0)
				var_313_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_313_0.position).x, (manager.ui.mainCamera.transform.position - var_313_0.position).y, (manager.ui.mainCamera.transform.position - var_313_0.position).z)
				var_313_0.localEulerAngles.z = 0
				var_313_0.localEulerAngles.x = 0
				var_313_0.localEulerAngles = var_313_0.localEulerAngles
			end

			local var_313_2 = 0
			local var_313_3 = 0.525

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_2 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[45].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, true)
				arg_310_1.iconController_:SetSelectedState("hero")

				arg_310_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10045")

				arg_310_1.callingController_:SetSelectedState("normal")

				arg_310_1.keyicon_.color = Color.New(1, 1, 1)
				arg_310_1.icon_.color = Color.New(1, 1, 1)

				local var_313_4 = arg_310_1:GetWordFromCfg(305072071)
				local var_313_5 = arg_310_1:FormatText(var_313_4.content)

				arg_310_1.text_.text = var_313_5

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_7 = 21 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_5) / 21)

				if (21 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_5) / 21)) > 0 and var_313_3 < var_313_7 then
					arg_310_1.talkMaxDuration = var_313_7

					if var_313_7 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_7 + var_313_2
					end
				end

				arg_310_1.text_.text = var_313_5
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072071", "story_v_out_305072.awb") ~= 0 then
					local var_313_8 = manager.audio:GetVoiceLength("story_v_out_305072", "305072071", "story_v_out_305072.awb") / 1000

					if var_313_8 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_8 + var_313_2
					end

					if var_313_4.prefab_name ~= "" and arg_310_1.actors_[var_313_4.prefab_name] ~= nil then
						local var_313_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_4.prefab_name].transform, "story_v_out_305072", "305072071", "story_v_out_305072.awb")

						arg_310_1:RecordAudio("305072071", var_313_9)
						arg_310_1:RecordAudio("305072071", var_313_9)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_305072", "305072071", "story_v_out_305072.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_305072", "305072071", "story_v_out_305072.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_10 = math.max(var_313_3, arg_310_1.talkMaxDuration)

			if var_313_2 <= arg_310_1.time_ and arg_310_1.time_ < var_313_2 + var_313_10 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_2) / var_313_10

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_2 + var_313_10 and arg_310_1.time_ < var_313_2 + var_313_10 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play305072072 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 305072072
		arg_314_1.duration_ = 8.93

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play305072073(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_9000

			if 2.16666666666667 < arg_314_1.time_ and arg_314_1.time_ <= 2.16666666666667 + arg_317_0 then
				arg_314_1.var_.moveOldPos10045ui_story = arg_314_1.actors_["10045ui_story"].transform.localPosition
			end

			local var_317_0 = 0.133333333333333

			if 2.16666666666667 <= arg_314_1.time_ and arg_314_1.time_ < 2.16666666666667 + var_317_0 then
				arg_314_1.actors_["10045ui_story"].transform.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos10045ui_story, Vector3.New(0, 100, 0), (arg_314_1.time_ - 2.16666666666667) / var_317_0)
				arg_314_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10045ui_story"].transform.position).z)
				arg_314_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["10045ui_story"].transform.localEulerAngles = arg_314_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			if arg_314_1.time_ >= 2.16666666666667 + var_317_0 and arg_314_1.time_ < 2.16666666666667 + var_317_0 + arg_317_0 then
				arg_314_1.actors_["10045ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_314_1.actors_["10045ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_314_1.actors_["10045ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10045ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_314_1.actors_["10045ui_story"].transform.position).z)
				arg_314_1.actors_["10045ui_story"].transform.localEulerAngles.z = 0
				arg_314_1.actors_["10045ui_story"].transform.localEulerAngles.x = 0
				arg_314_1.actors_["10045ui_story"].transform.localEulerAngles = arg_314_1.actors_["10045ui_story"].transform.localEulerAngles
			end

			local var_317_1 = arg_314_1.actors_["10045ui_story"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_1) and arg_314_1.var_.characterEffect10045ui_story == nil then
				arg_314_1.var_.characterEffect10045ui_story = var_317_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_2 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_2 and not isNil(var_317_1) then
				if arg_314_1.var_.characterEffect10045ui_story and not isNil(var_317_1) then
					arg_314_1.var_.characterEffect10045ui_story.fillFlat = true
					arg_314_1.var_.characterEffect10045ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_314_1.time_ - 0) / var_317_2)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_2 and arg_314_1.time_ < 0 + var_317_2 + arg_317_0 and not isNil(var_317_1) and arg_314_1.var_.characterEffect10045ui_story then
				arg_314_1.var_.characterEffect10045ui_story.fillFlat = true
				arg_314_1.var_.characterEffect10045ui_story.fillRatio = 0.5
			end

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				local var_317_3 = arg_314_1.var_.effect333问问

				if not arg_314_1.var_.effect333问问 then
					var_317_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapblink"), manager.ui.mainCamera.transform)
					var_317_3.name = "333问问"
					arg_314_1.var_.effect333问问 = var_317_3
				else
					var_317_3.transform:SetParent(var_317_9000)
				end

				var_317_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_317_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_317_3.transform.localScale = Vector3.New(var_317_3.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_317_3.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_317_3.transform.localScale.z)
			end

			if 3.5 < arg_314_1.time_ and arg_314_1.time_ <= 3.5 + arg_317_0 then
				if arg_314_1.var_.effect333问问 then
					Object.Destroy(arg_314_1.var_.effect333问问)

					arg_314_1.var_.effect333问问 = nil
				end
			end

			local var_317_6 = 0

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_6 + arg_317_0 then
				arg_314_1.allBtn_.enabled = false
			end

			if arg_314_1.time_ >= var_317_6 + 4.43948500556871 and arg_314_1.time_ < var_317_6 + 4.43948500556871 + arg_317_0 then
				arg_314_1.allBtn_.enabled = true
			end

			local var_317_7 = 1.94921720679849

			if 1.94921720679849 < arg_314_1.time_ and arg_314_1.time_ <= var_317_7 + arg_317_0 then
				arg_314_1.mask_.enabled = true
				arg_314_1.mask_.raycastTarget = true

				arg_314_1:SetGaussion(false)
			end

			local var_317_8 = 1.150783

			if var_317_7 <= arg_314_1.time_ and arg_314_1.time_ < var_317_7 + var_317_8 then
				local var_317_9 = Color.New(1, 1, 1)

				var_317_9.a = Mathf.Lerp(1, 0, (arg_314_1.time_ - var_317_7) / var_317_8)
				arg_314_1.mask_.color = var_317_9
			end

			if arg_314_1.time_ >= var_317_7 + var_317_8 and arg_314_1.time_ < var_317_7 + var_317_8 + arg_317_0 then
				local var_317_10 = Color.New(1, 1, 1)

				arg_314_1.mask_.enabled = false
				var_317_10.a = 0
				arg_314_1.mask_.color = var_317_10
			end

			local var_317_11

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				local var_317_12 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_317_12 then
					var_317_12.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_317_12.radialBlurScale = 0.986
					var_317_12.radialBlurGradient = 1
					var_317_12.radialBlurIntensity = 1

					if var_317_11 then
						var_317_12.radialBlurTarget = var_317_11.transform
					end
				end
			end

			local var_317_13 = 2.4

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_13 then
				local var_317_14 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_317_14 then
					var_317_14.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_317_14.radialBlurScale = Mathf.Lerp(0.986, 0.986, (arg_314_1.time_ - 0) / var_317_13)
					var_317_14.radialBlurGradient = Mathf.Lerp(1, 1, (arg_314_1.time_ - 0) / var_317_13)
					var_317_14.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_314_1.time_ - 0) / var_317_13)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_13 and arg_314_1.time_ < 0 + var_317_13 + arg_317_0 then
				local var_317_15 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_317_15 then
					var_317_15.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_317_15.radialBlurScale = 0.986
					var_317_15.radialBlurGradient = 1
					var_317_15.radialBlurIntensity = 1
				end
			end

			local var_317_16

			if 2.4 < arg_314_1.time_ and arg_314_1.time_ <= 2.4 + arg_317_0 then
				local var_317_17 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_317_17 then
					var_317_17.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_317_17.radialBlurScale = 0.986
					var_317_17.radialBlurGradient = 1
					var_317_17.radialBlurIntensity = 1

					if var_317_16 then
						var_317_17.radialBlurTarget = var_317_16.transform
					end
				end
			end

			local var_317_18 = 0.3

			if 2.4 <= arg_314_1.time_ and arg_314_1.time_ < 2.4 + var_317_18 then
				local var_317_19 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_317_19 then
					var_317_19.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_317_19.radialBlurScale = Mathf.Lerp(0.986, 0, (arg_314_1.time_ - 2.4) / var_317_18)
					var_317_19.radialBlurGradient = Mathf.Lerp(1, 1, (arg_314_1.time_ - 2.4) / var_317_18)
					var_317_19.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_314_1.time_ - 2.4) / var_317_18)
				end
			end

			if arg_314_1.time_ >= 2.4 + var_317_18 and arg_314_1.time_ < 2.4 + var_317_18 + arg_317_0 then
				local var_317_20 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_317_20 then
					var_317_20.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_317_20.radialBlurScale = 0
					var_317_20.radialBlurGradient = 1
					var_317_20.radialBlurIntensity = 1
				end
			end

			if 2.3 < arg_314_1.time_ and arg_314_1.time_ <= 2.3 + arg_317_0 then
				if arg_314_1.var_.effect不不不啊啊 then
					Object.Destroy(arg_314_1.var_.effect不不不啊啊)

					arg_314_1.var_.effect不不不啊啊 = nil
				end
			end

			if arg_314_1.frameCnt_ <= 1 then
				arg_314_1.dialog_:SetActive(false)
			end

			local var_317_22 = 3.93333333333333
			local var_317_23 = 0.775

			if 3.93333333333333 < arg_314_1.time_ and arg_314_1.time_ <= var_317_22 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0

				arg_314_1.dialog_:SetActive(true)

				arg_314_1.dialogCg_.alpha = 0

				local var_317_24 = LeanTween.value(arg_314_1.dialog_, 0, 1, 0.3)

				var_317_24:setOnUpdate(LuaHelper.FloatAction(function(arg_318_0)
					arg_314_1.dialogCg_.alpha = arg_318_0
				end))
				var_317_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_314_1.dialog_)
					var_317_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_314_1.duration_ = arg_314_1.duration_ + 0.3

				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_25 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(305072072).content)

				arg_314_1.text_.text = var_317_25

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_27 = 31 <= 0 and var_317_23 or var_317_23 * (utf8.len(var_317_25) / 31)

				if (31 <= 0 and var_317_23 or var_317_23 * (utf8.len(var_317_25) / 31)) > 0 and var_317_23 < var_317_27 then
					arg_314_1.talkMaxDuration = var_317_27
					var_317_22 = var_317_22 + 0.3

					if var_317_27 + var_317_22 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_27 + var_317_22
					end
				end

				arg_314_1.text_.text = var_317_25
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_28 = var_317_22 + 0.3
			local var_317_29 = math.max(var_317_23, arg_314_1.talkMaxDuration)

			if var_317_22 + 0.3 <= arg_314_1.time_ and arg_314_1.time_ < var_317_28 + var_317_29 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_28) / var_317_29

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_28 + var_317_29 and arg_314_1.time_ < var_317_28 + var_317_29 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10045ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.133333333333333,
				className = "StoryMoveNode",
				startTime = 2.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play305072073 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 305072073
		arg_320_1.duration_ = 4.77

		local var_320_0 = {
			zh = 4.6,
			ja = 4.766
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play305072074(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos1148ui_story = arg_320_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_323_0 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 then
				arg_320_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1148ui_story, Vector3.New(0, -0.8, -6.2), (arg_320_1.time_ - 0) / var_323_0)
				arg_320_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1148ui_story"].transform.position).z)
				arg_320_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["1148ui_story"].transform.localEulerAngles = arg_320_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 then
				arg_320_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, -0.8, -6.2)
				arg_320_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1148ui_story"].transform.position).z)
				arg_320_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["1148ui_story"].transform.localEulerAngles = arg_320_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_323_1 = arg_320_1.actors_["1148ui_story"]

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(var_323_1) and arg_320_1.var_.characterEffect1148ui_story == nil then
				arg_320_1.var_.characterEffect1148ui_story = var_323_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_2 = 0.200000002980232

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_2 and not isNil(var_323_1) then
				if arg_320_1.var_.characterEffect1148ui_story and not isNil(var_323_1) then
					arg_320_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= 0 + var_323_2 and arg_320_1.time_ < 0 + var_323_2 + arg_323_0 and not isNil(var_323_1) and arg_320_1.var_.characterEffect1148ui_story then
				arg_320_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148actionlink/1148action495")
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_323_4 = 0
			local var_323_5 = 0.525

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_4 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_6 = arg_320_1:GetWordFromCfg(305072073)
				local var_323_7 = arg_320_1:FormatText(var_323_6.content)

				arg_320_1.text_.text = var_323_7

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_9 = 21 <= 0 and var_323_5 or var_323_5 * (utf8.len(var_323_7) / 21)

				if (21 <= 0 and var_323_5 or var_323_5 * (utf8.len(var_323_7) / 21)) > 0 and var_323_5 < var_323_9 then
					arg_320_1.talkMaxDuration = var_323_9

					if var_323_9 + var_323_4 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_9 + var_323_4
					end
				end

				arg_320_1.text_.text = var_323_7
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305072", "305072073", "story_v_out_305072.awb") ~= 0 then
					local var_323_10 = manager.audio:GetVoiceLength("story_v_out_305072", "305072073", "story_v_out_305072.awb") / 1000

					if var_323_10 + var_323_4 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_10 + var_323_4
					end

					if var_323_6.prefab_name ~= "" and arg_320_1.actors_[var_323_6.prefab_name] ~= nil then
						local var_323_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_6.prefab_name].transform, "story_v_out_305072", "305072073", "story_v_out_305072.awb")

						arg_320_1:RecordAudio("305072073", var_323_11)
						arg_320_1:RecordAudio("305072073", var_323_11)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_305072", "305072073", "story_v_out_305072.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_305072", "305072073", "story_v_out_305072.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_12 = math.max(var_323_5, arg_320_1.talkMaxDuration)

			if var_323_4 <= arg_320_1.time_ and arg_320_1.time_ < var_323_4 + var_323_12 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_4) / var_323_12

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_4 + var_323_12 and arg_320_1.time_ < var_323_4 + var_323_12 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play305072074 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 305072074
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play305072075(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["1148ui_story"]) and arg_324_1.var_.characterEffect1148ui_story == nil then
				arg_324_1.var_.characterEffect1148ui_story = arg_324_1.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_0 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["1148ui_story"]) then
				if arg_324_1.var_.characterEffect1148ui_story and not isNil(arg_324_1.actors_["1148ui_story"]) then
					arg_324_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_324_1.time_ - 0) / var_327_0)
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["1148ui_story"]) and arg_324_1.var_.characterEffect1148ui_story then
				arg_324_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_327_1 = 0
			local var_327_2 = 0.575

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, true)
				arg_324_1.iconController_:SetSelectedState("hero")

				arg_324_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_324_1.callingController_:SetSelectedState("normal")

				arg_324_1.keyicon_.color = Color.New(1, 1, 1)
				arg_324_1.icon_.color = Color.New(1, 1, 1)

				local var_327_3 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(305072074).content)

				arg_324_1.text_.text = var_327_3

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_5 = 23 <= 0 and var_327_2 or var_327_2 * (utf8.len(var_327_3) / 23)

				if (23 <= 0 and var_327_2 or var_327_2 * (utf8.len(var_327_3) / 23)) > 0 and var_327_2 < var_327_5 then
					arg_324_1.talkMaxDuration = var_327_5

					if var_327_5 + var_327_1 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_5 + var_327_1
					end
				end

				arg_324_1.text_.text = var_327_3
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_6 = math.max(var_327_2, arg_324_1.talkMaxDuration)

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_6 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_1) / var_327_6

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_1 + var_327_6 and arg_324_1.time_ < var_327_1 + var_327_6 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play305072075 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 305072075
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
			arg_328_1.auto_ = false
		end

		function arg_328_1.playNext_(arg_330_0)
			arg_328_1.onStoryFinished_()
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0.625

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_1 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(305072075).content)

				arg_328_1.text_.text = var_331_1

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_3 = 25 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_1) / 25)

				if (25 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_1) / 25)) > 0 and var_331_0 < var_331_3 then
					arg_328_1.talkMaxDuration = var_331_3

					if var_331_3 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_3 + 0
					end
				end

				arg_328_1.text_.text = var_331_1
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_4 = math.max(var_331_0, arg_328_1.talkMaxDuration)

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_4 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - 0) / var_331_4

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= 0 + var_331_4 and arg_328_1.time_ < 0 + var_331_4 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B12",
		"TextureConfig/Background/S0505",
		"TextureConfig/Background/S0507",
		"TextureConfig/Background/B06b"
	},
	voices = {
		"story_v_out_305072.awb"
	}
}
