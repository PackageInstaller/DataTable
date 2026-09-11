return {
	Play423102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423102001
		arg_1_1.duration_ = 9.27

		local var_1_0 = {
			zh = 6.332999999999,
			ja = 9.265999999999
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
				arg_1_0:Play423102002(arg_1_1)
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

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street")

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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 1.999999999999
			local var_4_17 = 0.425

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:GetWordFromCfg(423102001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 17 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 17)

				if (17 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 17)) > 0 and var_4_17 < var_4_22 then
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

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102001", "story_v_out_423102.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_out_423102", "423102001", "story_v_out_423102.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_out_423102", "423102001", "story_v_out_423102.awb")

						arg_1_1:RecordAudio("423102001", var_4_24)
						arg_1_1:RecordAudio("423102001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423102", "423102001", "story_v_out_423102.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423102", "423102001", "story_v_out_423102.awb")
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
	Play423102002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423102002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play423102003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0.266666666666667 < arg_9_1.time_ and arg_9_1.time_ <= 0.266666666666667 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_144", "se_story_144_drop", "")
			end

			local var_12_1 = 0
			local var_12_2 = 1.7

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(423102002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 68 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 68)

				if (68 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 68)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play423102003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423102003
		arg_13_1.duration_ = 2.2

		local var_13_0 = {
			zh = 2.2,
			ja = 1.733
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
				arg_13_0:Play423102004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.175

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1348].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(423102003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 7 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 7)

				if (7 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 7)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102003", "story_v_out_423102.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_423102", "423102003", "story_v_out_423102.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_423102", "423102003", "story_v_out_423102.awb")

						arg_13_1:RecordAudio("423102003", var_16_6)
						arg_13_1:RecordAudio("423102003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_423102", "423102003", "story_v_out_423102.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_423102", "423102003", "story_v_out_423102.awb")
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
	Play423102004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 423102004
		arg_17_1.duration_ = 6.23

		local var_17_0 = {
			zh = 4.033,
			ja = 6.233
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
				arg_17_0:Play423102005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1083"] == nil then
				local var_20_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_20_0) then
					local var_20_1 = Object.Instantiate(var_20_0, arg_17_1.canvasGo_.transform)

					var_20_1.transform:SetSiblingIndex(1)

					var_20_1.name = "1083"
					var_20_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_["1083"] = var_20_1

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs((var_20_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_2 = arg_17_1.actors_["1083"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps1083 == nil then
				arg_17_1.var_.actorSpriteComps1083 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps1083 then
					for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_20_3 then
							if arg_17_1.isInRecall_ then
								iter_20_3.color = Color.New(Mathf.Lerp(iter_20_3.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_3), Mathf.Lerp(iter_20_3.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_3), (Mathf.Lerp(iter_20_3.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_3)))
							else
								local var_20_4 = Mathf.Lerp(iter_20_3.color.r, 1, (arg_17_1.time_ - 0) / var_20_3)

								iter_20_3.color = Color.New(var_20_4, var_20_4, var_20_4)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps1083 then
				for iter_20_4, iter_20_5 in pairs(arg_17_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_20_5 then
						iter_20_5.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps1083 = nil
			end

			local var_20_5 = arg_17_1.actors_["1083"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1083 = var_20_5.localPosition
				var_20_5.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1083", 3)

				for iter_20_6 = 0, var_20_5.childCount - 1 do
					local var_20_6 = var_20_5:GetChild(iter_20_6)

					if var_20_6.name == "split_7" or not string.find(var_20_6.name, "split") then
						var_20_6.gameObject:SetActive(true)
					else
						var_20_6.gameObject:SetActive(false)
					end
				end
			end

			local var_20_7 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_7 then
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_17_1.time_ - 0) / var_20_7)
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				local var_20_8 = arg_17_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_20_8 then
					arg_17_1.var_.alphaOldValue1083 = var_20_8.alpha
					arg_17_1.var_.characterEffect1083 = var_20_8
				end

				arg_17_1.var_.alphaOldValue1083 = 0
			end

			local var_20_9 = 0.5

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_9 then
				if arg_17_1.var_.characterEffect1083 then
					arg_17_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_17_1.var_.alphaOldValue1083, 1, (arg_17_1.time_ - 0) / var_20_9)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_9 and arg_17_1.time_ < 0 + var_20_9 + arg_20_0 and arg_17_1.var_.characterEffect1083 then
				arg_17_1.var_.characterEffect1083.alpha = 1
			end

			local var_20_10 = 0
			local var_20_11 = 0.525

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_12 = arg_17_1:GetWordFromCfg(423102004)
				local var_20_13 = arg_17_1:FormatText(var_20_12.content)

				arg_17_1.text_.text = var_20_13

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_15 = 21 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 21)

				if (21 <= 0 and var_20_11 or var_20_11 * (utf8.len(var_20_13) / 21)) > 0 and var_20_11 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_13
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102004", "story_v_out_423102.awb") ~= 0 then
					local var_20_16 = manager.audio:GetVoiceLength("story_v_out_423102", "423102004", "story_v_out_423102.awb") / 1000

					if var_20_16 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_16 + var_20_10
					end

					if var_20_12.prefab_name ~= "" and arg_17_1.actors_[var_20_12.prefab_name] ~= nil then
						local var_20_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_12.prefab_name].transform, "story_v_out_423102", "423102004", "story_v_out_423102.awb")

						arg_17_1:RecordAudio("423102004", var_20_17)
						arg_17_1:RecordAudio("423102004", var_20_17)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_423102", "423102004", "story_v_out_423102.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_423102", "423102004", "story_v_out_423102.awb")
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
				actorName = "1083",
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
	Play423102005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 423102005
		arg_21_1.duration_ = 6.1

		local var_21_0 = {
			zh = 6.1,
			ja = 6.066
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
				arg_21_0:Play423102006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1083"]) and arg_21_1.var_.actorSpriteComps1083 == nil then
				arg_21_1.var_.actorSpriteComps1083 = arg_21_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1083"]) then
				if arg_21_1.var_.actorSpriteComps1083 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								iter_24_1.color = Color.New(Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_0), Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_0), (Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_0)))
							else
								local var_24_1 = Mathf.Lerp(iter_24_1.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_0)

								iter_24_1.color = Color.New(var_24_1, var_24_1, var_24_1)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1083"]) and arg_21_1.var_.actorSpriteComps1083 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps1083 = nil
			end

			local var_24_2 = 0
			local var_24_3 = 0.425

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_4 = arg_21_1:GetWordFromCfg(423102005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 17 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 17)

				if (17 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 17)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102005", "story_v_out_423102.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_423102", "423102005", "story_v_out_423102.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_423102", "423102005", "story_v_out_423102.awb")

						arg_21_1:RecordAudio("423102005", var_24_9)
						arg_21_1:RecordAudio("423102005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_423102", "423102005", "story_v_out_423102.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_423102", "423102005", "story_v_out_423102.awb")
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
	Play423102006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 423102006
		arg_25_1.duration_ = 12.93

		local var_25_0 = {
			zh = 8.8,
			ja = 12.933
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
				arg_25_0:Play423102007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 1.025

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(423102006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 41 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 41)

				if (41 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 41)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102006", "story_v_out_423102.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_423102", "423102006", "story_v_out_423102.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_423102", "423102006", "story_v_out_423102.awb")

						arg_25_1:RecordAudio("423102006", var_28_6)
						arg_25_1:RecordAudio("423102006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_423102", "423102006", "story_v_out_423102.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_423102", "423102006", "story_v_out_423102.awb")
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
	Play423102007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 423102007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play423102008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1083 = arg_29_1.actors_["1083"].transform.localPosition
				arg_29_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1083", 7)

				for iter_32_0 = 0, arg_29_1.actors_["1083"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["1083"].transform:GetChild(iter_32_0)

					if var_32_0.name == "" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["1083"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_2 = 0
			local var_32_3 = 1.475

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(423102007).content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_6 = 59 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_4) / 59)

				if (59 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_4) / 59)) > 0 and var_32_3 < var_32_6 then
					arg_29_1.talkMaxDuration = var_32_6

					if var_32_6 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_6 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_7 and arg_29_1.time_ < var_32_2 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play423102008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 423102008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play423102009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.55

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(423102008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 62 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 62)

				if (62 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 62)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play423102009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423102009
		arg_37_1.duration_ = 12.9

		local var_37_0 = {
			zh = 12.9,
			ja = 11.733
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
				arg_37_0:Play423102010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1083"]) and arg_37_1.var_.actorSpriteComps1083 == nil then
				arg_37_1.var_.actorSpriteComps1083 = arg_37_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1083"]) then
				if arg_37_1.var_.actorSpriteComps1083 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								iter_40_1.color = Color.New(Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_0), Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_0), (Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_0)))
							else
								local var_40_1 = Mathf.Lerp(iter_40_1.color.r, 1, (arg_37_1.time_ - 0) / var_40_0)

								iter_40_1.color = Color.New(var_40_1, var_40_1, var_40_1)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1083"]) and arg_37_1.var_.actorSpriteComps1083 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps1083 = nil
			end

			local var_40_2 = arg_37_1.actors_["1083"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1083 = var_40_2.localPosition
				var_40_2.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1083", 3)

				for iter_40_4 = 0, var_40_2.childCount - 1 do
					local var_40_3 = var_40_2:GetChild(iter_40_4)

					if var_40_3.name == "split_1" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_2.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_37_1.time_ - 0) / var_40_4)
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_40_5 = 0
			local var_40_6 = 1.425

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(423102009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 57 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 57)

				if (57 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 57)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102009", "story_v_out_423102.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_423102", "423102009", "story_v_out_423102.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_423102", "423102009", "story_v_out_423102.awb")

						arg_37_1:RecordAudio("423102009", var_40_12)
						arg_37_1:RecordAudio("423102009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_423102", "423102009", "story_v_out_423102.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_423102", "423102009", "story_v_out_423102.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_13 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_5) / var_40_13

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_5 + var_40_13 and arg_37_1.time_ < var_40_5 + var_40_13 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play423102010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 423102010
		arg_41_1.duration_ = 7.5

		local var_41_0 = {
			zh = 5.566,
			ja = 7.5
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
				arg_41_0:Play423102011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1083 = arg_41_1.actors_["1083"].transform.localPosition
				arg_41_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1083", 3)

				for iter_44_0 = 0, arg_41_1.actors_["1083"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["1083"].transform:GetChild(iter_44_0)

					if var_44_0.name == "" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_44_2 = 0
			local var_44_3 = 0.7

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(423102010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 28 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 28)

				if (28 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 28)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102010", "story_v_out_423102.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_423102", "423102010", "story_v_out_423102.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_423102", "423102010", "story_v_out_423102.awb")

						arg_41_1:RecordAudio("423102010", var_44_9)
						arg_41_1:RecordAudio("423102010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_423102", "423102010", "story_v_out_423102.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_423102", "423102010", "story_v_out_423102.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
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

		arg_41_1:InitPlayNodeList()
	end,
	Play423102011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 423102011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play423102012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1083"]) and arg_45_1.var_.actorSpriteComps1083 == nil then
				arg_45_1.var_.actorSpriteComps1083 = arg_45_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1083"]) then
				if arg_45_1.var_.actorSpriteComps1083 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								iter_48_1.color = Color.New(Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_0), Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_0), (Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_0)))
							else
								local var_48_1 = Mathf.Lerp(iter_48_1.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_0)

								iter_48_1.color = Color.New(var_48_1, var_48_1, var_48_1)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1083"]) and arg_45_1.var_.actorSpriteComps1083 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps1083 = nil
			end

			local var_48_2 = arg_45_1.actors_["1083"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1083 = var_48_2.localPosition
				var_48_2.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1083", 7)

				for iter_48_4 = 0, var_48_2.childCount - 1 do
					local var_48_3 = var_48_2:GetChild(iter_48_4)

					if var_48_3.name == "" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				var_48_2.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_45_1.time_ - 0) / var_48_4)
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				var_48_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_5 = 0
			local var_48_6 = 1.65

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(423102011).content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 66 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_7) / 66)

				if (66 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_7) / 66)) > 0 and var_48_6 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_10 and arg_45_1.time_ < var_48_5 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play423102012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 423102012
		arg_49_1.duration_ = 7.6

		local var_49_0 = {
			zh = 6.333,
			ja = 7.6
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
				arg_49_0:Play423102013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.65

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(423102012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 26 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 26)

				if (26 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 26)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102012", "story_v_out_423102.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_423102", "423102012", "story_v_out_423102.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_423102", "423102012", "story_v_out_423102.awb")

						arg_49_1:RecordAudio("423102012", var_52_6)
						arg_49_1:RecordAudio("423102012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_423102", "423102012", "story_v_out_423102.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_423102", "423102012", "story_v_out_423102.awb")
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
	Play423102013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 423102013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play423102014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.725

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(423102013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 29 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 29)

				if (29 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 29)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play423102014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 423102014
		arg_57_1.duration_ = 14.8

		local var_57_0 = {
			zh = 7.233,
			ja = 14.8
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
				arg_57_0:Play423102015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.675

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(423102014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 27 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 27)

				if (27 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 27)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102014", "story_v_out_423102.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_423102", "423102014", "story_v_out_423102.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_423102", "423102014", "story_v_out_423102.awb")

						arg_57_1:RecordAudio("423102014", var_60_6)
						arg_57_1:RecordAudio("423102014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_423102", "423102014", "story_v_out_423102.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_423102", "423102014", "story_v_out_423102.awb")
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
	Play423102015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 423102015
		arg_61_1.duration_ = 7.37

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play423102016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 2.6 < arg_61_1.time_ and arg_61_1.time_ <= 2.6 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_clap", "")
			end

			local var_64_1 = 0

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_2 = 1.5

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = Color.New(0, 0, 0)

				var_64_3.a = Mathf.Lerp(0, 1, (arg_61_1.time_ - var_64_1) / var_64_2)
				arg_61_1.mask_.color = var_64_3
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				local var_64_4 = Color.New(0, 0, 0)

				var_64_4.a = 1
				arg_61_1.mask_.color = var_64_4
			end

			local var_64_5 = 1.5

			if 1.5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = false

				arg_61_1:SetGaussion(false)
			end

			local var_64_6 = 1.5

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_6 then
				local var_64_7 = Color.New(0, 0, 0)

				var_64_7.a = Mathf.Lerp(1, 0, (arg_61_1.time_ - var_64_5) / var_64_6)
				arg_61_1.mask_.color = var_64_7
			end

			if arg_61_1.time_ >= var_64_5 + var_64_6 and arg_61_1.time_ < var_64_5 + var_64_6 + arg_64_0 then
				local var_64_8 = Color.New(0, 0, 0)

				arg_61_1.mask_.enabled = false
				var_64_8.a = 0
				arg_61_1.mask_.color = var_64_8
			end

			if arg_61_1.frameCnt_ <= 1 then
				arg_61_1.dialog_:SetActive(false)
			end

			local var_64_9 = 2.36666666666667
			local var_64_10 = 1.5

			if 2.36666666666667 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0

				arg_61_1.dialog_:SetActive(true)

				arg_61_1.dialogCg_.alpha = 0

				local var_64_11 = LeanTween.value(arg_61_1.dialog_, 0, 1, 0.3)

				var_64_11:setOnUpdate(LuaHelper.FloatAction(function(arg_65_0)
					arg_61_1.dialogCg_.alpha = arg_65_0
				end))
				var_64_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_61_1.dialog_)
					var_64_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_61_1.duration_ = arg_61_1.duration_ + 0.3

				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_12 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(423102015).content)

				arg_61_1.text_.text = var_64_12

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_14 = 60 <= 0 and var_64_10 or var_64_10 * (utf8.len(var_64_12) / 60)

				if (60 <= 0 and var_64_10 or var_64_10 * (utf8.len(var_64_12) / 60)) > 0 and var_64_10 < var_64_14 then
					arg_61_1.talkMaxDuration = var_64_14
					var_64_9 = var_64_9 + 0.3

					if var_64_14 + var_64_9 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_9
					end
				end

				arg_61_1.text_.text = var_64_12
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_15 = var_64_9 + 0.3
			local var_64_16 = math.max(var_64_10, arg_61_1.talkMaxDuration)

			if var_64_9 + 0.3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_15) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_15 + var_64_16 and arg_61_1.time_ < var_64_15 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play423102016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 423102016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play423102017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.4

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(423102016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 16 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 16)

				if (16 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 16)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play423102017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 423102017
		arg_71_1.duration_ = 14.63

		local var_71_0 = {
			zh = 10.733,
			ja = 14.633
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
				arg_71_0:Play423102018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1083"]) and arg_71_1.var_.actorSpriteComps1083 == nil then
				arg_71_1.var_.actorSpriteComps1083 = arg_71_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_0 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1083"]) then
				if arg_71_1.var_.actorSpriteComps1083 then
					for iter_74_0, iter_74_1 in pairs(arg_71_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_74_1 then
							if arg_71_1.isInRecall_ then
								iter_74_1.color = Color.New(Mathf.Lerp(iter_74_1.color.r, arg_71_1.hightColor1.r, (arg_71_1.time_ - 0) / var_74_0), Mathf.Lerp(iter_74_1.color.g, arg_71_1.hightColor1.g, (arg_71_1.time_ - 0) / var_74_0), (Mathf.Lerp(iter_74_1.color.b, arg_71_1.hightColor1.b, (arg_71_1.time_ - 0) / var_74_0)))
							else
								local var_74_1 = Mathf.Lerp(iter_74_1.color.r, 1, (arg_71_1.time_ - 0) / var_74_0)

								iter_74_1.color = Color.New(var_74_1, var_74_1, var_74_1)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1083"]) and arg_71_1.var_.actorSpriteComps1083 then
				for iter_74_2, iter_74_3 in pairs(arg_71_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_74_3 then
						iter_74_3.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_71_1.var_.actorSpriteComps1083 = nil
			end

			local var_74_2 = arg_71_1.actors_["1083"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1083 = var_74_2.localPosition
				var_74_2.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("1083", 3)

				for iter_74_4 = 0, var_74_2.childCount - 1 do
					local var_74_3 = var_74_2:GetChild(iter_74_4)

					if var_74_3.name == "" or not string.find(var_74_3.name, "split") then
						var_74_3.gameObject:SetActive(true)
					else
						var_74_3.gameObject:SetActive(false)
					end
				end
			end

			local var_74_4 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				var_74_2.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_71_1.time_ - 0) / var_74_4)
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				var_74_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_74_5 = 0
			local var_74_6 = 1.3

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_5 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_7 = arg_71_1:GetWordFromCfg(423102017)
				local var_74_8 = arg_71_1:FormatText(var_74_7.content)

				arg_71_1.text_.text = var_74_8

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_10 = 52 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_8) / 52)

				if (52 <= 0 and var_74_6 or var_74_6 * (utf8.len(var_74_8) / 52)) > 0 and var_74_6 < var_74_10 then
					arg_71_1.talkMaxDuration = var_74_10

					if var_74_10 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_5
					end
				end

				arg_71_1.text_.text = var_74_8
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102017", "story_v_out_423102.awb") ~= 0 then
					local var_74_11 = manager.audio:GetVoiceLength("story_v_out_423102", "423102017", "story_v_out_423102.awb") / 1000

					if var_74_11 + var_74_5 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_5
					end

					if var_74_7.prefab_name ~= "" and arg_71_1.actors_[var_74_7.prefab_name] ~= nil then
						local var_74_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_7.prefab_name].transform, "story_v_out_423102", "423102017", "story_v_out_423102.awb")

						arg_71_1:RecordAudio("423102017", var_74_12)
						arg_71_1:RecordAudio("423102017", var_74_12)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_423102", "423102017", "story_v_out_423102.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_423102", "423102017", "story_v_out_423102.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_13 = math.max(var_74_6, arg_71_1.talkMaxDuration)

			if var_74_5 <= arg_71_1.time_ and arg_71_1.time_ < var_74_5 + var_74_13 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_5) / var_74_13

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_5 + var_74_13 and arg_71_1.time_ < var_74_5 + var_74_13 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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

		arg_71_1:InitPlayNodeList()
	end,
	Play423102018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 423102018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play423102019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1083"]) and arg_75_1.var_.actorSpriteComps1083 == nil then
				arg_75_1.var_.actorSpriteComps1083 = arg_75_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_0 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1083"]) then
				if arg_75_1.var_.actorSpriteComps1083 then
					for iter_78_0, iter_78_1 in pairs(arg_75_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_78_1 then
							if arg_75_1.isInRecall_ then
								iter_78_1.color = Color.New(Mathf.Lerp(iter_78_1.color.r, arg_75_1.hightColor2.r, (arg_75_1.time_ - 0) / var_78_0), Mathf.Lerp(iter_78_1.color.g, arg_75_1.hightColor2.g, (arg_75_1.time_ - 0) / var_78_0), (Mathf.Lerp(iter_78_1.color.b, arg_75_1.hightColor2.b, (arg_75_1.time_ - 0) / var_78_0)))
							else
								local var_78_1 = Mathf.Lerp(iter_78_1.color.r, 0.5, (arg_75_1.time_ - 0) / var_78_0)

								iter_78_1.color = Color.New(var_78_1, var_78_1, var_78_1)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1083"]) and arg_75_1.var_.actorSpriteComps1083 then
				for iter_78_2, iter_78_3 in pairs(arg_75_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_78_3 then
						iter_78_3.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_75_1.var_.actorSpriteComps1083 = nil
			end

			local var_78_2 = 0
			local var_78_3 = 0.475

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_4 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(423102018).content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_6 = 19 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_4) / 19)

				if (19 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_4) / 19)) > 0 and var_78_3 < var_78_6 then
					arg_75_1.talkMaxDuration = var_78_6

					if var_78_6 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_2
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_3, arg_75_1.talkMaxDuration)

			if var_78_2 <= arg_75_1.time_ and arg_75_1.time_ < var_78_2 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_2) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_2 + var_78_7 and arg_75_1.time_ < var_78_2 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play423102019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 423102019
		arg_79_1.duration_ = 7.33

		local var_79_0 = {
			zh = 7.066,
			ja = 7.333
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
				arg_79_0:Play423102020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1083"]) and arg_79_1.var_.actorSpriteComps1083 == nil then
				arg_79_1.var_.actorSpriteComps1083 = arg_79_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1083"]) then
				if arg_79_1.var_.actorSpriteComps1083 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								iter_82_1.color = Color.New(Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor1.r, (arg_79_1.time_ - 0) / var_82_0), Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor1.g, (arg_79_1.time_ - 0) / var_82_0), (Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor1.b, (arg_79_1.time_ - 0) / var_82_0)))
							else
								local var_82_1 = Mathf.Lerp(iter_82_1.color.r, 1, (arg_79_1.time_ - 0) / var_82_0)

								iter_82_1.color = Color.New(var_82_1, var_82_1, var_82_1)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1083"]) and arg_79_1.var_.actorSpriteComps1083 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_82_3 then
						iter_82_3.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_79_1.var_.actorSpriteComps1083 = nil
			end

			local var_82_2 = arg_79_1.actors_["1083"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1083 = var_82_2.localPosition
				var_82_2.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("1083", 3)

				for iter_82_4 = 0, var_82_2.childCount - 1 do
					local var_82_3 = var_82_2:GetChild(iter_82_4)

					if var_82_3.name == "" or not string.find(var_82_3.name, "split") then
						var_82_3.gameObject:SetActive(true)
					else
						var_82_3.gameObject:SetActive(false)
					end
				end
			end

			local var_82_4 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				var_82_2.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_79_1.time_ - 0) / var_82_4)
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				var_82_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_82_5 = 0
			local var_82_6 = 0.575

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_7 = arg_79_1:GetWordFromCfg(423102019)
				local var_82_8 = arg_79_1:FormatText(var_82_7.content)

				arg_79_1.text_.text = var_82_8

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_10 = 23 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_8) / 23)

				if (23 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_8) / 23)) > 0 and var_82_6 < var_82_10 then
					arg_79_1.talkMaxDuration = var_82_10

					if var_82_10 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_5
					end
				end

				arg_79_1.text_.text = var_82_8
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102019", "story_v_out_423102.awb") ~= 0 then
					local var_82_11 = manager.audio:GetVoiceLength("story_v_out_423102", "423102019", "story_v_out_423102.awb") / 1000

					if var_82_11 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_11 + var_82_5
					end

					if var_82_7.prefab_name ~= "" and arg_79_1.actors_[var_82_7.prefab_name] ~= nil then
						local var_82_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_7.prefab_name].transform, "story_v_out_423102", "423102019", "story_v_out_423102.awb")

						arg_79_1:RecordAudio("423102019", var_82_12)
						arg_79_1:RecordAudio("423102019", var_82_12)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_423102", "423102019", "story_v_out_423102.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_423102", "423102019", "story_v_out_423102.awb")
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

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play423102020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 423102020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play423102021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1083"]) and arg_83_1.var_.actorSpriteComps1083 == nil then
				arg_83_1.var_.actorSpriteComps1083 = arg_83_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1083"]) then
				if arg_83_1.var_.actorSpriteComps1083 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_86_1 then
							if arg_83_1.isInRecall_ then
								iter_86_1.color = Color.New(Mathf.Lerp(iter_86_1.color.r, arg_83_1.hightColor2.r, (arg_83_1.time_ - 0) / var_86_0), Mathf.Lerp(iter_86_1.color.g, arg_83_1.hightColor2.g, (arg_83_1.time_ - 0) / var_86_0), (Mathf.Lerp(iter_86_1.color.b, arg_83_1.hightColor2.b, (arg_83_1.time_ - 0) / var_86_0)))
							else
								local var_86_1 = Mathf.Lerp(iter_86_1.color.r, 0.5, (arg_83_1.time_ - 0) / var_86_0)

								iter_86_1.color = Color.New(var_86_1, var_86_1, var_86_1)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1083"]) and arg_83_1.var_.actorSpriteComps1083 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_86_3 then
						iter_86_3.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_83_1.var_.actorSpriteComps1083 = nil
			end

			local var_86_2 = 0
			local var_86_3 = 1.25

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_4 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(423102020).content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 50 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_4) / 50)

				if (50 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_4) / 50)) > 0 and var_86_3 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_2
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_3, arg_83_1.talkMaxDuration)

			if var_86_2 <= arg_83_1.time_ and arg_83_1.time_ < var_86_2 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_2) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_2 + var_86_7 and arg_83_1.time_ < var_86_2 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play423102021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 423102021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play423102022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.775

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_1 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(423102021).content)

				arg_87_1.text_.text = var_90_1

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_3 = 31 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 31)

				if (31 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_1) / 31)) > 0 and var_90_0 < var_90_3 then
					arg_87_1.talkMaxDuration = var_90_3

					if var_90_3 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_3 + 0
					end
				end

				arg_87_1.text_.text = var_90_1
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_4 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_4 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_4

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_4 and arg_87_1.time_ < 0 + var_90_4 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play423102022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 423102022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play423102023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 1.125

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(423102022).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 45 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 45)

				if (45 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 45)) > 0 and var_94_0 < var_94_3 then
					arg_91_1.talkMaxDuration = var_94_3

					if var_94_3 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_3 + 0
					end
				end

				arg_91_1.text_.text = var_94_1
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_4 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_4

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play423102023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 423102023
		arg_95_1.duration_ = 9.73

		local var_95_0 = {
			zh = 6.666,
			ja = 9.733
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
				arg_95_0:Play423102024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1083"]) and arg_95_1.var_.actorSpriteComps1083 == nil then
				arg_95_1.var_.actorSpriteComps1083 = arg_95_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_0 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1083"]) then
				if arg_95_1.var_.actorSpriteComps1083 then
					for iter_98_0, iter_98_1 in pairs(arg_95_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_98_1 then
							if arg_95_1.isInRecall_ then
								iter_98_1.color = Color.New(Mathf.Lerp(iter_98_1.color.r, arg_95_1.hightColor1.r, (arg_95_1.time_ - 0) / var_98_0), Mathf.Lerp(iter_98_1.color.g, arg_95_1.hightColor1.g, (arg_95_1.time_ - 0) / var_98_0), (Mathf.Lerp(iter_98_1.color.b, arg_95_1.hightColor1.b, (arg_95_1.time_ - 0) / var_98_0)))
							else
								local var_98_1 = Mathf.Lerp(iter_98_1.color.r, 1, (arg_95_1.time_ - 0) / var_98_0)

								iter_98_1.color = Color.New(var_98_1, var_98_1, var_98_1)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1083"]) and arg_95_1.var_.actorSpriteComps1083 then
				for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_98_3 then
						iter_98_3.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_95_1.var_.actorSpriteComps1083 = nil
			end

			local var_98_2 = arg_95_1.actors_["1083"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1083 = var_98_2.localPosition
				var_98_2.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1083", 3)

				for iter_98_4 = 0, var_98_2.childCount - 1 do
					local var_98_3 = var_98_2:GetChild(iter_98_4)

					if var_98_3.name == "split_4" or not string.find(var_98_3.name, "split") then
						var_98_3.gameObject:SetActive(true)
					else
						var_98_3.gameObject:SetActive(false)
					end
				end
			end

			local var_98_4 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				var_98_2.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_95_1.time_ - 0) / var_98_4)
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				var_98_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_98_5 = 0
			local var_98_6 = 0.725

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_7 = arg_95_1:GetWordFromCfg(423102023)
				local var_98_8 = arg_95_1:FormatText(var_98_7.content)

				arg_95_1.text_.text = var_98_8

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_10 = 29 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_8) / 29)

				if (29 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_8) / 29)) > 0 and var_98_6 < var_98_10 then
					arg_95_1.talkMaxDuration = var_98_10

					if var_98_10 + var_98_5 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_5
					end
				end

				arg_95_1.text_.text = var_98_8
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102023", "story_v_out_423102.awb") ~= 0 then
					local var_98_11 = manager.audio:GetVoiceLength("story_v_out_423102", "423102023", "story_v_out_423102.awb") / 1000

					if var_98_11 + var_98_5 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_11 + var_98_5
					end

					if var_98_7.prefab_name ~= "" and arg_95_1.actors_[var_98_7.prefab_name] ~= nil then
						local var_98_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_7.prefab_name].transform, "story_v_out_423102", "423102023", "story_v_out_423102.awb")

						arg_95_1:RecordAudio("423102023", var_98_12)
						arg_95_1:RecordAudio("423102023", var_98_12)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_423102", "423102023", "story_v_out_423102.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_423102", "423102023", "story_v_out_423102.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_13 = math.max(var_98_6, arg_95_1.talkMaxDuration)

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_13 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_5) / var_98_13

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_5 + var_98_13 and arg_95_1.time_ < var_98_5 + var_98_13 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play423102024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 423102024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play423102025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(arg_99_1.actors_["1083"]) and arg_99_1.var_.actorSpriteComps1083 == nil then
				arg_99_1.var_.actorSpriteComps1083 = arg_99_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_0 = 0.2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 and not isNil(arg_99_1.actors_["1083"]) then
				if arg_99_1.var_.actorSpriteComps1083 then
					for iter_102_0, iter_102_1 in pairs(arg_99_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_102_1 then
							if arg_99_1.isInRecall_ then
								iter_102_1.color = Color.New(Mathf.Lerp(iter_102_1.color.r, arg_99_1.hightColor2.r, (arg_99_1.time_ - 0) / var_102_0), Mathf.Lerp(iter_102_1.color.g, arg_99_1.hightColor2.g, (arg_99_1.time_ - 0) / var_102_0), (Mathf.Lerp(iter_102_1.color.b, arg_99_1.hightColor2.b, (arg_99_1.time_ - 0) / var_102_0)))
							else
								local var_102_1 = Mathf.Lerp(iter_102_1.color.r, 0.5, (arg_99_1.time_ - 0) / var_102_0)

								iter_102_1.color = Color.New(var_102_1, var_102_1, var_102_1)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 and not isNil(arg_99_1.actors_["1083"]) and arg_99_1.var_.actorSpriteComps1083 then
				for iter_102_2, iter_102_3 in pairs(arg_99_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_102_3 then
						iter_102_3.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_99_1.var_.actorSpriteComps1083 = nil
			end

			local var_102_2 = 0
			local var_102_3 = 0.5

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_2 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_4 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(423102024).content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_6 = 20 <= 0 and var_102_3 or var_102_3 * (utf8.len(var_102_4) / 20)

				if (20 <= 0 and var_102_3 or var_102_3 * (utf8.len(var_102_4) / 20)) > 0 and var_102_3 < var_102_6 then
					arg_99_1.talkMaxDuration = var_102_6

					if var_102_6 + var_102_2 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_6 + var_102_2
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_3, arg_99_1.talkMaxDuration)

			if var_102_2 <= arg_99_1.time_ and arg_99_1.time_ < var_102_2 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_2) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_2 + var_102_7 and arg_99_1.time_ < var_102_2 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play423102025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 423102025
		arg_103_1.duration_ = 8.3

		local var_103_0 = {
			zh = 7.933,
			ja = 8.3
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
				arg_103_0:Play423102026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1083"]) and arg_103_1.var_.actorSpriteComps1083 == nil then
				arg_103_1.var_.actorSpriteComps1083 = arg_103_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_0 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1083"]) then
				if arg_103_1.var_.actorSpriteComps1083 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								iter_106_1.color = Color.New(Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor1.r, (arg_103_1.time_ - 0) / var_106_0), Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor1.g, (arg_103_1.time_ - 0) / var_106_0), (Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor1.b, (arg_103_1.time_ - 0) / var_106_0)))
							else
								local var_106_1 = Mathf.Lerp(iter_106_1.color.r, 1, (arg_103_1.time_ - 0) / var_106_0)

								iter_106_1.color = Color.New(var_106_1, var_106_1, var_106_1)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1083"]) and arg_103_1.var_.actorSpriteComps1083 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_106_3 then
						iter_106_3.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps1083 = nil
			end

			local var_106_2 = arg_103_1.actors_["1083"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1083 = var_106_2.localPosition
				var_106_2.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("1083", 3)

				for iter_106_4 = 0, var_106_2.childCount - 1 do
					local var_106_3 = var_106_2:GetChild(iter_106_4)

					if var_106_3.name == "" or not string.find(var_106_3.name, "split") then
						var_106_3.gameObject:SetActive(true)
					else
						var_106_3.gameObject:SetActive(false)
					end
				end
			end

			local var_106_4 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				var_106_2.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_103_1.time_ - 0) / var_106_4)
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				var_106_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_106_5 = 0
			local var_106_6 = 0.775

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:GetWordFromCfg(423102025)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 31 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 31)

				if (31 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 31)) > 0 and var_106_6 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102025", "story_v_out_423102.awb") ~= 0 then
					local var_106_11 = manager.audio:GetVoiceLength("story_v_out_423102", "423102025", "story_v_out_423102.awb") / 1000

					if var_106_11 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_5
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_out_423102", "423102025", "story_v_out_423102.awb")

						arg_103_1:RecordAudio("423102025", var_106_12)
						arg_103_1:RecordAudio("423102025", var_106_12)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_423102", "423102025", "story_v_out_423102.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_423102", "423102025", "story_v_out_423102.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_13 = math.max(var_106_6, arg_103_1.talkMaxDuration)

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_13 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_5) / var_106_13

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_5 + var_106_13 and arg_103_1.time_ < var_106_5 + var_106_13 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
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

		arg_103_1:InitPlayNodeList()
	end,
	Play423102026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 423102026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play423102027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1083"]) and arg_107_1.var_.actorSpriteComps1083 == nil then
				arg_107_1.var_.actorSpriteComps1083 = arg_107_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1083"]) then
				if arg_107_1.var_.actorSpriteComps1083 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								iter_110_1.color = Color.New(Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor2.r, (arg_107_1.time_ - 0) / var_110_0), Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor2.g, (arg_107_1.time_ - 0) / var_110_0), (Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor2.b, (arg_107_1.time_ - 0) / var_110_0)))
							else
								local var_110_1 = Mathf.Lerp(iter_110_1.color.r, 0.5, (arg_107_1.time_ - 0) / var_110_0)

								iter_110_1.color = Color.New(var_110_1, var_110_1, var_110_1)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1083"]) and arg_107_1.var_.actorSpriteComps1083 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps1083 = nil
			end

			local var_110_2 = 0
			local var_110_3 = 0.75

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_2 + arg_110_0 then
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

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_4 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(423102026).content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_6 = 30 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 30)

				if (30 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 30)) > 0 and var_110_3 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_2
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_3, arg_107_1.talkMaxDuration)

			if var_110_2 <= arg_107_1.time_ and arg_107_1.time_ < var_110_2 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_2) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_2 + var_110_7 and arg_107_1.time_ < var_110_2 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play423102027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 423102027
		arg_111_1.duration_ = 7.57

		local var_111_0 = {
			zh = 5,
			ja = 7.566
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
				arg_111_0:Play423102028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.6

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_1 = arg_111_1:GetWordFromCfg(423102027)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 24 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 24)

				if (24 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 24)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102027", "story_v_out_423102.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_423102", "423102027", "story_v_out_423102.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_423102", "423102027", "story_v_out_423102.awb")

						arg_111_1:RecordAudio("423102027", var_114_6)
						arg_111_1:RecordAudio("423102027", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_423102", "423102027", "story_v_out_423102.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_423102", "423102027", "story_v_out_423102.awb")
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
	Play423102028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 423102028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play423102029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.725

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

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_1 = arg_115_1:FormatText(arg_115_1:GetWordFromCfg(423102028).content)

				arg_115_1.text_.text = var_118_1

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_3 = 29 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 29)

				if (29 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_1) / 29)) > 0 and var_118_0 < var_118_3 then
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
	Play423102029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 423102029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play423102030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1083 = arg_119_1.actors_["1083"].transform.localPosition
				arg_119_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1083", 7)

				for iter_122_0 = 0, arg_119_1.actors_["1083"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["1083"].transform:GetChild(iter_122_0)

					if var_122_0.name == "" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["1083"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_122_2 = 0
			local var_122_3 = 1.625

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_4 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(423102029).content)

				arg_119_1.text_.text = var_122_4

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_6 = 65 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_4) / 65)

				if (65 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_4) / 65)) > 0 and var_122_3 < var_122_6 then
					arg_119_1.talkMaxDuration = var_122_6

					if var_122_6 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_2
					end
				end

				arg_119_1.text_.text = var_122_4
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_3, arg_119_1.talkMaxDuration)

			if var_122_2 <= arg_119_1.time_ and arg_119_1.time_ < var_122_2 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_2) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_2 + var_122_7 and arg_119_1.time_ < var_122_2 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
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

		arg_119_1:InitPlayNodeList()
	end,
	Play423102030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 423102030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play423102031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.525

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(423102030).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 21 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 21)

				if (21 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 21)) > 0 and var_126_0 < var_126_3 then
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
	Play423102031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 423102031
		arg_127_1.duration_ = 8.03

		local var_127_0 = {
			zh = 5.9,
			ja = 8.033
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play423102032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1083"]) and arg_127_1.var_.actorSpriteComps1083 == nil then
				arg_127_1.var_.actorSpriteComps1083 = arg_127_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1083"]) then
				if arg_127_1.var_.actorSpriteComps1083 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								iter_130_1.color = Color.New(Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 0) / var_130_0), Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 0) / var_130_0), (Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 0) / var_130_0)))
							else
								local var_130_1 = Mathf.Lerp(iter_130_1.color.r, 1, (arg_127_1.time_ - 0) / var_130_0)

								iter_130_1.color = Color.New(var_130_1, var_130_1, var_130_1)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1083"]) and arg_127_1.var_.actorSpriteComps1083 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps1083 = nil
			end

			local var_130_2 = arg_127_1.actors_["1083"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1083 = var_130_2.localPosition
				var_130_2.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1083", 3)

				for iter_130_4 = 0, var_130_2.childCount - 1 do
					local var_130_3 = var_130_2:GetChild(iter_130_4)

					if var_130_3.name == "" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_2.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_127_1.time_ - 0) / var_130_4)
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_130_5 = 0
			local var_130_6 = 0.675

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_7 = arg_127_1:GetWordFromCfg(423102031)
				local var_130_8 = arg_127_1:FormatText(var_130_7.content)

				arg_127_1.text_.text = var_130_8

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 27 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 27)

				if (27 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 27)) > 0 and var_130_6 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_8
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102031", "story_v_out_423102.awb") ~= 0 then
					local var_130_11 = manager.audio:GetVoiceLength("story_v_out_423102", "423102031", "story_v_out_423102.awb") / 1000

					if var_130_11 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_5
					end

					if var_130_7.prefab_name ~= "" and arg_127_1.actors_[var_130_7.prefab_name] ~= nil then
						local var_130_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_7.prefab_name].transform, "story_v_out_423102", "423102031", "story_v_out_423102.awb")

						arg_127_1:RecordAudio("423102031", var_130_12)
						arg_127_1:RecordAudio("423102031", var_130_12)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_423102", "423102031", "story_v_out_423102.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_423102", "423102031", "story_v_out_423102.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_13 = math.max(var_130_6, arg_127_1.talkMaxDuration)

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_13 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_5) / var_130_13

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_5 + var_130_13 and arg_127_1.time_ < var_130_5 + var_130_13 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play423102032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 423102032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play423102033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1083"]) and arg_131_1.var_.actorSpriteComps1083 == nil then
				arg_131_1.var_.actorSpriteComps1083 = arg_131_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1083"]) then
				if arg_131_1.var_.actorSpriteComps1083 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								iter_134_1.color = Color.New(Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor2.r, (arg_131_1.time_ - 0) / var_134_0), Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor2.g, (arg_131_1.time_ - 0) / var_134_0), (Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor2.b, (arg_131_1.time_ - 0) / var_134_0)))
							else
								local var_134_1 = Mathf.Lerp(iter_134_1.color.r, 0.5, (arg_131_1.time_ - 0) / var_134_0)

								iter_134_1.color = Color.New(var_134_1, var_134_1, var_134_1)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1083"]) and arg_131_1.var_.actorSpriteComps1083 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_134_3 then
						iter_134_3.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_131_1.var_.actorSpriteComps1083 = nil
			end

			local var_134_2 = 0
			local var_134_3 = 0.525

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_4 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(423102032).content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_6 = 21 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_4) / 21)

				if (21 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_4) / 21)) > 0 and var_134_3 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_3, arg_131_1.talkMaxDuration)

			if var_134_2 <= arg_131_1.time_ and arg_131_1.time_ < var_134_2 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_2) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_2 + var_134_7 and arg_131_1.time_ < var_134_2 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play423102033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 423102033
		arg_135_1.duration_ = 4.27

		local var_135_0 = {
			zh = 2.1,
			ja = 4.266
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play423102034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1083"]) and arg_135_1.var_.actorSpriteComps1083 == nil then
				arg_135_1.var_.actorSpriteComps1083 = arg_135_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1083"]) then
				if arg_135_1.var_.actorSpriteComps1083 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								iter_138_1.color = Color.New(Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_0), Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_0), (Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_0)))
							else
								local var_138_1 = Mathf.Lerp(iter_138_1.color.r, 1, (arg_135_1.time_ - 0) / var_138_0)

								iter_138_1.color = Color.New(var_138_1, var_138_1, var_138_1)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1083"]) and arg_135_1.var_.actorSpriteComps1083 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps1083 = nil
			end

			local var_138_2 = arg_135_1.actors_["1083"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1083 = var_138_2.localPosition
				var_138_2.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1083", 3)

				for iter_138_4 = 0, var_138_2.childCount - 1 do
					local var_138_3 = var_138_2:GetChild(iter_138_4)

					if var_138_3.name == "split_2" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				var_138_2.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_135_1.time_ - 0) / var_138_4)
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				var_138_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_138_5 = 0
			local var_138_6 = 0.175

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_7 = arg_135_1:GetWordFromCfg(423102033)
				local var_138_8 = arg_135_1:FormatText(var_138_7.content)

				arg_135_1.text_.text = var_138_8

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_10 = 7 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 7)

				if (7 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 7)) > 0 and var_138_6 < var_138_10 then
					arg_135_1.talkMaxDuration = var_138_10

					if var_138_10 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_5
					end
				end

				arg_135_1.text_.text = var_138_8
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102033", "story_v_out_423102.awb") ~= 0 then
					local var_138_11 = manager.audio:GetVoiceLength("story_v_out_423102", "423102033", "story_v_out_423102.awb") / 1000

					if var_138_11 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_5
					end

					if var_138_7.prefab_name ~= "" and arg_135_1.actors_[var_138_7.prefab_name] ~= nil then
						local var_138_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_7.prefab_name].transform, "story_v_out_423102", "423102033", "story_v_out_423102.awb")

						arg_135_1:RecordAudio("423102033", var_138_12)
						arg_135_1:RecordAudio("423102033", var_138_12)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_423102", "423102033", "story_v_out_423102.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_423102", "423102033", "story_v_out_423102.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_13 = math.max(var_138_6, arg_135_1.talkMaxDuration)

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_13 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_5) / var_138_13

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_5 + var_138_13 and arg_135_1.time_ < var_138_5 + var_138_13 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play423102034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 423102034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play423102035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1083"]) and arg_139_1.var_.actorSpriteComps1083 == nil then
				arg_139_1.var_.actorSpriteComps1083 = arg_139_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1083"]) then
				if arg_139_1.var_.actorSpriteComps1083 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								iter_142_1.color = Color.New(Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_0), Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_0), (Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_0)))
							else
								local var_142_1 = Mathf.Lerp(iter_142_1.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_0)

								iter_142_1.color = Color.New(var_142_1, var_142_1, var_142_1)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1083"]) and arg_139_1.var_.actorSpriteComps1083 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps1083 = nil
			end

			local var_142_2 = 0
			local var_142_3 = 0.85

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_4 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(423102034).content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_6 = 34 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_4) / 34)

				if (34 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_4) / 34)) > 0 and var_142_3 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_7 and arg_139_1.time_ < var_142_2 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play423102035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 423102035
		arg_143_1.duration_ = 13.67

		local var_143_0 = {
			zh = 10.2,
			ja = 13.666
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play423102036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1083"]) and arg_143_1.var_.actorSpriteComps1083 == nil then
				arg_143_1.var_.actorSpriteComps1083 = arg_143_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1083"]) then
				if arg_143_1.var_.actorSpriteComps1083 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								iter_146_1.color = Color.New(Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor1.r, (arg_143_1.time_ - 0) / var_146_0), Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor1.g, (arg_143_1.time_ - 0) / var_146_0), (Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor1.b, (arg_143_1.time_ - 0) / var_146_0)))
							else
								local var_146_1 = Mathf.Lerp(iter_146_1.color.r, 1, (arg_143_1.time_ - 0) / var_146_0)

								iter_146_1.color = Color.New(var_146_1, var_146_1, var_146_1)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1083"]) and arg_143_1.var_.actorSpriteComps1083 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_146_3 then
						iter_146_3.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps1083 = nil
			end

			local var_146_2 = arg_143_1.actors_["1083"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1083 = var_146_2.localPosition
				var_146_2.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1083", 3)

				for iter_146_4 = 0, var_146_2.childCount - 1 do
					local var_146_3 = var_146_2:GetChild(iter_146_4)

					if var_146_3.name == "" or not string.find(var_146_3.name, "split") then
						var_146_3.gameObject:SetActive(true)
					else
						var_146_3.gameObject:SetActive(false)
					end
				end
			end

			local var_146_4 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				var_146_2.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_143_1.time_ - 0) / var_146_4)
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				var_146_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_146_5 = 0
			local var_146_6 = 1.2

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_7 = arg_143_1:GetWordFromCfg(423102035)
				local var_146_8 = arg_143_1:FormatText(var_146_7.content)

				arg_143_1.text_.text = var_146_8

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_10 = 48 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_8) / 48)

				if (48 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_8) / 48)) > 0 and var_146_6 < var_146_10 then
					arg_143_1.talkMaxDuration = var_146_10

					if var_146_10 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_5
					end
				end

				arg_143_1.text_.text = var_146_8
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102035", "story_v_out_423102.awb") ~= 0 then
					local var_146_11 = manager.audio:GetVoiceLength("story_v_out_423102", "423102035", "story_v_out_423102.awb") / 1000

					if var_146_11 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_5
					end

					if var_146_7.prefab_name ~= "" and arg_143_1.actors_[var_146_7.prefab_name] ~= nil then
						local var_146_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_7.prefab_name].transform, "story_v_out_423102", "423102035", "story_v_out_423102.awb")

						arg_143_1:RecordAudio("423102035", var_146_12)
						arg_143_1:RecordAudio("423102035", var_146_12)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_423102", "423102035", "story_v_out_423102.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_423102", "423102035", "story_v_out_423102.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_13 = math.max(var_146_6, arg_143_1.talkMaxDuration)

			if var_146_5 <= arg_143_1.time_ and arg_143_1.time_ < var_146_5 + var_146_13 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_5) / var_146_13

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_5 + var_146_13 and arg_143_1.time_ < var_146_5 + var_146_13 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play423102036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 423102036
		arg_147_1.duration_ = 14.93

		local var_147_0 = {
			zh = 8.666,
			ja = 14.933
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play423102037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1083 = arg_147_1.actors_["1083"].transform.localPosition
				arg_147_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1083", 3)

				for iter_150_0 = 0, arg_147_1.actors_["1083"].transform.childCount - 1 do
					local var_150_0 = arg_147_1.actors_["1083"].transform:GetChild(iter_150_0)

					if var_150_0.name == "" or not string.find(var_150_0.name, "split") then
						var_150_0.gameObject:SetActive(true)
					else
						var_150_0.gameObject:SetActive(false)
					end
				end
			end

			local var_150_1 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_1 then
				arg_147_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_147_1.time_ - 0) / var_150_1)
			end

			if arg_147_1.time_ >= 0 + var_150_1 and arg_147_1.time_ < 0 + var_150_1 + arg_150_0 then
				arg_147_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_150_2 = 0
			local var_150_3 = 1

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_4 = arg_147_1:GetWordFromCfg(423102036)
				local var_150_5 = arg_147_1:FormatText(var_150_4.content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_7 = 40 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 40)

				if (40 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 40)) > 0 and var_150_3 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_2
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102036", "story_v_out_423102.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_423102", "423102036", "story_v_out_423102.awb") / 1000

					if var_150_8 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_2
					end

					if var_150_4.prefab_name ~= "" and arg_147_1.actors_[var_150_4.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_4.prefab_name].transform, "story_v_out_423102", "423102036", "story_v_out_423102.awb")

						arg_147_1:RecordAudio("423102036", var_150_9)
						arg_147_1:RecordAudio("423102036", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_423102", "423102036", "story_v_out_423102.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_423102", "423102036", "story_v_out_423102.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_3, arg_147_1.talkMaxDuration)

			if var_150_2 <= arg_147_1.time_ and arg_147_1.time_ < var_150_2 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_2) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_2 + var_150_10 and arg_147_1.time_ < var_150_2 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play423102037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 423102037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play423102038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1083"]) and arg_151_1.var_.actorSpriteComps1083 == nil then
				arg_151_1.var_.actorSpriteComps1083 = arg_151_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1083"]) then
				if arg_151_1.var_.actorSpriteComps1083 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								iter_154_1.color = Color.New(Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_0), Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_0), (Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_0)))
							else
								local var_154_1 = Mathf.Lerp(iter_154_1.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_0)

								iter_154_1.color = Color.New(var_154_1, var_154_1, var_154_1)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1083"]) and arg_151_1.var_.actorSpriteComps1083 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps1083 = nil
			end

			local var_154_2 = 0
			local var_154_3 = 0.725

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_4 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(423102037).content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_6 = 29 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_4) / 29)

				if (29 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_4) / 29)) > 0 and var_154_3 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_7 and arg_151_1.time_ < var_154_2 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play423102038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 423102038
		arg_155_1.duration_ = 8.77

		local var_155_0 = {
			zh = 5.8,
			ja = 8.766
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play423102039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["1083"]) and arg_155_1.var_.actorSpriteComps1083 == nil then
				arg_155_1.var_.actorSpriteComps1083 = arg_155_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_0 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["1083"]) then
				if arg_155_1.var_.actorSpriteComps1083 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								iter_158_1.color = Color.New(Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor1.r, (arg_155_1.time_ - 0) / var_158_0), Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor1.g, (arg_155_1.time_ - 0) / var_158_0), (Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor1.b, (arg_155_1.time_ - 0) / var_158_0)))
							else
								local var_158_1 = Mathf.Lerp(iter_158_1.color.r, 1, (arg_155_1.time_ - 0) / var_158_0)

								iter_158_1.color = Color.New(var_158_1, var_158_1, var_158_1)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["1083"]) and arg_155_1.var_.actorSpriteComps1083 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_158_3 then
						iter_158_3.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps1083 = nil
			end

			local var_158_2 = arg_155_1.actors_["1083"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1083 = var_158_2.localPosition
				var_158_2.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1083", 3)

				for iter_158_4 = 0, var_158_2.childCount - 1 do
					local var_158_3 = var_158_2:GetChild(iter_158_4)

					if var_158_3.name == "" or not string.find(var_158_3.name, "split") then
						var_158_3.gameObject:SetActive(true)
					else
						var_158_3.gameObject:SetActive(false)
					end
				end
			end

			local var_158_4 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_4 then
				var_158_2.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_155_1.time_ - 0) / var_158_4)
			end

			if arg_155_1.time_ >= 0 + var_158_4 and arg_155_1.time_ < 0 + var_158_4 + arg_158_0 then
				var_158_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_158_5 = 0
			local var_158_6 = 0.625

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_7 = arg_155_1:GetWordFromCfg(423102038)
				local var_158_8 = arg_155_1:FormatText(var_158_7.content)

				arg_155_1.text_.text = var_158_8

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_10 = 25 <= 0 and var_158_6 or var_158_6 * (utf8.len(var_158_8) / 25)

				if (25 <= 0 and var_158_6 or var_158_6 * (utf8.len(var_158_8) / 25)) > 0 and var_158_6 < var_158_10 then
					arg_155_1.talkMaxDuration = var_158_10

					if var_158_10 + var_158_5 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_5
					end
				end

				arg_155_1.text_.text = var_158_8
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102038", "story_v_out_423102.awb") ~= 0 then
					local var_158_11 = manager.audio:GetVoiceLength("story_v_out_423102", "423102038", "story_v_out_423102.awb") / 1000

					if var_158_11 + var_158_5 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_5
					end

					if var_158_7.prefab_name ~= "" and arg_155_1.actors_[var_158_7.prefab_name] ~= nil then
						local var_158_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_7.prefab_name].transform, "story_v_out_423102", "423102038", "story_v_out_423102.awb")

						arg_155_1:RecordAudio("423102038", var_158_12)
						arg_155_1:RecordAudio("423102038", var_158_12)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_423102", "423102038", "story_v_out_423102.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_423102", "423102038", "story_v_out_423102.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_13 = math.max(var_158_6, arg_155_1.talkMaxDuration)

			if var_158_5 <= arg_155_1.time_ and arg_155_1.time_ < var_158_5 + var_158_13 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_5) / var_158_13

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_5 + var_158_13 and arg_155_1.time_ < var_158_5 + var_158_13 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play423102039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 423102039
		arg_159_1.duration_ = 7.23

		local var_159_0 = {
			zh = 4.7,
			ja = 7.233
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play423102040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.625

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:GetWordFromCfg(423102039)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 25 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 25)

				if (25 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 25)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102039", "story_v_out_423102.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_423102", "423102039", "story_v_out_423102.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_423102", "423102039", "story_v_out_423102.awb")

						arg_159_1:RecordAudio("423102039", var_162_6)
						arg_159_1:RecordAudio("423102039", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_423102", "423102039", "story_v_out_423102.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_423102", "423102039", "story_v_out_423102.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play423102040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 423102040
		arg_163_1.duration_ = 13.47

		local var_163_0 = {
			zh = 6.9,
			ja = 13.466
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play423102041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1083 = arg_163_1.actors_["1083"].transform.localPosition
				arg_163_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1083", 3)

				for iter_166_0 = 0, arg_163_1.actors_["1083"].transform.childCount - 1 do
					local var_166_0 = arg_163_1.actors_["1083"].transform:GetChild(iter_166_0)

					if var_166_0.name == "" or not string.find(var_166_0.name, "split") then
						var_166_0.gameObject:SetActive(true)
					else
						var_166_0.gameObject:SetActive(false)
					end
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_163_1.time_ - 0) / var_166_1)
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_166_2 = 0
			local var_166_3 = 0.85

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_4 = arg_163_1:GetWordFromCfg(423102040)
				local var_166_5 = arg_163_1:FormatText(var_166_4.content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 35 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 35)

				if (35 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 35)) > 0 and var_166_3 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102040", "story_v_out_423102.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_423102", "423102040", "story_v_out_423102.awb") / 1000

					if var_166_8 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_2
					end

					if var_166_4.prefab_name ~= "" and arg_163_1.actors_[var_166_4.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_4.prefab_name].transform, "story_v_out_423102", "423102040", "story_v_out_423102.awb")

						arg_163_1:RecordAudio("423102040", var_166_9)
						arg_163_1:RecordAudio("423102040", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_423102", "423102040", "story_v_out_423102.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_423102", "423102040", "story_v_out_423102.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_3, arg_163_1.talkMaxDuration)

			if var_166_2 <= arg_163_1.time_ and arg_163_1.time_ < var_166_2 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_2) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_2 + var_166_10 and arg_163_1.time_ < var_166_2 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play423102041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 423102041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play423102042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1083"]) and arg_167_1.var_.actorSpriteComps1083 == nil then
				arg_167_1.var_.actorSpriteComps1083 = arg_167_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1083"]) then
				if arg_167_1.var_.actorSpriteComps1083 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_170_1 then
							if arg_167_1.isInRecall_ then
								iter_170_1.color = Color.New(Mathf.Lerp(iter_170_1.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_0), Mathf.Lerp(iter_170_1.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_0), (Mathf.Lerp(iter_170_1.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_0)))
							else
								local var_170_1 = Mathf.Lerp(iter_170_1.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_0)

								iter_170_1.color = Color.New(var_170_1, var_170_1, var_170_1)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1083"]) and arg_167_1.var_.actorSpriteComps1083 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps1083 = nil
			end

			local var_170_2 = 0
			local var_170_3 = 0.475

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_4 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(423102041).content)

				arg_167_1.text_.text = var_170_4

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_6 = 19 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_4) / 19)

				if (19 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_4) / 19)) > 0 and var_170_3 < var_170_6 then
					arg_167_1.talkMaxDuration = var_170_6

					if var_170_6 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_6 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_4
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_3, arg_167_1.talkMaxDuration)

			if var_170_2 <= arg_167_1.time_ and arg_167_1.time_ < var_170_2 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_2) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_2 + var_170_7 and arg_167_1.time_ < var_170_2 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play423102042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 423102042
		arg_171_1.duration_ = 8.87

		local var_171_0 = {
			zh = 8.866,
			ja = 7.2
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
				arg_171_0:Play423102043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1083"]) and arg_171_1.var_.actorSpriteComps1083 == nil then
				arg_171_1.var_.actorSpriteComps1083 = arg_171_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_0 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1083"]) then
				if arg_171_1.var_.actorSpriteComps1083 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								iter_174_1.color = Color.New(Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_0), Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_0), (Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_0)))
							else
								local var_174_1 = Mathf.Lerp(iter_174_1.color.r, 1, (arg_171_1.time_ - 0) / var_174_0)

								iter_174_1.color = Color.New(var_174_1, var_174_1, var_174_1)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1083"]) and arg_171_1.var_.actorSpriteComps1083 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_174_3 then
						iter_174_3.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps1083 = nil
			end

			local var_174_2 = arg_171_1.actors_["1083"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1083 = var_174_2.localPosition
				var_174_2.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1083", 3)

				for iter_174_4 = 0, var_174_2.childCount - 1 do
					local var_174_3 = var_174_2:GetChild(iter_174_4)

					if var_174_3.name == "" or not string.find(var_174_3.name, "split") then
						var_174_3.gameObject:SetActive(true)
					else
						var_174_3.gameObject:SetActive(false)
					end
				end
			end

			local var_174_4 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				var_174_2.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_171_1.time_ - 0) / var_174_4)
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				var_174_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_174_5 = 0
			local var_174_6 = 0.85

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_7 = arg_171_1:GetWordFromCfg(423102042)
				local var_174_8 = arg_171_1:FormatText(var_174_7.content)

				arg_171_1.text_.text = var_174_8

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_10 = 34 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 34)

				if (34 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 34)) > 0 and var_174_6 < var_174_10 then
					arg_171_1.talkMaxDuration = var_174_10

					if var_174_10 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_5
					end
				end

				arg_171_1.text_.text = var_174_8
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102042", "story_v_out_423102.awb") ~= 0 then
					local var_174_11 = manager.audio:GetVoiceLength("story_v_out_423102", "423102042", "story_v_out_423102.awb") / 1000

					if var_174_11 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_5
					end

					if var_174_7.prefab_name ~= "" and arg_171_1.actors_[var_174_7.prefab_name] ~= nil then
						local var_174_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_7.prefab_name].transform, "story_v_out_423102", "423102042", "story_v_out_423102.awb")

						arg_171_1:RecordAudio("423102042", var_174_12)
						arg_171_1:RecordAudio("423102042", var_174_12)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_423102", "423102042", "story_v_out_423102.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_423102", "423102042", "story_v_out_423102.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_13 = math.max(var_174_6, arg_171_1.talkMaxDuration)

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_13 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_5) / var_174_13

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_5 + var_174_13 and arg_171_1.time_ < var_174_5 + var_174_13 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play423102043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 423102043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play423102044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1083"]) and arg_175_1.var_.actorSpriteComps1083 == nil then
				arg_175_1.var_.actorSpriteComps1083 = arg_175_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_0 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1083"]) then
				if arg_175_1.var_.actorSpriteComps1083 then
					for iter_178_0, iter_178_1 in pairs(arg_175_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_178_1 then
							if arg_175_1.isInRecall_ then
								iter_178_1.color = Color.New(Mathf.Lerp(iter_178_1.color.r, arg_175_1.hightColor2.r, (arg_175_1.time_ - 0) / var_178_0), Mathf.Lerp(iter_178_1.color.g, arg_175_1.hightColor2.g, (arg_175_1.time_ - 0) / var_178_0), (Mathf.Lerp(iter_178_1.color.b, arg_175_1.hightColor2.b, (arg_175_1.time_ - 0) / var_178_0)))
							else
								local var_178_1 = Mathf.Lerp(iter_178_1.color.r, 0.5, (arg_175_1.time_ - 0) / var_178_0)

								iter_178_1.color = Color.New(var_178_1, var_178_1, var_178_1)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1083"]) and arg_175_1.var_.actorSpriteComps1083 then
				for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_178_3 then
						iter_178_3.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_175_1.var_.actorSpriteComps1083 = nil
			end

			local var_178_2 = 0
			local var_178_3 = 0.5

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_2 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_4 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(423102043).content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_6 = 20 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_4) / 20)

				if (20 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_4) / 20)) > 0 and var_178_3 < var_178_6 then
					arg_175_1.talkMaxDuration = var_178_6

					if var_178_6 + var_178_2 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_6 + var_178_2
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_3, arg_175_1.talkMaxDuration)

			if var_178_2 <= arg_175_1.time_ and arg_175_1.time_ < var_178_2 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_2) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_2 + var_178_7 and arg_175_1.time_ < var_178_2 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play423102044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 423102044
		arg_179_1.duration_ = 6.5

		local var_179_0 = {
			zh = 6.5,
			ja = 4.666
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
				arg_179_0:Play423102045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1083"]) and arg_179_1.var_.actorSpriteComps1083 == nil then
				arg_179_1.var_.actorSpriteComps1083 = arg_179_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1083"]) then
				if arg_179_1.var_.actorSpriteComps1083 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								iter_182_1.color = Color.New(Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor1.r, (arg_179_1.time_ - 0) / var_182_0), Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor1.g, (arg_179_1.time_ - 0) / var_182_0), (Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor1.b, (arg_179_1.time_ - 0) / var_182_0)))
							else
								local var_182_1 = Mathf.Lerp(iter_182_1.color.r, 1, (arg_179_1.time_ - 0) / var_182_0)

								iter_182_1.color = Color.New(var_182_1, var_182_1, var_182_1)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1083"]) and arg_179_1.var_.actorSpriteComps1083 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_179_1.var_.actorSpriteComps1083 = nil
			end

			local var_182_2 = arg_179_1.actors_["1083"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1083 = var_182_2.localPosition
				var_182_2.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("1083", 3)

				for iter_182_4 = 0, var_182_2.childCount - 1 do
					local var_182_3 = var_182_2:GetChild(iter_182_4)

					if var_182_3.name == "split_2" or not string.find(var_182_3.name, "split") then
						var_182_3.gameObject:SetActive(true)
					else
						var_182_3.gameObject:SetActive(false)
					end
				end
			end

			local var_182_4 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				var_182_2.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_179_1.time_ - 0) / var_182_4)
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				var_182_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_182_5 = 0
			local var_182_6 = 0.7

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_5 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_7 = arg_179_1:GetWordFromCfg(423102044)
				local var_182_8 = arg_179_1:FormatText(var_182_7.content)

				arg_179_1.text_.text = var_182_8

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_10 = 28 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 28)

				if (28 <= 0 and var_182_6 or var_182_6 * (utf8.len(var_182_8) / 28)) > 0 and var_182_6 < var_182_10 then
					arg_179_1.talkMaxDuration = var_182_10

					if var_182_10 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_5
					end
				end

				arg_179_1.text_.text = var_182_8
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102044", "story_v_out_423102.awb") ~= 0 then
					local var_182_11 = manager.audio:GetVoiceLength("story_v_out_423102", "423102044", "story_v_out_423102.awb") / 1000

					if var_182_11 + var_182_5 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_11 + var_182_5
					end

					if var_182_7.prefab_name ~= "" and arg_179_1.actors_[var_182_7.prefab_name] ~= nil then
						local var_182_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_7.prefab_name].transform, "story_v_out_423102", "423102044", "story_v_out_423102.awb")

						arg_179_1:RecordAudio("423102044", var_182_12)
						arg_179_1:RecordAudio("423102044", var_182_12)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_423102", "423102044", "story_v_out_423102.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_423102", "423102044", "story_v_out_423102.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_13 = math.max(var_182_6, arg_179_1.talkMaxDuration)

			if var_182_5 <= arg_179_1.time_ and arg_179_1.time_ < var_182_5 + var_182_13 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_5) / var_182_13

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_5 + var_182_13 and arg_179_1.time_ < var_182_5 + var_182_13 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play423102045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 423102045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play423102046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1083"]) and arg_183_1.var_.actorSpriteComps1083 == nil then
				arg_183_1.var_.actorSpriteComps1083 = arg_183_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_0 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1083"]) then
				if arg_183_1.var_.actorSpriteComps1083 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								iter_186_1.color = Color.New(Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 0) / var_186_0), Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 0) / var_186_0), (Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 0) / var_186_0)))
							else
								local var_186_1 = Mathf.Lerp(iter_186_1.color.r, 0.5, (arg_183_1.time_ - 0) / var_186_0)

								iter_186_1.color = Color.New(var_186_1, var_186_1, var_186_1)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1083"]) and arg_183_1.var_.actorSpriteComps1083 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_186_3 then
						iter_186_3.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps1083 = nil
			end

			local var_186_2 = 0
			local var_186_3 = 0.375

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_2 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_4 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(423102045).content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_6 = 15 <= 0 and var_186_3 or var_186_3 * (utf8.len(var_186_4) / 15)

				if (15 <= 0 and var_186_3 or var_186_3 * (utf8.len(var_186_4) / 15)) > 0 and var_186_3 < var_186_6 then
					arg_183_1.talkMaxDuration = var_186_6

					if var_186_6 + var_186_2 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_6 + var_186_2
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_3, arg_183_1.talkMaxDuration)

			if var_186_2 <= arg_183_1.time_ and arg_183_1.time_ < var_186_2 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_2) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_2 + var_186_7 and arg_183_1.time_ < var_186_2 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play423102046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 423102046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play423102047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1083 = arg_187_1.actors_["1083"].transform.localPosition
				arg_187_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("1083", 7)

				for iter_190_0 = 0, arg_187_1.actors_["1083"].transform.childCount - 1 do
					local var_190_0 = arg_187_1.actors_["1083"].transform:GetChild(iter_190_0)

					if var_190_0.name == "" or not string.find(var_190_0.name, "split") then
						var_190_0.gameObject:SetActive(true)
					else
						var_190_0.gameObject:SetActive(false)
					end
				end
			end

			local var_190_1 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_1 then
				arg_187_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_187_1.time_ - 0) / var_190_1)
			end

			if arg_187_1.time_ >= 0 + var_190_1 and arg_187_1.time_ < 0 + var_190_1 + arg_190_0 then
				arg_187_1.actors_["1083"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_190_2 = 0
			local var_190_3 = 1.95

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_2 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_4 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(423102046).content)

				arg_187_1.text_.text = var_190_4

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_6 = 78 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_4) / 78)

				if (78 <= 0 and var_190_3 or var_190_3 * (utf8.len(var_190_4) / 78)) > 0 and var_190_3 < var_190_6 then
					arg_187_1.talkMaxDuration = var_190_6

					if var_190_6 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_6 + var_190_2
					end
				end

				arg_187_1.text_.text = var_190_4
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_3, arg_187_1.talkMaxDuration)

			if var_190_2 <= arg_187_1.time_ and arg_187_1.time_ < var_190_2 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_2) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_2 + var_190_7 and arg_187_1.time_ < var_190_2 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
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

		arg_187_1:InitPlayNodeList()
	end,
	Play423102047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 423102047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play423102048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.675

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

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(423102047).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 27 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 27)

				if (27 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 27)) > 0 and var_194_0 < var_194_3 then
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
	Play423102048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 423102048
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play423102049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.325

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(423102048).content)

				arg_195_1.text_.text = var_198_1

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_3 = 13 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 13)

				if (13 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_1) / 13)) > 0 and var_198_0 < var_198_3 then
					arg_195_1.talkMaxDuration = var_198_3

					if var_198_3 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_3 + 0
					end
				end

				arg_195_1.text_.text = var_198_1
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_4 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_4

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play423102049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 423102049
		arg_199_1.duration_ = 9

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play423102050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if arg_199_1.bgs_.L08g == nil then
				local var_202_0 = Object.Instantiate(arg_199_1.paintGo_)

				var_202_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L08g")
				var_202_0.name = "L08g"
				var_202_0.transform.parent = arg_199_1.stage_.transform
				var_202_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.bgs_.L08g = var_202_0
			end

			if 1.999999999999 < arg_199_1.time_ and arg_199_1.time_ <= 1.999999999999 + arg_202_0 then
				local var_202_1 = arg_199_1.bgs_.L08g

				arg_199_1.bgs_.L08g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_202_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_202_2 = var_202_1:GetComponent("SpriteRenderer")

				if var_202_2 and var_202_2.sprite then
					local var_202_3 = 2 * (var_202_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_202_1.transform.localScale = Vector3.New(var_202_3 / var_202_2.sprite.bounds.size.y < var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x and var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x or var_202_3 / var_202_2.sprite.bounds.size.y, var_202_3 / var_202_2.sprite.bounds.size.y < var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x and var_202_3 * manager.ui.mainCameraCom_.aspect / var_202_2.sprite.bounds.size.x or var_202_3 / var_202_2.sprite.bounds.size.y, 0)
				end

				for iter_202_0, iter_202_1 in pairs(arg_199_1.bgs_) do
					if iter_202_0 ~= "L08g" then
						iter_202_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_202_4 = 3.999999999999

			if 3.999999999999 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.allBtn_.enabled = false
			end

			if arg_199_1.time_ >= var_202_4 + 0.3 and arg_199_1.time_ < var_202_4 + 0.3 + arg_202_0 then
				arg_199_1.allBtn_.enabled = true
			end

			local var_202_5 = 0

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_6 = 2

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_6 then
				local var_202_7 = Color.New(0, 0, 0)

				var_202_7.a = Mathf.Lerp(0, 1, (arg_199_1.time_ - var_202_5) / var_202_6)
				arg_199_1.mask_.color = var_202_7
			end

			if arg_199_1.time_ >= var_202_5 + var_202_6 and arg_199_1.time_ < var_202_5 + var_202_6 + arg_202_0 then
				local var_202_8 = Color.New(0, 0, 0)

				var_202_8.a = 1
				arg_199_1.mask_.color = var_202_8
			end

			local var_202_9 = 2

			if 2 < arg_199_1.time_ and arg_199_1.time_ <= var_202_9 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_10 = 2

			if var_202_9 <= arg_199_1.time_ and arg_199_1.time_ < var_202_9 + var_202_10 then
				local var_202_11 = Color.New(0, 0, 0)

				var_202_11.a = Mathf.Lerp(1, 0, (arg_199_1.time_ - var_202_9) / var_202_10)
				arg_199_1.mask_.color = var_202_11
			end

			if arg_199_1.time_ >= var_202_9 + var_202_10 and arg_199_1.time_ < var_202_9 + var_202_10 + arg_202_0 then
				local var_202_12 = Color.New(0, 0, 0)

				arg_199_1.mask_.enabled = false
				var_202_12.a = 0
				arg_199_1.mask_.color = var_202_12
			end

			if 0.166666666666667 < arg_199_1.time_ and arg_199_1.time_ <= 0.166666666666667 + arg_202_0 then
				arg_199_1:AudioAction("stop", "effect", "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			if 1.63333333333333 < arg_199_1.time_ and arg_199_1.time_ <= 1.63333333333333 + arg_202_0 then
				arg_199_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drain", "")
			end

			if arg_199_1.frameCnt_ <= 1 then
				arg_199_1.dialog_:SetActive(false)
			end

			local var_202_15 = 3.999999999999
			local var_202_16 = 1.775

			if 3.999999999999 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				arg_199_1.dialog_:SetActive(true)

				arg_199_1.dialogCg_.alpha = 0

				local var_202_17 = LeanTween.value(arg_199_1.dialog_, 0, 1, 0.3)

				var_202_17:setOnUpdate(LuaHelper.FloatAction(function(arg_203_0)
					arg_199_1.dialogCg_.alpha = arg_203_0
				end))
				var_202_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_199_1.dialog_)
					var_202_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_199_1.duration_ = arg_199_1.duration_ + 0.3

				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_18 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(423102049).content)

				arg_199_1.text_.text = var_202_18

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_20 = 71 <= 0 and var_202_16 or var_202_16 * (utf8.len(var_202_18) / 71)

				if (71 <= 0 and var_202_16 or var_202_16 * (utf8.len(var_202_18) / 71)) > 0 and var_202_16 < var_202_20 then
					arg_199_1.talkMaxDuration = var_202_20
					var_202_15 = var_202_15 + 0.3

					if var_202_20 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_20 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_18
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_21 = var_202_15 + 0.3
			local var_202_22 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 + 0.3 <= arg_199_1.time_ and arg_199_1.time_ < var_202_21 + var_202_22 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_21) / var_202_22

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_21 + var_202_22 and arg_199_1.time_ < var_202_21 + var_202_22 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play423102050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 423102050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play423102051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0.333333333333333 < arg_205_1.time_ and arg_205_1.time_ <= 0.333333333333333 + arg_208_0 then
				arg_205_1:AudioAction("play", "effect", "se_story_144", "se_story_144_metal", "")
			end

			local var_208_1 = 0
			local var_208_2 = 1.975

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(423102050).content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 79 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 79)

				if (79 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 79)) > 0 and var_208_2 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_6 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_6 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_6

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_6 and arg_205_1.time_ < var_208_1 + var_208_6 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play423102051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 423102051
		arg_209_1.duration_ = 13.47

		local var_209_0 = {
			zh = 8.333,
			ja = 13.466
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
				arg_209_0:Play423102052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if arg_209_1.actors_["10146"] == nil then
				local var_212_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10146")

				if not isNil(var_212_0) then
					local var_212_1 = Object.Instantiate(var_212_0, arg_209_1.canvasGo_.transform)

					var_212_1.transform:SetSiblingIndex(1)

					var_212_1.name = "10146"
					var_212_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_209_1.actors_["10146"] = var_212_1

					if arg_209_1.isInRecall_ then
						for iter_212_0, iter_212_1 in ipairs((var_212_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_212_1.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_212_2 = arg_209_1.actors_["10146"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps10146 == nil then
				arg_209_1.var_.actorSpriteComps10146 = var_212_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_3 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 and not isNil(var_212_2) then
				if arg_209_1.var_.actorSpriteComps10146 then
					for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_212_3 then
							if arg_209_1.isInRecall_ then
								iter_212_3.color = Color.New(Mathf.Lerp(iter_212_3.color.r, arg_209_1.hightColor1.r, (arg_209_1.time_ - 0) / var_212_3), Mathf.Lerp(iter_212_3.color.g, arg_209_1.hightColor1.g, (arg_209_1.time_ - 0) / var_212_3), (Mathf.Lerp(iter_212_3.color.b, arg_209_1.hightColor1.b, (arg_209_1.time_ - 0) / var_212_3)))
							else
								local var_212_4 = Mathf.Lerp(iter_212_3.color.r, 1, (arg_209_1.time_ - 0) / var_212_3)

								iter_212_3.color = Color.New(var_212_4, var_212_4, var_212_4)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps10146 then
				for iter_212_4, iter_212_5 in pairs(arg_209_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_212_5 then
						iter_212_5.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps10146 = nil
			end

			local var_212_5 = arg_209_1.actors_["10146"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10146 = var_212_5.localPosition
				var_212_5.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10146", 3)

				for iter_212_6 = 0, var_212_5.childCount - 1 do
					local var_212_6 = var_212_5:GetChild(iter_212_6)

					if var_212_6.name == "split_3" or not string.find(var_212_6.name, "split") then
						var_212_6.gameObject:SetActive(true)
					else
						var_212_6.gameObject:SetActive(false)
					end
				end
			end

			local var_212_7 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				var_212_5.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_209_1.time_ - 0) / var_212_7)
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				var_212_5.localPosition = Vector3.New(0, -350, -320)
			end

			local var_212_8 = 0
			local var_212_9 = 0.85

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_10 = arg_209_1:GetWordFromCfg(423102051)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 34 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 34)

				if (34 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 34)) > 0 and var_212_9 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102051", "story_v_out_423102.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_out_423102", "423102051", "story_v_out_423102.awb") / 1000

					if var_212_14 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_8
					end

					if var_212_10.prefab_name ~= "" and arg_209_1.actors_[var_212_10.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_10.prefab_name].transform, "story_v_out_423102", "423102051", "story_v_out_423102.awb")

						arg_209_1:RecordAudio("423102051", var_212_15)
						arg_209_1:RecordAudio("423102051", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_423102", "423102051", "story_v_out_423102.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_423102", "423102051", "story_v_out_423102.awb")
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
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play423102052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 423102052
		arg_213_1.duration_ = 10.17

		local var_213_0 = {
			zh = 6.366,
			ja = 10.166
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
				arg_213_0:Play423102053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.85

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(423102052)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 34 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 34)

				if (34 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 34)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102052", "story_v_out_423102.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_423102", "423102052", "story_v_out_423102.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_423102", "423102052", "story_v_out_423102.awb")

						arg_213_1:RecordAudio("423102052", var_216_6)
						arg_213_1:RecordAudio("423102052", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_423102", "423102052", "story_v_out_423102.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_423102", "423102052", "story_v_out_423102.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play423102053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 423102053
		arg_217_1.duration_ = 9.3

		local var_217_0 = {
			zh = 6.5,
			ja = 9.3
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
				arg_217_0:Play423102054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.65

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(423102053)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 26 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 26)

				if (26 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 26)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102053", "story_v_out_423102.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_423102", "423102053", "story_v_out_423102.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_423102", "423102053", "story_v_out_423102.awb")

						arg_217_1:RecordAudio("423102053", var_220_6)
						arg_217_1:RecordAudio("423102053", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_423102", "423102053", "story_v_out_423102.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_423102", "423102053", "story_v_out_423102.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play423102054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 423102054
		arg_221_1.duration_ = 13.1

		local var_221_0 = {
			zh = 9.866,
			ja = 13.1
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
			arg_221_1.auto_ = false
		end

		function arg_221_1.playNext_(arg_223_0)
			arg_221_1.onStoryFinished_()
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10146 = arg_221_1.actors_["10146"].transform.localPosition
				arg_221_1.actors_["10146"].transform.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10146", 3)

				for iter_224_0 = 0, arg_221_1.actors_["10146"].transform.childCount - 1 do
					local var_224_0 = arg_221_1.actors_["10146"].transform:GetChild(iter_224_0)

					if var_224_0.name == "split_1" or not string.find(var_224_0.name, "split") then
						var_224_0.gameObject:SetActive(true)
					else
						var_224_0.gameObject:SetActive(false)
					end
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["10146"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_221_1.time_ - 0) / var_224_1)
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["10146"].transform.localPosition = Vector3.New(0, -350, -320)
			end

			local var_224_2 = 0
			local var_224_3 = 0.9

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_4 = arg_221_1:GetWordFromCfg(423102054)
				local var_224_5 = arg_221_1:FormatText(var_224_4.content)

				arg_221_1.text_.text = var_224_5

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_7 = 36 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 36)

				if (36 <= 0 and var_224_3 or var_224_3 * (utf8.len(var_224_5) / 36)) > 0 and var_224_3 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_2
					end
				end

				arg_221_1.text_.text = var_224_5
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423102", "423102054", "story_v_out_423102.awb") ~= 0 then
					local var_224_8 = manager.audio:GetVoiceLength("story_v_out_423102", "423102054", "story_v_out_423102.awb") / 1000

					if var_224_8 + var_224_2 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_8 + var_224_2
					end

					if var_224_4.prefab_name ~= "" and arg_221_1.actors_[var_224_4.prefab_name] ~= nil then
						local var_224_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_4.prefab_name].transform, "story_v_out_423102", "423102054", "story_v_out_423102.awb")

						arg_221_1:RecordAudio("423102054", var_224_9)
						arg_221_1:RecordAudio("423102054", var_224_9)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_423102", "423102054", "story_v_out_423102.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_423102", "423102054", "story_v_out_423102.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_10 = math.max(var_224_3, arg_221_1.talkMaxDuration)

			if var_224_2 <= arg_221_1.time_ and arg_221_1.time_ < var_224_2 + var_224_10 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_2) / var_224_10

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_2 + var_224_10 and arg_221_1.time_ < var_224_2 + var_224_10 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I25h",
		"TextureConfig/Background/L08g"
	},
	voices = {
		"story_v_out_423102.awb"
	}
}
