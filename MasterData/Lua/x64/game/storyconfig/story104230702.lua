return {
	Play423072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423072001
		arg_1_1.duration_ = 6.07

		local var_1_0 = {
			zh = 6.065999999999,
			ja = 4.232999999999
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
				arg_1_0:Play423072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I25h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I25h")
				var_4_0.name = "I25h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I25h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I25h

				arg_1_1.bgs_.I25h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I25h" then
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
				arg_1_1:AudioAction("play", "effect", "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_16", "se_story_16_gun03", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous.awb")

				local var_4_16 = manager.audio:GetAudioName("bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_16 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_16

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_16
						arg_1_1.bgmTxt2_.text = var_4_16
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

			local var_4_17 = 1.999999999999
			local var_4_18 = 0.3

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_19 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_19:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1335].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_gangsterb")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_20 = arg_1_1:GetWordFromCfg(423072001)
				local var_4_21 = arg_1_1:FormatText(var_4_20.content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 12 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_21) / 12)

				if (12 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_21) / 12)) > 0 and var_4_18 < var_4_23 then
					arg_1_1.talkMaxDuration = var_4_23
					var_4_17 = var_4_17 + 0.3

					if var_4_23 + var_4_17 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_17
					end
				end

				arg_1_1.text_.text = var_4_21
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423072", "423072001", "story_v_out_423072.awb") ~= 0 then
					local var_4_24 = manager.audio:GetVoiceLength("story_v_out_423072", "423072001", "story_v_out_423072.awb") / 1000

					if var_4_24 + var_4_17 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_17
					end

					if var_4_20.prefab_name ~= "" and arg_1_1.actors_[var_4_20.prefab_name] ~= nil then
						local var_4_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_20.prefab_name].transform, "story_v_out_423072", "423072001", "story_v_out_423072.awb")

						arg_1_1:RecordAudio("423072001", var_4_25)
						arg_1_1:RecordAudio("423072001", var_4_25)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423072", "423072001", "story_v_out_423072.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423072", "423072001", "story_v_out_423072.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_26 = var_4_17 + 0.3
			local var_4_27 = math.max(var_4_18, arg_1_1.talkMaxDuration)

			if var_4_17 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_26) / var_4_27

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play423072002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423072002
		arg_9_1.duration_ = 5.6

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play423072003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_9000

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_12_0 = 0.6

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				local var_12_1, var_12_2 = math.modf((arg_9_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_12_2 * 0.13, var_12_2 * 0.13, var_12_2 * 0.13) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				manager.ui.mainCamera.transform.localPosition = arg_9_1.var_.shakeOldPos
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_3 = arg_9_1.var_.effectzhuijizhan1

				if not arg_9_1.var_.effectzhuijizhan1 then
					var_12_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), manager.ui.mainCamera.transform)
					var_12_3.name = "zhuijizhan1"
					arg_9_1.var_.effectzhuijizhan1 = var_12_3
				else
					var_12_3.transform:SetParent(var_12_9000)
				end

				var_12_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_12_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_12_5 = 0

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			if arg_9_1.time_ >= var_12_5 + 0.6 and arg_9_1.time_ < var_12_5 + 0.6 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			if 0.166666666666667 < arg_9_1.time_ and arg_9_1.time_ <= 0.166666666666667 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_144", "se_story_144_motorcyclegun", "")
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_7 = 0.6
			local var_12_8 = 1.2

			if 0.6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_7 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_9 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_9:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(423072002).content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_12 = 48 <= 0 and var_12_8 or var_12_8 * (utf8.len(var_12_10) / 48)

				if (48 <= 0 and var_12_8 or var_12_8 * (utf8.len(var_12_10) / 48)) > 0 and var_12_8 < var_12_12 then
					arg_9_1.talkMaxDuration = var_12_12
					var_12_7 = var_12_7 + 0.3

					if var_12_12 + var_12_7 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_12 + var_12_7
					end
				end

				arg_9_1.text_.text = var_12_10
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_13 = var_12_7 + 0.3
			local var_12_14 = math.max(var_12_8, arg_9_1.talkMaxDuration)

			if var_12_7 + 0.3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_13 + var_12_14 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_13) / var_12_14

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_13 + var_12_14 and arg_9_1.time_ < var_12_13 + var_12_14 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play423072003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 423072003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play423072004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 1.325

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_1 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(423072003).content)

				arg_15_1.text_.text = var_18_1

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_3 = 53 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 53)

				if (53 <= 0 and var_18_0 or var_18_0 * (utf8.len(var_18_1) / 53)) > 0 and var_18_0 < var_18_3 then
					arg_15_1.talkMaxDuration = var_18_3

					if var_18_3 + 0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_3 + 0
					end
				end

				arg_15_1.text_.text = var_18_1
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_4 = math.max(var_18_0, arg_15_1.talkMaxDuration)

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - 0) / var_18_4

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play423072004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 423072004
		arg_19_1.duration_ = 5.2

		local var_19_0 = {
			zh = 4.066,
			ja = 5.2
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play423072005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_9000

			if arg_19_1.actors_["1083"] == nil then
				local var_22_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_22_0) then
					local var_22_1 = Object.Instantiate(var_22_0, arg_19_1.canvasGo_.transform)

					var_22_1.transform:SetSiblingIndex(1)

					var_22_1.name = "1083"
					var_22_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_19_1.actors_["1083"] = var_22_1

					if arg_19_1.isInRecall_ then
						for iter_22_0, iter_22_1 in ipairs((var_22_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_22_1.color = arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_22_2 = arg_19_1.actors_["1083"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_2) and arg_19_1.var_.actorSpriteComps1083 == nil then
				arg_19_1.var_.actorSpriteComps1083 = var_22_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_3 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_3 and not isNil(var_22_2) then
				if arg_19_1.var_.actorSpriteComps1083 then
					for iter_22_2, iter_22_3 in pairs(arg_19_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_22_3 then
							if arg_19_1.isInRecall_ then
								iter_22_3.color = Color.New(Mathf.Lerp(iter_22_3.color.r, arg_19_1.hightColor1.r, (arg_19_1.time_ - 0) / var_22_3), Mathf.Lerp(iter_22_3.color.g, arg_19_1.hightColor1.g, (arg_19_1.time_ - 0) / var_22_3), (Mathf.Lerp(iter_22_3.color.b, arg_19_1.hightColor1.b, (arg_19_1.time_ - 0) / var_22_3)))
							else
								local var_22_4 = Mathf.Lerp(iter_22_3.color.r, 1, (arg_19_1.time_ - 0) / var_22_3)

								iter_22_3.color = Color.New(var_22_4, var_22_4, var_22_4)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= 0 + var_22_3 and arg_19_1.time_ < 0 + var_22_3 + arg_22_0 and not isNil(var_22_2) and arg_19_1.var_.actorSpriteComps1083 then
				for iter_22_4, iter_22_5 in pairs(arg_19_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_22_5 then
						iter_22_5.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_19_1.var_.actorSpriteComps1083 = nil
			end

			local var_22_5 = arg_19_1.actors_["1083"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1083 = var_22_5.localPosition
				var_22_5.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("1083", 3)

				for iter_22_6 = 0, var_22_5.childCount - 1 do
					local var_22_6 = var_22_5:GetChild(iter_22_6)

					if var_22_6.name == "split_7" or not string.find(var_22_6.name, "split") then
						var_22_6.gameObject:SetActive(true)
					else
						var_22_6.gameObject:SetActive(false)
					end
				end
			end

			local var_22_7 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_7 then
				var_22_5.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_19_1.time_ - 0) / var_22_7)
			end

			if arg_19_1.time_ >= 0 + var_22_7 and arg_19_1.time_ < 0 + var_22_7 + arg_22_0 then
				var_22_5.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				local var_22_8 = arg_19_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_22_8 then
					arg_19_1.var_.alphaOldValue1083 = var_22_8.alpha
					arg_19_1.var_.characterEffect1083 = var_22_8
				end

				arg_19_1.var_.alphaOldValue1083 = 0
			end

			local var_22_9 = 0.3

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_9 then
				if arg_19_1.var_.characterEffect1083 then
					arg_19_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_19_1.var_.alphaOldValue1083, 1, (arg_19_1.time_ - 0) / var_22_9)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_9 and arg_19_1.time_ < 0 + var_22_9 + arg_22_0 and arg_19_1.var_.characterEffect1083 then
				arg_19_1.var_.characterEffect1083.alpha = 1
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				if arg_19_1.var_.effectzhuijizhan1 then
					Object.Destroy(arg_19_1.var_.effectzhuijizhan1)

					arg_19_1.var_.effectzhuijizhan1 = nil
				end
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				local var_22_11 = arg_19_1.var_.effectzhuijizhan2

				if not arg_19_1.var_.effectzhuijizhan2 then
					var_22_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_out"), manager.ui.mainCamera.transform)
					var_22_11.name = "zhuijizhan2"
					arg_19_1.var_.effectzhuijizhan2 = var_22_11
				else
					var_22_11.transform:SetParent(var_22_9000)
				end

				var_22_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_22_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_19_1.time_ and arg_19_1.time_ <= 1 + arg_22_0 then
				if arg_19_1.var_.effectzhuijizhan2 then
					Object.Destroy(arg_19_1.var_.effectzhuijizhan2)

					arg_19_1.var_.effectzhuijizhan2 = nil
				end
			end

			local var_22_14 = 0
			local var_22_15 = 0.575

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_14 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_16 = arg_19_1:GetWordFromCfg(423072004)
				local var_22_17 = arg_19_1:FormatText(var_22_16.content)

				arg_19_1.text_.text = var_22_17

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_19 = 23 <= 0 and var_22_15 or var_22_15 * (utf8.len(var_22_17) / 23)

				if (23 <= 0 and var_22_15 or var_22_15 * (utf8.len(var_22_17) / 23)) > 0 and var_22_15 < var_22_19 then
					arg_19_1.talkMaxDuration = var_22_19

					if var_22_19 + var_22_14 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_19 + var_22_14
					end
				end

				arg_19_1.text_.text = var_22_17
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423072", "423072004", "story_v_out_423072.awb") ~= 0 then
					local var_22_20 = manager.audio:GetVoiceLength("story_v_out_423072", "423072004", "story_v_out_423072.awb") / 1000

					if var_22_20 + var_22_14 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_20 + var_22_14
					end

					if var_22_16.prefab_name ~= "" and arg_19_1.actors_[var_22_16.prefab_name] ~= nil then
						local var_22_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_16.prefab_name].transform, "story_v_out_423072", "423072004", "story_v_out_423072.awb")

						arg_19_1:RecordAudio("423072004", var_22_21)
						arg_19_1:RecordAudio("423072004", var_22_21)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_423072", "423072004", "story_v_out_423072.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_423072", "423072004", "story_v_out_423072.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_22 = math.max(var_22_15, arg_19_1.talkMaxDuration)

			if var_22_14 <= arg_19_1.time_ and arg_19_1.time_ < var_22_14 + var_22_22 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_14) / var_22_22

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_14 + var_22_22 and arg_19_1.time_ < var_22_14 + var_22_22 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play423072005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 423072005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play423072006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1083"]) and arg_23_1.var_.actorSpriteComps1083 == nil then
				arg_23_1.var_.actorSpriteComps1083 = arg_23_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_0 = 0.2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1083"]) then
				if arg_23_1.var_.actorSpriteComps1083 then
					for iter_26_0, iter_26_1 in pairs(arg_23_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_26_1 then
							if arg_23_1.isInRecall_ then
								iter_26_1.color = Color.New(Mathf.Lerp(iter_26_1.color.r, arg_23_1.hightColor2.r, (arg_23_1.time_ - 0) / var_26_0), Mathf.Lerp(iter_26_1.color.g, arg_23_1.hightColor2.g, (arg_23_1.time_ - 0) / var_26_0), (Mathf.Lerp(iter_26_1.color.b, arg_23_1.hightColor2.b, (arg_23_1.time_ - 0) / var_26_0)))
							else
								local var_26_1 = Mathf.Lerp(iter_26_1.color.r, 0.5, (arg_23_1.time_ - 0) / var_26_0)

								iter_26_1.color = Color.New(var_26_1, var_26_1, var_26_1)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1083"]) and arg_23_1.var_.actorSpriteComps1083 then
				for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_26_3 then
						iter_26_3.color = arg_23_1.isInRecall_ and (arg_23_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_23_1.var_.actorSpriteComps1083 = nil
			end

			local var_26_2 = 0
			local var_26_3 = 0.675

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_2 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_4 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(423072005).content)

				arg_23_1.text_.text = var_26_4

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_6 = 27 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_4) / 27)

				if (27 <= 0 and var_26_3 or var_26_3 * (utf8.len(var_26_4) / 27)) > 0 and var_26_3 < var_26_6 then
					arg_23_1.talkMaxDuration = var_26_6

					if var_26_6 + var_26_2 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_6 + var_26_2
					end
				end

				arg_23_1.text_.text = var_26_4
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_3, arg_23_1.talkMaxDuration)

			if var_26_2 <= arg_23_1.time_ and arg_23_1.time_ < var_26_2 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_2) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_2 + var_26_7 and arg_23_1.time_ < var_26_2 + var_26_7 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play423072006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 423072006
		arg_27_1.duration_ = 4.3

		local var_27_0 = {
			zh = 4.266,
			ja = 4.3
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
				arg_27_0:Play423072007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1083"]) and arg_27_1.var_.actorSpriteComps1083 == nil then
				arg_27_1.var_.actorSpriteComps1083 = arg_27_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_0 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1083"]) then
				if arg_27_1.var_.actorSpriteComps1083 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								iter_30_1.color = Color.New(Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor1.r, (arg_27_1.time_ - 0) / var_30_0), Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor1.g, (arg_27_1.time_ - 0) / var_30_0), (Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor1.b, (arg_27_1.time_ - 0) / var_30_0)))
							else
								local var_30_1 = Mathf.Lerp(iter_30_1.color.r, 1, (arg_27_1.time_ - 0) / var_30_0)

								iter_30_1.color = Color.New(var_30_1, var_30_1, var_30_1)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1083"]) and arg_27_1.var_.actorSpriteComps1083 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_30_3 then
						iter_30_3.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_27_1.var_.actorSpriteComps1083 = nil
			end

			local var_30_2 = arg_27_1.actors_["1083"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1083 = var_30_2.localPosition
				var_30_2.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("1083", 3)

				for iter_30_4 = 0, var_30_2.childCount - 1 do
					local var_30_3 = var_30_2:GetChild(iter_30_4)

					if var_30_3.name == "" or not string.find(var_30_3.name, "split") then
						var_30_3.gameObject:SetActive(true)
					else
						var_30_3.gameObject:SetActive(false)
					end
				end
			end

			local var_30_4 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				var_30_2.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_27_1.time_ - 0) / var_30_4)
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				var_30_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_30_5 = 0
			local var_30_6 = 0.5

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_7 = arg_27_1:GetWordFromCfg(423072006)
				local var_30_8 = arg_27_1:FormatText(var_30_7.content)

				arg_27_1.text_.text = var_30_8

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_10 = 20 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_8) / 20)

				if (20 <= 0 and var_30_6 or var_30_6 * (utf8.len(var_30_8) / 20)) > 0 and var_30_6 < var_30_10 then
					arg_27_1.talkMaxDuration = var_30_10

					if var_30_10 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_10 + var_30_5
					end
				end

				arg_27_1.text_.text = var_30_8
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423072", "423072006", "story_v_out_423072.awb") ~= 0 then
					local var_30_11 = manager.audio:GetVoiceLength("story_v_out_423072", "423072006", "story_v_out_423072.awb") / 1000

					if var_30_11 + var_30_5 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_11 + var_30_5
					end

					if var_30_7.prefab_name ~= "" and arg_27_1.actors_[var_30_7.prefab_name] ~= nil then
						local var_30_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_7.prefab_name].transform, "story_v_out_423072", "423072006", "story_v_out_423072.awb")

						arg_27_1:RecordAudio("423072006", var_30_12)
						arg_27_1:RecordAudio("423072006", var_30_12)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_423072", "423072006", "story_v_out_423072.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_423072", "423072006", "story_v_out_423072.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_13 = math.max(var_30_6, arg_27_1.talkMaxDuration)

			if var_30_5 <= arg_27_1.time_ and arg_27_1.time_ < var_30_5 + var_30_13 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_5) / var_30_13

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_5 + var_30_13 and arg_27_1.time_ < var_30_5 + var_30_13 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play423072007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 423072007
		arg_31_1.duration_ = 7.2

		local var_31_0 = {
			zh = 6.1,
			ja = 7.2
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play423072008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1083 = arg_31_1.actors_["1083"].transform.localPosition
				arg_31_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("1083", 3)

				for iter_34_0 = 0, arg_31_1.actors_["1083"].transform.childCount - 1 do
					local var_34_0 = arg_31_1.actors_["1083"].transform:GetChild(iter_34_0)

					if var_34_0.name == "" or not string.find(var_34_0.name, "split") then
						var_34_0.gameObject:SetActive(true)
					else
						var_34_0.gameObject:SetActive(false)
					end
				end
			end

			local var_34_1 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_1 then
				arg_31_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_31_1.time_ - 0) / var_34_1)
			end

			if arg_31_1.time_ >= 0 + var_34_1 and arg_31_1.time_ < 0 + var_34_1 + arg_34_0 then
				arg_31_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_34_2 = 0
			local var_34_3 = 0.7

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_2 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_4 = arg_31_1:GetWordFromCfg(423072007)
				local var_34_5 = arg_31_1:FormatText(var_34_4.content)

				arg_31_1.text_.text = var_34_5

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_7 = 28 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_5) / 28)

				if (28 <= 0 and var_34_3 or var_34_3 * (utf8.len(var_34_5) / 28)) > 0 and var_34_3 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_2 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_2
					end
				end

				arg_31_1.text_.text = var_34_5
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423072", "423072007", "story_v_out_423072.awb") ~= 0 then
					local var_34_8 = manager.audio:GetVoiceLength("story_v_out_423072", "423072007", "story_v_out_423072.awb") / 1000

					if var_34_8 + var_34_2 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_2
					end

					if var_34_4.prefab_name ~= "" and arg_31_1.actors_[var_34_4.prefab_name] ~= nil then
						local var_34_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_4.prefab_name].transform, "story_v_out_423072", "423072007", "story_v_out_423072.awb")

						arg_31_1:RecordAudio("423072007", var_34_9)
						arg_31_1:RecordAudio("423072007", var_34_9)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_423072", "423072007", "story_v_out_423072.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_423072", "423072007", "story_v_out_423072.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = math.max(var_34_3, arg_31_1.talkMaxDuration)

			if var_34_2 <= arg_31_1.time_ and arg_31_1.time_ < var_34_2 + var_34_10 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_2) / var_34_10

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_2 + var_34_10 and arg_31_1.time_ < var_34_2 + var_34_10 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play423072008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 423072008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play423072009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1083"]) and arg_35_1.var_.actorSpriteComps1083 == nil then
				arg_35_1.var_.actorSpriteComps1083 = arg_35_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_0 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1083"]) then
				if arg_35_1.var_.actorSpriteComps1083 then
					for iter_38_0, iter_38_1 in pairs(arg_35_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_38_1 then
							if arg_35_1.isInRecall_ then
								iter_38_1.color = Color.New(Mathf.Lerp(iter_38_1.color.r, arg_35_1.hightColor2.r, (arg_35_1.time_ - 0) / var_38_0), Mathf.Lerp(iter_38_1.color.g, arg_35_1.hightColor2.g, (arg_35_1.time_ - 0) / var_38_0), (Mathf.Lerp(iter_38_1.color.b, arg_35_1.hightColor2.b, (arg_35_1.time_ - 0) / var_38_0)))
							else
								local var_38_1 = Mathf.Lerp(iter_38_1.color.r, 0.5, (arg_35_1.time_ - 0) / var_38_0)

								iter_38_1.color = Color.New(var_38_1, var_38_1, var_38_1)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1083"]) and arg_35_1.var_.actorSpriteComps1083 then
				for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_38_3 then
						iter_38_3.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_35_1.var_.actorSpriteComps1083 = nil
			end

			local var_38_2 = 0
			local var_38_3 = 0.375

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_2 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_4 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(423072008).content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_6 = 15 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_4) / 15)

				if (15 <= 0 and var_38_3 or var_38_3 * (utf8.len(var_38_4) / 15)) > 0 and var_38_3 < var_38_6 then
					arg_35_1.talkMaxDuration = var_38_6

					if var_38_6 + var_38_2 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_6 + var_38_2
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_3, arg_35_1.talkMaxDuration)

			if var_38_2 <= arg_35_1.time_ and arg_35_1.time_ < var_38_2 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_2) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_2 + var_38_7 and arg_35_1.time_ < var_38_2 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play423072009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 423072009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play423072010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.575

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(423072009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 23 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 23)

				if (23 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 23)) > 0 and var_42_0 < var_42_3 then
					arg_39_1.talkMaxDuration = var_42_3

					if var_42_3 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_3 + 0
					end
				end

				arg_39_1.text_.text = var_42_1
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_4 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_4

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play423072010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 423072010
		arg_43_1.duration_ = 5.47

		local var_43_0 = {
			zh = 5.466,
			ja = 4.866
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
				arg_43_0:Play423072011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.bgs_.I25f == nil then
				local var_46_0 = Object.Instantiate(arg_43_1.paintGo_)

				var_46_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I25f")
				var_46_0.name = "I25f"
				var_46_0.transform.parent = arg_43_1.stage_.transform
				var_46_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.bgs_.I25f = var_46_0
			end

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= 2 + arg_46_0 then
				local var_46_1 = arg_43_1.bgs_.I25f

				arg_43_1.bgs_.I25f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_46_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_46_2 = var_46_1:GetComponent("SpriteRenderer")

				if var_46_2 and var_46_2.sprite then
					local var_46_3 = 2 * (var_46_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_46_1.transform.localScale = Vector3.New(var_46_3 / var_46_2.sprite.bounds.size.y < var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x and var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x or var_46_3 / var_46_2.sprite.bounds.size.y, var_46_3 / var_46_2.sprite.bounds.size.y < var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x and var_46_3 * manager.ui.mainCameraCom_.aspect / var_46_2.sprite.bounds.size.x or var_46_3 / var_46_2.sprite.bounds.size.y, 0)
				end

				for iter_46_0, iter_46_1 in pairs(arg_43_1.bgs_) do
					if iter_46_0 ~= "I25f" then
						iter_46_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_46_4 = 4

			if 4 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.allBtn_.enabled = false
			end

			if arg_43_1.time_ >= var_46_4 + 0.3 and arg_43_1.time_ < var_46_4 + 0.3 + arg_46_0 then
				arg_43_1.allBtn_.enabled = true
			end

			local var_46_5 = 0

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_6 = 2

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_6 then
				local var_46_7 = Color.New(0, 0, 0)

				var_46_7.a = Mathf.Lerp(0, 1, (arg_43_1.time_ - var_46_5) / var_46_6)
				arg_43_1.mask_.color = var_46_7
			end

			if arg_43_1.time_ >= var_46_5 + var_46_6 and arg_43_1.time_ < var_46_5 + var_46_6 + arg_46_0 then
				local var_46_8 = Color.New(0, 0, 0)

				var_46_8.a = 1
				arg_43_1.mask_.color = var_46_8
			end

			local var_46_9 = 2

			if 2 < arg_43_1.time_ and arg_43_1.time_ <= var_46_9 + arg_46_0 then
				arg_43_1.mask_.enabled = true
				arg_43_1.mask_.raycastTarget = true

				arg_43_1:SetGaussion(false)
			end

			local var_46_10 = 2

			if var_46_9 <= arg_43_1.time_ and arg_43_1.time_ < var_46_9 + var_46_10 then
				local var_46_11 = Color.New(0, 0, 0)

				var_46_11.a = Mathf.Lerp(1, 0, (arg_43_1.time_ - var_46_9) / var_46_10)
				arg_43_1.mask_.color = var_46_11
			end

			if arg_43_1.time_ >= var_46_9 + var_46_10 and arg_43_1.time_ < var_46_9 + var_46_10 + arg_46_0 then
				local var_46_12 = Color.New(0, 0, 0)

				arg_43_1.mask_.enabled = false
				var_46_12.a = 0
				arg_43_1.mask_.color = var_46_12
			end

			local var_46_13 = arg_43_1.actors_["1083"].transform

			if 4 < arg_43_1.time_ and arg_43_1.time_ <= 4 + arg_46_0 then
				arg_43_1.var_.moveOldPos1083 = var_46_13.localPosition
				var_46_13.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1083", 3)

				for iter_46_2 = 0, var_46_13.childCount - 1 do
					local var_46_14 = var_46_13:GetChild(iter_46_2)

					if var_46_14.name == "split_6" or not string.find(var_46_14.name, "split") then
						var_46_14.gameObject:SetActive(true)
					else
						var_46_14.gameObject:SetActive(false)
					end
				end
			end

			local var_46_15 = 0.001

			if 4 <= arg_43_1.time_ and arg_43_1.time_ < 4 + var_46_15 then
				var_46_13.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_43_1.time_ - 4) / var_46_15)
			end

			if arg_43_1.time_ >= 4 + var_46_15 and arg_43_1.time_ < 4 + var_46_15 + arg_46_0 then
				var_46_13.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_46_16 = arg_43_1.actors_["1083"]

			if 4 < arg_43_1.time_ and arg_43_1.time_ <= 4 + arg_46_0 and not isNil(var_46_16) and arg_43_1.var_.actorSpriteComps1083 == nil then
				arg_43_1.var_.actorSpriteComps1083 = var_46_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_17 = 0.2

			if 4 <= arg_43_1.time_ and arg_43_1.time_ < 4 + var_46_17 and not isNil(var_46_16) then
				if arg_43_1.var_.actorSpriteComps1083 then
					for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_46_4 then
							if arg_43_1.isInRecall_ then
								iter_46_4.color = Color.New(Mathf.Lerp(iter_46_4.color.r, arg_43_1.hightColor1.r, (arg_43_1.time_ - 4) / var_46_17), Mathf.Lerp(iter_46_4.color.g, arg_43_1.hightColor1.g, (arg_43_1.time_ - 4) / var_46_17), (Mathf.Lerp(iter_46_4.color.b, arg_43_1.hightColor1.b, (arg_43_1.time_ - 4) / var_46_17)))
							else
								local var_46_18 = Mathf.Lerp(iter_46_4.color.r, 1, (arg_43_1.time_ - 4) / var_46_17)

								iter_46_4.color = Color.New(var_46_18, var_46_18, var_46_18)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 4 + var_46_17 and arg_43_1.time_ < 4 + var_46_17 + arg_46_0 and not isNil(var_46_16) and arg_43_1.var_.actorSpriteComps1083 then
				for iter_46_5, iter_46_6 in pairs(arg_43_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_46_6 then
						iter_46_6.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_43_1.var_.actorSpriteComps1083 = nil
			end

			local var_46_19 = arg_43_1.actors_["1083"].transform

			if 1.966 < arg_43_1.time_ and arg_43_1.time_ <= 1.966 + arg_46_0 then
				arg_43_1.var_.moveOldPos1083 = var_46_19.localPosition
				var_46_19.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1083", 7)

				for iter_46_7 = 0, var_46_19.childCount - 1 do
					local var_46_20 = var_46_19:GetChild(iter_46_7)

					if var_46_20.name == "split_6" or not string.find(var_46_20.name, "split") then
						var_46_20.gameObject:SetActive(true)
					else
						var_46_20.gameObject:SetActive(false)
					end
				end
			end

			local var_46_21 = 0.001

			if 1.966 <= arg_43_1.time_ and arg_43_1.time_ < 1.966 + var_46_21 then
				var_46_19.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_43_1.time_ - 1.966) / var_46_21)
			end

			if arg_43_1.time_ >= 1.966 + var_46_21 and arg_43_1.time_ < 1.966 + var_46_21 + arg_46_0 then
				var_46_19.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.3 < arg_43_1.time_ and arg_43_1.time_ <= 0.3 + arg_46_0 then
				arg_43_1:AudioAction("stop", "effect", "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			if 1.63333333333333 < arg_43_1.time_ and arg_43_1.time_ <= 1.63333333333333 + arg_46_0 then
				arg_43_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_24 = 4
			local var_46_25 = 0.1

			if 4 < arg_43_1.time_ and arg_43_1.time_ <= var_46_24 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_26 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_26:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1341].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_27 = arg_43_1:GetWordFromCfg(423072010)
				local var_46_28 = arg_43_1:FormatText(var_46_27.content)

				arg_43_1.text_.text = var_46_28

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_30 = 4 <= 0 and var_46_25 or var_46_25 * (utf8.len(var_46_28) / 4)

				if (4 <= 0 and var_46_25 or var_46_25 * (utf8.len(var_46_28) / 4)) > 0 and var_46_25 < var_46_30 then
					arg_43_1.talkMaxDuration = var_46_30
					var_46_24 = var_46_24 + 0.3

					if var_46_30 + var_46_24 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_30 + var_46_24
					end
				end

				arg_43_1.text_.text = var_46_28
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423072", "423072010", "story_v_out_423072.awb") ~= 0 then
					local var_46_31 = manager.audio:GetVoiceLength("story_v_out_423072", "423072010", "story_v_out_423072.awb") / 1000

					if var_46_31 + var_46_24 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_31 + var_46_24
					end

					if var_46_27.prefab_name ~= "" and arg_43_1.actors_[var_46_27.prefab_name] ~= nil then
						local var_46_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_27.prefab_name].transform, "story_v_out_423072", "423072010", "story_v_out_423072.awb")

						arg_43_1:RecordAudio("423072010", var_46_32)
						arg_43_1:RecordAudio("423072010", var_46_32)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_423072", "423072010", "story_v_out_423072.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_423072", "423072010", "story_v_out_423072.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_33 = var_46_24 + 0.3
			local var_46_34 = math.max(var_46_25, arg_43_1.talkMaxDuration)

			if var_46_24 + 0.3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_33 + var_46_34 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_33) / var_46_34

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_33 + var_46_34 and arg_43_1.time_ < var_46_33 + var_46_34 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play423072011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 423072011
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play423072012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1083 = arg_49_1.actors_["1083"].transform.localPosition
				arg_49_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1083", 7)

				for iter_52_0 = 0, arg_49_1.actors_["1083"].transform.childCount - 1 do
					local var_52_0 = arg_49_1.actors_["1083"].transform:GetChild(iter_52_0)

					if var_52_0.name == "" or not string.find(var_52_0.name, "split") then
						var_52_0.gameObject:SetActive(true)
					else
						var_52_0.gameObject:SetActive(false)
					end
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["1083"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_52_2 = 0
			local var_52_3 = 1.175

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(423072011).content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 47 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_4) / 47)

				if (47 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_4) / 47)) > 0 and var_52_3 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_7 and arg_49_1.time_ < var_52_2 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play423072012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 423072012
		arg_53_1.duration_ = 3.63

		local var_53_0 = {
			zh = 2.6,
			ja = 3.633
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
				arg_53_0:Play423072013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1083"]) and arg_53_1.var_.actorSpriteComps1083 == nil then
				arg_53_1.var_.actorSpriteComps1083 = arg_53_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1083"]) then
				if arg_53_1.var_.actorSpriteComps1083 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								iter_56_1.color = Color.New(Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_0), Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_0), (Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_0)))
							else
								local var_56_1 = Mathf.Lerp(iter_56_1.color.r, 1, (arg_53_1.time_ - 0) / var_56_0)

								iter_56_1.color = Color.New(var_56_1, var_56_1, var_56_1)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1083"]) and arg_53_1.var_.actorSpriteComps1083 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps1083 = nil
			end

			local var_56_2 = arg_53_1.actors_["1083"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1083 = var_56_2.localPosition
				var_56_2.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1083", 3)

				for iter_56_4 = 0, var_56_2.childCount - 1 do
					local var_56_3 = var_56_2:GetChild(iter_56_4)

					if var_56_3.name == "split_3" or not string.find(var_56_3.name, "split") then
						var_56_3.gameObject:SetActive(true)
					else
						var_56_3.gameObject:SetActive(false)
					end
				end
			end

			local var_56_4 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				var_56_2.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_53_1.time_ - 0) / var_56_4)
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				var_56_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_56_5 = 0
			local var_56_6 = 0.325

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(423072012)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 13 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 13)

				if (13 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 13)) > 0 and var_56_6 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423072", "423072012", "story_v_out_423072.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_out_423072", "423072012", "story_v_out_423072.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_423072", "423072012", "story_v_out_423072.awb")

						arg_53_1:RecordAudio("423072012", var_56_12)
						arg_53_1:RecordAudio("423072012", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_423072", "423072012", "story_v_out_423072.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_423072", "423072012", "story_v_out_423072.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_13 = math.max(var_56_6, arg_53_1.talkMaxDuration)

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_13 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_5) / var_56_13

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_5 + var_56_13 and arg_53_1.time_ < var_56_5 + var_56_13 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play423072013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 423072013
		arg_57_1.duration_ = 3.47

		local var_57_0 = {
			zh = 3.466,
			ja = 2.2
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
			arg_57_1.auto_ = false
		end

		function arg_57_1.playNext_(arg_59_0)
			arg_57_1.onStoryFinished_()
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.225

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(423072013)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 9 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 9)

				if (9 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 9)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423072", "423072013", "story_v_out_423072.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_423072", "423072013", "story_v_out_423072.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_423072", "423072013", "story_v_out_423072.awb")

						arg_57_1:RecordAudio("423072013", var_60_6)
						arg_57_1:RecordAudio("423072013", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_423072", "423072013", "story_v_out_423072.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_423072", "423072013", "story_v_out_423072.awb")
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
	assets = {
		"TextureConfig/Background/I25h",
		"TextureConfig/Background/I25f"
	},
	voices = {
		"story_v_out_423072.awb"
	}
}
