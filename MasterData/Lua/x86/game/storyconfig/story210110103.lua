return {
	Play1101103001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1101103001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1101103002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST18 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST18")
				var_4_0.name = "ST18"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST18 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST18

				arg_1_1.bgs_.ST18.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST18" then
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

			if 0.533333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.533333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")

				local var_4_16 = manager.audio:GetAudioName("bgm_side_daily01", "bgm_side_daily01")

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

			local var_4_17 = 2
			local var_4_18 = 0.275

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_19 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_19:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_20 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1101103001).content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 11 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_20) / 11)

				if (11 <= 0 and var_4_18 or var_4_18 * (utf8.len(var_4_20) / 11)) > 0 and var_4_18 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_17 = var_4_17 + 0.3

					if var_4_22 + var_4_17 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_17
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_23 = var_4_17 + 0.3
			local var_4_24 = math.max(var_4_18, arg_1_1.talkMaxDuration)

			if var_4_17 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_24 then
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
	Play1101103002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 1101103002
		arg_10_1.duration_ = 6.87

		local var_10_0 = {
			zh = 6.866,
			ja = 4.3
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play1101103003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = 0.725

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				arg_10_1.leftNameTxt_.text = arg_10_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, true)
				arg_10_1.iconController_:SetSelectedState("hero")

				arg_10_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_10_1.callingController_:SetSelectedState("normal")

				arg_10_1.keyicon_.color = Color.New(1, 1, 1)
				arg_10_1.icon_.color = Color.New(1, 1, 1)

				local var_13_1 = arg_10_1:GetWordFromCfg(1101103002)
				local var_13_2 = arg_10_1:FormatText(var_13_1.content)

				arg_10_1.text_.text = var_13_2

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_4 = 29 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_2) / 29)

				if (29 <= 0 and var_13_0 or var_13_0 * (utf8.len(var_13_2) / 29)) > 0 and var_13_0 < var_13_4 then
					arg_10_1.talkMaxDuration = var_13_4

					if var_13_4 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_4 + 0
					end
				end

				arg_10_1.text_.text = var_13_2
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103002", "story_v_side_new_1101103.awb") ~= 0 then
					local var_13_5 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103002", "story_v_side_new_1101103.awb") / 1000

					if var_13_5 + 0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_5 + 0
					end

					if var_13_1.prefab_name ~= "" and arg_10_1.actors_[var_13_1.prefab_name] ~= nil then
						local var_13_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_1.prefab_name].transform, "story_v_side_new_1101103", "1101103002", "story_v_side_new_1101103.awb")

						arg_10_1:RecordAudio("1101103002", var_13_6)
						arg_10_1:RecordAudio("1101103002", var_13_6)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103002", "story_v_side_new_1101103.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103002", "story_v_side_new_1101103.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_7 = math.max(var_13_0, arg_10_1.talkMaxDuration)

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_7 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - 0) / var_13_7

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= 0 + var_13_7 and arg_10_1.time_ < 0 + var_13_7 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play1101103003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 1101103003
		arg_14_1.duration_ = 9.27

		local var_14_0 = {
			zh = 6.066,
			ja = 9.266
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play1101103004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = 0.825

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_1 = arg_14_1:GetWordFromCfg(1101103003)
				local var_17_2 = arg_14_1:FormatText(var_17_1.content)

				arg_14_1.text_.text = var_17_2

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_4 = 33 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 33)

				if (33 <= 0 and var_17_0 or var_17_0 * (utf8.len(var_17_2) / 33)) > 0 and var_17_0 < var_17_4 then
					arg_14_1.talkMaxDuration = var_17_4

					if var_17_4 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_4 + 0
					end
				end

				arg_14_1.text_.text = var_17_2
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103003", "story_v_side_new_1101103.awb") ~= 0 then
					local var_17_5 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103003", "story_v_side_new_1101103.awb") / 1000

					if var_17_5 + 0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_5 + 0
					end

					if var_17_1.prefab_name ~= "" and arg_14_1.actors_[var_17_1.prefab_name] ~= nil then
						local var_17_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_1.prefab_name].transform, "story_v_side_new_1101103", "1101103003", "story_v_side_new_1101103.awb")

						arg_14_1:RecordAudio("1101103003", var_17_6)
						arg_14_1:RecordAudio("1101103003", var_17_6)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103003", "story_v_side_new_1101103.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103003", "story_v_side_new_1101103.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_7 = math.max(var_17_0, arg_14_1.talkMaxDuration)

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_7 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - 0) / var_17_7

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= 0 + var_17_7 and arg_14_1.time_ < 0 + var_17_7 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play1101103004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 1101103004
		arg_18_1.duration_ = 3.37

		local var_18_0 = {
			zh = 2.866,
			ja = 3.366
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play1101103005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0.35

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_1 = arg_18_1:GetWordFromCfg(1101103004)
				local var_21_2 = arg_18_1:FormatText(var_21_1.content)

				arg_18_1.text_.text = var_21_2

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 14 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 14)

				if (14 <= 0 and var_21_0 or var_21_0 * (utf8.len(var_21_2) / 14)) > 0 and var_21_0 < var_21_4 then
					arg_18_1.talkMaxDuration = var_21_4

					if var_21_4 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_4 + 0
					end
				end

				arg_18_1.text_.text = var_21_2
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103004", "story_v_side_new_1101103.awb") ~= 0 then
					local var_21_5 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103004", "story_v_side_new_1101103.awb") / 1000

					if var_21_5 + 0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_5 + 0
					end

					if var_21_1.prefab_name ~= "" and arg_18_1.actors_[var_21_1.prefab_name] ~= nil then
						local var_21_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_1.prefab_name].transform, "story_v_side_new_1101103", "1101103004", "story_v_side_new_1101103.awb")

						arg_18_1:RecordAudio("1101103004", var_21_6)
						arg_18_1:RecordAudio("1101103004", var_21_6)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103004", "story_v_side_new_1101103.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103004", "story_v_side_new_1101103.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_0, arg_18_1.talkMaxDuration)

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - 0) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= 0 + var_21_7 and arg_18_1.time_ < 0 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play1101103005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 1101103005
		arg_22_1.duration_ = 6.07

		local var_22_0 = {
			zh = 6.066,
			ja = 3.3
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
				arg_22_0:Play1101103006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.15

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_1 = arg_22_1:GetWordFromCfg(1101103005)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 6 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 6)

				if (6 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 6)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103005", "story_v_side_new_1101103.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103005", "story_v_side_new_1101103.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_side_new_1101103", "1101103005", "story_v_side_new_1101103.awb")

						arg_22_1:RecordAudio("1101103005", var_25_6)
						arg_22_1:RecordAudio("1101103005", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103005", "story_v_side_new_1101103.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103005", "story_v_side_new_1101103.awb")
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
	Play1101103006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 1101103006
		arg_26_1.duration_ = 9

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play1101103007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if arg_26_1.bgs_.ST19_blur == nil then
				local var_29_0 = Object.Instantiate(arg_26_1.paintGo_)

				var_29_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST19_blur")
				var_29_0.name = "ST19_blur"
				var_29_0.transform.parent = arg_26_1.stage_.transform
				var_29_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_26_1.bgs_.ST19_blur = var_29_0
			end

			if 2 < arg_26_1.time_ and arg_26_1.time_ <= 2 + arg_29_0 then
				local var_29_1 = arg_26_1.bgs_.ST19_blur

				arg_26_1.bgs_.ST19_blur.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_29_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_29_2 = var_29_1:GetComponent("SpriteRenderer")

				if var_29_2 and var_29_2.sprite then
					local var_29_3 = 2 * (var_29_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_29_1.transform.localScale = Vector3.New(var_29_3 / var_29_2.sprite.bounds.size.y < var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x and var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x or var_29_3 / var_29_2.sprite.bounds.size.y, var_29_3 / var_29_2.sprite.bounds.size.y < var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x and var_29_3 * manager.ui.mainCameraCom_.aspect / var_29_2.sprite.bounds.size.x or var_29_3 / var_29_2.sprite.bounds.size.y, 0)
				end

				for iter_29_0, iter_29_1 in pairs(arg_26_1.bgs_) do
					if iter_29_0 ~= "ST19_blur" then
						iter_29_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_29_4 = 0

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_5 = 2

			if var_29_4 <= arg_26_1.time_ and arg_26_1.time_ < var_29_4 + var_29_5 then
				local var_29_6 = Color.New(0, 0, 0)

				var_29_6.a = Mathf.Lerp(0, 1, (arg_26_1.time_ - var_29_4) / var_29_5)
				arg_26_1.mask_.color = var_29_6
			end

			if arg_26_1.time_ >= var_29_4 + var_29_5 and arg_26_1.time_ < var_29_4 + var_29_5 + arg_29_0 then
				local var_29_7 = Color.New(0, 0, 0)

				var_29_7.a = 1
				arg_26_1.mask_.color = var_29_7
			end

			local var_29_8 = 2

			if 2 < arg_26_1.time_ and arg_26_1.time_ <= var_29_8 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = true

				arg_26_1:SetGaussion(false)
			end

			local var_29_9 = 2

			if var_29_8 <= arg_26_1.time_ and arg_26_1.time_ < var_29_8 + var_29_9 then
				local var_29_10 = Color.New(0, 0, 0)

				var_29_10.a = Mathf.Lerp(1, 0, (arg_26_1.time_ - var_29_8) / var_29_9)
				arg_26_1.mask_.color = var_29_10
			end

			if arg_26_1.time_ >= var_29_8 + var_29_9 and arg_26_1.time_ < var_29_8 + var_29_9 + arg_29_0 then
				local var_29_11 = Color.New(0, 0, 0)

				arg_26_1.mask_.enabled = false
				var_29_11.a = 0
				arg_26_1.mask_.color = var_29_11
			end

			local var_29_12 = "ST19"

			if arg_26_1.bgs_.ST19 == nil then
				local var_29_13 = Object.Instantiate(arg_26_1.blurPaintGo_)

				var_29_13:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_29_12)
				var_29_13.name = var_29_12
				var_29_13.transform.parent = arg_26_1.stage_.transform
				var_29_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_26_1.bgs_[var_29_12] = var_29_13
			end

			local var_29_14 = 4
			local var_29_15 = arg_26_1.bgs_[var_29_12]

			if 4 < arg_26_1.time_ and arg_26_1.time_ <= var_29_14 + arg_29_0 then
				var_29_15.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_29_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_29_16 = var_29_15:GetComponent("SpriteRenderer")

				if var_29_16 and var_29_16.sprite then
					local var_29_17 = 2 * (var_29_15.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_29_15.transform.localScale = Vector3.New(var_29_17 / var_29_16.sprite.bounds.size.y < var_29_17 * manager.ui.mainCameraCom_.aspect / var_29_16.sprite.bounds.size.x and var_29_17 * manager.ui.mainCameraCom_.aspect / var_29_16.sprite.bounds.size.x or var_29_17 / var_29_16.sprite.bounds.size.y, var_29_17 / var_29_16.sprite.bounds.size.y < var_29_17 * manager.ui.mainCameraCom_.aspect / var_29_16.sprite.bounds.size.x and var_29_17 * manager.ui.mainCameraCom_.aspect / var_29_16.sprite.bounds.size.x or var_29_17 / var_29_16.sprite.bounds.size.y, 0)
				end
			end

			local var_29_18 = 2

			if var_29_14 <= arg_26_1.time_ and arg_26_1.time_ < var_29_14 + var_29_18 then
				local var_29_19 = Color.New(1, 1, 1)

				var_29_19.a = Mathf.Lerp(0, 1, (arg_26_1.time_ - var_29_14) / var_29_18)

				var_29_15:GetComponent("SpriteRenderer").material:SetColor("_Color", var_29_19)
			end

			if arg_26_1.frameCnt_ <= 1 then
				arg_26_1.dialog_:SetActive(false)
			end

			local var_29_20 = 4
			local var_29_21 = 1

			if 4 < arg_26_1.time_ and arg_26_1.time_ <= var_29_20 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				arg_26_1.dialog_:SetActive(true)

				arg_26_1.dialogCg_.alpha = 0

				local var_29_22 = LeanTween.value(arg_26_1.dialog_, 0, 1, 0.3)

				var_29_22:setOnUpdate(LuaHelper.FloatAction(function(arg_30_0)
					arg_26_1.dialogCg_.alpha = arg_30_0
				end))
				var_29_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_26_1.dialog_)
					var_29_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_26_1.duration_ = arg_26_1.duration_ + 0.3

				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_23 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(1101103006).content)

				arg_26_1.text_.text = var_29_23

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_25 = 40 <= 0 and var_29_21 or var_29_21 * (utf8.len(var_29_23) / 40)

				if (40 <= 0 and var_29_21 or var_29_21 * (utf8.len(var_29_23) / 40)) > 0 and var_29_21 < var_29_25 then
					arg_26_1.talkMaxDuration = var_29_25
					var_29_20 = var_29_20 + 0.3

					if var_29_25 + var_29_20 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_25 + var_29_20
					end
				end

				arg_26_1.text_.text = var_29_23
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_26 = var_29_20 + 0.3
			local var_29_27 = math.max(var_29_21, arg_26_1.talkMaxDuration)

			if var_29_20 + 0.3 <= arg_26_1.time_ and arg_26_1.time_ < var_29_26 + var_29_27 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_26) / var_29_27

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_26 + var_29_27 and arg_26_1.time_ < var_29_26 + var_29_27 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play1101103007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 1101103007
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play1101103008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.25

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_1 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(1101103007).content)

				arg_32_1.text_.text = var_35_1

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_3 = 10 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 10)

				if (10 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 10)) > 0 and var_35_0 < var_35_3 then
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
	Play1101103008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 1101103008
		arg_36_1.duration_ = 7.63

		local var_36_0 = {
			zh = 6.6,
			ja = 7.633
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
				arg_36_0:Play1101103009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if arg_36_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_39_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_36_1.stage_.transform)

				var_39_0.name = "1011ui_story"
				var_39_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1011ui_story"] = var_39_0

				local var_39_1 = var_39_0:GetComponentInChildren(typeof(CharacterEffect))

				var_39_1.enabled = true

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end

				arg_36_1:ShowWeapon(var_39_1.transform, false)

				arg_36_1.var_["1011ui_story" .. "Animator"] = var_39_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_36_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_36_1.var_["1011ui_story" .. "LipSync"] = var_39_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_39_3 = arg_36_1.actors_["1011ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1011ui_story = var_39_3.localPosition
			end

			local var_39_4 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				var_39_3.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_36_1.time_ - 0) / var_39_4)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				var_39_3.localPosition = Vector3.New(0, -0.71, -6)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			local var_39_5 = arg_36_1.actors_["1011ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1011ui_story == nil then
				arg_36_1.var_.characterEffect1011ui_story = var_39_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_6 and not isNil(var_39_5) then
				if arg_36_1.var_.characterEffect1011ui_story and not isNil(var_39_5) then
					arg_36_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_6 and arg_36_1.time_ < 0 + var_39_6 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1011ui_story then
				arg_36_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_39_8 = 0
			local var_39_9 = 0.575

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_10 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_10:setOnUpdate(LuaHelper.FloatAction(function(arg_40_0)
					arg_36_1.dialogCg_.alpha = arg_40_0
				end))
				var_39_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_11 = arg_36_1:GetWordFromCfg(1101103008)
				local var_39_12 = arg_36_1:FormatText(var_39_11.content)

				arg_36_1.text_.text = var_39_12

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_14 = 23 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_12) / 23)

				if (23 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_12) / 23)) > 0 and var_39_9 < var_39_14 then
					arg_36_1.talkMaxDuration = var_39_14
					var_39_8 = var_39_8 + 0.3

					if var_39_14 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_8
					end
				end

				arg_36_1.text_.text = var_39_12
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103008", "story_v_side_new_1101103.awb") ~= 0 then
					local var_39_15 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103008", "story_v_side_new_1101103.awb") / 1000

					if var_39_15 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_15 + var_39_8
					end

					if var_39_11.prefab_name ~= "" and arg_36_1.actors_[var_39_11.prefab_name] ~= nil then
						local var_39_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_11.prefab_name].transform, "story_v_side_new_1101103", "1101103008", "story_v_side_new_1101103.awb")

						arg_36_1:RecordAudio("1101103008", var_39_16)
						arg_36_1:RecordAudio("1101103008", var_39_16)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103008", "story_v_side_new_1101103.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103008", "story_v_side_new_1101103.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_17 = var_39_8 + 0.3
			local var_39_18 = math.max(var_39_9, arg_36_1.talkMaxDuration)

			if var_39_8 + 0.3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_17 + var_39_18 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_17) / var_39_18

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_17 + var_39_18 and arg_36_1.time_ < var_39_17 + var_39_18 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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

		arg_36_1:InitPlayNodeList()
	end,
	Play1101103009 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 1101103009
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play1101103010(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1011ui_story"]) and arg_42_1.var_.characterEffect1011ui_story == nil then
				arg_42_1.var_.characterEffect1011ui_story = arg_42_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_0 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1011ui_story"]) then
				if arg_42_1.var_.characterEffect1011ui_story and not isNil(arg_42_1.actors_["1011ui_story"]) then
					arg_42_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_0)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1011ui_story"]) and arg_42_1.var_.characterEffect1011ui_story then
				arg_42_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_45_1 = 0
			local var_45_2 = 0.25

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_3 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(1101103009).content)

				arg_42_1.text_.text = var_45_3

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 10 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_3) / 10)

				if (10 <= 0 and var_45_2 or var_45_2 * (utf8.len(var_45_3) / 10)) > 0 and var_45_2 < var_45_5 then
					arg_42_1.talkMaxDuration = var_45_5

					if var_45_5 + var_45_1 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_5 + var_45_1
					end
				end

				arg_42_1.text_.text = var_45_3
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_6 = math.max(var_45_2, arg_42_1.talkMaxDuration)

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_6 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_1) / var_45_6

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_1 + var_45_6 and arg_42_1.time_ < var_45_1 + var_45_6 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play1101103010 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 1101103010
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play1101103011(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 1.025

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_1 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(1101103010).content)

				arg_46_1.text_.text = var_49_1

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_3 = 41 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 41)

				if (41 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_1) / 41)) > 0 and var_49_0 < var_49_3 then
					arg_46_1.talkMaxDuration = var_49_3

					if var_49_3 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_3 + 0
					end
				end

				arg_46_1.text_.text = var_49_1
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_4 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_4

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play1101103011 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 1101103011
		arg_50_1.duration_ = 2.37

		local var_50_0 = {
			zh = 2.2,
			ja = 2.366
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
				arg_50_0:Play1101103012(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1011ui_story = arg_50_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_53_0 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 then
				arg_50_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_50_1.time_ - 0) / var_53_0)
				arg_50_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1011ui_story"].transform.position).z)
				arg_50_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1011ui_story"].transform.localEulerAngles = arg_50_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 then
				arg_50_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_50_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_50_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_50_1.actors_["1011ui_story"].transform.position).z)
				arg_50_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_50_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_50_1.actors_["1011ui_story"].transform.localEulerAngles = arg_50_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_53_1 = arg_50_1.actors_["1011ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_1) and arg_50_1.var_.characterEffect1011ui_story == nil then
				arg_50_1.var_.characterEffect1011ui_story = var_53_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_2 and not isNil(var_53_1) then
				if arg_50_1.var_.characterEffect1011ui_story and not isNil(var_53_1) then
					arg_50_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_2 and arg_50_1.time_ < 0 + var_53_2 + arg_53_0 and not isNil(var_53_1) and arg_50_1.var_.characterEffect1011ui_story then
				arg_50_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_53_4 = 0
			local var_53_5 = 0.2

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_6 = arg_50_1:GetWordFromCfg(1101103011)
				local var_53_7 = arg_50_1:FormatText(var_53_6.content)

				arg_50_1.text_.text = var_53_7

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_9 = 8 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 8)

				if (8 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 8)) > 0 and var_53_5 < var_53_9 then
					arg_50_1.talkMaxDuration = var_53_9

					if var_53_9 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_4
					end
				end

				arg_50_1.text_.text = var_53_7
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103011", "story_v_side_new_1101103.awb") ~= 0 then
					local var_53_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103011", "story_v_side_new_1101103.awb") / 1000

					if var_53_10 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_4
					end

					if var_53_6.prefab_name ~= "" and arg_50_1.actors_[var_53_6.prefab_name] ~= nil then
						local var_53_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_6.prefab_name].transform, "story_v_side_new_1101103", "1101103011", "story_v_side_new_1101103.awb")

						arg_50_1:RecordAudio("1101103011", var_53_11)
						arg_50_1:RecordAudio("1101103011", var_53_11)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103011", "story_v_side_new_1101103.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103011", "story_v_side_new_1101103.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_12 = math.max(var_53_5, arg_50_1.talkMaxDuration)

			if var_53_4 <= arg_50_1.time_ and arg_50_1.time_ < var_53_4 + var_53_12 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_4) / var_53_12

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_4 + var_53_12 and arg_50_1.time_ < var_53_4 + var_53_12 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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

		arg_50_1:InitPlayNodeList()
	end,
	Play1101103012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 1101103012
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play1101103013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1011ui_story = arg_54_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_57_0 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 then
				arg_54_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_54_1.time_ - 0) / var_57_0)
				arg_54_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1011ui_story"].transform.position).z)
				arg_54_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1011ui_story"].transform.localEulerAngles = arg_54_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 then
				arg_54_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1011ui_story"].transform.position).z)
				arg_54_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1011ui_story"].transform.localEulerAngles = arg_54_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_57_1 = arg_54_1.actors_["1011ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect1011ui_story == nil then
				arg_54_1.var_.characterEffect1011ui_story = var_57_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_2 and not isNil(var_57_1) then
				if arg_54_1.var_.characterEffect1011ui_story and not isNil(var_57_1) then
					arg_54_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_2)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_2 and arg_54_1.time_ < 0 + var_57_2 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect1011ui_story then
				arg_54_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_57_3 = 0
			local var_57_4 = 0.5

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_3 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_5 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(1101103012).content)

				arg_54_1.text_.text = var_57_5

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_7 = 20 <= 0 and var_57_4 or var_57_4 * (utf8.len(var_57_5) / 20)

				if (20 <= 0 and var_57_4 or var_57_4 * (utf8.len(var_57_5) / 20)) > 0 and var_57_4 < var_57_7 then
					arg_54_1.talkMaxDuration = var_57_7

					if var_57_7 + var_57_3 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_7 + var_57_3
					end
				end

				arg_54_1.text_.text = var_57_5
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_8 = math.max(var_57_4, arg_54_1.talkMaxDuration)

			if var_57_3 <= arg_54_1.time_ and arg_54_1.time_ < var_57_3 + var_57_8 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_3) / var_57_8

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_3 + var_57_8 and arg_54_1.time_ < var_57_3 + var_57_8 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
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

		arg_54_1:InitPlayNodeList()
	end,
	Play1101103013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 1101103013
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play1101103014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0.5

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_1 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(1101103013).content)

				arg_58_1.text_.text = var_61_1

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_3 = 20 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_1) / 20)

				if (20 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_1) / 20)) > 0 and var_61_0 < var_61_3 then
					arg_58_1.talkMaxDuration = var_61_3

					if var_61_3 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_3 + 0
					end
				end

				arg_58_1.text_.text = var_61_1
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_4 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_4 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_4

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_4 and arg_58_1.time_ < 0 + var_61_4 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play1101103014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 1101103014
		arg_62_1.duration_ = 6.37

		local var_62_0 = {
			zh = 4.566,
			ja = 6.366
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
				arg_62_0:Play1101103015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.575

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_1 = arg_62_1:GetWordFromCfg(1101103014)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 23 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 23)

				if (23 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 23)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103014", "story_v_side_new_1101103.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103014", "story_v_side_new_1101103.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_side_new_1101103", "1101103014", "story_v_side_new_1101103.awb")

						arg_62_1:RecordAudio("1101103014", var_65_6)
						arg_62_1:RecordAudio("1101103014", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103014", "story_v_side_new_1101103.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103014", "story_v_side_new_1101103.awb")
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
	Play1101103015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 1101103015
		arg_66_1.duration_ = 9

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play1101103016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if arg_66_1.bgs_.ST19 == nil then
				local var_69_0 = Object.Instantiate(arg_66_1.paintGo_)

				var_69_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST19")
				var_69_0.name = "ST19"
				var_69_0.transform.parent = arg_66_1.stage_.transform
				var_69_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.bgs_.ST19 = var_69_0
			end

			if 2 < arg_66_1.time_ and arg_66_1.time_ <= 2 + arg_69_0 then
				local var_69_1 = arg_66_1.bgs_.ST19

				arg_66_1.bgs_.ST19.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_69_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_69_2 = var_69_1:GetComponent("SpriteRenderer")

				if var_69_2 and var_69_2.sprite then
					local var_69_3 = 2 * (var_69_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_69_1.transform.localScale = Vector3.New(var_69_3 / var_69_2.sprite.bounds.size.y < var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x and var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x or var_69_3 / var_69_2.sprite.bounds.size.y, var_69_3 / var_69_2.sprite.bounds.size.y < var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x and var_69_3 * manager.ui.mainCameraCom_.aspect / var_69_2.sprite.bounds.size.x or var_69_3 / var_69_2.sprite.bounds.size.y, 0)
				end

				for iter_69_0, iter_69_1 in pairs(arg_66_1.bgs_) do
					if iter_69_0 ~= "ST19" then
						iter_69_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_69_4 = 0

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_5 = 2

			if var_69_4 <= arg_66_1.time_ and arg_66_1.time_ < var_69_4 + var_69_5 then
				local var_69_6 = Color.New(0, 0, 0)

				var_69_6.a = Mathf.Lerp(0, 1, (arg_66_1.time_ - var_69_4) / var_69_5)
				arg_66_1.mask_.color = var_69_6
			end

			if arg_66_1.time_ >= var_69_4 + var_69_5 and arg_66_1.time_ < var_69_4 + var_69_5 + arg_69_0 then
				local var_69_7 = Color.New(0, 0, 0)

				var_69_7.a = 1
				arg_66_1.mask_.color = var_69_7
			end

			local var_69_8 = 2

			if 2 < arg_66_1.time_ and arg_66_1.time_ <= var_69_8 + arg_69_0 then
				arg_66_1.mask_.enabled = true
				arg_66_1.mask_.raycastTarget = true

				arg_66_1:SetGaussion(false)
			end

			local var_69_9 = 2

			if var_69_8 <= arg_66_1.time_ and arg_66_1.time_ < var_69_8 + var_69_9 then
				local var_69_10 = Color.New(0, 0, 0)

				var_69_10.a = Mathf.Lerp(1, 0, (arg_66_1.time_ - var_69_8) / var_69_9)
				arg_66_1.mask_.color = var_69_10
			end

			if arg_66_1.time_ >= var_69_8 + var_69_9 and arg_66_1.time_ < var_69_8 + var_69_9 + arg_69_0 then
				local var_69_11 = Color.New(0, 0, 0)

				arg_66_1.mask_.enabled = false
				var_69_11.a = 0
				arg_66_1.mask_.color = var_69_11
			end

			if arg_66_1.frameCnt_ <= 1 then
				arg_66_1.dialog_:SetActive(false)
			end

			local var_69_12 = 4
			local var_69_13 = 0.625

			if 4 < arg_66_1.time_ and arg_66_1.time_ <= var_69_12 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0

				arg_66_1.dialog_:SetActive(true)

				arg_66_1.dialogCg_.alpha = 0

				local var_69_14 = LeanTween.value(arg_66_1.dialog_, 0, 1, 0.3)

				var_69_14:setOnUpdate(LuaHelper.FloatAction(function(arg_70_0)
					arg_66_1.dialogCg_.alpha = arg_70_0
				end))
				var_69_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_66_1.dialog_)
					var_69_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_66_1.duration_ = arg_66_1.duration_ + 0.3

				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_15 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(1101103015).content)

				arg_66_1.text_.text = var_69_15

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_17 = 25 <= 0 and var_69_13 or var_69_13 * (utf8.len(var_69_15) / 25)

				if (25 <= 0 and var_69_13 or var_69_13 * (utf8.len(var_69_15) / 25)) > 0 and var_69_13 < var_69_17 then
					arg_66_1.talkMaxDuration = var_69_17
					var_69_12 = var_69_12 + 0.3

					if var_69_17 + var_69_12 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_17 + var_69_12
					end
				end

				arg_66_1.text_.text = var_69_15
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_18 = var_69_12 + 0.3
			local var_69_19 = math.max(var_69_13, arg_66_1.talkMaxDuration)

			if var_69_12 + 0.3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_18 + var_69_19 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_18) / var_69_19

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_18 + var_69_19 and arg_66_1.time_ < var_69_18 + var_69_19 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play1101103016 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 1101103016
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play1101103017(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.575

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(1101103016).content)

				arg_72_1.text_.text = var_75_1

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_3 = 23 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 23)

				if (23 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_1) / 23)) > 0 and var_75_0 < var_75_3 then
					arg_72_1.talkMaxDuration = var_75_3

					if var_75_3 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_3 + 0
					end
				end

				arg_72_1.text_.text = var_75_1
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_4 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_4 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_4

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_4 and arg_72_1.time_ < 0 + var_75_4 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play1101103017 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 1101103017
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play1101103018(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.75

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(1101103017).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 30 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 30)

				if (30 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 30)) > 0 and var_79_0 < var_79_3 then
					arg_76_1.talkMaxDuration = var_79_3

					if var_79_3 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_3 + 0
					end
				end

				arg_76_1.text_.text = var_79_1
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_4 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_4

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play1101103018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 1101103018
		arg_80_1.duration_ = 2

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play1101103019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if arg_80_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_83_0 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_80_1.stage_.transform)

				var_83_0.name = "1111ui_story"
				var_83_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_["1111ui_story"] = var_83_0

				local var_83_1 = var_83_0:GetComponentInChildren(typeof(CharacterEffect))

				var_83_1.enabled = true

				local var_83_2 = GameObjectTools.GetOrAddComponent(var_83_0, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(false)
				end

				arg_80_1:ShowWeapon(var_83_1.transform, false)

				arg_80_1.var_["1111ui_story" .. "Animator"] = var_83_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_80_1.var_["1111ui_story" .. "Animator"].applyRootMotion = true
				arg_80_1.var_["1111ui_story" .. "LipSync"] = var_83_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_83_3 = arg_80_1.actors_["1111ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1111ui_story = var_83_3.localPosition
			end

			local var_83_4 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				var_83_3.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_80_1.time_ - 0) / var_83_4)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				var_83_3.localPosition = Vector3.New(0, -0.87, -5.7)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			local var_83_5 = arg_80_1.actors_["1111ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_5) and arg_80_1.var_.characterEffect1111ui_story == nil then
				arg_80_1.var_.characterEffect1111ui_story = var_83_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_6 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_6 and not isNil(var_83_5) then
				if arg_80_1.var_.characterEffect1111ui_story and not isNil(var_83_5) then
					arg_80_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_6 and arg_80_1.time_ < 0 + var_83_6 + arg_83_0 and not isNil(var_83_5) and arg_80_1.var_.characterEffect1111ui_story then
				arg_80_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_83_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_80_1.bgmTxt_.text ~= var_83_10 and arg_80_1.bgmTxt_.text ~= "" then
						if arg_80_1.bgmTxt2_.text ~= "" then
							arg_80_1.bgmTxt_.text = arg_80_1.bgmTxt2_.text
						end

						arg_80_1.bgmTxt2_.text = var_83_10

						arg_80_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_80_1.bgmTxt_.text = var_83_10
						arg_80_1.bgmTxt2_.text = var_83_10
					end

					if arg_80_1.bgmTimer then
						arg_80_1.bgmTimer:Stop()

						arg_80_1.bgmTimer = nil
					end

					if arg_80_1.settingData.show_music_name == 1 then
						arg_80_1.musicController:SetSelectedState("show")
						arg_80_1.musicAnimator_:Play("open", 0, 0)

						if arg_80_1.settingData.music_time ~= 0 then
							arg_80_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_80_1.settingData.music_time), function()
								if arg_80_1 == nil or isNil(arg_80_1.bgmTxt_) then
									return
								end

								arg_80_1.musicController:SetSelectedState("hide")
								arg_80_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.533333333333333 < arg_80_1.time_ and arg_80_1.time_ <= 0.533333333333333 + arg_83_0 then
				arg_80_1:AudioAction("play", "music", "bgm_side_daily06", "bgm_side_daily06", "bgm_side_daily06.awb")

				local var_83_13 = manager.audio:GetAudioName("bgm_side_daily06", "bgm_side_daily06")

				if "" ~= "" then
					if arg_80_1.bgmTxt_.text ~= var_83_13 and arg_80_1.bgmTxt_.text ~= "" then
						if arg_80_1.bgmTxt2_.text ~= "" then
							arg_80_1.bgmTxt_.text = arg_80_1.bgmTxt2_.text
						end

						arg_80_1.bgmTxt2_.text = var_83_13

						arg_80_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_80_1.bgmTxt_.text = var_83_13
						arg_80_1.bgmTxt2_.text = var_83_13
					end

					if arg_80_1.bgmTimer then
						arg_80_1.bgmTimer:Stop()

						arg_80_1.bgmTimer = nil
					end

					if arg_80_1.settingData.show_music_name == 1 then
						arg_80_1.musicController:SetSelectedState("show")
						arg_80_1.musicAnimator_:Play("open", 0, 0)

						if arg_80_1.settingData.music_time ~= 0 then
							arg_80_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_80_1.settingData.music_time), function()
								if arg_80_1 == nil or isNil(arg_80_1.bgmTxt_) then
									return
								end

								arg_80_1.musicController:SetSelectedState("hide")
								arg_80_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_83_14 = 0
			local var_83_15 = 0.05

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_16 = arg_80_1:GetWordFromCfg(1101103018)
				local var_83_17 = arg_80_1:FormatText(var_83_16.content)

				arg_80_1.text_.text = var_83_17

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_19 = 2 <= 0 and var_83_15 or var_83_15 * (utf8.len(var_83_17) / 2)

				if (2 <= 0 and var_83_15 or var_83_15 * (utf8.len(var_83_17) / 2)) > 0 and var_83_15 < var_83_19 then
					arg_80_1.talkMaxDuration = var_83_19

					if var_83_19 + var_83_14 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_19 + var_83_14
					end
				end

				arg_80_1.text_.text = var_83_17
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103018", "story_v_side_new_1101103.awb") ~= 0 then
					local var_83_20 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103018", "story_v_side_new_1101103.awb") / 1000

					if var_83_20 + var_83_14 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_20 + var_83_14
					end

					if var_83_16.prefab_name ~= "" and arg_80_1.actors_[var_83_16.prefab_name] ~= nil then
						local var_83_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_16.prefab_name].transform, "story_v_side_new_1101103", "1101103018", "story_v_side_new_1101103.awb")

						arg_80_1:RecordAudio("1101103018", var_83_21)
						arg_80_1:RecordAudio("1101103018", var_83_21)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103018", "story_v_side_new_1101103.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103018", "story_v_side_new_1101103.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_22 = math.max(var_83_15, arg_80_1.talkMaxDuration)

			if var_83_14 <= arg_80_1.time_ and arg_80_1.time_ < var_83_14 + var_83_22 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_14) / var_83_22

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_14 + var_83_22 and arg_80_1.time_ < var_83_14 + var_83_22 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play1101103019 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 1101103019
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play1101103020(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1111ui_story = arg_86_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_89_0 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				arg_86_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_0)
				arg_86_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1111ui_story"].transform.position).z)
				arg_86_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1111ui_story"].transform.localEulerAngles = arg_86_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				arg_86_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1111ui_story"].transform.position).z)
				arg_86_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1111ui_story"].transform.localEulerAngles = arg_86_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_89_1 = 0
			local var_89_2 = 0.575

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_3 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(1101103019).content)

				arg_86_1.text_.text = var_89_3

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 23 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 23)

				if (23 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 23)) > 0 and var_89_2 < var_89_5 then
					arg_86_1.talkMaxDuration = var_89_5

					if var_89_5 + var_89_1 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + var_89_1
					end
				end

				arg_86_1.text_.text = var_89_3
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_6 = math.max(var_89_2, arg_86_1.talkMaxDuration)

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_6 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_1) / var_89_6

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_1 + var_89_6 and arg_86_1.time_ < var_89_1 + var_89_6 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play1101103020 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 1101103020
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play1101103021(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.175

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(1101103020).content)

				arg_90_1.text_.text = var_93_1

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_3 = 7 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 7)

				if (7 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 7)) > 0 and var_93_0 < var_93_3 then
					arg_90_1.talkMaxDuration = var_93_3

					if var_93_3 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_3 + 0
					end
				end

				arg_90_1.text_.text = var_93_1
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_4 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_4

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play1101103021 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 1101103021
		arg_94_1.duration_ = 4.13

		local var_94_0 = {
			zh = 4.133,
			ja = 3.2
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play1101103022(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.175

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_1 = arg_94_1:GetWordFromCfg(1101103021)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 7 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 7)

				if (7 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 7)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103021", "story_v_side_new_1101103.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103021", "story_v_side_new_1101103.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_side_new_1101103", "1101103021", "story_v_side_new_1101103.awb")

						arg_94_1:RecordAudio("1101103021", var_97_6)
						arg_94_1:RecordAudio("1101103021", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103021", "story_v_side_new_1101103.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103021", "story_v_side_new_1101103.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play1101103022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 1101103022
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play1101103023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos1111ui_story = arg_98_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_101_0 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 then
				arg_98_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_98_1.time_ - 0) / var_101_0)
				arg_98_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1111ui_story"].transform.position).z)
				arg_98_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["1111ui_story"].transform.localEulerAngles = arg_98_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 then
				arg_98_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_98_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["1111ui_story"].transform.position).z)
				arg_98_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["1111ui_story"].transform.localEulerAngles = arg_98_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_101_1 = arg_98_1.actors_["1111ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect1111ui_story == nil then
				arg_98_1.var_.characterEffect1111ui_story = var_101_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_2 and not isNil(var_101_1) then
				if arg_98_1.var_.characterEffect1111ui_story and not isNil(var_101_1) then
					arg_98_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_2 and arg_98_1.time_ < 0 + var_101_2 + arg_101_0 and not isNil(var_101_1) and arg_98_1.var_.characterEffect1111ui_story then
				arg_98_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_101_4 = 0
			local var_101_5 = 0.775

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_6 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(1101103022).content)

				arg_98_1.text_.text = var_101_6

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_8 = 31 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_6) / 31)

				if (31 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_6) / 31)) > 0 and var_101_5 < var_101_8 then
					arg_98_1.talkMaxDuration = var_101_8

					if var_101_8 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_8 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_6
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_9 = math.max(var_101_5, arg_98_1.talkMaxDuration)

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_9 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_4) / var_101_9

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_4 + var_101_9 and arg_98_1.time_ < var_101_4 + var_101_9 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play1101103023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 1101103023
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play1101103024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1111ui_story = arg_102_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_105_0 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 then
				arg_102_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_0)
				arg_102_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1111ui_story"].transform.position).z)
				arg_102_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1111ui_story"].transform.localEulerAngles = arg_102_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 then
				arg_102_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_102_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_102_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_102_1.actors_["1111ui_story"].transform.position).z)
				arg_102_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_102_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_102_1.actors_["1111ui_story"].transform.localEulerAngles = arg_102_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_105_1 = 0
			local var_105_2 = 0.625

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_3 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(1101103023).content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 25 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 25)

				if (25 <= 0 and var_105_2 or var_105_2 * (utf8.len(var_105_3) / 25)) > 0 and var_105_2 < var_105_5 then
					arg_102_1.talkMaxDuration = var_105_5

					if var_105_5 + var_105_1 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_5 + var_105_1
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_6 = math.max(var_105_2, arg_102_1.talkMaxDuration)

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_6 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_1) / var_105_6

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_1 + var_105_6 and arg_102_1.time_ < var_105_1 + var_105_6 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play1101103024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 1101103024
		arg_106_1.duration_ = 5.73

		local var_106_0 = {
			zh = 2.6,
			ja = 5.733
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
				arg_106_0:Play1101103025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1111ui_story = arg_106_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_109_0 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 then
				arg_106_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_106_1.time_ - 0) / var_109_0)
				arg_106_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1111ui_story"].transform.position).z)
				arg_106_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1111ui_story"].transform.localEulerAngles = arg_106_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 then
				arg_106_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_106_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["1111ui_story"].transform.position).z)
				arg_106_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["1111ui_story"].transform.localEulerAngles = arg_106_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_109_1 = arg_106_1.actors_["1111ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect1111ui_story == nil then
				arg_106_1.var_.characterEffect1111ui_story = var_109_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_2 and not isNil(var_109_1) then
				if arg_106_1.var_.characterEffect1111ui_story and not isNil(var_109_1) then
					arg_106_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_2)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_2 and arg_106_1.time_ < 0 + var_109_2 + arg_109_0 and not isNil(var_109_1) and arg_106_1.var_.characterEffect1111ui_story then
				arg_106_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_109_3 = arg_106_1.actors_["1011ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos1011ui_story = var_109_3.localPosition
			end

			local var_109_4 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 then
				var_109_3.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_106_1.time_ - 0) / var_109_4)
				var_109_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_3.position).x, (manager.ui.mainCamera.transform.position - var_109_3.position).y, (manager.ui.mainCamera.transform.position - var_109_3.position).z)
				var_109_3.localEulerAngles.z = 0
				var_109_3.localEulerAngles.x = 0
				var_109_3.localEulerAngles = var_109_3.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 then
				var_109_3.localPosition = Vector3.New(0, -0.71, -6)
				var_109_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_3.position).x, (manager.ui.mainCamera.transform.position - var_109_3.position).y, (manager.ui.mainCamera.transform.position - var_109_3.position).z)
				var_109_3.localEulerAngles.z = 0
				var_109_3.localEulerAngles.x = 0
				var_109_3.localEulerAngles = var_109_3.localEulerAngles
			end

			local var_109_5 = arg_106_1.actors_["1011ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_5) and arg_106_1.var_.characterEffect1011ui_story == nil then
				arg_106_1.var_.characterEffect1011ui_story = var_109_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_6 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_6 and not isNil(var_109_5) then
				if arg_106_1.var_.characterEffect1011ui_story and not isNil(var_109_5) then
					arg_106_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_6 and arg_106_1.time_ < 0 + var_109_6 + arg_109_0 and not isNil(var_109_5) and arg_106_1.var_.characterEffect1011ui_story then
				arg_106_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_109_8 = 0
			local var_109_9 = 0.275

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_8 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_10 = arg_106_1:GetWordFromCfg(1101103024)
				local var_109_11 = arg_106_1:FormatText(var_109_10.content)

				arg_106_1.text_.text = var_109_11

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_13 = 11 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_11) / 11)

				if (11 <= 0 and var_109_9 or var_109_9 * (utf8.len(var_109_11) / 11)) > 0 and var_109_9 < var_109_13 then
					arg_106_1.talkMaxDuration = var_109_13

					if var_109_13 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_13 + var_109_8
					end
				end

				arg_106_1.text_.text = var_109_11
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103024", "story_v_side_new_1101103.awb") ~= 0 then
					local var_109_14 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103024", "story_v_side_new_1101103.awb") / 1000

					if var_109_14 + var_109_8 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_14 + var_109_8
					end

					if var_109_10.prefab_name ~= "" and arg_106_1.actors_[var_109_10.prefab_name] ~= nil then
						local var_109_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_10.prefab_name].transform, "story_v_side_new_1101103", "1101103024", "story_v_side_new_1101103.awb")

						arg_106_1:RecordAudio("1101103024", var_109_15)
						arg_106_1:RecordAudio("1101103024", var_109_15)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103024", "story_v_side_new_1101103.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103024", "story_v_side_new_1101103.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_16 = math.max(var_109_9, arg_106_1.talkMaxDuration)

			if var_109_8 <= arg_106_1.time_ and arg_106_1.time_ < var_109_8 + var_109_16 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_8) / var_109_16

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_8 + var_109_16 and arg_106_1.time_ < var_109_8 + var_109_16 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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

		arg_106_1:InitPlayNodeList()
	end,
	Play1101103025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 1101103025
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play1101103026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1011ui_story"]) and arg_110_1.var_.characterEffect1011ui_story == nil then
				arg_110_1.var_.characterEffect1011ui_story = arg_110_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1011ui_story"]) then
				if arg_110_1.var_.characterEffect1011ui_story and not isNil(arg_110_1.actors_["1011ui_story"]) then
					arg_110_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_0)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1011ui_story"]) and arg_110_1.var_.characterEffect1011ui_story then
				arg_110_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_113_1 = 0
			local var_113_2 = 1.05

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(1101103025).content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_5 = 42 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 42)

				if (42 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_3) / 42)) > 0 and var_113_2 < var_113_5 then
					arg_110_1.talkMaxDuration = var_113_5

					if var_113_5 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + var_113_1
					end
				end

				arg_110_1.text_.text = var_113_3
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_6 = math.max(var_113_2, arg_110_1.talkMaxDuration)

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_6 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_1) / var_113_6

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_1 + var_113_6 and arg_110_1.time_ < var_113_1 + var_113_6 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play1101103026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 1101103026
		arg_114_1.duration_ = 9.53

		local var_114_0 = {
			zh = 9.266,
			ja = 9.533
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
				arg_114_0:Play1101103027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1011ui_story = arg_114_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_117_0 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 then
				arg_114_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_114_1.time_ - 0) / var_117_0)
				arg_114_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1011ui_story"].transform.position).z)
				arg_114_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1011ui_story"].transform.localEulerAngles = arg_114_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 then
				arg_114_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_114_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1011ui_story"].transform.position).z)
				arg_114_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1011ui_story"].transform.localEulerAngles = arg_114_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_117_1 = arg_114_1.actors_["1011ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_1) and arg_114_1.var_.characterEffect1011ui_story == nil then
				arg_114_1.var_.characterEffect1011ui_story = var_117_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_2 and not isNil(var_117_1) then
				if arg_114_1.var_.characterEffect1011ui_story and not isNil(var_117_1) then
					arg_114_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_2 and arg_114_1.time_ < 0 + var_117_2 + arg_117_0 and not isNil(var_117_1) and arg_114_1.var_.characterEffect1011ui_story then
				arg_114_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action7_1")
			end

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_117_4 = 0
			local var_117_5 = 1

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_4 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_6 = arg_114_1:GetWordFromCfg(1101103026)
				local var_117_7 = arg_114_1:FormatText(var_117_6.content)

				arg_114_1.text_.text = var_117_7

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_9 = 40 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 40)

				if (40 <= 0 and var_117_5 or var_117_5 * (utf8.len(var_117_7) / 40)) > 0 and var_117_5 < var_117_9 then
					arg_114_1.talkMaxDuration = var_117_9

					if var_117_9 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_4
					end
				end

				arg_114_1.text_.text = var_117_7
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103026", "story_v_side_new_1101103.awb") ~= 0 then
					local var_117_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103026", "story_v_side_new_1101103.awb") / 1000

					if var_117_10 + var_117_4 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_10 + var_117_4
					end

					if var_117_6.prefab_name ~= "" and arg_114_1.actors_[var_117_6.prefab_name] ~= nil then
						local var_117_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_6.prefab_name].transform, "story_v_side_new_1101103", "1101103026", "story_v_side_new_1101103.awb")

						arg_114_1:RecordAudio("1101103026", var_117_11)
						arg_114_1:RecordAudio("1101103026", var_117_11)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103026", "story_v_side_new_1101103.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103026", "story_v_side_new_1101103.awb")
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

		arg_114_1.nodeConfigList_ = {
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

		arg_114_1:InitPlayNodeList()
	end,
	Play1101103027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 1101103027
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play1101103028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1011ui_story"]) and arg_118_1.var_.characterEffect1011ui_story == nil then
				arg_118_1.var_.characterEffect1011ui_story = arg_118_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1011ui_story"]) then
				if arg_118_1.var_.characterEffect1011ui_story and not isNil(arg_118_1.actors_["1011ui_story"]) then
					arg_118_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_0)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1011ui_story"]) and arg_118_1.var_.characterEffect1011ui_story then
				arg_118_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_121_1 = 0
			local var_121_2 = 0.5

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, true)
				arg_118_1.iconController_:SetSelectedState("hero")

				arg_118_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_118_1.callingController_:SetSelectedState("normal")

				arg_118_1.keyicon_.color = Color.New(1, 1, 1)
				arg_118_1.icon_.color = Color.New(1, 1, 1)

				local var_121_3 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(1101103027).content)

				arg_118_1.text_.text = var_121_3

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_5 = 20 <= 0 and var_121_2 or var_121_2 * (utf8.len(var_121_3) / 20)

				if (20 <= 0 and var_121_2 or var_121_2 * (utf8.len(var_121_3) / 20)) > 0 and var_121_2 < var_121_5 then
					arg_118_1.talkMaxDuration = var_121_5

					if var_121_5 + var_121_1 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + var_121_1
					end
				end

				arg_118_1.text_.text = var_121_3
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_6 = math.max(var_121_2, arg_118_1.talkMaxDuration)

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_6 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_1) / var_121_6

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_1 + var_121_6 and arg_118_1.time_ < var_121_1 + var_121_6 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play1101103028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 1101103028
		arg_122_1.duration_ = 5.9

		local var_122_0 = {
			zh = 3.366,
			ja = 5.9
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
				arg_122_0:Play1101103029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1011ui_story = arg_122_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_125_0 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 then
				arg_122_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_122_1.time_ - 0) / var_125_0)
				arg_122_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1011ui_story"].transform.position).z)
				arg_122_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1011ui_story"].transform.localEulerAngles = arg_122_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 then
				arg_122_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_122_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["1011ui_story"].transform.position).z)
				arg_122_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["1011ui_story"].transform.localEulerAngles = arg_122_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_125_1 = arg_122_1.actors_["1011ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect1011ui_story == nil then
				arg_122_1.var_.characterEffect1011ui_story = var_125_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_2 and not isNil(var_125_1) then
				if arg_122_1.var_.characterEffect1011ui_story and not isNil(var_125_1) then
					arg_122_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_2 and arg_122_1.time_ < 0 + var_125_2 + arg_125_0 and not isNil(var_125_1) and arg_122_1.var_.characterEffect1011ui_story then
				arg_122_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1302cva")
			end

			local var_125_4 = 0
			local var_125_5 = 0.425

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_4 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_6 = arg_122_1:GetWordFromCfg(1101103028)
				local var_125_7 = arg_122_1:FormatText(var_125_6.content)

				arg_122_1.text_.text = var_125_7

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_9 = 17 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 17)

				if (17 <= 0 and var_125_5 or var_125_5 * (utf8.len(var_125_7) / 17)) > 0 and var_125_5 < var_125_9 then
					arg_122_1.talkMaxDuration = var_125_9

					if var_125_9 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_4
					end
				end

				arg_122_1.text_.text = var_125_7
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103028", "story_v_side_new_1101103.awb") ~= 0 then
					local var_125_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103028", "story_v_side_new_1101103.awb") / 1000

					if var_125_10 + var_125_4 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_10 + var_125_4
					end

					if var_125_6.prefab_name ~= "" and arg_122_1.actors_[var_125_6.prefab_name] ~= nil then
						local var_125_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_6.prefab_name].transform, "story_v_side_new_1101103", "1101103028", "story_v_side_new_1101103.awb")

						arg_122_1:RecordAudio("1101103028", var_125_11)
						arg_122_1:RecordAudio("1101103028", var_125_11)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103028", "story_v_side_new_1101103.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103028", "story_v_side_new_1101103.awb")
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

		arg_122_1.nodeConfigList_ = {
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

		arg_122_1:InitPlayNodeList()
	end,
	Play1101103029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 1101103029
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play1101103030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["1011ui_story"]) and arg_126_1.var_.characterEffect1011ui_story == nil then
				arg_126_1.var_.characterEffect1011ui_story = arg_126_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["1011ui_story"]) then
				if arg_126_1.var_.characterEffect1011ui_story and not isNil(arg_126_1.actors_["1011ui_story"]) then
					arg_126_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_0)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["1011ui_story"]) and arg_126_1.var_.characterEffect1011ui_story then
				arg_126_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action7_2")
			end

			local var_129_1 = 0
			local var_129_2 = 0.375

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_3 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(1101103029).content)

				arg_126_1.text_.text = var_129_3

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_5 = 15 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 15)

				if (15 <= 0 and var_129_2 or var_129_2 * (utf8.len(var_129_3) / 15)) > 0 and var_129_2 < var_129_5 then
					arg_126_1.talkMaxDuration = var_129_5

					if var_129_5 + var_129_1 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + var_129_1
					end
				end

				arg_126_1.text_.text = var_129_3
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_6 = math.max(var_129_2, arg_126_1.talkMaxDuration)

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_6 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_1) / var_129_6

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_1 + var_129_6 and arg_126_1.time_ < var_129_1 + var_129_6 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play1101103030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 1101103030
		arg_130_1.duration_ = 9.63

		local var_130_0 = {
			zh = 6.166,
			ja = 9.633
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play1101103031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1011ui_story = arg_130_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_133_0 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 then
				arg_130_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_130_1.time_ - 0) / var_133_0)
				arg_130_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1011ui_story"].transform.position).z)
				arg_130_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1011ui_story"].transform.localEulerAngles = arg_130_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 then
				arg_130_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_130_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1011ui_story"].transform.position).z)
				arg_130_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1011ui_story"].transform.localEulerAngles = arg_130_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_133_1 = arg_130_1.actors_["1011ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect1011ui_story == nil then
				arg_130_1.var_.characterEffect1011ui_story = var_133_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_2 and not isNil(var_133_1) then
				if arg_130_1.var_.characterEffect1011ui_story and not isNil(var_133_1) then
					arg_130_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_2 and arg_130_1.time_ < 0 + var_133_2 + arg_133_0 and not isNil(var_133_1) and arg_130_1.var_.characterEffect1011ui_story then
				arg_130_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_133_4 = 0
			local var_133_5 = 0.725

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_4 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_6 = arg_130_1:GetWordFromCfg(1101103030)
				local var_133_7 = arg_130_1:FormatText(var_133_6.content)

				arg_130_1.text_.text = var_133_7

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_9 = 29 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 29)

				if (29 <= 0 and var_133_5 or var_133_5 * (utf8.len(var_133_7) / 29)) > 0 and var_133_5 < var_133_9 then
					arg_130_1.talkMaxDuration = var_133_9

					if var_133_9 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_4
					end
				end

				arg_130_1.text_.text = var_133_7
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103030", "story_v_side_new_1101103.awb") ~= 0 then
					local var_133_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103030", "story_v_side_new_1101103.awb") / 1000

					if var_133_10 + var_133_4 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_10 + var_133_4
					end

					if var_133_6.prefab_name ~= "" and arg_130_1.actors_[var_133_6.prefab_name] ~= nil then
						local var_133_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_6.prefab_name].transform, "story_v_side_new_1101103", "1101103030", "story_v_side_new_1101103.awb")

						arg_130_1:RecordAudio("1101103030", var_133_11)
						arg_130_1:RecordAudio("1101103030", var_133_11)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103030", "story_v_side_new_1101103.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103030", "story_v_side_new_1101103.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_12 = math.max(var_133_5, arg_130_1.talkMaxDuration)

			if var_133_4 <= arg_130_1.time_ and arg_130_1.time_ < var_133_4 + var_133_12 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_4) / var_133_12

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_4 + var_133_12 and arg_130_1.time_ < var_133_4 + var_133_12 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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

		arg_130_1:InitPlayNodeList()
	end,
	Play1101103031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 1101103031
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play1101103032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1011ui_story"]) and arg_134_1.var_.characterEffect1011ui_story == nil then
				arg_134_1.var_.characterEffect1011ui_story = arg_134_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1011ui_story"]) then
				if arg_134_1.var_.characterEffect1011ui_story and not isNil(arg_134_1.actors_["1011ui_story"]) then
					arg_134_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_0)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1011ui_story"]) and arg_134_1.var_.characterEffect1011ui_story then
				arg_134_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_137_1 = 0
			local var_137_2 = 0.775

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_3 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(1101103031).content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 31 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 31)

				if (31 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 31)) > 0 and var_137_2 < var_137_5 then
					arg_134_1.talkMaxDuration = var_137_5

					if var_137_5 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + var_137_1
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_6 = math.max(var_137_2, arg_134_1.talkMaxDuration)

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_6 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_1) / var_137_6

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_1 + var_137_6 and arg_134_1.time_ < var_137_1 + var_137_6 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play1101103032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 1101103032
		arg_138_1.duration_ = 4.6

		local var_138_0 = {
			zh = 4.1,
			ja = 4.6
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
				arg_138_0:Play1101103033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1011ui_story = arg_138_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_141_0 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 then
				arg_138_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_0)
				arg_138_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1011ui_story"].transform.position).z)
				arg_138_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1011ui_story"].transform.localEulerAngles = arg_138_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 then
				arg_138_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_138_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["1011ui_story"].transform.position).z)
				arg_138_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["1011ui_story"].transform.localEulerAngles = arg_138_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_141_1 = arg_138_1.actors_["1011ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1011ui_story == nil then
				arg_138_1.var_.characterEffect1011ui_story = var_141_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_2 and not isNil(var_141_1) then
				if arg_138_1.var_.characterEffect1011ui_story and not isNil(var_141_1) then
					arg_138_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_2)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_2 and arg_138_1.time_ < 0 + var_141_2 + arg_141_0 and not isNil(var_141_1) and arg_138_1.var_.characterEffect1011ui_story then
				arg_138_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_141_3 = arg_138_1.actors_["1111ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1111ui_story = var_141_3.localPosition
			end

			local var_141_4 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 then
				var_141_3.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_138_1.time_ - 0) / var_141_4)
				var_141_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_3.position).x, (manager.ui.mainCamera.transform.position - var_141_3.position).y, (manager.ui.mainCamera.transform.position - var_141_3.position).z)
				var_141_3.localEulerAngles.z = 0
				var_141_3.localEulerAngles.x = 0
				var_141_3.localEulerAngles = var_141_3.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 then
				var_141_3.localPosition = Vector3.New(0, -0.87, -5.7)
				var_141_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_3.position).x, (manager.ui.mainCamera.transform.position - var_141_3.position).y, (manager.ui.mainCamera.transform.position - var_141_3.position).z)
				var_141_3.localEulerAngles.z = 0
				var_141_3.localEulerAngles.x = 0
				var_141_3.localEulerAngles = var_141_3.localEulerAngles
			end

			local var_141_5 = arg_138_1.actors_["1111ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_5) and arg_138_1.var_.characterEffect1111ui_story == nil then
				arg_138_1.var_.characterEffect1111ui_story = var_141_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_6 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_6 and not isNil(var_141_5) then
				if arg_138_1.var_.characterEffect1111ui_story and not isNil(var_141_5) then
					arg_138_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_6 and arg_138_1.time_ < 0 + var_141_6 + arg_141_0 and not isNil(var_141_5) and arg_138_1.var_.characterEffect1111ui_story then
				arg_138_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_141_8 = 0
			local var_141_9 = 0.475

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_8 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_10 = arg_138_1:GetWordFromCfg(1101103032)
				local var_141_11 = arg_138_1:FormatText(var_141_10.content)

				arg_138_1.text_.text = var_141_11

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_13 = 19 <= 0 and var_141_9 or var_141_9 * (utf8.len(var_141_11) / 19)

				if (19 <= 0 and var_141_9 or var_141_9 * (utf8.len(var_141_11) / 19)) > 0 and var_141_9 < var_141_13 then
					arg_138_1.talkMaxDuration = var_141_13

					if var_141_13 + var_141_8 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_13 + var_141_8
					end
				end

				arg_138_1.text_.text = var_141_11
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103032", "story_v_side_new_1101103.awb") ~= 0 then
					local var_141_14 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103032", "story_v_side_new_1101103.awb") / 1000

					if var_141_14 + var_141_8 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_14 + var_141_8
					end

					if var_141_10.prefab_name ~= "" and arg_138_1.actors_[var_141_10.prefab_name] ~= nil then
						local var_141_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_10.prefab_name].transform, "story_v_side_new_1101103", "1101103032", "story_v_side_new_1101103.awb")

						arg_138_1:RecordAudio("1101103032", var_141_15)
						arg_138_1:RecordAudio("1101103032", var_141_15)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103032", "story_v_side_new_1101103.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103032", "story_v_side_new_1101103.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_16 = math.max(var_141_9, arg_138_1.talkMaxDuration)

			if var_141_8 <= arg_138_1.time_ and arg_138_1.time_ < var_141_8 + var_141_16 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_8) / var_141_16

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_8 + var_141_16 and arg_138_1.time_ < var_141_8 + var_141_16 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play1101103033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 1101103033
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play1101103034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["1111ui_story"]) and arg_142_1.var_.characterEffect1111ui_story == nil then
				arg_142_1.var_.characterEffect1111ui_story = arg_142_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["1111ui_story"]) then
				if arg_142_1.var_.characterEffect1111ui_story and not isNil(arg_142_1.actors_["1111ui_story"]) then
					arg_142_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_0)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["1111ui_story"]) and arg_142_1.var_.characterEffect1111ui_story then
				arg_142_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_145_1 = 0
			local var_145_2 = 0.575

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_3 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(1101103033).content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 23 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 23)

				if (23 <= 0 and var_145_2 or var_145_2 * (utf8.len(var_145_3) / 23)) > 0 and var_145_2 < var_145_5 then
					arg_142_1.talkMaxDuration = var_145_5

					if var_145_5 + var_145_1 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + var_145_1
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_6 = math.max(var_145_2, arg_142_1.talkMaxDuration)

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_6 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_1) / var_145_6

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_1 + var_145_6 and arg_142_1.time_ < var_145_1 + var_145_6 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play1101103034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 1101103034
		arg_146_1.duration_ = 9.5

		local var_146_0 = {
			zh = 5.566,
			ja = 9.5
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
				arg_146_0:Play1101103035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos1111ui_story = arg_146_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_149_0 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 then
				arg_146_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_146_1.time_ - 0) / var_149_0)
				arg_146_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1111ui_story"].transform.position).z)
				arg_146_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1111ui_story"].transform.localEulerAngles = arg_146_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 then
				arg_146_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_146_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["1111ui_story"].transform.position).z)
				arg_146_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["1111ui_story"].transform.localEulerAngles = arg_146_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_149_1 = arg_146_1.actors_["1111ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect1111ui_story == nil then
				arg_146_1.var_.characterEffect1111ui_story = var_149_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_2 and not isNil(var_149_1) then
				if arg_146_1.var_.characterEffect1111ui_story and not isNil(var_149_1) then
					arg_146_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_2 and arg_146_1.time_ < 0 + var_149_2 + arg_149_0 and not isNil(var_149_1) and arg_146_1.var_.characterEffect1111ui_story then
				arg_146_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_149_4 = 0
			local var_149_5 = 0.65

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_4 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_6 = arg_146_1:GetWordFromCfg(1101103034)
				local var_149_7 = arg_146_1:FormatText(var_149_6.content)

				arg_146_1.text_.text = var_149_7

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_9 = 26 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 26)

				if (26 <= 0 and var_149_5 or var_149_5 * (utf8.len(var_149_7) / 26)) > 0 and var_149_5 < var_149_9 then
					arg_146_1.talkMaxDuration = var_149_9

					if var_149_9 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_9 + var_149_4
					end
				end

				arg_146_1.text_.text = var_149_7
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103034", "story_v_side_new_1101103.awb") ~= 0 then
					local var_149_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103034", "story_v_side_new_1101103.awb") / 1000

					if var_149_10 + var_149_4 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_4
					end

					if var_149_6.prefab_name ~= "" and arg_146_1.actors_[var_149_6.prefab_name] ~= nil then
						local var_149_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_6.prefab_name].transform, "story_v_side_new_1101103", "1101103034", "story_v_side_new_1101103.awb")

						arg_146_1:RecordAudio("1101103034", var_149_11)
						arg_146_1:RecordAudio("1101103034", var_149_11)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103034", "story_v_side_new_1101103.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103034", "story_v_side_new_1101103.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_12 = math.max(var_149_5, arg_146_1.talkMaxDuration)

			if var_149_4 <= arg_146_1.time_ and arg_146_1.time_ < var_149_4 + var_149_12 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_4) / var_149_12

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_4 + var_149_12 and arg_146_1.time_ < var_149_4 + var_149_12 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play1101103035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 1101103035
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play1101103036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1111ui_story = arg_150_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_153_0 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 then
				arg_150_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_150_1.time_ - 0) / var_153_0)
				arg_150_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1111ui_story"].transform.position).z)
				arg_150_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1111ui_story"].transform.localEulerAngles = arg_150_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 then
				arg_150_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_150_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_150_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_150_1.actors_["1111ui_story"].transform.position).z)
				arg_150_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_150_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_150_1.actors_["1111ui_story"].transform.localEulerAngles = arg_150_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_153_1 = arg_150_1.actors_["1111ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_1) and arg_150_1.var_.characterEffect1111ui_story == nil then
				arg_150_1.var_.characterEffect1111ui_story = var_153_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_2 and not isNil(var_153_1) then
				if arg_150_1.var_.characterEffect1111ui_story and not isNil(var_153_1) then
					arg_150_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_2)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_2 and arg_150_1.time_ < 0 + var_153_2 + arg_153_0 and not isNil(var_153_1) and arg_150_1.var_.characterEffect1111ui_story then
				arg_150_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_153_3 = arg_150_1.actors_["1011ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1011ui_story = var_153_3.localPosition
			end

			local var_153_4 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 then
				var_153_3.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_150_1.time_ - 0) / var_153_4)
				var_153_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_3.position).x, (manager.ui.mainCamera.transform.position - var_153_3.position).y, (manager.ui.mainCamera.transform.position - var_153_3.position).z)
				var_153_3.localEulerAngles.z = 0
				var_153_3.localEulerAngles.x = 0
				var_153_3.localEulerAngles = var_153_3.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 then
				var_153_3.localPosition = Vector3.New(0, -0.71, -6)
				var_153_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_3.position).x, (manager.ui.mainCamera.transform.position - var_153_3.position).y, (manager.ui.mainCamera.transform.position - var_153_3.position).z)
				var_153_3.localEulerAngles.z = 0
				var_153_3.localEulerAngles.x = 0
				var_153_3.localEulerAngles = var_153_3.localEulerAngles
			end

			local var_153_5 = arg_150_1.actors_["1011ui_story"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_5) and arg_150_1.var_.characterEffect1011ui_story == nil then
				arg_150_1.var_.characterEffect1011ui_story = var_153_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_6 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_6 and not isNil(var_153_5) then
				if arg_150_1.var_.characterEffect1011ui_story and not isNil(var_153_5) then
					arg_150_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_6)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_6 and arg_150_1.time_ < 0 + var_153_6 + arg_153_0 and not isNil(var_153_5) and arg_150_1.var_.characterEffect1011ui_story then
				arg_150_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action8_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_153_7 = 0
			local var_153_8 = 0.325

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_7 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_9 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(1101103035).content)

				arg_150_1.text_.text = var_153_9

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_11 = 13 <= 0 and var_153_8 or var_153_8 * (utf8.len(var_153_9) / 13)

				if (13 <= 0 and var_153_8 or var_153_8 * (utf8.len(var_153_9) / 13)) > 0 and var_153_8 < var_153_11 then
					arg_150_1.talkMaxDuration = var_153_11

					if var_153_11 + var_153_7 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_11 + var_153_7
					end
				end

				arg_150_1.text_.text = var_153_9
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_12 = math.max(var_153_8, arg_150_1.talkMaxDuration)

			if var_153_7 <= arg_150_1.time_ and arg_150_1.time_ < var_153_7 + var_153_12 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_7) / var_153_12

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_7 + var_153_12 and arg_150_1.time_ < var_153_7 + var_153_12 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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

		arg_150_1:InitPlayNodeList()
	end,
	Play1101103036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 1101103036
		arg_154_1.duration_ = 13.3

		local var_154_0 = {
			zh = 10.566,
			ja = 13.3
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
				arg_154_0:Play1101103037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1011ui_story = arg_154_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_157_0 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 then
				arg_154_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_154_1.time_ - 0) / var_157_0)
				arg_154_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1011ui_story"].transform.position).z)
				arg_154_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1011ui_story"].transform.localEulerAngles = arg_154_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 then
				arg_154_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_154_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["1011ui_story"].transform.position).z)
				arg_154_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["1011ui_story"].transform.localEulerAngles = arg_154_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_157_1 = arg_154_1.actors_["1011ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_1) and arg_154_1.var_.characterEffect1011ui_story == nil then
				arg_154_1.var_.characterEffect1011ui_story = var_157_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_2 and not isNil(var_157_1) then
				if arg_154_1.var_.characterEffect1011ui_story and not isNil(var_157_1) then
					arg_154_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_2 and arg_154_1.time_ < 0 + var_157_2 + arg_157_0 and not isNil(var_157_1) and arg_154_1.var_.characterEffect1011ui_story then
				arg_154_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_157_4 = 0
			local var_157_5 = 0.95

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_6 = arg_154_1:GetWordFromCfg(1101103036)
				local var_157_7 = arg_154_1:FormatText(var_157_6.content)

				arg_154_1.text_.text = var_157_7

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_9 = 38 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 38)

				if (38 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 38)) > 0 and var_157_5 < var_157_9 then
					arg_154_1.talkMaxDuration = var_157_9

					if var_157_9 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_9 + var_157_4
					end
				end

				arg_154_1.text_.text = var_157_7
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103036", "story_v_side_new_1101103.awb") ~= 0 then
					local var_157_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103036", "story_v_side_new_1101103.awb") / 1000

					if var_157_10 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_4
					end

					if var_157_6.prefab_name ~= "" and arg_154_1.actors_[var_157_6.prefab_name] ~= nil then
						local var_157_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_6.prefab_name].transform, "story_v_side_new_1101103", "1101103036", "story_v_side_new_1101103.awb")

						arg_154_1:RecordAudio("1101103036", var_157_11)
						arg_154_1:RecordAudio("1101103036", var_157_11)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103036", "story_v_side_new_1101103.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103036", "story_v_side_new_1101103.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_12 = math.max(var_157_5, arg_154_1.talkMaxDuration)

			if var_157_4 <= arg_154_1.time_ and arg_154_1.time_ < var_157_4 + var_157_12 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_4) / var_157_12

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_4 + var_157_12 and arg_154_1.time_ < var_157_4 + var_157_12 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
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

		arg_154_1:InitPlayNodeList()
	end,
	Play1101103037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 1101103037
		arg_158_1.duration_ = 10.67

		local var_158_0 = {
			zh = 8.666,
			ja = 10.666
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
				arg_158_0:Play1101103038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos1011ui_story = arg_158_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_161_0 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 then
				arg_158_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_158_1.time_ - 0) / var_161_0)
				arg_158_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1011ui_story"].transform.position).z)
				arg_158_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1011ui_story"].transform.localEulerAngles = arg_158_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 then
				arg_158_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_158_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["1011ui_story"].transform.position).z)
				arg_158_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["1011ui_story"].transform.localEulerAngles = arg_158_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_161_1 = arg_158_1.actors_["1011ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect1011ui_story == nil then
				arg_158_1.var_.characterEffect1011ui_story = var_161_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_2 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_2 and not isNil(var_161_1) then
				if arg_158_1.var_.characterEffect1011ui_story and not isNil(var_161_1) then
					arg_158_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_158_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_2)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_2 and arg_158_1.time_ < 0 + var_161_2 + arg_161_0 and not isNil(var_161_1) and arg_158_1.var_.characterEffect1011ui_story then
				arg_158_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_158_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_161_3 = arg_158_1.actors_["1111ui_story"].transform

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos1111ui_story = var_161_3.localPosition
			end

			local var_161_4 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				var_161_3.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_158_1.time_ - 0) / var_161_4)
				var_161_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_3.position).x, (manager.ui.mainCamera.transform.position - var_161_3.position).y, (manager.ui.mainCamera.transform.position - var_161_3.position).z)
				var_161_3.localEulerAngles.z = 0
				var_161_3.localEulerAngles.x = 0
				var_161_3.localEulerAngles = var_161_3.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				var_161_3.localPosition = Vector3.New(0, -0.87, -5.7)
				var_161_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_3.position).x, (manager.ui.mainCamera.transform.position - var_161_3.position).y, (manager.ui.mainCamera.transform.position - var_161_3.position).z)
				var_161_3.localEulerAngles.z = 0
				var_161_3.localEulerAngles.x = 0
				var_161_3.localEulerAngles = var_161_3.localEulerAngles
			end

			local var_161_5 = arg_158_1.actors_["1111ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_5) and arg_158_1.var_.characterEffect1111ui_story == nil then
				arg_158_1.var_.characterEffect1111ui_story = var_161_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_6 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_6 and not isNil(var_161_5) then
				if arg_158_1.var_.characterEffect1111ui_story and not isNil(var_161_5) then
					arg_158_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_6 and arg_158_1.time_ < 0 + var_161_6 + arg_161_0 and not isNil(var_161_5) and arg_158_1.var_.characterEffect1111ui_story then
				arg_158_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action7_1")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_161_8 = 0
			local var_161_9 = 0.925

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_8 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_10 = arg_158_1:GetWordFromCfg(1101103037)
				local var_161_11 = arg_158_1:FormatText(var_161_10.content)

				arg_158_1.text_.text = var_161_11

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_13 = 37 <= 0 and var_161_9 or var_161_9 * (utf8.len(var_161_11) / 37)

				if (37 <= 0 and var_161_9 or var_161_9 * (utf8.len(var_161_11) / 37)) > 0 and var_161_9 < var_161_13 then
					arg_158_1.talkMaxDuration = var_161_13

					if var_161_13 + var_161_8 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_13 + var_161_8
					end
				end

				arg_158_1.text_.text = var_161_11
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103037", "story_v_side_new_1101103.awb") ~= 0 then
					local var_161_14 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103037", "story_v_side_new_1101103.awb") / 1000

					if var_161_14 + var_161_8 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_14 + var_161_8
					end

					if var_161_10.prefab_name ~= "" and arg_158_1.actors_[var_161_10.prefab_name] ~= nil then
						local var_161_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_10.prefab_name].transform, "story_v_side_new_1101103", "1101103037", "story_v_side_new_1101103.awb")

						arg_158_1:RecordAudio("1101103037", var_161_15)
						arg_158_1:RecordAudio("1101103037", var_161_15)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103037", "story_v_side_new_1101103.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103037", "story_v_side_new_1101103.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_16 = math.max(var_161_9, arg_158_1.talkMaxDuration)

			if var_161_8 <= arg_158_1.time_ and arg_158_1.time_ < var_161_8 + var_161_16 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_8) / var_161_16

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_8 + var_161_16 and arg_158_1.time_ < var_161_8 + var_161_16 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play1101103038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 1101103038
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play1101103039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["1111ui_story"]) and arg_162_1.var_.characterEffect1111ui_story == nil then
				arg_162_1.var_.characterEffect1111ui_story = arg_162_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["1111ui_story"]) then
				if arg_162_1.var_.characterEffect1111ui_story and not isNil(arg_162_1.actors_["1111ui_story"]) then
					arg_162_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_0)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["1111ui_story"]) and arg_162_1.var_.characterEffect1111ui_story then
				arg_162_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_165_1 = 0
			local var_165_2 = 0.85

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_3 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(1101103038).content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 34 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 34)

				if (34 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 34)) > 0 and var_165_2 < var_165_5 then
					arg_162_1.talkMaxDuration = var_165_5

					if var_165_5 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_6 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_6 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_6

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_6 and arg_162_1.time_ < var_165_1 + var_165_6 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play1101103039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 1101103039
		arg_166_1.duration_ = 6.23

		local var_166_0 = {
			zh = 4.066,
			ja = 6.233
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
				arg_166_0:Play1101103040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1111ui_story = arg_166_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_169_0 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 then
				arg_166_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_166_1.time_ - 0) / var_169_0)
				arg_166_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1111ui_story"].transform.position).z)
				arg_166_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1111ui_story"].transform.localEulerAngles = arg_166_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 then
				arg_166_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["1111ui_story"].transform.position).z)
				arg_166_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["1111ui_story"].transform.localEulerAngles = arg_166_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_169_1 = arg_166_1.actors_["1111ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_1) and arg_166_1.var_.characterEffect1111ui_story == nil then
				arg_166_1.var_.characterEffect1111ui_story = var_169_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_2 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_2 and not isNil(var_169_1) then
				if arg_166_1.var_.characterEffect1111ui_story and not isNil(var_169_1) then
					arg_166_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_166_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_2)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_2 and arg_166_1.time_ < 0 + var_169_2 + arg_169_0 and not isNil(var_169_1) and arg_166_1.var_.characterEffect1111ui_story then
				arg_166_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_166_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_169_3 = arg_166_1.actors_["1011ui_story"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1011ui_story = var_169_3.localPosition
			end

			local var_169_4 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				var_169_3.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_166_1.time_ - 0) / var_169_4)
				var_169_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_3.position).x, (manager.ui.mainCamera.transform.position - var_169_3.position).y, (manager.ui.mainCamera.transform.position - var_169_3.position).z)
				var_169_3.localEulerAngles.z = 0
				var_169_3.localEulerAngles.x = 0
				var_169_3.localEulerAngles = var_169_3.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				var_169_3.localPosition = Vector3.New(0, -0.71, -6)
				var_169_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_3.position).x, (manager.ui.mainCamera.transform.position - var_169_3.position).y, (manager.ui.mainCamera.transform.position - var_169_3.position).z)
				var_169_3.localEulerAngles.z = 0
				var_169_3.localEulerAngles.x = 0
				var_169_3.localEulerAngles = var_169_3.localEulerAngles
			end

			local var_169_5 = arg_166_1.actors_["1011ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_5) and arg_166_1.var_.characterEffect1011ui_story == nil then
				arg_166_1.var_.characterEffect1011ui_story = var_169_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_6 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_6 and not isNil(var_169_5) then
				if arg_166_1.var_.characterEffect1011ui_story and not isNil(var_169_5) then
					arg_166_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_6 and arg_166_1.time_ < 0 + var_169_6 + arg_169_0 and not isNil(var_169_5) and arg_166_1.var_.characterEffect1011ui_story then
				arg_166_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_169_8 = 0
			local var_169_9 = 0.325

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_8 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_10 = arg_166_1:GetWordFromCfg(1101103039)
				local var_169_11 = arg_166_1:FormatText(var_169_10.content)

				arg_166_1.text_.text = var_169_11

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_13 = 13 <= 0 and var_169_9 or var_169_9 * (utf8.len(var_169_11) / 13)

				if (13 <= 0 and var_169_9 or var_169_9 * (utf8.len(var_169_11) / 13)) > 0 and var_169_9 < var_169_13 then
					arg_166_1.talkMaxDuration = var_169_13

					if var_169_13 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_13 + var_169_8
					end
				end

				arg_166_1.text_.text = var_169_11
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103039", "story_v_side_new_1101103.awb") ~= 0 then
					local var_169_14 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103039", "story_v_side_new_1101103.awb") / 1000

					if var_169_14 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_14 + var_169_8
					end

					if var_169_10.prefab_name ~= "" and arg_166_1.actors_[var_169_10.prefab_name] ~= nil then
						local var_169_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_10.prefab_name].transform, "story_v_side_new_1101103", "1101103039", "story_v_side_new_1101103.awb")

						arg_166_1:RecordAudio("1101103039", var_169_15)
						arg_166_1:RecordAudio("1101103039", var_169_15)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103039", "story_v_side_new_1101103.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103039", "story_v_side_new_1101103.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_16 = math.max(var_169_9, arg_166_1.talkMaxDuration)

			if var_169_8 <= arg_166_1.time_ and arg_166_1.time_ < var_169_8 + var_169_16 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_8) / var_169_16

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_8 + var_169_16 and arg_166_1.time_ < var_169_8 + var_169_16 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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

		arg_166_1:InitPlayNodeList()
	end,
	Play1101103040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 1101103040
		arg_170_1.duration_ = 6.5

		local var_170_0 = {
			zh = 6.5,
			ja = 5.6
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play1101103041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1011ui_story = arg_170_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_173_0 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 then
				arg_170_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_170_1.time_ - 0) / var_173_0)
				arg_170_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).z)
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles = arg_170_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 then
				arg_170_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_170_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1011ui_story"].transform.position).z)
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1011ui_story"].transform.localEulerAngles = arg_170_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_173_1 = arg_170_1.actors_["1011ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1011ui_story == nil then
				arg_170_1.var_.characterEffect1011ui_story = var_173_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_2 and not isNil(var_173_1) then
				if arg_170_1.var_.characterEffect1011ui_story and not isNil(var_173_1) then
					arg_170_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_2)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_2 and arg_170_1.time_ < 0 + var_173_2 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1011ui_story then
				arg_170_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_173_3 = arg_170_1.actors_["1111ui_story"].transform

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1111ui_story = var_173_3.localPosition
			end

			local var_173_4 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 then
				var_173_3.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_170_1.time_ - 0) / var_173_4)
				var_173_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_3.position).x, (manager.ui.mainCamera.transform.position - var_173_3.position).y, (manager.ui.mainCamera.transform.position - var_173_3.position).z)
				var_173_3.localEulerAngles.z = 0
				var_173_3.localEulerAngles.x = 0
				var_173_3.localEulerAngles = var_173_3.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 then
				var_173_3.localPosition = Vector3.New(0, -0.87, -5.7)
				var_173_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_173_3.position).x, (manager.ui.mainCamera.transform.position - var_173_3.position).y, (manager.ui.mainCamera.transform.position - var_173_3.position).z)
				var_173_3.localEulerAngles.z = 0
				var_173_3.localEulerAngles.x = 0
				var_173_3.localEulerAngles = var_173_3.localEulerAngles
			end

			local var_173_5 = arg_170_1.actors_["1111ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_5) and arg_170_1.var_.characterEffect1111ui_story == nil then
				arg_170_1.var_.characterEffect1111ui_story = var_173_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_6 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_6 and not isNil(var_173_5) then
				if arg_170_1.var_.characterEffect1111ui_story and not isNil(var_173_5) then
					arg_170_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_6 and arg_170_1.time_ < 0 + var_173_6 + arg_173_0 and not isNil(var_173_5) and arg_170_1.var_.characterEffect1111ui_story then
				arg_170_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action7_2")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_173_8 = 0
			local var_173_9 = 0.8

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_8 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_10 = arg_170_1:GetWordFromCfg(1101103040)
				local var_173_11 = arg_170_1:FormatText(var_173_10.content)

				arg_170_1.text_.text = var_173_11

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_13 = 32 <= 0 and var_173_9 or var_173_9 * (utf8.len(var_173_11) / 32)

				if (32 <= 0 and var_173_9 or var_173_9 * (utf8.len(var_173_11) / 32)) > 0 and var_173_9 < var_173_13 then
					arg_170_1.talkMaxDuration = var_173_13

					if var_173_13 + var_173_8 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_13 + var_173_8
					end
				end

				arg_170_1.text_.text = var_173_11
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103040", "story_v_side_new_1101103.awb") ~= 0 then
					local var_173_14 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103040", "story_v_side_new_1101103.awb") / 1000

					if var_173_14 + var_173_8 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_14 + var_173_8
					end

					if var_173_10.prefab_name ~= "" and arg_170_1.actors_[var_173_10.prefab_name] ~= nil then
						local var_173_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_10.prefab_name].transform, "story_v_side_new_1101103", "1101103040", "story_v_side_new_1101103.awb")

						arg_170_1:RecordAudio("1101103040", var_173_15)
						arg_170_1:RecordAudio("1101103040", var_173_15)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103040", "story_v_side_new_1101103.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103040", "story_v_side_new_1101103.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_16 = math.max(var_173_9, arg_170_1.talkMaxDuration)

			if var_173_8 <= arg_170_1.time_ and arg_170_1.time_ < var_173_8 + var_173_16 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_8) / var_173_16

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_8 + var_173_16 and arg_170_1.time_ < var_173_8 + var_173_16 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play1101103041 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 1101103041
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play1101103042(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1111ui_story = arg_174_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_177_0 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 then
				arg_174_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_174_1.time_ - 0) / var_177_0)
				arg_174_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1111ui_story"].transform.position).z)
				arg_174_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["1111ui_story"].transform.localEulerAngles = arg_174_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 then
				arg_174_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_174_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_174_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_174_1.actors_["1111ui_story"].transform.position).z)
				arg_174_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_174_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_174_1.actors_["1111ui_story"].transform.localEulerAngles = arg_174_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_177_1 = arg_174_1.actors_["1111ui_story"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect1111ui_story == nil then
				arg_174_1.var_.characterEffect1111ui_story = var_177_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_2 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_2 and not isNil(var_177_1) then
				if arg_174_1.var_.characterEffect1111ui_story and not isNil(var_177_1) then
					arg_174_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_2)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_2 and arg_174_1.time_ < 0 + var_177_2 + arg_177_0 and not isNil(var_177_1) and arg_174_1.var_.characterEffect1111ui_story then
				arg_174_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_177_3 = 0
			local var_177_4 = 0.525

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_3 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_5 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(1101103041).content)

				arg_174_1.text_.text = var_177_5

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_7 = 21 <= 0 and var_177_4 or var_177_4 * (utf8.len(var_177_5) / 21)

				if (21 <= 0 and var_177_4 or var_177_4 * (utf8.len(var_177_5) / 21)) > 0 and var_177_4 < var_177_7 then
					arg_174_1.talkMaxDuration = var_177_7

					if var_177_7 + var_177_3 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_7 + var_177_3
					end
				end

				arg_174_1.text_.text = var_177_5
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_8 = math.max(var_177_4, arg_174_1.talkMaxDuration)

			if var_177_3 <= arg_174_1.time_ and arg_174_1.time_ < var_177_3 + var_177_8 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_3) / var_177_8

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_3 + var_177_8 and arg_174_1.time_ < var_177_3 + var_177_8 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play1101103042 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 1101103042
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play1101103043(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0.475

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_1 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(1101103042).content)

				arg_178_1.text_.text = var_181_1

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_3 = 19 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 19)

				if (19 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 19)) > 0 and var_181_0 < var_181_3 then
					arg_178_1.talkMaxDuration = var_181_3

					if var_181_3 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_3 + 0
					end
				end

				arg_178_1.text_.text = var_181_1
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_4 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_4 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_4

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_4 and arg_178_1.time_ < 0 + var_181_4 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play1101103043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1101103043
		arg_182_1.duration_ = 4.23

		local var_182_0 = {
			zh = 2.166,
			ja = 4.233
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1101103044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1011ui_story = arg_182_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_185_0 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 then
				arg_182_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_182_1.time_ - 0) / var_185_0)
				arg_182_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1011ui_story"].transform.position).z)
				arg_182_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1011ui_story"].transform.localEulerAngles = arg_182_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 then
				arg_182_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_182_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1011ui_story"].transform.position).z)
				arg_182_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1011ui_story"].transform.localEulerAngles = arg_182_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_185_1 = arg_182_1.actors_["1011ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1011ui_story == nil then
				arg_182_1.var_.characterEffect1011ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect1011ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1011ui_story then
				arg_182_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_185_4 = 0
			local var_185_5 = 0.125

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_6 = arg_182_1:GetWordFromCfg(1101103043)
				local var_185_7 = arg_182_1:FormatText(var_185_6.content)

				arg_182_1.text_.text = var_185_7

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_9 = 5 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 5)

				if (5 <= 0 and var_185_5 or var_185_5 * (utf8.len(var_185_7) / 5)) > 0 and var_185_5 < var_185_9 then
					arg_182_1.talkMaxDuration = var_185_9

					if var_185_9 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_9 + var_185_4
					end
				end

				arg_182_1.text_.text = var_185_7
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103043", "story_v_side_new_1101103.awb") ~= 0 then
					local var_185_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103043", "story_v_side_new_1101103.awb") / 1000

					if var_185_10 + var_185_4 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_4
					end

					if var_185_6.prefab_name ~= "" and arg_182_1.actors_[var_185_6.prefab_name] ~= nil then
						local var_185_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_6.prefab_name].transform, "story_v_side_new_1101103", "1101103043", "story_v_side_new_1101103.awb")

						arg_182_1:RecordAudio("1101103043", var_185_11)
						arg_182_1:RecordAudio("1101103043", var_185_11)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103043", "story_v_side_new_1101103.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103043", "story_v_side_new_1101103.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_12 = math.max(var_185_5, arg_182_1.talkMaxDuration)

			if var_185_4 <= arg_182_1.time_ and arg_182_1.time_ < var_185_4 + var_185_12 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_4) / var_185_12

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_4 + var_185_12 and arg_182_1.time_ < var_185_4 + var_185_12 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
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

		arg_182_1:InitPlayNodeList()
	end,
	Play1101103044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1101103044
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1101103045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1011ui_story = arg_186_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_189_0 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 then
				arg_186_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 0) / var_189_0)
				arg_186_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1011ui_story"].transform.position).z)
				arg_186_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["1011ui_story"].transform.localEulerAngles = arg_186_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 then
				arg_186_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_186_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1011ui_story"].transform.position).z)
				arg_186_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["1011ui_story"].transform.localEulerAngles = arg_186_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_189_1 = arg_186_1.actors_["1011ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1011ui_story == nil then
				arg_186_1.var_.characterEffect1011ui_story = var_189_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_2 and not isNil(var_189_1) then
				if arg_186_1.var_.characterEffect1011ui_story and not isNil(var_189_1) then
					arg_186_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_2)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_2 and arg_186_1.time_ < 0 + var_189_2 + arg_189_0 and not isNil(var_189_1) and arg_186_1.var_.characterEffect1011ui_story then
				arg_186_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_189_3 = 0
			local var_189_4 = 0.625

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_3 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_5 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(1101103044).content)

				arg_186_1.text_.text = var_189_5

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_7 = 25 <= 0 and var_189_4 or var_189_4 * (utf8.len(var_189_5) / 25)

				if (25 <= 0 and var_189_4 or var_189_4 * (utf8.len(var_189_5) / 25)) > 0 and var_189_4 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_3 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_3
					end
				end

				arg_186_1.text_.text = var_189_5
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_8 = math.max(var_189_4, arg_186_1.talkMaxDuration)

			if var_189_3 <= arg_186_1.time_ and arg_186_1.time_ < var_189_3 + var_189_8 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_3) / var_189_8

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_3 + var_189_8 and arg_186_1.time_ < var_189_3 + var_189_8 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
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

		arg_186_1:InitPlayNodeList()
	end,
	Play1101103045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1101103045
		arg_190_1.duration_ = 6.03

		local var_190_0 = {
			zh = 4.533,
			ja = 6.033
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play1101103046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1111ui_story = arg_190_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_193_0 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 then
				arg_190_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_190_1.time_ - 0) / var_193_0)
				arg_190_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1111ui_story"].transform.position).z)
				arg_190_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1111ui_story"].transform.localEulerAngles = arg_190_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 then
				arg_190_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_190_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1111ui_story"].transform.position).z)
				arg_190_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1111ui_story"].transform.localEulerAngles = arg_190_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_193_1 = arg_190_1.actors_["1111ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1111ui_story == nil then
				arg_190_1.var_.characterEffect1111ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 and not isNil(var_193_1) then
				if arg_190_1.var_.characterEffect1111ui_story and not isNil(var_193_1) then
					arg_190_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1111ui_story then
				arg_190_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action9_1")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			if 2 < arg_190_1.time_ and arg_190_1.time_ <= 2 + arg_193_0 then
				arg_190_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_193_4 = 0
			local var_193_5 = 0.475

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_6 = arg_190_1:GetWordFromCfg(1101103045)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 19 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 19)

				if (19 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 19)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103045", "story_v_side_new_1101103.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103045", "story_v_side_new_1101103.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_side_new_1101103", "1101103045", "story_v_side_new_1101103.awb")

						arg_190_1:RecordAudio("1101103045", var_193_11)
						arg_190_1:RecordAudio("1101103045", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103045", "story_v_side_new_1101103.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103045", "story_v_side_new_1101103.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_12 = math.max(var_193_5, arg_190_1.talkMaxDuration)

			if var_193_4 <= arg_190_1.time_ and arg_190_1.time_ < var_193_4 + var_193_12 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_4) / var_193_12

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_4 + var_193_12 and arg_190_1.time_ < var_193_4 + var_193_12 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play1101103046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1101103046
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1101103047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.475

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, false)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_1 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(1101103046).content)

				arg_194_1.text_.text = var_197_1

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_3 = 19 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_1) / 19)

				if (19 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_1) / 19)) > 0 and var_197_0 < var_197_3 then
					arg_194_1.talkMaxDuration = var_197_3

					if var_197_3 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_3 + 0
					end
				end

				arg_194_1.text_.text = var_197_1
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_4 = math.max(var_197_0, arg_194_1.talkMaxDuration)

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_4 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - 0) / var_197_4

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= 0 + var_197_4 and arg_194_1.time_ < 0 + var_197_4 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play1101103047 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1101103047
		arg_198_1.duration_ = 2

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1101103048(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1111ui_story = arg_198_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1111ui_story"].transform.position).z)
				arg_198_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1111ui_story"].transform.localEulerAngles = arg_198_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_198_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1111ui_story"].transform.position).z)
				arg_198_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1111ui_story"].transform.localEulerAngles = arg_198_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_201_1 = arg_198_1.actors_["1111ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect1111ui_story == nil then
				arg_198_1.var_.characterEffect1111ui_story = var_201_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_2 and not isNil(var_201_1) then
				if arg_198_1.var_.characterEffect1111ui_story and not isNil(var_201_1) then
					arg_198_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_2 and arg_198_1.time_ < 0 + var_201_2 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect1111ui_story then
				arg_198_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action9_2")
			end

			local var_201_4 = 0
			local var_201_5 = 0.05

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_6 = arg_198_1:GetWordFromCfg(1101103047)
				local var_201_7 = arg_198_1:FormatText(var_201_6.content)

				arg_198_1.text_.text = var_201_7

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_9 = 2 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 2)

				if (2 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 2)) > 0 and var_201_5 < var_201_9 then
					arg_198_1.talkMaxDuration = var_201_9

					if var_201_9 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_4
					end
				end

				arg_198_1.text_.text = var_201_7
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103047", "story_v_side_new_1101103.awb") ~= 0 then
					local var_201_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103047", "story_v_side_new_1101103.awb") / 1000

					if var_201_10 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_4
					end

					if var_201_6.prefab_name ~= "" and arg_198_1.actors_[var_201_6.prefab_name] ~= nil then
						local var_201_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_6.prefab_name].transform, "story_v_side_new_1101103", "1101103047", "story_v_side_new_1101103.awb")

						arg_198_1:RecordAudio("1101103047", var_201_11)
						arg_198_1:RecordAudio("1101103047", var_201_11)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103047", "story_v_side_new_1101103.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103047", "story_v_side_new_1101103.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_12 = math.max(var_201_5, arg_198_1.talkMaxDuration)

			if var_201_4 <= arg_198_1.time_ and arg_198_1.time_ < var_201_4 + var_201_12 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_4) / var_201_12

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_4 + var_201_12 and arg_198_1.time_ < var_201_4 + var_201_12 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play1101103048 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 1101103048
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play1101103049(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["1111ui_story"]) and arg_202_1.var_.characterEffect1111ui_story == nil then
				arg_202_1.var_.characterEffect1111ui_story = arg_202_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["1111ui_story"]) then
				if arg_202_1.var_.characterEffect1111ui_story and not isNil(arg_202_1.actors_["1111ui_story"]) then
					arg_202_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_0)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["1111ui_story"]) and arg_202_1.var_.characterEffect1111ui_story then
				arg_202_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_205_1 = 0
			local var_205_2 = 0.95

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_3 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(1101103048).content)

				arg_202_1.text_.text = var_205_3

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 38 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 38)

				if (38 <= 0 and var_205_2 or var_205_2 * (utf8.len(var_205_3) / 38)) > 0 and var_205_2 < var_205_5 then
					arg_202_1.talkMaxDuration = var_205_5

					if var_205_5 + var_205_1 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_5 + var_205_1
					end
				end

				arg_202_1.text_.text = var_205_3
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_6 = math.max(var_205_2, arg_202_1.talkMaxDuration)

			if var_205_1 <= arg_202_1.time_ and arg_202_1.time_ < var_205_1 + var_205_6 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_1) / var_205_6

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_1 + var_205_6 and arg_202_1.time_ < var_205_1 + var_205_6 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play1101103049 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 1101103049
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play1101103050(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = 0.475

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_1 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(1101103049).content)

				arg_206_1.text_.text = var_209_1

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_3 = 19 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 19)

				if (19 <= 0 and var_209_0 or var_209_0 * (utf8.len(var_209_1) / 19)) > 0 and var_209_0 < var_209_3 then
					arg_206_1.talkMaxDuration = var_209_3

					if var_209_3 + 0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_3 + 0
					end
				end

				arg_206_1.text_.text = var_209_1
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_4 = math.max(var_209_0, arg_206_1.talkMaxDuration)

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - 0) / var_209_4

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play1101103050 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 1101103050
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play1101103051(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_213_0 = 0
			local var_213_1 = 0.55

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_2 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(1101103050).content)

				arg_210_1.text_.text = var_213_2

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_4 = 22 <= 0 and var_213_1 or var_213_1 * (utf8.len(var_213_2) / 22)

				if (22 <= 0 and var_213_1 or var_213_1 * (utf8.len(var_213_2) / 22)) > 0 and var_213_1 < var_213_4 then
					arg_210_1.talkMaxDuration = var_213_4

					if var_213_4 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_4 + var_213_0
					end
				end

				arg_210_1.text_.text = var_213_2
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_5 = math.max(var_213_1, arg_210_1.talkMaxDuration)

			if var_213_0 <= arg_210_1.time_ and arg_210_1.time_ < var_213_0 + var_213_5 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_0) / var_213_5

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_0 + var_213_5 and arg_210_1.time_ < var_213_0 + var_213_5 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play1101103051 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 1101103051
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play1101103052(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.mask_.enabled = true
				arg_214_1.mask_.raycastTarget = false

				arg_214_1:SetGaussion(false)
			end

			local var_217_0 = 1

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 then
				local var_217_1 = Color.New(1, 1, 1)

				var_217_1.a = Mathf.Lerp(1, 0, (arg_214_1.time_ - 0) / var_217_0)
				arg_214_1.mask_.color = var_217_1
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 then
				local var_217_2 = Color.New(1, 1, 1)

				arg_214_1.mask_.enabled = false
				var_217_2.a = 0
				arg_214_1.mask_.color = var_217_2
			end

			local var_217_3 = 0
			local var_217_4 = 0.575

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_3 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0

				arg_214_1.dialog_:SetActive(true)

				arg_214_1.dialogCg_.alpha = 0

				local var_217_5 = LeanTween.value(arg_214_1.dialog_, 0, 1, 0.3)

				var_217_5:setOnUpdate(LuaHelper.FloatAction(function(arg_218_0)
					arg_214_1.dialogCg_.alpha = arg_218_0
				end))
				var_217_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_214_1.dialog_)
					var_217_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_214_1.duration_ = arg_214_1.duration_ + 0.3

				SetActive(arg_214_1.leftNameGo_, false)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_6 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(1101103051).content)

				arg_214_1.text_.text = var_217_6

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_8 = 23 <= 0 and var_217_4 or var_217_4 * (utf8.len(var_217_6) / 23)

				if (23 <= 0 and var_217_4 or var_217_4 * (utf8.len(var_217_6) / 23)) > 0 and var_217_4 < var_217_8 then
					arg_214_1.talkMaxDuration = var_217_8
					var_217_3 = var_217_3 + 0.3

					if var_217_8 + var_217_3 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_3
					end
				end

				arg_214_1.text_.text = var_217_6
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_9 = var_217_3 + 0.3
			local var_217_10 = math.max(var_217_4, arg_214_1.talkMaxDuration)

			if var_217_3 + 0.3 <= arg_214_1.time_ and arg_214_1.time_ < var_217_9 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_9) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_9 + var_217_10 and arg_214_1.time_ < var_217_9 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play1101103052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 1101103052
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play1101103053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0.55

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_1 = arg_220_1:FormatText(arg_220_1:GetWordFromCfg(1101103052).content)

				arg_220_1.text_.text = var_223_1

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_3 = 22 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_1) / 22)

				if (22 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_1) / 22)) > 0 and var_223_0 < var_223_3 then
					arg_220_1.talkMaxDuration = var_223_3

					if var_223_3 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_3 + 0
					end
				end

				arg_220_1.text_.text = var_223_1
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_4 = math.max(var_223_0, arg_220_1.talkMaxDuration)

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_4 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - 0) / var_223_4

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= 0 + var_223_4 and arg_220_1.time_ < 0 + var_223_4 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play1101103053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 1101103053
		arg_224_1.duration_ = 5.9

		local var_224_0 = {
			zh = 5.9,
			ja = 5.866
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play1101103054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1011ui_story = arg_224_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_227_0 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 then
				arg_224_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_224_1.time_ - 0) / var_227_0)
				arg_224_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1011ui_story"].transform.position).z)
				arg_224_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["1011ui_story"].transform.localEulerAngles = arg_224_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 then
				arg_224_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_224_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_224_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_224_1.actors_["1011ui_story"].transform.position).z)
				arg_224_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_224_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_224_1.actors_["1011ui_story"].transform.localEulerAngles = arg_224_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_227_1 = arg_224_1.actors_["1011ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_1) and arg_224_1.var_.characterEffect1011ui_story == nil then
				arg_224_1.var_.characterEffect1011ui_story = var_227_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_2 and not isNil(var_227_1) then
				if arg_224_1.var_.characterEffect1011ui_story and not isNil(var_227_1) then
					arg_224_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_2 and arg_224_1.time_ < 0 + var_227_2 + arg_227_0 and not isNil(var_227_1) and arg_224_1.var_.characterEffect1011ui_story then
				arg_224_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_227_4 = arg_224_1.actors_["1111ui_story"].transform

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1111ui_story = var_227_4.localPosition
			end

			local var_227_5 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_5 then
				var_227_4.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_224_1.time_ - 0) / var_227_5)
				var_227_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_4.position).x, (manager.ui.mainCamera.transform.position - var_227_4.position).y, (manager.ui.mainCamera.transform.position - var_227_4.position).z)
				var_227_4.localEulerAngles.z = 0
				var_227_4.localEulerAngles.x = 0
				var_227_4.localEulerAngles = var_227_4.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_5 and arg_224_1.time_ < 0 + var_227_5 + arg_227_0 then
				var_227_4.localPosition = Vector3.New(0.7, -0.87, -5.7)
				var_227_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_4.position).x, (manager.ui.mainCamera.transform.position - var_227_4.position).y, (manager.ui.mainCamera.transform.position - var_227_4.position).z)
				var_227_4.localEulerAngles.z = 0
				var_227_4.localEulerAngles.x = 0
				var_227_4.localEulerAngles = var_227_4.localEulerAngles
			end

			local var_227_6 = arg_224_1.actors_["1111ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_6) and arg_224_1.var_.characterEffect1111ui_story == nil then
				arg_224_1.var_.characterEffect1111ui_story = var_227_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_7 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_7 and not isNil(var_227_6) then
				if arg_224_1.var_.characterEffect1111ui_story and not isNil(var_227_6) then
					arg_224_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_7)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_7 and arg_224_1.time_ < 0 + var_227_7 + arg_227_0 and not isNil(var_227_6) and arg_224_1.var_.characterEffect1111ui_story then
				arg_224_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_227_8 = 0
			local var_227_9 = 0.425

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_8 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_10 = arg_224_1:GetWordFromCfg(1101103053)
				local var_227_11 = arg_224_1:FormatText(var_227_10.content)

				arg_224_1.text_.text = var_227_11

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_13 = 17 <= 0 and var_227_9 or var_227_9 * (utf8.len(var_227_11) / 17)

				if (17 <= 0 and var_227_9 or var_227_9 * (utf8.len(var_227_11) / 17)) > 0 and var_227_9 < var_227_13 then
					arg_224_1.talkMaxDuration = var_227_13

					if var_227_13 + var_227_8 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_13 + var_227_8
					end
				end

				arg_224_1.text_.text = var_227_11
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103053", "story_v_side_new_1101103.awb") ~= 0 then
					local var_227_14 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103053", "story_v_side_new_1101103.awb") / 1000

					if var_227_14 + var_227_8 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_14 + var_227_8
					end

					if var_227_10.prefab_name ~= "" and arg_224_1.actors_[var_227_10.prefab_name] ~= nil then
						local var_227_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_10.prefab_name].transform, "story_v_side_new_1101103", "1101103053", "story_v_side_new_1101103.awb")

						arg_224_1:RecordAudio("1101103053", var_227_15)
						arg_224_1:RecordAudio("1101103053", var_227_15)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103053", "story_v_side_new_1101103.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103053", "story_v_side_new_1101103.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_16 = math.max(var_227_9, arg_224_1.talkMaxDuration)

			if var_227_8 <= arg_224_1.time_ and arg_224_1.time_ < var_227_8 + var_227_16 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_8) / var_227_16

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_8 + var_227_16 and arg_224_1.time_ < var_227_8 + var_227_16 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play1101103054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1101103054
		arg_228_1.duration_ = 5.53

		local var_228_0 = {
			zh = 2.333,
			ja = 5.533
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play1101103055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos1111ui_story = arg_228_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_231_0 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 then
				arg_228_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_228_1.time_ - 0) / var_231_0)
				arg_228_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1111ui_story"].transform.position).z)
				arg_228_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["1111ui_story"].transform.localEulerAngles = arg_228_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 then
				arg_228_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_228_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1111ui_story"].transform.position).z)
				arg_228_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["1111ui_story"].transform.localEulerAngles = arg_228_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_231_1 = arg_228_1.actors_["1111ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect1111ui_story == nil then
				arg_228_1.var_.characterEffect1111ui_story = var_231_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_2 and not isNil(var_231_1) then
				if arg_228_1.var_.characterEffect1111ui_story and not isNil(var_231_1) then
					arg_228_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_2 and arg_228_1.time_ < 0 + var_231_2 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect1111ui_story then
				arg_228_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_231_4 = arg_228_1.actors_["1011ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect1011ui_story == nil then
				arg_228_1.var_.characterEffect1011ui_story = var_231_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_5 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_5 and not isNil(var_231_4) then
				if arg_228_1.var_.characterEffect1011ui_story and not isNil(var_231_4) then
					arg_228_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_5)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_5 and arg_228_1.time_ < 0 + var_231_5 + arg_231_0 and not isNil(var_231_4) and arg_228_1.var_.characterEffect1011ui_story then
				arg_228_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_231_6 = 0
			local var_231_7 = 0.25

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_6 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_8 = arg_228_1:GetWordFromCfg(1101103054)
				local var_231_9 = arg_228_1:FormatText(var_231_8.content)

				arg_228_1.text_.text = var_231_9

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_11 = 10 <= 0 and var_231_7 or var_231_7 * (utf8.len(var_231_9) / 10)

				if (10 <= 0 and var_231_7 or var_231_7 * (utf8.len(var_231_9) / 10)) > 0 and var_231_7 < var_231_11 then
					arg_228_1.talkMaxDuration = var_231_11

					if var_231_11 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_11 + var_231_6
					end
				end

				arg_228_1.text_.text = var_231_9
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103054", "story_v_side_new_1101103.awb") ~= 0 then
					local var_231_12 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103054", "story_v_side_new_1101103.awb") / 1000

					if var_231_12 + var_231_6 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_12 + var_231_6
					end

					if var_231_8.prefab_name ~= "" and arg_228_1.actors_[var_231_8.prefab_name] ~= nil then
						local var_231_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_8.prefab_name].transform, "story_v_side_new_1101103", "1101103054", "story_v_side_new_1101103.awb")

						arg_228_1:RecordAudio("1101103054", var_231_13)
						arg_228_1:RecordAudio("1101103054", var_231_13)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103054", "story_v_side_new_1101103.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103054", "story_v_side_new_1101103.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_14 = math.max(var_231_7, arg_228_1.talkMaxDuration)

			if var_231_6 <= arg_228_1.time_ and arg_228_1.time_ < var_231_6 + var_231_14 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_6) / var_231_14

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_6 + var_231_14 and arg_228_1.time_ < var_231_6 + var_231_14 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play1101103055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 1101103055
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play1101103056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(arg_232_1.actors_["1111ui_story"]) and arg_232_1.var_.characterEffect1111ui_story == nil then
				arg_232_1.var_.characterEffect1111ui_story = arg_232_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_0 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 and not isNil(arg_232_1.actors_["1111ui_story"]) then
				if arg_232_1.var_.characterEffect1111ui_story and not isNil(arg_232_1.actors_["1111ui_story"]) then
					arg_232_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_0)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 and not isNil(arg_232_1.actors_["1111ui_story"]) and arg_232_1.var_.characterEffect1111ui_story then
				arg_232_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_235_1 = 0
			local var_235_2 = 0.275

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_3 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(1101103055).content)

				arg_232_1.text_.text = var_235_3

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_5 = 11 <= 0 and var_235_2 or var_235_2 * (utf8.len(var_235_3) / 11)

				if (11 <= 0 and var_235_2 or var_235_2 * (utf8.len(var_235_3) / 11)) > 0 and var_235_2 < var_235_5 then
					arg_232_1.talkMaxDuration = var_235_5

					if var_235_5 + var_235_1 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_5 + var_235_1
					end
				end

				arg_232_1.text_.text = var_235_3
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_6 = math.max(var_235_2, arg_232_1.talkMaxDuration)

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_6 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_1) / var_235_6

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_1 + var_235_6 and arg_232_1.time_ < var_235_1 + var_235_6 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play1101103056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 1101103056
		arg_236_1.duration_ = 5.4

		local var_236_0 = {
			zh = 4.233,
			ja = 5.4
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play1101103057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1011ui_story = arg_236_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_239_0 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 then
				arg_236_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_236_1.time_ - 0) / var_239_0)
				arg_236_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1011ui_story"].transform.position).z)
				arg_236_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1011ui_story"].transform.localEulerAngles = arg_236_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 then
				arg_236_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_236_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1011ui_story"].transform.position).z)
				arg_236_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1011ui_story"].transform.localEulerAngles = arg_236_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_239_1 = arg_236_1.actors_["1011ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1011ui_story == nil then
				arg_236_1.var_.characterEffect1011ui_story = var_239_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_2 and not isNil(var_239_1) then
				if arg_236_1.var_.characterEffect1011ui_story and not isNil(var_239_1) then
					arg_236_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_2 and arg_236_1.time_ < 0 + var_239_2 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1011ui_story then
				arg_236_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_239_4 = 0
			local var_239_5 = 0.275

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_6 = arg_236_1:GetWordFromCfg(1101103056)
				local var_239_7 = arg_236_1:FormatText(var_239_6.content)

				arg_236_1.text_.text = var_239_7

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_9 = 11 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 11)

				if (11 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 11)) > 0 and var_239_5 < var_239_9 then
					arg_236_1.talkMaxDuration = var_239_9

					if var_239_9 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_9 + var_239_4
					end
				end

				arg_236_1.text_.text = var_239_7
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103056", "story_v_side_new_1101103.awb") ~= 0 then
					local var_239_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103056", "story_v_side_new_1101103.awb") / 1000

					if var_239_10 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_4
					end

					if var_239_6.prefab_name ~= "" and arg_236_1.actors_[var_239_6.prefab_name] ~= nil then
						local var_239_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_6.prefab_name].transform, "story_v_side_new_1101103", "1101103056", "story_v_side_new_1101103.awb")

						arg_236_1:RecordAudio("1101103056", var_239_11)
						arg_236_1:RecordAudio("1101103056", var_239_11)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103056", "story_v_side_new_1101103.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103056", "story_v_side_new_1101103.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_12 = math.max(var_239_5, arg_236_1.talkMaxDuration)

			if var_239_4 <= arg_236_1.time_ and arg_236_1.time_ < var_239_4 + var_239_12 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_4) / var_239_12

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_4 + var_239_12 and arg_236_1.time_ < var_239_4 + var_239_12 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
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

		arg_236_1:InitPlayNodeList()
	end,
	Play1101103057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 1101103057
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play1101103058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["1011ui_story"]) and arg_240_1.var_.characterEffect1011ui_story == nil then
				arg_240_1.var_.characterEffect1011ui_story = arg_240_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_0 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["1011ui_story"]) then
				if arg_240_1.var_.characterEffect1011ui_story and not isNil(arg_240_1.actors_["1011ui_story"]) then
					arg_240_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_240_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_240_1.time_ - 0) / var_243_0)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["1011ui_story"]) and arg_240_1.var_.characterEffect1011ui_story then
				arg_240_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_240_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_243_1 = 0
			local var_243_2 = 0.325

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_3 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(1101103057).content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_5 = 13 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_3) / 13)

				if (13 <= 0 and var_243_2 or var_243_2 * (utf8.len(var_243_3) / 13)) > 0 and var_243_2 < var_243_5 then
					arg_240_1.talkMaxDuration = var_243_5

					if var_243_5 + var_243_1 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + var_243_1
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_6 = math.max(var_243_2, arg_240_1.talkMaxDuration)

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_6 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_1) / var_243_6

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_1 + var_243_6 and arg_240_1.time_ < var_243_1 + var_243_6 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play1101103058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 1101103058
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play1101103059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1011ui_story = arg_244_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_247_0 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 then
				arg_244_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_244_1.time_ - 0) / var_247_0)
				arg_244_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1011ui_story"].transform.position).z)
				arg_244_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1011ui_story"].transform.localEulerAngles = arg_244_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 then
				arg_244_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_244_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_244_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_244_1.actors_["1011ui_story"].transform.position).z)
				arg_244_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_244_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_244_1.actors_["1011ui_story"].transform.localEulerAngles = arg_244_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_247_1 = arg_244_1.actors_["1011ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1011ui_story == nil then
				arg_244_1.var_.characterEffect1011ui_story = var_247_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_2 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_2 and not isNil(var_247_1) then
				if arg_244_1.var_.characterEffect1011ui_story and not isNil(var_247_1) then
					arg_244_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_2)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_2 and arg_244_1.time_ < 0 + var_247_2 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.characterEffect1011ui_story then
				arg_244_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_247_3 = arg_244_1.actors_["1111ui_story"].transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1111ui_story = var_247_3.localPosition
			end

			local var_247_4 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 then
				var_247_3.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_244_1.time_ - 0) / var_247_4)
				var_247_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_3.position).x, (manager.ui.mainCamera.transform.position - var_247_3.position).y, (manager.ui.mainCamera.transform.position - var_247_3.position).z)
				var_247_3.localEulerAngles.z = 0
				var_247_3.localEulerAngles.x = 0
				var_247_3.localEulerAngles = var_247_3.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 then
				var_247_3.localPosition = Vector3.New(0, 100, 0)
				var_247_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_3.position).x, (manager.ui.mainCamera.transform.position - var_247_3.position).y, (manager.ui.mainCamera.transform.position - var_247_3.position).z)
				var_247_3.localEulerAngles.z = 0
				var_247_3.localEulerAngles.x = 0
				var_247_3.localEulerAngles = var_247_3.localEulerAngles
			end

			local var_247_5 = arg_244_1.actors_["1111ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_5) and arg_244_1.var_.characterEffect1111ui_story == nil then
				arg_244_1.var_.characterEffect1111ui_story = var_247_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_6 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_6 and not isNil(var_247_5) then
				if arg_244_1.var_.characterEffect1111ui_story and not isNil(var_247_5) then
					arg_244_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_6)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_6 and arg_244_1.time_ < 0 + var_247_6 + arg_247_0 and not isNil(var_247_5) and arg_244_1.var_.characterEffect1111ui_story then
				arg_244_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_247_7 = 0
			local var_247_8 = 0.825

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_7 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_9 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(1101103058).content)

				arg_244_1.text_.text = var_247_9

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_11 = 33 <= 0 and var_247_8 or var_247_8 * (utf8.len(var_247_9) / 33)

				if (33 <= 0 and var_247_8 or var_247_8 * (utf8.len(var_247_9) / 33)) > 0 and var_247_8 < var_247_11 then
					arg_244_1.talkMaxDuration = var_247_11

					if var_247_11 + var_247_7 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_11 + var_247_7
					end
				end

				arg_244_1.text_.text = var_247_9
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_12 = math.max(var_247_8, arg_244_1.talkMaxDuration)

			if var_247_7 <= arg_244_1.time_ and arg_244_1.time_ < var_247_7 + var_247_12 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_7) / var_247_12

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_7 + var_247_12 and arg_244_1.time_ < var_247_7 + var_247_12 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play1101103059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 1101103059
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play1101103060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.35

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(1101103059).content)

				arg_248_1.text_.text = var_251_1

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_3 = 14 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 14)

				if (14 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 14)) > 0 and var_251_0 < var_251_3 then
					arg_248_1.talkMaxDuration = var_251_3

					if var_251_3 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_3 + 0
					end
				end

				arg_248_1.text_.text = var_251_1
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_4 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_4

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play1101103060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 1101103060
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play1101103061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0.925

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_1 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(1101103060).content)

				arg_252_1.text_.text = var_255_1

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_3 = 37 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 37)

				if (37 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 37)) > 0 and var_255_0 < var_255_3 then
					arg_252_1.talkMaxDuration = var_255_3

					if var_255_3 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_3 + 0
					end
				end

				arg_252_1.text_.text = var_255_1
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_4 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_4

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play1101103061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 1101103061
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play1101103062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 1.05

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_1 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(1101103061).content)

				arg_256_1.text_.text = var_259_1

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_3 = 42 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 42)

				if (42 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 42)) > 0 and var_259_0 < var_259_3 then
					arg_256_1.talkMaxDuration = var_259_3

					if var_259_3 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_3 + 0
					end
				end

				arg_256_1.text_.text = var_259_1
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_4 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_4 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_4

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_4 and arg_256_1.time_ < 0 + var_259_4 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play1101103062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 1101103062
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play1101103063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.475

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
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

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_1 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(1101103062).content)

				arg_260_1.text_.text = var_263_1

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_3 = 19 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_1) / 19)

				if (19 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_1) / 19)) > 0 and var_263_0 < var_263_3 then
					arg_260_1.talkMaxDuration = var_263_3

					if var_263_3 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_3 + 0
					end
				end

				arg_260_1.text_.text = var_263_1
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_4 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_4

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play1101103063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 1101103063
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play1101103064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:AudioAction("play", "effect", "se_story_side_1011", "se_story_side_1011_closedoor", "")
			end

			local var_267_1 = 0
			local var_267_2 = 0.525

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_3 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(1101103063).content)

				arg_264_1.text_.text = var_267_3

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_5 = 21 <= 0 and var_267_2 or var_267_2 * (utf8.len(var_267_3) / 21)

				if (21 <= 0 and var_267_2 or var_267_2 * (utf8.len(var_267_3) / 21)) > 0 and var_267_2 < var_267_5 then
					arg_264_1.talkMaxDuration = var_267_5

					if var_267_5 + var_267_1 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + var_267_1
					end
				end

				arg_264_1.text_.text = var_267_3
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_6 = math.max(var_267_2, arg_264_1.talkMaxDuration)

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_6 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_1) / var_267_6

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_1 + var_267_6 and arg_264_1.time_ < var_267_1 + var_267_6 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play1101103064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 1101103064
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play1101103065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = 0.575

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_1 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(1101103064).content)

				arg_268_1.text_.text = var_271_1

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_3 = 23 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 23)

				if (23 <= 0 and var_271_0 or var_271_0 * (utf8.len(var_271_1) / 23)) > 0 and var_271_0 < var_271_3 then
					arg_268_1.talkMaxDuration = var_271_3

					if var_271_3 + 0 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_3 + 0
					end
				end

				arg_268_1.text_.text = var_271_1
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_4 = math.max(var_271_0, arg_268_1.talkMaxDuration)

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_4 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - 0) / var_271_4

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= 0 + var_271_4 and arg_268_1.time_ < 0 + var_271_4 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play1101103065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 1101103065
		arg_272_1.duration_ = 8.3

		local var_272_0 = {
			zh = 6.833,
			ja = 8.3
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play1101103066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos1011ui_story = arg_272_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_275_0 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 then
				arg_272_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_272_1.time_ - 0) / var_275_0)
				arg_272_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1011ui_story"].transform.position).z)
				arg_272_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["1011ui_story"].transform.localEulerAngles = arg_272_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 then
				arg_272_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_272_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1011ui_story"].transform.position).z)
				arg_272_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["1011ui_story"].transform.localEulerAngles = arg_272_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_275_1 = arg_272_1.actors_["1011ui_story"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_1) and arg_272_1.var_.characterEffect1011ui_story == nil then
				arg_272_1.var_.characterEffect1011ui_story = var_275_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_2 and not isNil(var_275_1) then
				if arg_272_1.var_.characterEffect1011ui_story and not isNil(var_275_1) then
					arg_272_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 0 + var_275_2 and arg_272_1.time_ < 0 + var_275_2 + arg_275_0 and not isNil(var_275_1) and arg_272_1.var_.characterEffect1011ui_story then
				arg_272_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_275_4 = arg_272_1.actors_["1111ui_story"].transform

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos1111ui_story = var_275_4.localPosition
			end

			local var_275_5 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_5 then
				var_275_4.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_272_1.time_ - 0) / var_275_5)
				var_275_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_275_4.position).x, (manager.ui.mainCamera.transform.position - var_275_4.position).y, (manager.ui.mainCamera.transform.position - var_275_4.position).z)
				var_275_4.localEulerAngles.z = 0
				var_275_4.localEulerAngles.x = 0
				var_275_4.localEulerAngles = var_275_4.localEulerAngles
			end

			if arg_272_1.time_ >= 0 + var_275_5 and arg_272_1.time_ < 0 + var_275_5 + arg_275_0 then
				var_275_4.localPosition = Vector3.New(0.7, -0.87, -5.7)
				var_275_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_275_4.position).x, (manager.ui.mainCamera.transform.position - var_275_4.position).y, (manager.ui.mainCamera.transform.position - var_275_4.position).z)
				var_275_4.localEulerAngles.z = 0
				var_275_4.localEulerAngles.x = 0
				var_275_4.localEulerAngles = var_275_4.localEulerAngles
			end

			local var_275_6 = arg_272_1.actors_["1111ui_story"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_6) and arg_272_1.var_.characterEffect1111ui_story == nil then
				arg_272_1.var_.characterEffect1111ui_story = var_275_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_7 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_7 and not isNil(var_275_6) then
				if arg_272_1.var_.characterEffect1111ui_story and not isNil(var_275_6) then
					arg_272_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_272_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_272_1.time_ - 0) / var_275_7)
				end
			end

			if arg_272_1.time_ >= 0 + var_275_7 and arg_272_1.time_ < 0 + var_275_7 + arg_275_0 and not isNil(var_275_6) and arg_272_1.var_.characterEffect1111ui_story then
				arg_272_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_272_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_275_8 = 0
			local var_275_9 = 0.75

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_8 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_10 = arg_272_1:GetWordFromCfg(1101103065)
				local var_275_11 = arg_272_1:FormatText(var_275_10.content)

				arg_272_1.text_.text = var_275_11

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_13 = 30 <= 0 and var_275_9 or var_275_9 * (utf8.len(var_275_11) / 30)

				if (30 <= 0 and var_275_9 or var_275_9 * (utf8.len(var_275_11) / 30)) > 0 and var_275_9 < var_275_13 then
					arg_272_1.talkMaxDuration = var_275_13

					if var_275_13 + var_275_8 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_13 + var_275_8
					end
				end

				arg_272_1.text_.text = var_275_11
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103065", "story_v_side_new_1101103.awb") ~= 0 then
					local var_275_14 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103065", "story_v_side_new_1101103.awb") / 1000

					if var_275_14 + var_275_8 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_14 + var_275_8
					end

					if var_275_10.prefab_name ~= "" and arg_272_1.actors_[var_275_10.prefab_name] ~= nil then
						local var_275_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_10.prefab_name].transform, "story_v_side_new_1101103", "1101103065", "story_v_side_new_1101103.awb")

						arg_272_1:RecordAudio("1101103065", var_275_15)
						arg_272_1:RecordAudio("1101103065", var_275_15)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103065", "story_v_side_new_1101103.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103065", "story_v_side_new_1101103.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_16 = math.max(var_275_9, arg_272_1.talkMaxDuration)

			if var_275_8 <= arg_272_1.time_ and arg_272_1.time_ < var_275_8 + var_275_16 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_8) / var_275_16

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_8 + var_275_16 and arg_272_1.time_ < var_275_8 + var_275_16 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play1101103066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 1101103066
		arg_276_1.duration_ = 7.5

		local var_276_0 = {
			zh = 7.5,
			ja = 4.866
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play1101103067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos1111ui_story = arg_276_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_279_0 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 then
				arg_276_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_276_1.time_ - 0) / var_279_0)
				arg_276_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1111ui_story"].transform.position).z)
				arg_276_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["1111ui_story"].transform.localEulerAngles = arg_276_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 then
				arg_276_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_276_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1111ui_story"].transform.position).z)
				arg_276_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["1111ui_story"].transform.localEulerAngles = arg_276_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_279_1 = arg_276_1.actors_["1111ui_story"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_1) and arg_276_1.var_.characterEffect1111ui_story == nil then
				arg_276_1.var_.characterEffect1111ui_story = var_279_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_2 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_2 and not isNil(var_279_1) then
				if arg_276_1.var_.characterEffect1111ui_story and not isNil(var_279_1) then
					arg_276_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= 0 + var_279_2 and arg_276_1.time_ < 0 + var_279_2 + arg_279_0 and not isNil(var_279_1) and arg_276_1.var_.characterEffect1111ui_story then
				arg_276_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_279_4 = arg_276_1.actors_["1011ui_story"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_4) and arg_276_1.var_.characterEffect1011ui_story == nil then
				arg_276_1.var_.characterEffect1011ui_story = var_279_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_5 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_5 and not isNil(var_279_4) then
				if arg_276_1.var_.characterEffect1011ui_story and not isNil(var_279_4) then
					arg_276_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_276_1.time_ - 0) / var_279_5)
				end
			end

			if arg_276_1.time_ >= 0 + var_279_5 and arg_276_1.time_ < 0 + var_279_5 + arg_279_0 and not isNil(var_279_4) and arg_276_1.var_.characterEffect1011ui_story then
				arg_276_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_279_6 = 0
			local var_279_7 = 0.825

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_6 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_8 = arg_276_1:GetWordFromCfg(1101103066)
				local var_279_9 = arg_276_1:FormatText(var_279_8.content)

				arg_276_1.text_.text = var_279_9

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_11 = 33 <= 0 and var_279_7 or var_279_7 * (utf8.len(var_279_9) / 33)

				if (33 <= 0 and var_279_7 or var_279_7 * (utf8.len(var_279_9) / 33)) > 0 and var_279_7 < var_279_11 then
					arg_276_1.talkMaxDuration = var_279_11

					if var_279_11 + var_279_6 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_11 + var_279_6
					end
				end

				arg_276_1.text_.text = var_279_9
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103066", "story_v_side_new_1101103.awb") ~= 0 then
					local var_279_12 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103066", "story_v_side_new_1101103.awb") / 1000

					if var_279_12 + var_279_6 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_12 + var_279_6
					end

					if var_279_8.prefab_name ~= "" and arg_276_1.actors_[var_279_8.prefab_name] ~= nil then
						local var_279_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_8.prefab_name].transform, "story_v_side_new_1101103", "1101103066", "story_v_side_new_1101103.awb")

						arg_276_1:RecordAudio("1101103066", var_279_13)
						arg_276_1:RecordAudio("1101103066", var_279_13)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103066", "story_v_side_new_1101103.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103066", "story_v_side_new_1101103.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_14 = math.max(var_279_7, arg_276_1.talkMaxDuration)

			if var_279_6 <= arg_276_1.time_ and arg_276_1.time_ < var_279_6 + var_279_14 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_6) / var_279_14

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_6 + var_279_14 and arg_276_1.time_ < var_279_6 + var_279_14 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play1101103067 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 1101103067
		arg_280_1.duration_ = 3.57

		local var_280_0 = {
			zh = 1.999999999999,
			ja = 3.566
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
				arg_280_0:Play1101103068(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos1011ui_story = arg_280_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_283_0 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 then
				arg_280_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_280_1.time_ - 0) / var_283_0)
				arg_280_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["1011ui_story"].transform.position).z)
				arg_280_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["1011ui_story"].transform.localEulerAngles = arg_280_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 then
				arg_280_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_280_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_280_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_280_1.actors_["1011ui_story"].transform.position).z)
				arg_280_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_280_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_280_1.actors_["1011ui_story"].transform.localEulerAngles = arg_280_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_283_1 = arg_280_1.actors_["1011ui_story"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_1) and arg_280_1.var_.characterEffect1011ui_story == nil then
				arg_280_1.var_.characterEffect1011ui_story = var_283_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_2 and not isNil(var_283_1) then
				if arg_280_1.var_.characterEffect1011ui_story and not isNil(var_283_1) then
					arg_280_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_2 and arg_280_1.time_ < 0 + var_283_2 + arg_283_0 and not isNil(var_283_1) and arg_280_1.var_.characterEffect1011ui_story then
				arg_280_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_283_4 = arg_280_1.actors_["1111ui_story"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_4) and arg_280_1.var_.characterEffect1111ui_story == nil then
				arg_280_1.var_.characterEffect1111ui_story = var_283_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_5 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_5 and not isNil(var_283_4) then
				if arg_280_1.var_.characterEffect1111ui_story and not isNil(var_283_4) then
					arg_280_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_280_1.time_ - 0) / var_283_5)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_5 and arg_280_1.time_ < 0 + var_283_5 + arg_283_0 and not isNil(var_283_4) and arg_280_1.var_.characterEffect1111ui_story then
				arg_280_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_283_6 = 0
			local var_283_7 = 0.125

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_6 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[580].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_8 = arg_280_1:GetWordFromCfg(1101103067)
				local var_283_9 = arg_280_1:FormatText(var_283_8.content)

				arg_280_1.text_.text = var_283_9

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_11 = 5 <= 0 and var_283_7 or var_283_7 * (utf8.len(var_283_9) / 5)

				if (5 <= 0 and var_283_7 or var_283_7 * (utf8.len(var_283_9) / 5)) > 0 and var_283_7 < var_283_11 then
					arg_280_1.talkMaxDuration = var_283_11

					if var_283_11 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_11 + var_283_6
					end
				end

				arg_280_1.text_.text = var_283_9
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103067", "story_v_side_new_1101103.awb") ~= 0 then
					local var_283_12 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103067", "story_v_side_new_1101103.awb") / 1000

					if var_283_12 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_12 + var_283_6
					end

					if var_283_8.prefab_name ~= "" and arg_280_1.actors_[var_283_8.prefab_name] ~= nil then
						local var_283_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_8.prefab_name].transform, "story_v_side_new_1101103", "1101103067", "story_v_side_new_1101103.awb")

						arg_280_1:RecordAudio("1101103067", var_283_13)
						arg_280_1:RecordAudio("1101103067", var_283_13)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103067", "story_v_side_new_1101103.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103067", "story_v_side_new_1101103.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_14 = math.max(var_283_7, arg_280_1.talkMaxDuration)

			if var_283_6 <= arg_280_1.time_ and arg_280_1.time_ < var_283_6 + var_283_14 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_6) / var_283_14

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_6 + var_283_14 and arg_280_1.time_ < var_283_6 + var_283_14 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
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

		arg_280_1:InitPlayNodeList()
	end,
	Play1101103068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 1101103068
		arg_284_1.duration_ = 2.2

		local var_284_0 = {
			zh = 1.999999999999,
			ja = 2.2
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play1101103069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos1111ui_story = arg_284_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_287_0 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 then
				arg_284_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_284_1.time_ - 0) / var_287_0)
				arg_284_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1111ui_story"].transform.position).z)
				arg_284_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["1111ui_story"].transform.localEulerAngles = arg_284_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 then
				arg_284_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_284_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1111ui_story"].transform.position).z)
				arg_284_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["1111ui_story"].transform.localEulerAngles = arg_284_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_287_1 = arg_284_1.actors_["1111ui_story"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_1) and arg_284_1.var_.characterEffect1111ui_story == nil then
				arg_284_1.var_.characterEffect1111ui_story = var_287_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_2 and not isNil(var_287_1) then
				if arg_284_1.var_.characterEffect1111ui_story and not isNil(var_287_1) then
					arg_284_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= 0 + var_287_2 and arg_284_1.time_ < 0 + var_287_2 + arg_287_0 and not isNil(var_287_1) and arg_284_1.var_.characterEffect1111ui_story then
				arg_284_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_287_4 = 0
			local var_287_5 = 0.225

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_6 = arg_284_1:GetWordFromCfg(1101103068)
				local var_287_7 = arg_284_1:FormatText(var_287_6.content)

				arg_284_1.text_.text = var_287_7

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_9 = 9 <= 0 and var_287_5 or var_287_5 * (utf8.len(var_287_7) / 9)

				if (9 <= 0 and var_287_5 or var_287_5 * (utf8.len(var_287_7) / 9)) > 0 and var_287_5 < var_287_9 then
					arg_284_1.talkMaxDuration = var_287_9

					if var_287_9 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_9 + var_287_4
					end
				end

				arg_284_1.text_.text = var_287_7
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103068", "story_v_side_new_1101103.awb") ~= 0 then
					local var_287_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103068", "story_v_side_new_1101103.awb") / 1000

					if var_287_10 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_10 + var_287_4
					end

					if var_287_6.prefab_name ~= "" and arg_284_1.actors_[var_287_6.prefab_name] ~= nil then
						local var_287_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_6.prefab_name].transform, "story_v_side_new_1101103", "1101103068", "story_v_side_new_1101103.awb")

						arg_284_1:RecordAudio("1101103068", var_287_11)
						arg_284_1:RecordAudio("1101103068", var_287_11)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103068", "story_v_side_new_1101103.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103068", "story_v_side_new_1101103.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_12 = math.max(var_287_5, arg_284_1.talkMaxDuration)

			if var_287_4 <= arg_284_1.time_ and arg_284_1.time_ < var_287_4 + var_287_12 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_4) / var_287_12

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_4 + var_287_12 and arg_284_1.time_ < var_287_4 + var_287_12 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play1101103069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 1101103069
		arg_288_1.duration_ = 10.8

		local var_288_0 = {
			zh = 6.566,
			ja = 10.8
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play1101103070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos1011ui_story = arg_288_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_291_0 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 then
				arg_288_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_288_1.time_ - 0) / var_291_0)
				arg_288_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1011ui_story"].transform.position).z)
				arg_288_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["1011ui_story"].transform.localEulerAngles = arg_288_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 then
				arg_288_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_288_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1011ui_story"].transform.position).z)
				arg_288_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["1011ui_story"].transform.localEulerAngles = arg_288_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_291_1 = arg_288_1.actors_["1011ui_story"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_1) and arg_288_1.var_.characterEffect1011ui_story == nil then
				arg_288_1.var_.characterEffect1011ui_story = var_291_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_2 and not isNil(var_291_1) then
				if arg_288_1.var_.characterEffect1011ui_story and not isNil(var_291_1) then
					arg_288_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_2 and arg_288_1.time_ < 0 + var_291_2 + arg_291_0 and not isNil(var_291_1) and arg_288_1.var_.characterEffect1011ui_story then
				arg_288_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_2")
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_291_4 = arg_288_1.actors_["1111ui_story"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_4) and arg_288_1.var_.characterEffect1111ui_story == nil then
				arg_288_1.var_.characterEffect1111ui_story = var_291_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_5 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_5 and not isNil(var_291_4) then
				if arg_288_1.var_.characterEffect1111ui_story and not isNil(var_291_4) then
					arg_288_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_288_1.time_ - 0) / var_291_5)
				end
			end

			if arg_288_1.time_ >= 0 + var_291_5 and arg_288_1.time_ < 0 + var_291_5 + arg_291_0 and not isNil(var_291_4) and arg_288_1.var_.characterEffect1111ui_story then
				arg_288_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_291_6 = 0
			local var_291_7 = 1

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_6 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_8 = arg_288_1:GetWordFromCfg(1101103069)
				local var_291_9 = arg_288_1:FormatText(var_291_8.content)

				arg_288_1.text_.text = var_291_9

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_11 = 40 <= 0 and var_291_7 or var_291_7 * (utf8.len(var_291_9) / 40)

				if (40 <= 0 and var_291_7 or var_291_7 * (utf8.len(var_291_9) / 40)) > 0 and var_291_7 < var_291_11 then
					arg_288_1.talkMaxDuration = var_291_11

					if var_291_11 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_11 + var_291_6
					end
				end

				arg_288_1.text_.text = var_291_9
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103069", "story_v_side_new_1101103.awb") ~= 0 then
					local var_291_12 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103069", "story_v_side_new_1101103.awb") / 1000

					if var_291_12 + var_291_6 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_12 + var_291_6
					end

					if var_291_8.prefab_name ~= "" and arg_288_1.actors_[var_291_8.prefab_name] ~= nil then
						local var_291_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_8.prefab_name].transform, "story_v_side_new_1101103", "1101103069", "story_v_side_new_1101103.awb")

						arg_288_1:RecordAudio("1101103069", var_291_13)
						arg_288_1:RecordAudio("1101103069", var_291_13)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103069", "story_v_side_new_1101103.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103069", "story_v_side_new_1101103.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_14 = math.max(var_291_7, arg_288_1.talkMaxDuration)

			if var_291_6 <= arg_288_1.time_ and arg_288_1.time_ < var_291_6 + var_291_14 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_6) / var_291_14

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_6 + var_291_14 and arg_288_1.time_ < var_291_6 + var_291_14 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
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

		arg_288_1:InitPlayNodeList()
	end,
	Play1101103070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 1101103070
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play1101103071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1011ui_story = arg_292_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_295_0 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 then
				arg_292_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_292_1.time_ - 0) / var_295_0)
				arg_292_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1011ui_story"].transform.position).z)
				arg_292_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1011ui_story"].transform.localEulerAngles = arg_292_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 then
				arg_292_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_292_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1011ui_story"].transform.position).z)
				arg_292_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1011ui_story"].transform.localEulerAngles = arg_292_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_295_1 = arg_292_1.actors_["1011ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_1) and arg_292_1.var_.characterEffect1011ui_story == nil then
				arg_292_1.var_.characterEffect1011ui_story = var_295_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_2 and not isNil(var_295_1) then
				if arg_292_1.var_.characterEffect1011ui_story and not isNil(var_295_1) then
					arg_292_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_2)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_2 and arg_292_1.time_ < 0 + var_295_2 + arg_295_0 and not isNil(var_295_1) and arg_292_1.var_.characterEffect1011ui_story then
				arg_292_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_295_3 = arg_292_1.actors_["1111ui_story"].transform

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1111ui_story = var_295_3.localPosition
			end

			local var_295_4 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_4 then
				var_295_3.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_292_1.time_ - 0) / var_295_4)
				var_295_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_3.position).x, (manager.ui.mainCamera.transform.position - var_295_3.position).y, (manager.ui.mainCamera.transform.position - var_295_3.position).z)
				var_295_3.localEulerAngles.z = 0
				var_295_3.localEulerAngles.x = 0
				var_295_3.localEulerAngles = var_295_3.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_4 and arg_292_1.time_ < 0 + var_295_4 + arg_295_0 then
				var_295_3.localPosition = Vector3.New(0, 100, 0)
				var_295_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_3.position).x, (manager.ui.mainCamera.transform.position - var_295_3.position).y, (manager.ui.mainCamera.transform.position - var_295_3.position).z)
				var_295_3.localEulerAngles.z = 0
				var_295_3.localEulerAngles.x = 0
				var_295_3.localEulerAngles = var_295_3.localEulerAngles
			end

			local var_295_5 = arg_292_1.actors_["1111ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_5) and arg_292_1.var_.characterEffect1111ui_story == nil then
				arg_292_1.var_.characterEffect1111ui_story = var_295_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_6 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_6 and not isNil(var_295_5) then
				if arg_292_1.var_.characterEffect1111ui_story and not isNil(var_295_5) then
					arg_292_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_6)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_6 and arg_292_1.time_ < 0 + var_295_6 + arg_295_0 and not isNil(var_295_5) and arg_292_1.var_.characterEffect1111ui_story then
				arg_292_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_295_7 = 0
			local var_295_8 = 0.625

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_7 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_9 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(1101103070).content)

				arg_292_1.text_.text = var_295_9

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_11 = 25 <= 0 and var_295_8 or var_295_8 * (utf8.len(var_295_9) / 25)

				if (25 <= 0 and var_295_8 or var_295_8 * (utf8.len(var_295_9) / 25)) > 0 and var_295_8 < var_295_11 then
					arg_292_1.talkMaxDuration = var_295_11

					if var_295_11 + var_295_7 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_11 + var_295_7
					end
				end

				arg_292_1.text_.text = var_295_9
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_12 = math.max(var_295_8, arg_292_1.talkMaxDuration)

			if var_295_7 <= arg_292_1.time_ and arg_292_1.time_ < var_295_7 + var_295_12 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_7) / var_295_12

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_7 + var_295_12 and arg_292_1.time_ < var_295_7 + var_295_12 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play1101103071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 1101103071
		arg_296_1.duration_ = 6.53

		local var_296_0 = {
			zh = 6.333,
			ja = 6.533
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play1101103072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1111ui_story = arg_296_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_299_0 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 then
				arg_296_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_296_1.time_ - 0) / var_299_0)
				arg_296_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1111ui_story"].transform.position).z)
				arg_296_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1111ui_story"].transform.localEulerAngles = arg_296_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 then
				arg_296_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_296_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1111ui_story"].transform.position).z)
				arg_296_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1111ui_story"].transform.localEulerAngles = arg_296_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_299_1 = arg_296_1.actors_["1111ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1111ui_story == nil then
				arg_296_1.var_.characterEffect1111ui_story = var_299_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_2 and not isNil(var_299_1) then
				if arg_296_1.var_.characterEffect1111ui_story and not isNil(var_299_1) then
					arg_296_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_2 and arg_296_1.time_ < 0 + var_299_2 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1111ui_story then
				arg_296_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_299_4 = 0
			local var_299_5 = 0.725

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_6 = arg_296_1:GetWordFromCfg(1101103071)
				local var_299_7 = arg_296_1:FormatText(var_299_6.content)

				arg_296_1.text_.text = var_299_7

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_9 = 29 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 29)

				if (29 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 29)) > 0 and var_299_5 < var_299_9 then
					arg_296_1.talkMaxDuration = var_299_9

					if var_299_9 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_9 + var_299_4
					end
				end

				arg_296_1.text_.text = var_299_7
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103071", "story_v_side_new_1101103.awb") ~= 0 then
					local var_299_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103071", "story_v_side_new_1101103.awb") / 1000

					if var_299_10 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_10 + var_299_4
					end

					if var_299_6.prefab_name ~= "" and arg_296_1.actors_[var_299_6.prefab_name] ~= nil then
						local var_299_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_6.prefab_name].transform, "story_v_side_new_1101103", "1101103071", "story_v_side_new_1101103.awb")

						arg_296_1:RecordAudio("1101103071", var_299_11)
						arg_296_1:RecordAudio("1101103071", var_299_11)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103071", "story_v_side_new_1101103.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103071", "story_v_side_new_1101103.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_12 = math.max(var_299_5, arg_296_1.talkMaxDuration)

			if var_299_4 <= arg_296_1.time_ and arg_296_1.time_ < var_299_4 + var_299_12 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_4) / var_299_12

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_4 + var_299_12 and arg_296_1.time_ < var_299_4 + var_299_12 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play1101103072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1101103072
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1101103073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["1111ui_story"]) and arg_300_1.var_.characterEffect1111ui_story == nil then
				arg_300_1.var_.characterEffect1111ui_story = arg_300_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_0 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["1111ui_story"]) then
				if arg_300_1.var_.characterEffect1111ui_story and not isNil(arg_300_1.actors_["1111ui_story"]) then
					arg_300_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_300_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_300_1.time_ - 0) / var_303_0)
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["1111ui_story"]) and arg_300_1.var_.characterEffect1111ui_story then
				arg_300_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_300_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_303_1 = 0
			local var_303_2 = 0.4

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_3 = arg_300_1:FormatText(arg_300_1:GetWordFromCfg(1101103072).content)

				arg_300_1.text_.text = var_303_3

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 16 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_3) / 16)

				if (16 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_3) / 16)) > 0 and var_303_2 < var_303_5 then
					arg_300_1.talkMaxDuration = var_303_5

					if var_303_5 + var_303_1 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_5 + var_303_1
					end
				end

				arg_300_1.text_.text = var_303_3
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_6 = math.max(var_303_2, arg_300_1.talkMaxDuration)

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_6 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_1) / var_303_6

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_1 + var_303_6 and arg_300_1.time_ < var_303_1 + var_303_6 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play1101103073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 1101103073
		arg_304_1.duration_ = 3.2

		local var_304_0 = {
			zh = 2.033,
			ja = 3.2
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play1101103074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos1111ui_story = arg_304_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_307_0 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 then
				arg_304_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_304_1.time_ - 0) / var_307_0)
				arg_304_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1111ui_story"].transform.position).z)
				arg_304_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1111ui_story"].transform.localEulerAngles = arg_304_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 then
				arg_304_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_304_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1111ui_story"].transform.position).z)
				arg_304_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1111ui_story"].transform.localEulerAngles = arg_304_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_307_1 = arg_304_1.actors_["1111ui_story"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_1) and arg_304_1.var_.characterEffect1111ui_story == nil then
				arg_304_1.var_.characterEffect1111ui_story = var_307_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_2 and not isNil(var_307_1) then
				if arg_304_1.var_.characterEffect1111ui_story and not isNil(var_307_1) then
					arg_304_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= 0 + var_307_2 and arg_304_1.time_ < 0 + var_307_2 + arg_307_0 and not isNil(var_307_1) and arg_304_1.var_.characterEffect1111ui_story then
				arg_304_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_1")
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_307_4 = 0
			local var_307_5 = 0.275

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_4 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_6 = arg_304_1:GetWordFromCfg(1101103073)
				local var_307_7 = arg_304_1:FormatText(var_307_6.content)

				arg_304_1.text_.text = var_307_7

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_9 = 11 <= 0 and var_307_5 or var_307_5 * (utf8.len(var_307_7) / 11)

				if (11 <= 0 and var_307_5 or var_307_5 * (utf8.len(var_307_7) / 11)) > 0 and var_307_5 < var_307_9 then
					arg_304_1.talkMaxDuration = var_307_9

					if var_307_9 + var_307_4 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_9 + var_307_4
					end
				end

				arg_304_1.text_.text = var_307_7
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103073", "story_v_side_new_1101103.awb") ~= 0 then
					local var_307_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103073", "story_v_side_new_1101103.awb") / 1000

					if var_307_10 + var_307_4 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_10 + var_307_4
					end

					if var_307_6.prefab_name ~= "" and arg_304_1.actors_[var_307_6.prefab_name] ~= nil then
						local var_307_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_6.prefab_name].transform, "story_v_side_new_1101103", "1101103073", "story_v_side_new_1101103.awb")

						arg_304_1:RecordAudio("1101103073", var_307_11)
						arg_304_1:RecordAudio("1101103073", var_307_11)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103073", "story_v_side_new_1101103.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103073", "story_v_side_new_1101103.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_12 = math.max(var_307_5, arg_304_1.talkMaxDuration)

			if var_307_4 <= arg_304_1.time_ and arg_304_1.time_ < var_307_4 + var_307_12 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_4) / var_307_12

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_4 + var_307_12 and arg_304_1.time_ < var_307_4 + var_307_12 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play1101103074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 1101103074
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play1101103075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["1111ui_story"]) and arg_308_1.var_.characterEffect1111ui_story == nil then
				arg_308_1.var_.characterEffect1111ui_story = arg_308_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_0 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["1111ui_story"]) then
				if arg_308_1.var_.characterEffect1111ui_story and not isNil(arg_308_1.actors_["1111ui_story"]) then
					arg_308_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_0)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["1111ui_story"]) and arg_308_1.var_.characterEffect1111ui_story then
				arg_308_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_311_1 = 0
			local var_311_2 = 0.25

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_3 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(1101103074).content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_5 = 10 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_3) / 10)

				if (10 <= 0 and var_311_2 or var_311_2 * (utf8.len(var_311_3) / 10)) > 0 and var_311_2 < var_311_5 then
					arg_308_1.talkMaxDuration = var_311_5

					if var_311_5 + var_311_1 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_5 + var_311_1
					end
				end

				arg_308_1.text_.text = var_311_3
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_6 = math.max(var_311_2, arg_308_1.talkMaxDuration)

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_6 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_1) / var_311_6

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_1 + var_311_6 and arg_308_1.time_ < var_311_1 + var_311_6 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play1101103075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 1101103075
		arg_312_1.duration_ = 6.7

		local var_312_0 = {
			zh = 6.7,
			ja = 4.866
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play1101103076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1111ui_story = arg_312_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_315_0 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 then
				arg_312_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_312_1.time_ - 0) / var_315_0)
				arg_312_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1111ui_story"].transform.position).z)
				arg_312_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["1111ui_story"].transform.localEulerAngles = arg_312_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 then
				arg_312_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_312_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1111ui_story"].transform.position).z)
				arg_312_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["1111ui_story"].transform.localEulerAngles = arg_312_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_315_1 = arg_312_1.actors_["1111ui_story"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect1111ui_story == nil then
				arg_312_1.var_.characterEffect1111ui_story = var_315_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_2 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_2 and not isNil(var_315_1) then
				if arg_312_1.var_.characterEffect1111ui_story and not isNil(var_315_1) then
					arg_312_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= 0 + var_315_2 and arg_312_1.time_ < 0 + var_315_2 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect1111ui_story then
				arg_312_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_2")
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_315_4 = 0
			local var_315_5 = 0.675

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_4 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_6 = arg_312_1:GetWordFromCfg(1101103075)
				local var_315_7 = arg_312_1:FormatText(var_315_6.content)

				arg_312_1.text_.text = var_315_7

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_9 = 27 <= 0 and var_315_5 or var_315_5 * (utf8.len(var_315_7) / 27)

				if (27 <= 0 and var_315_5 or var_315_5 * (utf8.len(var_315_7) / 27)) > 0 and var_315_5 < var_315_9 then
					arg_312_1.talkMaxDuration = var_315_9

					if var_315_9 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_9 + var_315_4
					end
				end

				arg_312_1.text_.text = var_315_7
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103075", "story_v_side_new_1101103.awb") ~= 0 then
					local var_315_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103075", "story_v_side_new_1101103.awb") / 1000

					if var_315_10 + var_315_4 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_10 + var_315_4
					end

					if var_315_6.prefab_name ~= "" and arg_312_1.actors_[var_315_6.prefab_name] ~= nil then
						local var_315_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_6.prefab_name].transform, "story_v_side_new_1101103", "1101103075", "story_v_side_new_1101103.awb")

						arg_312_1:RecordAudio("1101103075", var_315_11)
						arg_312_1:RecordAudio("1101103075", var_315_11)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103075", "story_v_side_new_1101103.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103075", "story_v_side_new_1101103.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_12 = math.max(var_315_5, arg_312_1.talkMaxDuration)

			if var_315_4 <= arg_312_1.time_ and arg_312_1.time_ < var_315_4 + var_315_12 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_4) / var_315_12

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_4 + var_315_12 and arg_312_1.time_ < var_315_4 + var_315_12 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play1101103076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 1101103076
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play1101103077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["1111ui_story"]) and arg_316_1.var_.characterEffect1111ui_story == nil then
				arg_316_1.var_.characterEffect1111ui_story = arg_316_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_0 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["1111ui_story"]) then
				if arg_316_1.var_.characterEffect1111ui_story and not isNil(arg_316_1.actors_["1111ui_story"]) then
					arg_316_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_316_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_316_1.time_ - 0) / var_319_0)
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["1111ui_story"]) and arg_316_1.var_.characterEffect1111ui_story then
				arg_316_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_316_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_319_1 = 0
			local var_319_2 = 0.525

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_3 = arg_316_1:FormatText(arg_316_1:GetWordFromCfg(1101103076).content)

				arg_316_1.text_.text = var_319_3

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 21 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 21)

				if (21 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_3) / 21)) > 0 and var_319_2 < var_319_5 then
					arg_316_1.talkMaxDuration = var_319_5

					if var_319_5 + var_319_1 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + var_319_1
					end
				end

				arg_316_1.text_.text = var_319_3
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_6 = math.max(var_319_2, arg_316_1.talkMaxDuration)

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_6 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_1) / var_319_6

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_1 + var_319_6 and arg_316_1.time_ < var_319_1 + var_319_6 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play1101103077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 1101103077
		arg_320_1.duration_ = 7.2

		local var_320_0 = {
			zh = 7.2,
			ja = 5.066
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
				arg_320_0:Play1101103078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos1111ui_story = arg_320_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_323_0 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 then
				arg_320_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_320_1.time_ - 0) / var_323_0)
				arg_320_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1111ui_story"].transform.position).z)
				arg_320_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["1111ui_story"].transform.localEulerAngles = arg_320_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 then
				arg_320_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_320_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1111ui_story"].transform.position).z)
				arg_320_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["1111ui_story"].transform.localEulerAngles = arg_320_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_323_1 = arg_320_1.actors_["1111ui_story"]

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(var_323_1) and arg_320_1.var_.characterEffect1111ui_story == nil then
				arg_320_1.var_.characterEffect1111ui_story = var_323_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_2 = 0.200000002980232

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_2 and not isNil(var_323_1) then
				if arg_320_1.var_.characterEffect1111ui_story and not isNil(var_323_1) then
					arg_320_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= 0 + var_323_2 and arg_320_1.time_ < 0 + var_323_2 + arg_323_0 and not isNil(var_323_1) and arg_320_1.var_.characterEffect1111ui_story then
				arg_320_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_323_4 = 0
			local var_323_5 = 0.85

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_4 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_6 = arg_320_1:GetWordFromCfg(1101103077)
				local var_323_7 = arg_320_1:FormatText(var_323_6.content)

				arg_320_1.text_.text = var_323_7

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_9 = 34 <= 0 and var_323_5 or var_323_5 * (utf8.len(var_323_7) / 34)

				if (34 <= 0 and var_323_5 or var_323_5 * (utf8.len(var_323_7) / 34)) > 0 and var_323_5 < var_323_9 then
					arg_320_1.talkMaxDuration = var_323_9

					if var_323_9 + var_323_4 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_9 + var_323_4
					end
				end

				arg_320_1.text_.text = var_323_7
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103077", "story_v_side_new_1101103.awb") ~= 0 then
					local var_323_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103077", "story_v_side_new_1101103.awb") / 1000

					if var_323_10 + var_323_4 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_10 + var_323_4
					end

					if var_323_6.prefab_name ~= "" and arg_320_1.actors_[var_323_6.prefab_name] ~= nil then
						local var_323_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_6.prefab_name].transform, "story_v_side_new_1101103", "1101103077", "story_v_side_new_1101103.awb")

						arg_320_1:RecordAudio("1101103077", var_323_11)
						arg_320_1:RecordAudio("1101103077", var_323_11)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103077", "story_v_side_new_1101103.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103077", "story_v_side_new_1101103.awb")
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
				actorName = "1111ui_story",
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
	Play1101103078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 1101103078
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play1101103079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["1111ui_story"]) and arg_324_1.var_.characterEffect1111ui_story == nil then
				arg_324_1.var_.characterEffect1111ui_story = arg_324_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_0 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["1111ui_story"]) then
				if arg_324_1.var_.characterEffect1111ui_story and not isNil(arg_324_1.actors_["1111ui_story"]) then
					arg_324_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_324_1.time_ - 0) / var_327_0)
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["1111ui_story"]) and arg_324_1.var_.characterEffect1111ui_story then
				arg_324_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_327_1 = 0
			local var_327_2 = 0.525

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_3 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(1101103078).content)

				arg_324_1.text_.text = var_327_3

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_5 = 21 <= 0 and var_327_2 or var_327_2 * (utf8.len(var_327_3) / 21)

				if (21 <= 0 and var_327_2 or var_327_2 * (utf8.len(var_327_3) / 21)) > 0 and var_327_2 < var_327_5 then
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
	Play1101103079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 1101103079
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play1101103080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0.875

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

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_1 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(1101103079).content)

				arg_328_1.text_.text = var_331_1

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_3 = 35 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_1) / 35)

				if (35 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_1) / 35)) > 0 and var_331_0 < var_331_3 then
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
	Play1101103080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 1101103080
		arg_332_1.duration_ = 6.93

		local var_332_0 = {
			zh = 5.4,
			ja = 6.933
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play1101103081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos1111ui_story = arg_332_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_335_0 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 then
				arg_332_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_332_1.time_ - 0) / var_335_0)
				arg_332_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1111ui_story"].transform.position).z)
				arg_332_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["1111ui_story"].transform.localEulerAngles = arg_332_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 then
				arg_332_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_332_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1111ui_story"].transform.position).z)
				arg_332_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["1111ui_story"].transform.localEulerAngles = arg_332_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_335_1 = arg_332_1.actors_["1111ui_story"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_1) and arg_332_1.var_.characterEffect1111ui_story == nil then
				arg_332_1.var_.characterEffect1111ui_story = var_335_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_2 and not isNil(var_335_1) then
				if arg_332_1.var_.characterEffect1111ui_story and not isNil(var_335_1) then
					arg_332_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= 0 + var_335_2 and arg_332_1.time_ < 0 + var_335_2 + arg_335_0 and not isNil(var_335_1) and arg_332_1.var_.characterEffect1111ui_story then
				arg_332_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_335_4 = 0
			local var_335_5 = 0.6

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_4 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_6 = arg_332_1:GetWordFromCfg(1101103080)
				local var_335_7 = arg_332_1:FormatText(var_335_6.content)

				arg_332_1.text_.text = var_335_7

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_9 = 24 <= 0 and var_335_5 or var_335_5 * (utf8.len(var_335_7) / 24)

				if (24 <= 0 and var_335_5 or var_335_5 * (utf8.len(var_335_7) / 24)) > 0 and var_335_5 < var_335_9 then
					arg_332_1.talkMaxDuration = var_335_9

					if var_335_9 + var_335_4 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_9 + var_335_4
					end
				end

				arg_332_1.text_.text = var_335_7
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103080", "story_v_side_new_1101103.awb") ~= 0 then
					local var_335_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103080", "story_v_side_new_1101103.awb") / 1000

					if var_335_10 + var_335_4 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_10 + var_335_4
					end

					if var_335_6.prefab_name ~= "" and arg_332_1.actors_[var_335_6.prefab_name] ~= nil then
						local var_335_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_6.prefab_name].transform, "story_v_side_new_1101103", "1101103080", "story_v_side_new_1101103.awb")

						arg_332_1:RecordAudio("1101103080", var_335_11)
						arg_332_1:RecordAudio("1101103080", var_335_11)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103080", "story_v_side_new_1101103.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103080", "story_v_side_new_1101103.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_12 = math.max(var_335_5, arg_332_1.talkMaxDuration)

			if var_335_4 <= arg_332_1.time_ and arg_332_1.time_ < var_335_4 + var_335_12 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_4) / var_335_12

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_4 + var_335_12 and arg_332_1.time_ < var_335_4 + var_335_12 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play1101103081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 1101103081
		arg_336_1.duration_ = 1

		SetActive(arg_336_1.tipsGo_, true)

		arg_336_1.tipsText_.text = StoryTipsCfg[101102].name

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"

			SetActive(arg_336_1.choicesGo_, true)

			for iter_337_0, iter_337_1 in ipairs(arg_336_1.choices_) do
				SetActive(iter_337_1.go, iter_337_0 <= 2)
			end

			arg_336_1.choices_[1].txt.text = arg_336_1:FormatText(StoryChoiceCfg[610].name)
			arg_336_1.choices_[2].txt.text = arg_336_1:FormatText(StoryChoiceCfg[611].name)
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				PlayerAction.UseStoryTrigger(1011013, 210110103, 1101103081, 1)
				arg_336_0:Play1101103082(arg_336_1)
			end

			if arg_338_0 == 2 then
				PlayerAction.UseStoryTrigger(1011013, 210110103, 1101103081, 2)
				arg_336_0:Play1101103082(arg_336_1)
			end

			arg_336_1:RecordChoiceLog(1101103081, 610, 611)
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(arg_336_1.actors_["1111ui_story"]) and arg_336_1.var_.characterEffect1111ui_story == nil then
				arg_336_1.var_.characterEffect1111ui_story = arg_336_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_0 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 and not isNil(arg_336_1.actors_["1111ui_story"]) then
				if arg_336_1.var_.characterEffect1111ui_story and not isNil(arg_336_1.actors_["1111ui_story"]) then
					arg_336_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_336_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_336_1.time_ - 0) / var_339_0)
				end
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 and not isNil(arg_336_1.actors_["1111ui_story"]) and arg_336_1.var_.characterEffect1111ui_story then
				arg_336_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_336_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_339_1 = 0

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1.allBtn_.enabled = false
			end

			if arg_336_1.time_ >= var_339_1 + 0.5 and arg_336_1.time_ < var_339_1 + 0.5 + arg_339_0 then
				arg_336_1.allBtn_.enabled = true
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play1101103082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 1101103082
		arg_340_1.duration_ = 5.73

		local var_340_0 = {
			zh = 3.966,
			ja = 5.733
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play1101103083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos1111ui_story = arg_340_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_343_0 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 then
				arg_340_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_340_1.time_ - 0) / var_343_0)
				arg_340_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_340_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1111ui_story"].transform.position).z)
				arg_340_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_340_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_340_1.actors_["1111ui_story"].transform.localEulerAngles = arg_340_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 then
				arg_340_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_340_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_340_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_340_1.actors_["1111ui_story"].transform.position).z)
				arg_340_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_340_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_340_1.actors_["1111ui_story"].transform.localEulerAngles = arg_340_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_343_1 = arg_340_1.actors_["1111ui_story"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_1) and arg_340_1.var_.characterEffect1111ui_story == nil then
				arg_340_1.var_.characterEffect1111ui_story = var_343_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_2 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_2 and not isNil(var_343_1) then
				if arg_340_1.var_.characterEffect1111ui_story and not isNil(var_343_1) then
					arg_340_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= 0 + var_343_2 and arg_340_1.time_ < 0 + var_343_2 + arg_343_0 and not isNil(var_343_1) and arg_340_1.var_.characterEffect1111ui_story then
				arg_340_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_343_4 = "1111ui_story"

			if arg_340_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_343_5 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_340_1.stage_.transform)

				var_343_5.name = var_343_4
				var_343_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_340_1.actors_[var_343_4] = var_343_5

				local var_343_6 = var_343_5:GetComponentInChildren(typeof(CharacterEffect))

				var_343_6.enabled = true

				local var_343_7 = GameObjectTools.GetOrAddComponent(var_343_5, typeof(DynamicBoneHelper))

				if var_343_7 then
					var_343_7:EnableDynamicBone(false)
				end

				arg_340_1:ShowWeapon(var_343_6.transform, false)

				arg_340_1.var_[var_343_4 .. "Animator"] = var_343_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_340_1.var_[var_343_4 .. "Animator"].applyRootMotion = true
				arg_340_1.var_[var_343_4 .. "LipSync"] = var_343_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_343_8 = "1111ui_story"

			if arg_340_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_343_9 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_340_1.stage_.transform)

				var_343_9.name = var_343_8
				var_343_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_340_1.actors_[var_343_8] = var_343_9

				local var_343_10 = var_343_9:GetComponentInChildren(typeof(CharacterEffect))

				var_343_10.enabled = true

				local var_343_11 = GameObjectTools.GetOrAddComponent(var_343_9, typeof(DynamicBoneHelper))

				if var_343_11 then
					var_343_11:EnableDynamicBone(false)
				end

				arg_340_1:ShowWeapon(var_343_10.transform, false)

				arg_340_1.var_[var_343_8 .. "Animator"] = var_343_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_340_1.var_[var_343_8 .. "Animator"].applyRootMotion = true
				arg_340_1.var_[var_343_8 .. "LipSync"] = var_343_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_343_12 = 0
			local var_343_13 = 0.525

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_12 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_14 = arg_340_1:GetWordFromCfg(1101103082)
				local var_343_15 = arg_340_1:FormatText(var_343_14.content)

				arg_340_1.text_.text = var_343_15

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_17 = 21 <= 0 and var_343_13 or var_343_13 * (utf8.len(var_343_15) / 21)

				if (21 <= 0 and var_343_13 or var_343_13 * (utf8.len(var_343_15) / 21)) > 0 and var_343_13 < var_343_17 then
					arg_340_1.talkMaxDuration = var_343_17

					if var_343_17 + var_343_12 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_17 + var_343_12
					end
				end

				arg_340_1.text_.text = var_343_15
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103082", "story_v_side_new_1101103.awb") ~= 0 then
					local var_343_18 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103082", "story_v_side_new_1101103.awb") / 1000

					if var_343_18 + var_343_12 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_18 + var_343_12
					end

					if var_343_14.prefab_name ~= "" and arg_340_1.actors_[var_343_14.prefab_name] ~= nil then
						local var_343_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_14.prefab_name].transform, "story_v_side_new_1101103", "1101103082", "story_v_side_new_1101103.awb")

						arg_340_1:RecordAudio("1101103082", var_343_19)
						arg_340_1:RecordAudio("1101103082", var_343_19)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103082", "story_v_side_new_1101103.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103082", "story_v_side_new_1101103.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_20 = math.max(var_343_13, arg_340_1.talkMaxDuration)

			if var_343_12 <= arg_340_1.time_ and arg_340_1.time_ < var_343_12 + var_343_20 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_12) / var_343_20

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_12 + var_343_20 and arg_340_1.time_ < var_343_12 + var_343_20 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play1101103083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 1101103083
		arg_344_1.duration_ = 7.03

		local var_344_0 = {
			zh = 6.6,
			ja = 7.033
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play1101103084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0.9

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_1 = arg_344_1:GetWordFromCfg(1101103083)
				local var_347_2 = arg_344_1:FormatText(var_347_1.content)

				arg_344_1.text_.text = var_347_2

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_4 = 36 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_2) / 36)

				if (36 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_2) / 36)) > 0 and var_347_0 < var_347_4 then
					arg_344_1.talkMaxDuration = var_347_4

					if var_347_4 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_4 + 0
					end
				end

				arg_344_1.text_.text = var_347_2
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103083", "story_v_side_new_1101103.awb") ~= 0 then
					local var_347_5 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103083", "story_v_side_new_1101103.awb") / 1000

					if var_347_5 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_5 + 0
					end

					if var_347_1.prefab_name ~= "" and arg_344_1.actors_[var_347_1.prefab_name] ~= nil then
						local var_347_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_1.prefab_name].transform, "story_v_side_new_1101103", "1101103083", "story_v_side_new_1101103.awb")

						arg_344_1:RecordAudio("1101103083", var_347_6)
						arg_344_1:RecordAudio("1101103083", var_347_6)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103083", "story_v_side_new_1101103.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103083", "story_v_side_new_1101103.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_7 = math.max(var_347_0, arg_344_1.talkMaxDuration)

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_7 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - 0) / var_347_7

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= 0 + var_347_7 and arg_344_1.time_ < 0 + var_347_7 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play1101103084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 1101103084
		arg_348_1.duration_ = 9.17

		local var_348_0 = {
			zh = 6.833,
			ja = 9.166
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play1101103085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_351_0 = 0
			local var_351_1 = 0.825

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_2 = arg_348_1:GetWordFromCfg(1101103084)
				local var_351_3 = arg_348_1:FormatText(var_351_2.content)

				arg_348_1.text_.text = var_351_3

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 33 <= 0 and var_351_1 or var_351_1 * (utf8.len(var_351_3) / 33)

				if (33 <= 0 and var_351_1 or var_351_1 * (utf8.len(var_351_3) / 33)) > 0 and var_351_1 < var_351_5 then
					arg_348_1.talkMaxDuration = var_351_5

					if var_351_5 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_3
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103084", "story_v_side_new_1101103.awb") ~= 0 then
					local var_351_6 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103084", "story_v_side_new_1101103.awb") / 1000

					if var_351_6 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_6 + var_351_0
					end

					if var_351_2.prefab_name ~= "" and arg_348_1.actors_[var_351_2.prefab_name] ~= nil then
						local var_351_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_2.prefab_name].transform, "story_v_side_new_1101103", "1101103084", "story_v_side_new_1101103.awb")

						arg_348_1:RecordAudio("1101103084", var_351_7)
						arg_348_1:RecordAudio("1101103084", var_351_7)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103084", "story_v_side_new_1101103.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103084", "story_v_side_new_1101103.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_8 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_8 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_8

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_8 and arg_348_1.time_ < var_351_0 + var_351_8 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play1101103085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 1101103085
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play1101103086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["1111ui_story"]) and arg_352_1.var_.characterEffect1111ui_story == nil then
				arg_352_1.var_.characterEffect1111ui_story = arg_352_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_0 = 0.200000002980232

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["1111ui_story"]) then
				if arg_352_1.var_.characterEffect1111ui_story and not isNil(arg_352_1.actors_["1111ui_story"]) then
					arg_352_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_352_1.time_ - 0) / var_355_0)
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["1111ui_story"]) and arg_352_1.var_.characterEffect1111ui_story then
				arg_352_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_355_1 = 0
			local var_355_2 = 0.05

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_3 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(1101103085).content)

				arg_352_1.text_.text = var_355_3

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 2 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 2)

				if (2 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 2)) > 0 and var_355_2 < var_355_5 then
					arg_352_1.talkMaxDuration = var_355_5

					if var_355_5 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_5 + var_355_1
					end
				end

				arg_352_1.text_.text = var_355_3
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_6 = math.max(var_355_2, arg_352_1.talkMaxDuration)

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_6 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_1) / var_355_6

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_1 + var_355_6 and arg_352_1.time_ < var_355_1 + var_355_6 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play1101103086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 1101103086
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play1101103087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0.125

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_1 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(1101103086).content)

				arg_356_1.text_.text = var_359_1

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_3 = 5 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_1) / 5)

				if (5 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_1) / 5)) > 0 and var_359_0 < var_359_3 then
					arg_356_1.talkMaxDuration = var_359_3

					if var_359_3 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_3 + 0
					end
				end

				arg_356_1.text_.text = var_359_1
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_4 = math.max(var_359_0, arg_356_1.talkMaxDuration)

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_4 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - 0) / var_359_4

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= 0 + var_359_4 and arg_356_1.time_ < 0 + var_359_4 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play1101103087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 1101103087
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play1101103088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0.6

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_1 = arg_360_1:FormatText(arg_360_1:GetWordFromCfg(1101103087).content)

				arg_360_1.text_.text = var_363_1

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_3 = 24 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_1) / 24)

				if (24 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_1) / 24)) > 0 and var_363_0 < var_363_3 then
					arg_360_1.talkMaxDuration = var_363_3

					if var_363_3 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_3 + 0
					end
				end

				arg_360_1.text_.text = var_363_1
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_4 = math.max(var_363_0, arg_360_1.talkMaxDuration)

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_4 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - 0) / var_363_4

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= 0 + var_363_4 and arg_360_1.time_ < 0 + var_363_4 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play1101103088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 1101103088
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play1101103089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.05

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_1 = arg_364_1:FormatText(arg_364_1:GetWordFromCfg(1101103088).content)

				arg_364_1.text_.text = var_367_1

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_3 = 2 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_1) / 2)

				if (2 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_1) / 2)) > 0 and var_367_0 < var_367_3 then
					arg_364_1.talkMaxDuration = var_367_3

					if var_367_3 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_3 + 0
					end
				end

				arg_364_1.text_.text = var_367_1
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_4 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_4 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_4

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_4 and arg_364_1.time_ < 0 + var_367_4 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play1101103089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 1101103089
		arg_368_1.duration_ = 3

		local var_368_0 = {
			zh = 1.999999999999,
			ja = 3
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play1101103090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.var_.moveOldPos1111ui_story = arg_368_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_371_0 = 0.001

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 then
				arg_368_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_368_1.time_ - 0) / var_371_0)
				arg_368_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1111ui_story"].transform.position).z)
				arg_368_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["1111ui_story"].transform.localEulerAngles = arg_368_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 then
				arg_368_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_368_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_368_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_368_1.actors_["1111ui_story"].transform.position).z)
				arg_368_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_368_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_368_1.actors_["1111ui_story"].transform.localEulerAngles = arg_368_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_371_1 = arg_368_1.actors_["1111ui_story"]

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(var_371_1) and arg_368_1.var_.characterEffect1111ui_story == nil then
				arg_368_1.var_.characterEffect1111ui_story = var_371_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_371_2 = 0.200000002980232

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_2 and not isNil(var_371_1) then
				if arg_368_1.var_.characterEffect1111ui_story and not isNil(var_371_1) then
					arg_368_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_368_1.time_ >= 0 + var_371_2 and arg_368_1.time_ < 0 + var_371_2 + arg_371_0 and not isNil(var_371_1) and arg_368_1.var_.characterEffect1111ui_story then
				arg_368_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_1")
			end

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_371_4 = 0
			local var_371_5 = 0.1

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_6 = arg_368_1:GetWordFromCfg(1101103089)
				local var_371_7 = arg_368_1:FormatText(var_371_6.content)

				arg_368_1.text_.text = var_371_7

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_9 = 4 <= 0 and var_371_5 or var_371_5 * (utf8.len(var_371_7) / 4)

				if (4 <= 0 and var_371_5 or var_371_5 * (utf8.len(var_371_7) / 4)) > 0 and var_371_5 < var_371_9 then
					arg_368_1.talkMaxDuration = var_371_9

					if var_371_9 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_9 + var_371_4
					end
				end

				arg_368_1.text_.text = var_371_7
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103089", "story_v_side_new_1101103.awb") ~= 0 then
					local var_371_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103089", "story_v_side_new_1101103.awb") / 1000

					if var_371_10 + var_371_4 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_10 + var_371_4
					end

					if var_371_6.prefab_name ~= "" and arg_368_1.actors_[var_371_6.prefab_name] ~= nil then
						local var_371_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_6.prefab_name].transform, "story_v_side_new_1101103", "1101103089", "story_v_side_new_1101103.awb")

						arg_368_1:RecordAudio("1101103089", var_371_11)
						arg_368_1:RecordAudio("1101103089", var_371_11)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103089", "story_v_side_new_1101103.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103089", "story_v_side_new_1101103.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_12 = math.max(var_371_5, arg_368_1.talkMaxDuration)

			if var_371_4 <= arg_368_1.time_ and arg_368_1.time_ < var_371_4 + var_371_12 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_4) / var_371_12

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_4 + var_371_12 and arg_368_1.time_ < var_371_4 + var_371_12 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_368_1:InitPlayNodeList()
	end,
	Play1101103090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 1101103090
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play1101103091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(arg_372_1.actors_["1111ui_story"]) and arg_372_1.var_.characterEffect1111ui_story == nil then
				arg_372_1.var_.characterEffect1111ui_story = arg_372_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_0 = 0.200000002980232

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 and not isNil(arg_372_1.actors_["1111ui_story"]) then
				if arg_372_1.var_.characterEffect1111ui_story and not isNil(arg_372_1.actors_["1111ui_story"]) then
					arg_372_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_372_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_372_1.time_ - 0) / var_375_0)
				end
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 and not isNil(arg_372_1.actors_["1111ui_story"]) and arg_372_1.var_.characterEffect1111ui_story then
				arg_372_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_372_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_375_1 = 0
			local var_375_2 = 0.425

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, true)
				arg_372_1.iconController_:SetSelectedState("hero")

				arg_372_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_372_1.callingController_:SetSelectedState("normal")

				arg_372_1.keyicon_.color = Color.New(1, 1, 1)
				arg_372_1.icon_.color = Color.New(1, 1, 1)

				local var_375_3 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(1101103090).content)

				arg_372_1.text_.text = var_375_3

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_5 = 17 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_3) / 17)

				if (17 <= 0 and var_375_2 or var_375_2 * (utf8.len(var_375_3) / 17)) > 0 and var_375_2 < var_375_5 then
					arg_372_1.talkMaxDuration = var_375_5

					if var_375_5 + var_375_1 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_5 + var_375_1
					end
				end

				arg_372_1.text_.text = var_375_3
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_6 = math.max(var_375_2, arg_372_1.talkMaxDuration)

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_6 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_1) / var_375_6

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_1 + var_375_6 and arg_372_1.time_ < var_375_1 + var_375_6 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play1101103091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1101103091
		arg_376_1.duration_ = 7.9

		local var_376_0 = {
			zh = 6.433,
			ja = 7.9
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1101103092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(arg_376_1.actors_["1111ui_story"]) and arg_376_1.var_.characterEffect1111ui_story == nil then
				arg_376_1.var_.characterEffect1111ui_story = arg_376_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_0 = 0.200000002980232

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 and not isNil(arg_376_1.actors_["1111ui_story"]) then
				if arg_376_1.var_.characterEffect1111ui_story and not isNil(arg_376_1.actors_["1111ui_story"]) then
					arg_376_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 and not isNil(arg_376_1.actors_["1111ui_story"]) and arg_376_1.var_.characterEffect1111ui_story then
				arg_376_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_379_2 = 0
			local var_379_3 = 0.725

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_2 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_4 = arg_376_1:GetWordFromCfg(1101103091)
				local var_379_5 = arg_376_1:FormatText(var_379_4.content)

				arg_376_1.text_.text = var_379_5

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_7 = 29 <= 0 and var_379_3 or var_379_3 * (utf8.len(var_379_5) / 29)

				if (29 <= 0 and var_379_3 or var_379_3 * (utf8.len(var_379_5) / 29)) > 0 and var_379_3 < var_379_7 then
					arg_376_1.talkMaxDuration = var_379_7

					if var_379_7 + var_379_2 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_7 + var_379_2
					end
				end

				arg_376_1.text_.text = var_379_5
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103091", "story_v_side_new_1101103.awb") ~= 0 then
					local var_379_8 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103091", "story_v_side_new_1101103.awb") / 1000

					if var_379_8 + var_379_2 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_8 + var_379_2
					end

					if var_379_4.prefab_name ~= "" and arg_376_1.actors_[var_379_4.prefab_name] ~= nil then
						local var_379_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_4.prefab_name].transform, "story_v_side_new_1101103", "1101103091", "story_v_side_new_1101103.awb")

						arg_376_1:RecordAudio("1101103091", var_379_9)
						arg_376_1:RecordAudio("1101103091", var_379_9)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103091", "story_v_side_new_1101103.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103091", "story_v_side_new_1101103.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_10 = math.max(var_379_3, arg_376_1.talkMaxDuration)

			if var_379_2 <= arg_376_1.time_ and arg_376_1.time_ < var_379_2 + var_379_10 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_2) / var_379_10

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_2 + var_379_10 and arg_376_1.time_ < var_379_2 + var_379_10 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play1101103092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1101103092
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1101103093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos1111ui_story = arg_380_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_383_0 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 then
				arg_380_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_380_1.time_ - 0) / var_383_0)
				arg_380_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1111ui_story"].transform.position).z)
				arg_380_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["1111ui_story"].transform.localEulerAngles = arg_380_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 then
				arg_380_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_380_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_380_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_380_1.actors_["1111ui_story"].transform.position).z)
				arg_380_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_380_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_380_1.actors_["1111ui_story"].transform.localEulerAngles = arg_380_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_383_1 = 0
			local var_383_2 = 0.925

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_1 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_3 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(1101103092).content)

				arg_380_1.text_.text = var_383_3

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 37 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 37)

				if (37 <= 0 and var_383_2 or var_383_2 * (utf8.len(var_383_3) / 37)) > 0 and var_383_2 < var_383_5 then
					arg_380_1.talkMaxDuration = var_383_5

					if var_383_5 + var_383_1 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_5 + var_383_1
					end
				end

				arg_380_1.text_.text = var_383_3
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_6 = math.max(var_383_2, arg_380_1.talkMaxDuration)

			if var_383_1 <= arg_380_1.time_ and arg_380_1.time_ < var_383_1 + var_383_6 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_1) / var_383_6

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_1 + var_383_6 and arg_380_1.time_ < var_383_1 + var_383_6 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play1101103093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 1101103093
		arg_384_1.duration_ = 9

		local var_384_0 = {
			zh = 7.4,
			ja = 9
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play1101103094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.var_.moveOldPos1111ui_story = arg_384_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_387_0 = 0.001

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 then
				arg_384_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos1111ui_story, Vector3.New(0, -0.87, -5.7), (arg_384_1.time_ - 0) / var_387_0)
				arg_384_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1111ui_story"].transform.position).z)
				arg_384_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["1111ui_story"].transform.localEulerAngles = arg_384_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 then
				arg_384_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, -0.87, -5.7)
				arg_384_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_384_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_384_1.actors_["1111ui_story"].transform.position).z)
				arg_384_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_384_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_384_1.actors_["1111ui_story"].transform.localEulerAngles = arg_384_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_387_1 = arg_384_1.actors_["1111ui_story"]

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(var_387_1) and arg_384_1.var_.characterEffect1111ui_story == nil then
				arg_384_1.var_.characterEffect1111ui_story = var_387_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.200000002980232

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_2 and not isNil(var_387_1) then
				if arg_384_1.var_.characterEffect1111ui_story and not isNil(var_387_1) then
					arg_384_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_384_1.time_ >= 0 + var_387_2 and arg_384_1.time_ < 0 + var_387_2 + arg_387_0 and not isNil(var_387_1) and arg_384_1.var_.characterEffect1111ui_story then
				arg_384_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_387_4 = 0
			local var_387_5 = 0.875

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_4 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_6 = arg_384_1:GetWordFromCfg(1101103093)
				local var_387_7 = arg_384_1:FormatText(var_387_6.content)

				arg_384_1.text_.text = var_387_7

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_9 = 35 <= 0 and var_387_5 or var_387_5 * (utf8.len(var_387_7) / 35)

				if (35 <= 0 and var_387_5 or var_387_5 * (utf8.len(var_387_7) / 35)) > 0 and var_387_5 < var_387_9 then
					arg_384_1.talkMaxDuration = var_387_9

					if var_387_9 + var_387_4 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_9 + var_387_4
					end
				end

				arg_384_1.text_.text = var_387_7
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103093", "story_v_side_new_1101103.awb") ~= 0 then
					local var_387_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103093", "story_v_side_new_1101103.awb") / 1000

					if var_387_10 + var_387_4 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_10 + var_387_4
					end

					if var_387_6.prefab_name ~= "" and arg_384_1.actors_[var_387_6.prefab_name] ~= nil then
						local var_387_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_6.prefab_name].transform, "story_v_side_new_1101103", "1101103093", "story_v_side_new_1101103.awb")

						arg_384_1:RecordAudio("1101103093", var_387_11)
						arg_384_1:RecordAudio("1101103093", var_387_11)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103093", "story_v_side_new_1101103.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103093", "story_v_side_new_1101103.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_12 = math.max(var_387_5, arg_384_1.talkMaxDuration)

			if var_387_4 <= arg_384_1.time_ and arg_384_1.time_ < var_387_4 + var_387_12 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_4) / var_387_12

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_4 + var_387_12 and arg_384_1.time_ < var_387_4 + var_387_12 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play1101103094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1101103094
		arg_388_1.duration_ = 10.17

		local var_388_0 = {
			zh = 8.666,
			ja = 10.166
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1101103095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos1011ui_story = arg_388_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_391_0 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 then
				arg_388_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_388_1.time_ - 0) / var_391_0)
				arg_388_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1011ui_story"].transform.position).z)
				arg_388_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["1011ui_story"].transform.localEulerAngles = arg_388_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 then
				arg_388_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_388_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_388_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_388_1.actors_["1011ui_story"].transform.position).z)
				arg_388_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_388_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_388_1.actors_["1011ui_story"].transform.localEulerAngles = arg_388_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_391_1 = arg_388_1.actors_["1011ui_story"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_1) and arg_388_1.var_.characterEffect1011ui_story == nil then
				arg_388_1.var_.characterEffect1011ui_story = var_391_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_2 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_2 and not isNil(var_391_1) then
				if arg_388_1.var_.characterEffect1011ui_story and not isNil(var_391_1) then
					arg_388_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= 0 + var_391_2 and arg_388_1.time_ < 0 + var_391_2 + arg_391_0 and not isNil(var_391_1) and arg_388_1.var_.characterEffect1011ui_story then
				arg_388_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_391_4 = arg_388_1.actors_["1111ui_story"].transform

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos1111ui_story = var_391_4.localPosition
			end

			local var_391_5 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_5 then
				var_391_4.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_388_1.time_ - 0) / var_391_5)
				var_391_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_4.position).x, (manager.ui.mainCamera.transform.position - var_391_4.position).y, (manager.ui.mainCamera.transform.position - var_391_4.position).z)
				var_391_4.localEulerAngles.z = 0
				var_391_4.localEulerAngles.x = 0
				var_391_4.localEulerAngles = var_391_4.localEulerAngles
			end

			if arg_388_1.time_ >= 0 + var_391_5 and arg_388_1.time_ < 0 + var_391_5 + arg_391_0 then
				var_391_4.localPosition = Vector3.New(0.7, -0.87, -5.7)
				var_391_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_391_4.position).x, (manager.ui.mainCamera.transform.position - var_391_4.position).y, (manager.ui.mainCamera.transform.position - var_391_4.position).z)
				var_391_4.localEulerAngles.z = 0
				var_391_4.localEulerAngles.x = 0
				var_391_4.localEulerAngles = var_391_4.localEulerAngles
			end

			local var_391_6 = arg_388_1.actors_["1111ui_story"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_6) and arg_388_1.var_.characterEffect1111ui_story == nil then
				arg_388_1.var_.characterEffect1111ui_story = var_391_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_7 = 0.200000002980232

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_7 and not isNil(var_391_6) then
				if arg_388_1.var_.characterEffect1111ui_story and not isNil(var_391_6) then
					arg_388_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_388_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_388_1.time_ - 0) / var_391_7)
				end
			end

			if arg_388_1.time_ >= 0 + var_391_7 and arg_388_1.time_ < 0 + var_391_7 + arg_391_0 and not isNil(var_391_6) and arg_388_1.var_.characterEffect1111ui_story then
				arg_388_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_388_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_391_8 = 0
			local var_391_9 = 0.875

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_10 = arg_388_1:GetWordFromCfg(1101103094)
				local var_391_11 = arg_388_1:FormatText(var_391_10.content)

				arg_388_1.text_.text = var_391_11

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_13 = 35 <= 0 and var_391_9 or var_391_9 * (utf8.len(var_391_11) / 35)

				if (35 <= 0 and var_391_9 or var_391_9 * (utf8.len(var_391_11) / 35)) > 0 and var_391_9 < var_391_13 then
					arg_388_1.talkMaxDuration = var_391_13

					if var_391_13 + var_391_8 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_13 + var_391_8
					end
				end

				arg_388_1.text_.text = var_391_11
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103094", "story_v_side_new_1101103.awb") ~= 0 then
					local var_391_14 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103094", "story_v_side_new_1101103.awb") / 1000

					if var_391_14 + var_391_8 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_14 + var_391_8
					end

					if var_391_10.prefab_name ~= "" and arg_388_1.actors_[var_391_10.prefab_name] ~= nil then
						local var_391_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_10.prefab_name].transform, "story_v_side_new_1101103", "1101103094", "story_v_side_new_1101103.awb")

						arg_388_1:RecordAudio("1101103094", var_391_15)
						arg_388_1:RecordAudio("1101103094", var_391_15)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103094", "story_v_side_new_1101103.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103094", "story_v_side_new_1101103.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_16 = math.max(var_391_9, arg_388_1.talkMaxDuration)

			if var_391_8 <= arg_388_1.time_ and arg_388_1.time_ < var_391_8 + var_391_16 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_8) / var_391_16

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_8 + var_391_16 and arg_388_1.time_ < var_391_8 + var_391_16 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play1101103095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1101103095
		arg_392_1.duration_ = 10.63

		local var_392_0 = {
			zh = 6.466,
			ja = 10.633
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1101103096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.var_.moveOldPos1111ui_story = arg_392_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_395_0 = 0.001

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 then
				arg_392_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_392_1.time_ - 0) / var_395_0)
				arg_392_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1111ui_story"].transform.position).z)
				arg_392_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["1111ui_story"].transform.localEulerAngles = arg_392_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 then
				arg_392_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_392_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_392_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_392_1.actors_["1111ui_story"].transform.position).z)
				arg_392_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_392_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_392_1.actors_["1111ui_story"].transform.localEulerAngles = arg_392_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_395_1 = arg_392_1.actors_["1111ui_story"]

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(var_395_1) and arg_392_1.var_.characterEffect1111ui_story == nil then
				arg_392_1.var_.characterEffect1111ui_story = var_395_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_2 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_2 and not isNil(var_395_1) then
				if arg_392_1.var_.characterEffect1111ui_story and not isNil(var_395_1) then
					arg_392_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= 0 + var_395_2 and arg_392_1.time_ < 0 + var_395_2 + arg_395_0 and not isNil(var_395_1) and arg_392_1.var_.characterEffect1111ui_story then
				arg_392_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_395_4 = arg_392_1.actors_["1011ui_story"]

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(var_395_4) and arg_392_1.var_.characterEffect1011ui_story == nil then
				arg_392_1.var_.characterEffect1011ui_story = var_395_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_5 = 0.200000002980232

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_5 and not isNil(var_395_4) then
				if arg_392_1.var_.characterEffect1011ui_story and not isNil(var_395_4) then
					arg_392_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_392_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_392_1.time_ - 0) / var_395_5)
				end
			end

			if arg_392_1.time_ >= 0 + var_395_5 and arg_392_1.time_ < 0 + var_395_5 + arg_395_0 and not isNil(var_395_4) and arg_392_1.var_.characterEffect1011ui_story then
				arg_392_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_392_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_395_6 = 0
			local var_395_7 = 0.75

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_6 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_8 = arg_392_1:GetWordFromCfg(1101103095)
				local var_395_9 = arg_392_1:FormatText(var_395_8.content)

				arg_392_1.text_.text = var_395_9

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_11 = 30 <= 0 and var_395_7 or var_395_7 * (utf8.len(var_395_9) / 30)

				if (30 <= 0 and var_395_7 or var_395_7 * (utf8.len(var_395_9) / 30)) > 0 and var_395_7 < var_395_11 then
					arg_392_1.talkMaxDuration = var_395_11

					if var_395_11 + var_395_6 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_11 + var_395_6
					end
				end

				arg_392_1.text_.text = var_395_9
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103095", "story_v_side_new_1101103.awb") ~= 0 then
					local var_395_12 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103095", "story_v_side_new_1101103.awb") / 1000

					if var_395_12 + var_395_6 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_12 + var_395_6
					end

					if var_395_8.prefab_name ~= "" and arg_392_1.actors_[var_395_8.prefab_name] ~= nil then
						local var_395_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_8.prefab_name].transform, "story_v_side_new_1101103", "1101103095", "story_v_side_new_1101103.awb")

						arg_392_1:RecordAudio("1101103095", var_395_13)
						arg_392_1:RecordAudio("1101103095", var_395_13)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103095", "story_v_side_new_1101103.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103095", "story_v_side_new_1101103.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_14 = math.max(var_395_7, arg_392_1.talkMaxDuration)

			if var_395_6 <= arg_392_1.time_ and arg_392_1.time_ < var_395_6 + var_395_14 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_6) / var_395_14

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_6 + var_395_14 and arg_392_1.time_ < var_395_6 + var_395_14 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play1101103096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1101103096
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play1101103097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(arg_396_1.actors_["1111ui_story"]) and arg_396_1.var_.characterEffect1111ui_story == nil then
				arg_396_1.var_.characterEffect1111ui_story = arg_396_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_0 = 0.200000002980232

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 and not isNil(arg_396_1.actors_["1111ui_story"]) then
				if arg_396_1.var_.characterEffect1111ui_story and not isNil(arg_396_1.actors_["1111ui_story"]) then
					arg_396_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_396_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_396_1.time_ - 0) / var_399_0)
				end
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 and not isNil(arg_396_1.actors_["1111ui_story"]) and arg_396_1.var_.characterEffect1111ui_story then
				arg_396_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_396_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_2")
			end

			local var_399_1 = 0
			local var_399_2 = 0.625

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, true)
				arg_396_1.iconController_:SetSelectedState("hero")

				arg_396_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_396_1.callingController_:SetSelectedState("normal")

				arg_396_1.keyicon_.color = Color.New(1, 1, 1)
				arg_396_1.icon_.color = Color.New(1, 1, 1)

				local var_399_3 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(1101103096).content)

				arg_396_1.text_.text = var_399_3

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_5 = 25 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_3) / 25)

				if (25 <= 0 and var_399_2 or var_399_2 * (utf8.len(var_399_3) / 25)) > 0 and var_399_2 < var_399_5 then
					arg_396_1.talkMaxDuration = var_399_5

					if var_399_5 + var_399_1 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_5 + var_399_1
					end
				end

				arg_396_1.text_.text = var_399_3
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_6 = math.max(var_399_2, arg_396_1.talkMaxDuration)

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_6 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_1) / var_399_6

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_1 + var_399_6 and arg_396_1.time_ < var_399_1 + var_399_6 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play1101103097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1101103097
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1101103098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0.65

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_1 = arg_400_1:FormatText(arg_400_1:GetWordFromCfg(1101103097).content)

				arg_400_1.text_.text = var_403_1

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_3 = 26 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_1) / 26)

				if (26 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_1) / 26)) > 0 and var_403_0 < var_403_3 then
					arg_400_1.talkMaxDuration = var_403_3

					if var_403_3 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_3 + 0
					end
				end

				arg_400_1.text_.text = var_403_1
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_4 = math.max(var_403_0, arg_400_1.talkMaxDuration)

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_4 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - 0) / var_403_4

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= 0 + var_403_4 and arg_400_1.time_ < 0 + var_403_4 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play1101103098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1101103098
		arg_404_1.duration_ = 5.5

		local var_404_0 = {
			zh = 5.5,
			ja = 5.233
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1101103099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.var_.moveOldPos1111ui_story = arg_404_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_407_0 = 0.001

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 then
				arg_404_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_404_1.time_ - 0) / var_407_0)
				arg_404_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1111ui_story"].transform.position).z)
				arg_404_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1111ui_story"].transform.localEulerAngles = arg_404_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 then
				arg_404_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_404_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_404_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_404_1.actors_["1111ui_story"].transform.position).z)
				arg_404_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_404_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_404_1.actors_["1111ui_story"].transform.localEulerAngles = arg_404_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_407_1 = arg_404_1.actors_["1111ui_story"]

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1111ui_story == nil then
				arg_404_1.var_.characterEffect1111ui_story = var_407_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_2 = 0.200000002980232

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_2 and not isNil(var_407_1) then
				if arg_404_1.var_.characterEffect1111ui_story and not isNil(var_407_1) then
					arg_404_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= 0 + var_407_2 and arg_404_1.time_ < 0 + var_407_2 + arg_407_0 and not isNil(var_407_1) and arg_404_1.var_.characterEffect1111ui_story then
				arg_404_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_407_4 = 0
			local var_407_5 = 0.6

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_4 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_6 = arg_404_1:GetWordFromCfg(1101103098)
				local var_407_7 = arg_404_1:FormatText(var_407_6.content)

				arg_404_1.text_.text = var_407_7

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_9 = 24 <= 0 and var_407_5 or var_407_5 * (utf8.len(var_407_7) / 24)

				if (24 <= 0 and var_407_5 or var_407_5 * (utf8.len(var_407_7) / 24)) > 0 and var_407_5 < var_407_9 then
					arg_404_1.talkMaxDuration = var_407_9

					if var_407_9 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_9 + var_407_4
					end
				end

				arg_404_1.text_.text = var_407_7
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103098", "story_v_side_new_1101103.awb") ~= 0 then
					local var_407_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103098", "story_v_side_new_1101103.awb") / 1000

					if var_407_10 + var_407_4 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_10 + var_407_4
					end

					if var_407_6.prefab_name ~= "" and arg_404_1.actors_[var_407_6.prefab_name] ~= nil then
						local var_407_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_6.prefab_name].transform, "story_v_side_new_1101103", "1101103098", "story_v_side_new_1101103.awb")

						arg_404_1:RecordAudio("1101103098", var_407_11)
						arg_404_1:RecordAudio("1101103098", var_407_11)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103098", "story_v_side_new_1101103.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103098", "story_v_side_new_1101103.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_12 = math.max(var_407_5, arg_404_1.talkMaxDuration)

			if var_407_4 <= arg_404_1.time_ and arg_404_1.time_ < var_407_4 + var_407_12 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_4) / var_407_12

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_4 + var_407_12 and arg_404_1.time_ < var_407_4 + var_407_12 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_404_1:InitPlayNodeList()
	end,
	Play1101103099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1101103099
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1101103100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(arg_408_1.actors_["1111ui_story"]) and arg_408_1.var_.characterEffect1111ui_story == nil then
				arg_408_1.var_.characterEffect1111ui_story = arg_408_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_0 = 0.200000002980232

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_0 and not isNil(arg_408_1.actors_["1111ui_story"]) then
				if arg_408_1.var_.characterEffect1111ui_story and not isNil(arg_408_1.actors_["1111ui_story"]) then
					arg_408_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_408_1.time_ - 0) / var_411_0)
				end
			end

			if arg_408_1.time_ >= 0 + var_411_0 and arg_408_1.time_ < 0 + var_411_0 + arg_411_0 and not isNil(arg_408_1.actors_["1111ui_story"]) and arg_408_1.var_.characterEffect1111ui_story then
				arg_408_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_411_1 = 0
			local var_411_2 = 0.85

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_3 = arg_408_1:FormatText(arg_408_1:GetWordFromCfg(1101103099).content)

				arg_408_1.text_.text = var_411_3

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_5 = 34 <= 0 and var_411_2 or var_411_2 * (utf8.len(var_411_3) / 34)

				if (34 <= 0 and var_411_2 or var_411_2 * (utf8.len(var_411_3) / 34)) > 0 and var_411_2 < var_411_5 then
					arg_408_1.talkMaxDuration = var_411_5

					if var_411_5 + var_411_1 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_5 + var_411_1
					end
				end

				arg_408_1.text_.text = var_411_3
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_6 = math.max(var_411_2, arg_408_1.talkMaxDuration)

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_6 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_1) / var_411_6

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_1 + var_411_6 and arg_408_1.time_ < var_411_1 + var_411_6 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play1101103100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1101103100
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1101103101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0.775

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, false)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_1 = arg_412_1:FormatText(arg_412_1:GetWordFromCfg(1101103100).content)

				arg_412_1.text_.text = var_415_1

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_3 = 31 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_1) / 31)

				if (31 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_1) / 31)) > 0 and var_415_0 < var_415_3 then
					arg_412_1.talkMaxDuration = var_415_3

					if var_415_3 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_3 + 0
					end
				end

				arg_412_1.text_.text = var_415_1
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_4 = math.max(var_415_0, arg_412_1.talkMaxDuration)

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_4 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - 0) / var_415_4

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= 0 + var_415_4 and arg_412_1.time_ < 0 + var_415_4 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play1101103101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1101103101
		arg_416_1.duration_ = 5

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1101103102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0.925

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_416_1.callingController_:SetSelectedState("normal")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_1 = arg_416_1:FormatText(arg_416_1:GetWordFromCfg(1101103101).content)

				arg_416_1.text_.text = var_419_1

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_3 = 37 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_1) / 37)

				if (37 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_1) / 37)) > 0 and var_419_0 < var_419_3 then
					arg_416_1.talkMaxDuration = var_419_3

					if var_419_3 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_3 + 0
					end
				end

				arg_416_1.text_.text = var_419_1
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)
				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_4 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_4 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_4

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_4 and arg_416_1.time_ < 0 + var_419_4 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play1101103102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1101103102
		arg_420_1.duration_ = 2

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1101103103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos1011ui_story = arg_420_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_423_0 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 then
				arg_420_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_420_1.time_ - 0) / var_423_0)
				arg_420_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1011ui_story"].transform.position).z)
				arg_420_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["1011ui_story"].transform.localEulerAngles = arg_420_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 then
				arg_420_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_420_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_420_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_420_1.actors_["1011ui_story"].transform.position).z)
				arg_420_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_420_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_420_1.actors_["1011ui_story"].transform.localEulerAngles = arg_420_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_423_1 = arg_420_1.actors_["1011ui_story"]

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(var_423_1) and arg_420_1.var_.characterEffect1011ui_story == nil then
				arg_420_1.var_.characterEffect1011ui_story = var_423_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.200000002980232

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_2 and not isNil(var_423_1) then
				if arg_420_1.var_.characterEffect1011ui_story and not isNil(var_423_1) then
					arg_420_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= 0 + var_423_2 and arg_420_1.time_ < 0 + var_423_2 + arg_423_0 and not isNil(var_423_1) and arg_420_1.var_.characterEffect1011ui_story then
				arg_420_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_423_4 = 0
			local var_423_5 = 0.1

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_4 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_6 = arg_420_1:GetWordFromCfg(1101103102)
				local var_423_7 = arg_420_1:FormatText(var_423_6.content)

				arg_420_1.text_.text = var_423_7

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_9 = 4 <= 0 and var_423_5 or var_423_5 * (utf8.len(var_423_7) / 4)

				if (4 <= 0 and var_423_5 or var_423_5 * (utf8.len(var_423_7) / 4)) > 0 and var_423_5 < var_423_9 then
					arg_420_1.talkMaxDuration = var_423_9

					if var_423_9 + var_423_4 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_9 + var_423_4
					end
				end

				arg_420_1.text_.text = var_423_7
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103102", "story_v_side_new_1101103.awb") ~= 0 then
					local var_423_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103102", "story_v_side_new_1101103.awb") / 1000

					if var_423_10 + var_423_4 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_10 + var_423_4
					end

					if var_423_6.prefab_name ~= "" and arg_420_1.actors_[var_423_6.prefab_name] ~= nil then
						local var_423_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_6.prefab_name].transform, "story_v_side_new_1101103", "1101103102", "story_v_side_new_1101103.awb")

						arg_420_1:RecordAudio("1101103102", var_423_11)
						arg_420_1:RecordAudio("1101103102", var_423_11)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103102", "story_v_side_new_1101103.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103102", "story_v_side_new_1101103.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_12 = math.max(var_423_5, arg_420_1.talkMaxDuration)

			if var_423_4 <= arg_420_1.time_ and arg_420_1.time_ < var_423_4 + var_423_12 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_4) / var_423_12

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_4 + var_423_12 and arg_420_1.time_ < var_423_4 + var_423_12 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
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

		arg_420_1:InitPlayNodeList()
	end,
	Play1101103103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1101103103
		arg_424_1.duration_ = 2.37

		local var_424_0 = {
			zh = 1.999999999999,
			ja = 2.366
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1101103104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos1111ui_story = arg_424_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_427_0 = 0.001

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_0 then
				arg_424_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_424_1.time_ - 0) / var_427_0)
				arg_424_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1111ui_story"].transform.position).z)
				arg_424_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["1111ui_story"].transform.localEulerAngles = arg_424_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_424_1.time_ >= 0 + var_427_0 and arg_424_1.time_ < 0 + var_427_0 + arg_427_0 then
				arg_424_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_424_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_424_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_424_1.actors_["1111ui_story"].transform.position).z)
				arg_424_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_424_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_424_1.actors_["1111ui_story"].transform.localEulerAngles = arg_424_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_427_1 = arg_424_1.actors_["1111ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect1111ui_story == nil then
				arg_424_1.var_.characterEffect1111ui_story = var_427_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_2 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_2 and not isNil(var_427_1) then
				if arg_424_1.var_.characterEffect1111ui_story and not isNil(var_427_1) then
					arg_424_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= 0 + var_427_2 and arg_424_1.time_ < 0 + var_427_2 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect1111ui_story then
				arg_424_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_427_4 = arg_424_1.actors_["1011ui_story"]

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 and not isNil(var_427_4) and arg_424_1.var_.characterEffect1011ui_story == nil then
				arg_424_1.var_.characterEffect1011ui_story = var_427_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_5 = 0.200000002980232

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_5 and not isNil(var_427_4) then
				if arg_424_1.var_.characterEffect1011ui_story and not isNil(var_427_4) then
					arg_424_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_424_1.time_ - 0) / var_427_5)
				end
			end

			if arg_424_1.time_ >= 0 + var_427_5 and arg_424_1.time_ < 0 + var_427_5 + arg_427_0 and not isNil(var_427_4) and arg_424_1.var_.characterEffect1011ui_story then
				arg_424_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_427_6 = 0
			local var_427_7 = 0.15

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_6 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_8 = arg_424_1:GetWordFromCfg(1101103103)
				local var_427_9 = arg_424_1:FormatText(var_427_8.content)

				arg_424_1.text_.text = var_427_9

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_11 = 6 <= 0 and var_427_7 or var_427_7 * (utf8.len(var_427_9) / 6)

				if (6 <= 0 and var_427_7 or var_427_7 * (utf8.len(var_427_9) / 6)) > 0 and var_427_7 < var_427_11 then
					arg_424_1.talkMaxDuration = var_427_11

					if var_427_11 + var_427_6 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_11 + var_427_6
					end
				end

				arg_424_1.text_.text = var_427_9
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103103", "story_v_side_new_1101103.awb") ~= 0 then
					local var_427_12 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103103", "story_v_side_new_1101103.awb") / 1000

					if var_427_12 + var_427_6 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_12 + var_427_6
					end

					if var_427_8.prefab_name ~= "" and arg_424_1.actors_[var_427_8.prefab_name] ~= nil then
						local var_427_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_8.prefab_name].transform, "story_v_side_new_1101103", "1101103103", "story_v_side_new_1101103.awb")

						arg_424_1:RecordAudio("1101103103", var_427_13)
						arg_424_1:RecordAudio("1101103103", var_427_13)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103103", "story_v_side_new_1101103.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103103", "story_v_side_new_1101103.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_14 = math.max(var_427_7, arg_424_1.talkMaxDuration)

			if var_427_6 <= arg_424_1.time_ and arg_424_1.time_ < var_427_6 + var_427_14 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_6) / var_427_14

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_6 + var_427_14 and arg_424_1.time_ < var_427_6 + var_427_14 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play1101103104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1101103104
		arg_428_1.duration_ = 5.17

		local var_428_0 = {
			zh = 3,
			ja = 5.166
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1101103105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.var_.moveOldPos1011ui_story = arg_428_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_431_0 = 0.001

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_0 then
				arg_428_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_428_1.time_ - 0) / var_431_0)
				arg_428_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1011ui_story"].transform.position).z)
				arg_428_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["1011ui_story"].transform.localEulerAngles = arg_428_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_428_1.time_ >= 0 + var_431_0 and arg_428_1.time_ < 0 + var_431_0 + arg_431_0 then
				arg_428_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_428_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_428_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_428_1.actors_["1011ui_story"].transform.position).z)
				arg_428_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_428_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_428_1.actors_["1011ui_story"].transform.localEulerAngles = arg_428_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_431_1 = arg_428_1.actors_["1011ui_story"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_1) and arg_428_1.var_.characterEffect1011ui_story == nil then
				arg_428_1.var_.characterEffect1011ui_story = var_431_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_2 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_2 and not isNil(var_431_1) then
				if arg_428_1.var_.characterEffect1011ui_story and not isNil(var_431_1) then
					arg_428_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_428_1.time_ >= 0 + var_431_2 and arg_428_1.time_ < 0 + var_431_2 + arg_431_0 and not isNil(var_431_1) and arg_428_1.var_.characterEffect1011ui_story then
				arg_428_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_431_4 = arg_428_1.actors_["1111ui_story"]

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 and not isNil(var_431_4) and arg_428_1.var_.characterEffect1111ui_story == nil then
				arg_428_1.var_.characterEffect1111ui_story = var_431_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_5 = 0.200000002980232

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_5 and not isNil(var_431_4) then
				if arg_428_1.var_.characterEffect1111ui_story and not isNil(var_431_4) then
					arg_428_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_428_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_428_1.time_ - 0) / var_431_5)
				end
			end

			if arg_428_1.time_ >= 0 + var_431_5 and arg_428_1.time_ < 0 + var_431_5 + arg_431_0 and not isNil(var_431_4) and arg_428_1.var_.characterEffect1111ui_story then
				arg_428_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_428_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_431_6 = 0
			local var_431_7 = 0.55

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_6 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_8 = arg_428_1:GetWordFromCfg(1101103104)
				local var_431_9 = arg_428_1:FormatText(var_431_8.content)

				arg_428_1.text_.text = var_431_9

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_11 = 22 <= 0 and var_431_7 or var_431_7 * (utf8.len(var_431_9) / 22)

				if (22 <= 0 and var_431_7 or var_431_7 * (utf8.len(var_431_9) / 22)) > 0 and var_431_7 < var_431_11 then
					arg_428_1.talkMaxDuration = var_431_11

					if var_431_11 + var_431_6 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_11 + var_431_6
					end
				end

				arg_428_1.text_.text = var_431_9
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103104", "story_v_side_new_1101103.awb") ~= 0 then
					local var_431_12 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103104", "story_v_side_new_1101103.awb") / 1000

					if var_431_12 + var_431_6 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_12 + var_431_6
					end

					if var_431_8.prefab_name ~= "" and arg_428_1.actors_[var_431_8.prefab_name] ~= nil then
						local var_431_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_8.prefab_name].transform, "story_v_side_new_1101103", "1101103104", "story_v_side_new_1101103.awb")

						arg_428_1:RecordAudio("1101103104", var_431_13)
						arg_428_1:RecordAudio("1101103104", var_431_13)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103104", "story_v_side_new_1101103.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103104", "story_v_side_new_1101103.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_14 = math.max(var_431_7, arg_428_1.talkMaxDuration)

			if var_431_6 <= arg_428_1.time_ and arg_428_1.time_ < var_431_6 + var_431_14 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_6) / var_431_14

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_6 + var_431_14 and arg_428_1.time_ < var_431_6 + var_431_14 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
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

		arg_428_1:InitPlayNodeList()
	end,
	Play1101103105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1101103105
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1101103106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(arg_432_1.actors_["1011ui_story"]) and arg_432_1.var_.characterEffect1011ui_story == nil then
				arg_432_1.var_.characterEffect1011ui_story = arg_432_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_0 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 and not isNil(arg_432_1.actors_["1011ui_story"]) then
				if arg_432_1.var_.characterEffect1011ui_story and not isNil(arg_432_1.actors_["1011ui_story"]) then
					arg_432_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_432_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_432_1.time_ - 0) / var_435_0)
				end
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 and not isNil(arg_432_1.actors_["1011ui_story"]) and arg_432_1.var_.characterEffect1011ui_story then
				arg_432_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_432_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_435_1 = 0
			local var_435_2 = 0.725

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_3 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(1101103105).content)

				arg_432_1.text_.text = var_435_3

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_5 = 29 <= 0 and var_435_2 or var_435_2 * (utf8.len(var_435_3) / 29)

				if (29 <= 0 and var_435_2 or var_435_2 * (utf8.len(var_435_3) / 29)) > 0 and var_435_2 < var_435_5 then
					arg_432_1.talkMaxDuration = var_435_5

					if var_435_5 + var_435_1 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_5 + var_435_1
					end
				end

				arg_432_1.text_.text = var_435_3
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_6 = math.max(var_435_2, arg_432_1.talkMaxDuration)

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_6 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_1) / var_435_6

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_1 + var_435_6 and arg_432_1.time_ < var_435_1 + var_435_6 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1101103106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1101103106
		arg_436_1.duration_ = 4.37

		local var_436_0 = {
			zh = 4.366,
			ja = 2.766
		}
		local var_436_1 = manager.audio:GetLocalizationFlag()

		if var_436_0[var_436_1] ~= nil then
			arg_436_1.duration_ = var_436_0[var_436_1]
		end

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1101103107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPos1111ui_story = arg_436_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_439_0 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_0 then
				arg_436_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_436_1.time_ - 0) / var_439_0)
				arg_436_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1111ui_story"].transform.position).z)
				arg_436_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["1111ui_story"].transform.localEulerAngles = arg_436_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_436_1.time_ >= 0 + var_439_0 and arg_436_1.time_ < 0 + var_439_0 + arg_439_0 then
				arg_436_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_436_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_436_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_436_1.actors_["1111ui_story"].transform.position).z)
				arg_436_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_436_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_436_1.actors_["1111ui_story"].transform.localEulerAngles = arg_436_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_439_1 = arg_436_1.actors_["1111ui_story"]

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 and not isNil(var_439_1) and arg_436_1.var_.characterEffect1111ui_story == nil then
				arg_436_1.var_.characterEffect1111ui_story = var_439_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.200000002980232

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_2 and not isNil(var_439_1) then
				if arg_436_1.var_.characterEffect1111ui_story and not isNil(var_439_1) then
					arg_436_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= 0 + var_439_2 and arg_436_1.time_ < 0 + var_439_2 + arg_439_0 and not isNil(var_439_1) and arg_436_1.var_.characterEffect1111ui_story then
				arg_436_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_439_4 = 0
			local var_439_5 = 0.4

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_4 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_6 = arg_436_1:GetWordFromCfg(1101103106)
				local var_439_7 = arg_436_1:FormatText(var_439_6.content)

				arg_436_1.text_.text = var_439_7

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_9 = 16 <= 0 and var_439_5 or var_439_5 * (utf8.len(var_439_7) / 16)

				if (16 <= 0 and var_439_5 or var_439_5 * (utf8.len(var_439_7) / 16)) > 0 and var_439_5 < var_439_9 then
					arg_436_1.talkMaxDuration = var_439_9

					if var_439_9 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_9 + var_439_4
					end
				end

				arg_436_1.text_.text = var_439_7
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103106", "story_v_side_new_1101103.awb") ~= 0 then
					local var_439_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103106", "story_v_side_new_1101103.awb") / 1000

					if var_439_10 + var_439_4 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_10 + var_439_4
					end

					if var_439_6.prefab_name ~= "" and arg_436_1.actors_[var_439_6.prefab_name] ~= nil then
						local var_439_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_6.prefab_name].transform, "story_v_side_new_1101103", "1101103106", "story_v_side_new_1101103.awb")

						arg_436_1:RecordAudio("1101103106", var_439_11)
						arg_436_1:RecordAudio("1101103106", var_439_11)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103106", "story_v_side_new_1101103.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103106", "story_v_side_new_1101103.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_12 = math.max(var_439_5, arg_436_1.talkMaxDuration)

			if var_439_4 <= arg_436_1.time_ and arg_436_1.time_ < var_439_4 + var_439_12 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_4) / var_439_12

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_4 + var_439_12 and arg_436_1.time_ < var_439_4 + var_439_12 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_436_1:InitPlayNodeList()
	end,
	Play1101103107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1101103107
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1101103108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(arg_440_1.actors_["1111ui_story"]) and arg_440_1.var_.characterEffect1111ui_story == nil then
				arg_440_1.var_.characterEffect1111ui_story = arg_440_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_0 = 0.200000002980232

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_0 and not isNil(arg_440_1.actors_["1111ui_story"]) then
				if arg_440_1.var_.characterEffect1111ui_story and not isNil(arg_440_1.actors_["1111ui_story"]) then
					arg_440_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_440_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_440_1.time_ - 0) / var_443_0)
				end
			end

			if arg_440_1.time_ >= 0 + var_443_0 and arg_440_1.time_ < 0 + var_443_0 + arg_443_0 and not isNil(arg_440_1.actors_["1111ui_story"]) and arg_440_1.var_.characterEffect1111ui_story then
				arg_440_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_440_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_443_1 = 0
			local var_443_2 = 0.675

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, false)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_3 = arg_440_1:FormatText(arg_440_1:GetWordFromCfg(1101103107).content)

				arg_440_1.text_.text = var_443_3

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_5 = 27 <= 0 and var_443_2 or var_443_2 * (utf8.len(var_443_3) / 27)

				if (27 <= 0 and var_443_2 or var_443_2 * (utf8.len(var_443_3) / 27)) > 0 and var_443_2 < var_443_5 then
					arg_440_1.talkMaxDuration = var_443_5

					if var_443_5 + var_443_1 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_5 + var_443_1
					end
				end

				arg_440_1.text_.text = var_443_3
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_6 = math.max(var_443_2, arg_440_1.talkMaxDuration)

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_6 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_1) / var_443_6

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_1 + var_443_6 and arg_440_1.time_ < var_443_1 + var_443_6 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play1101103108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1101103108
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1101103109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0.325

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_1 = arg_444_1:FormatText(arg_444_1:GetWordFromCfg(1101103108).content)

				arg_444_1.text_.text = var_447_1

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_3 = 13 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_1) / 13)

				if (13 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_1) / 13)) > 0 and var_447_0 < var_447_3 then
					arg_444_1.talkMaxDuration = var_447_3

					if var_447_3 + 0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_3 + 0
					end
				end

				arg_444_1.text_.text = var_447_1
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_4 = math.max(var_447_0, arg_444_1.talkMaxDuration)

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_4 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - 0) / var_447_4

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= 0 + var_447_4 and arg_444_1.time_ < 0 + var_447_4 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play1101103109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1101103109
		arg_448_1.duration_ = 10.67

		local var_448_0 = {
			zh = 8.033,
			ja = 10.666
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1101103110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.var_.moveOldPos1011ui_story = arg_448_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_451_0 = 0.001

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 then
				arg_448_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_448_1.time_ - 0) / var_451_0)
				arg_448_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_448_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1011ui_story"].transform.position).z)
				arg_448_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_448_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_448_1.actors_["1011ui_story"].transform.localEulerAngles = arg_448_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 then
				arg_448_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_448_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_448_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1011ui_story"].transform.position).z)
				arg_448_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_448_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_448_1.actors_["1011ui_story"].transform.localEulerAngles = arg_448_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_451_1 = arg_448_1.actors_["1011ui_story"]

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(var_451_1) and arg_448_1.var_.characterEffect1011ui_story == nil then
				arg_448_1.var_.characterEffect1011ui_story = var_451_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_2 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_2 and not isNil(var_451_1) then
				if arg_448_1.var_.characterEffect1011ui_story and not isNil(var_451_1) then
					arg_448_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_448_1.time_ >= 0 + var_451_2 and arg_448_1.time_ < 0 + var_451_2 + arg_451_0 and not isNil(var_451_1) and arg_448_1.var_.characterEffect1011ui_story then
				arg_448_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action447")
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_451_4 = 0
			local var_451_5 = 0.75

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_4 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_6 = arg_448_1:GetWordFromCfg(1101103109)
				local var_451_7 = arg_448_1:FormatText(var_451_6.content)

				arg_448_1.text_.text = var_451_7

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_9 = 30 <= 0 and var_451_5 or var_451_5 * (utf8.len(var_451_7) / 30)

				if (30 <= 0 and var_451_5 or var_451_5 * (utf8.len(var_451_7) / 30)) > 0 and var_451_5 < var_451_9 then
					arg_448_1.talkMaxDuration = var_451_9

					if var_451_9 + var_451_4 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_9 + var_451_4
					end
				end

				arg_448_1.text_.text = var_451_7
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103109", "story_v_side_new_1101103.awb") ~= 0 then
					local var_451_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103109", "story_v_side_new_1101103.awb") / 1000

					if var_451_10 + var_451_4 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_10 + var_451_4
					end

					if var_451_6.prefab_name ~= "" and arg_448_1.actors_[var_451_6.prefab_name] ~= nil then
						local var_451_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_6.prefab_name].transform, "story_v_side_new_1101103", "1101103109", "story_v_side_new_1101103.awb")

						arg_448_1:RecordAudio("1101103109", var_451_11)
						arg_448_1:RecordAudio("1101103109", var_451_11)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103109", "story_v_side_new_1101103.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103109", "story_v_side_new_1101103.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_12 = math.max(var_451_5, arg_448_1.talkMaxDuration)

			if var_451_4 <= arg_448_1.time_ and arg_448_1.time_ < var_451_4 + var_451_12 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_4) / var_451_12

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_4 + var_451_12 and arg_448_1.time_ < var_451_4 + var_451_12 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
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

		arg_448_1:InitPlayNodeList()
	end,
	Play1101103110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1101103110
		arg_452_1.duration_ = 2

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1101103111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.var_.moveOldPos1111ui_story = arg_452_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_455_0 = 0.001

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 then
				arg_452_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_452_1.time_ - 0) / var_455_0)
				arg_452_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1111ui_story"].transform.position).z)
				arg_452_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["1111ui_story"].transform.localEulerAngles = arg_452_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 then
				arg_452_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_452_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_452_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_452_1.actors_["1111ui_story"].transform.position).z)
				arg_452_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_452_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_452_1.actors_["1111ui_story"].transform.localEulerAngles = arg_452_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_455_1 = arg_452_1.actors_["1111ui_story"]

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(var_455_1) and arg_452_1.var_.characterEffect1111ui_story == nil then
				arg_452_1.var_.characterEffect1111ui_story = var_455_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_2 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_2 and not isNil(var_455_1) then
				if arg_452_1.var_.characterEffect1111ui_story and not isNil(var_455_1) then
					arg_452_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_452_1.time_ >= 0 + var_455_2 and arg_452_1.time_ < 0 + var_455_2 + arg_455_0 and not isNil(var_455_1) and arg_452_1.var_.characterEffect1111ui_story then
				arg_452_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_455_4 = arg_452_1.actors_["1011ui_story"]

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(var_455_4) and arg_452_1.var_.characterEffect1011ui_story == nil then
				arg_452_1.var_.characterEffect1011ui_story = var_455_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_5 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_5 and not isNil(var_455_4) then
				if arg_452_1.var_.characterEffect1011ui_story and not isNil(var_455_4) then
					arg_452_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_452_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_452_1.time_ - 0) / var_455_5)
				end
			end

			if arg_452_1.time_ >= 0 + var_455_5 and arg_452_1.time_ < 0 + var_455_5 + arg_455_0 and not isNil(var_455_4) and arg_452_1.var_.characterEffect1011ui_story then
				arg_452_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_452_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_1")
			end

			local var_455_6 = 0
			local var_455_7 = 0.05

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_6 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_8 = arg_452_1:GetWordFromCfg(1101103110)
				local var_455_9 = arg_452_1:FormatText(var_455_8.content)

				arg_452_1.text_.text = var_455_9

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_11 = 2 <= 0 and var_455_7 or var_455_7 * (utf8.len(var_455_9) / 2)

				if (2 <= 0 and var_455_7 or var_455_7 * (utf8.len(var_455_9) / 2)) > 0 and var_455_7 < var_455_11 then
					arg_452_1.talkMaxDuration = var_455_11

					if var_455_11 + var_455_6 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_11 + var_455_6
					end
				end

				arg_452_1.text_.text = var_455_9
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103110", "story_v_side_new_1101103.awb") ~= 0 then
					local var_455_12 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103110", "story_v_side_new_1101103.awb") / 1000

					if var_455_12 + var_455_6 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_12 + var_455_6
					end

					if var_455_8.prefab_name ~= "" and arg_452_1.actors_[var_455_8.prefab_name] ~= nil then
						local var_455_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_8.prefab_name].transform, "story_v_side_new_1101103", "1101103110", "story_v_side_new_1101103.awb")

						arg_452_1:RecordAudio("1101103110", var_455_13)
						arg_452_1:RecordAudio("1101103110", var_455_13)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103110", "story_v_side_new_1101103.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103110", "story_v_side_new_1101103.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_14 = math.max(var_455_7, arg_452_1.talkMaxDuration)

			if var_455_6 <= arg_452_1.time_ and arg_452_1.time_ < var_455_6 + var_455_14 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_6) / var_455_14

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_6 + var_455_14 and arg_452_1.time_ < var_455_6 + var_455_14 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play1101103111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1101103111
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1101103112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(arg_456_1.actors_["1111ui_story"]) and arg_456_1.var_.characterEffect1111ui_story == nil then
				arg_456_1.var_.characterEffect1111ui_story = arg_456_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_0 = 0.200000002980232

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_0 and not isNil(arg_456_1.actors_["1111ui_story"]) then
				if arg_456_1.var_.characterEffect1111ui_story and not isNil(arg_456_1.actors_["1111ui_story"]) then
					arg_456_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_456_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_456_1.time_ - 0) / var_459_0)
				end
			end

			if arg_456_1.time_ >= 0 + var_459_0 and arg_456_1.time_ < 0 + var_459_0 + arg_459_0 and not isNil(arg_456_1.actors_["1111ui_story"]) and arg_456_1.var_.characterEffect1111ui_story then
				arg_456_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_456_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_459_1 = 0
			local var_459_2 = 0.05

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, true)
				arg_456_1.iconController_:SetSelectedState("hero")

				arg_456_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_456_1.callingController_:SetSelectedState("normal")

				arg_456_1.keyicon_.color = Color.New(1, 1, 1)
				arg_456_1.icon_.color = Color.New(1, 1, 1)

				local var_459_3 = arg_456_1:FormatText(arg_456_1:GetWordFromCfg(1101103111).content)

				arg_456_1.text_.text = var_459_3

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_5 = 2 <= 0 and var_459_2 or var_459_2 * (utf8.len(var_459_3) / 2)

				if (2 <= 0 and var_459_2 or var_459_2 * (utf8.len(var_459_3) / 2)) > 0 and var_459_2 < var_459_5 then
					arg_456_1.talkMaxDuration = var_459_5

					if var_459_5 + var_459_1 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_5 + var_459_1
					end
				end

				arg_456_1.text_.text = var_459_3
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_6 = math.max(var_459_2, arg_456_1.talkMaxDuration)

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_6 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_1) / var_459_6

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_1 + var_459_6 and arg_456_1.time_ < var_459_1 + var_459_6 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play1101103112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1101103112
		arg_460_1.duration_ = 5.6

		local var_460_0 = {
			zh = 5.333,
			ja = 5.6
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1101103113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.var_.moveOldPos1011ui_story = arg_460_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_463_0 = 0.001

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_0 then
				arg_460_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_460_1.time_ - 0) / var_463_0)
				arg_460_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1011ui_story"].transform.position).z)
				arg_460_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["1011ui_story"].transform.localEulerAngles = arg_460_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_460_1.time_ >= 0 + var_463_0 and arg_460_1.time_ < 0 + var_463_0 + arg_463_0 then
				arg_460_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_460_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1011ui_story"].transform.position).z)
				arg_460_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["1011ui_story"].transform.localEulerAngles = arg_460_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_463_1 = arg_460_1.actors_["1011ui_story"]

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(var_463_1) and arg_460_1.var_.characterEffect1011ui_story == nil then
				arg_460_1.var_.characterEffect1011ui_story = var_463_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_2 = 0.200000002980232

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_2 and not isNil(var_463_1) then
				if arg_460_1.var_.characterEffect1011ui_story and not isNil(var_463_1) then
					arg_460_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_460_1.time_ >= 0 + var_463_2 and arg_460_1.time_ < 0 + var_463_2 + arg_463_0 and not isNil(var_463_1) and arg_460_1.var_.characterEffect1011ui_story then
				arg_460_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action7_2")
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_463_4 = 0
			local var_463_5 = 0.7

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_4 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_6 = arg_460_1:GetWordFromCfg(1101103112)
				local var_463_7 = arg_460_1:FormatText(var_463_6.content)

				arg_460_1.text_.text = var_463_7

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_9 = 28 <= 0 and var_463_5 or var_463_5 * (utf8.len(var_463_7) / 28)

				if (28 <= 0 and var_463_5 or var_463_5 * (utf8.len(var_463_7) / 28)) > 0 and var_463_5 < var_463_9 then
					arg_460_1.talkMaxDuration = var_463_9

					if var_463_9 + var_463_4 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_9 + var_463_4
					end
				end

				arg_460_1.text_.text = var_463_7
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103112", "story_v_side_new_1101103.awb") ~= 0 then
					local var_463_10 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103112", "story_v_side_new_1101103.awb") / 1000

					if var_463_10 + var_463_4 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_10 + var_463_4
					end

					if var_463_6.prefab_name ~= "" and arg_460_1.actors_[var_463_6.prefab_name] ~= nil then
						local var_463_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_6.prefab_name].transform, "story_v_side_new_1101103", "1101103112", "story_v_side_new_1101103.awb")

						arg_460_1:RecordAudio("1101103112", var_463_11)
						arg_460_1:RecordAudio("1101103112", var_463_11)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103112", "story_v_side_new_1101103.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103112", "story_v_side_new_1101103.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_12 = math.max(var_463_5, arg_460_1.talkMaxDuration)

			if var_463_4 <= arg_460_1.time_ and arg_460_1.time_ < var_463_4 + var_463_12 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_4) / var_463_12

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_4 + var_463_12 and arg_460_1.time_ < var_463_4 + var_463_12 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
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

		arg_460_1:InitPlayNodeList()
	end,
	Play1101103113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 1101103113
		arg_464_1.duration_ = 11.8

		local var_464_0 = {
			zh = 8.8,
			ja = 11.8
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play1101103114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.var_.moveOldPos1111ui_story = arg_464_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_467_0 = 0.001

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 then
				arg_464_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_464_1.time_ - 0) / var_467_0)
				arg_464_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_464_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1111ui_story"].transform.position).z)
				arg_464_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_464_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_464_1.actors_["1111ui_story"].transform.localEulerAngles = arg_464_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 then
				arg_464_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_464_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_464_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_464_1.actors_["1111ui_story"].transform.position).z)
				arg_464_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_464_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_464_1.actors_["1111ui_story"].transform.localEulerAngles = arg_464_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_467_1 = arg_464_1.actors_["1111ui_story"]

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(var_467_1) and arg_464_1.var_.characterEffect1111ui_story == nil then
				arg_464_1.var_.characterEffect1111ui_story = var_467_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_2 = 0.200000002980232

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_2 and not isNil(var_467_1) then
				if arg_464_1.var_.characterEffect1111ui_story and not isNil(var_467_1) then
					arg_464_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_464_1.time_ >= 0 + var_467_2 and arg_464_1.time_ < 0 + var_467_2 + arg_467_0 and not isNil(var_467_1) and arg_464_1.var_.characterEffect1111ui_story then
				arg_464_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_467_4 = arg_464_1.actors_["1011ui_story"]

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(var_467_4) and arg_464_1.var_.characterEffect1011ui_story == nil then
				arg_464_1.var_.characterEffect1011ui_story = var_467_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_5 = 0.200000002980232

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_5 and not isNil(var_467_4) then
				if arg_464_1.var_.characterEffect1011ui_story and not isNil(var_467_4) then
					arg_464_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_464_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_464_1.time_ - 0) / var_467_5)
				end
			end

			if arg_464_1.time_ >= 0 + var_467_5 and arg_464_1.time_ < 0 + var_467_5 + arg_467_0 and not isNil(var_467_4) and arg_464_1.var_.characterEffect1011ui_story then
				arg_464_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_464_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_467_6 = 0
			local var_467_7 = 1.05

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_6 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_8 = arg_464_1:GetWordFromCfg(1101103113)
				local var_467_9 = arg_464_1:FormatText(var_467_8.content)

				arg_464_1.text_.text = var_467_9

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_11 = 42 <= 0 and var_467_7 or var_467_7 * (utf8.len(var_467_9) / 42)

				if (42 <= 0 and var_467_7 or var_467_7 * (utf8.len(var_467_9) / 42)) > 0 and var_467_7 < var_467_11 then
					arg_464_1.talkMaxDuration = var_467_11

					if var_467_11 + var_467_6 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_11 + var_467_6
					end
				end

				arg_464_1.text_.text = var_467_9
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103113", "story_v_side_new_1101103.awb") ~= 0 then
					local var_467_12 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103113", "story_v_side_new_1101103.awb") / 1000

					if var_467_12 + var_467_6 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_12 + var_467_6
					end

					if var_467_8.prefab_name ~= "" and arg_464_1.actors_[var_467_8.prefab_name] ~= nil then
						local var_467_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_8.prefab_name].transform, "story_v_side_new_1101103", "1101103113", "story_v_side_new_1101103.awb")

						arg_464_1:RecordAudio("1101103113", var_467_13)
						arg_464_1:RecordAudio("1101103113", var_467_13)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103113", "story_v_side_new_1101103.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103113", "story_v_side_new_1101103.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_14 = math.max(var_467_7, arg_464_1.talkMaxDuration)

			if var_467_6 <= arg_464_1.time_ and arg_464_1.time_ < var_467_6 + var_467_14 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_6) / var_467_14

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_6 + var_467_14 and arg_464_1.time_ < var_467_6 + var_467_14 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play1101103114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 1101103114
		arg_468_1.duration_ = 4

		local var_468_0 = {
			zh = 4,
			ja = 3.766
		}
		local var_468_1 = manager.audio:GetLocalizationFlag()

		if var_468_0[var_468_1] ~= nil then
			arg_468_1.duration_ = var_468_0[var_468_1]
		end

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play1101103115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.var_.moveOldPos1011ui_story = arg_468_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_471_0 = 0.001

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_0 then
				arg_468_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_468_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_468_1.time_ - 0) / var_471_0)
				arg_468_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_468_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1011ui_story"].transform.position).z)
				arg_468_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_468_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_468_1.actors_["1011ui_story"].transform.localEulerAngles = arg_468_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_468_1.time_ >= 0 + var_471_0 and arg_468_1.time_ < 0 + var_471_0 + arg_471_0 then
				arg_468_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(-0.7, -0.71, -6)
				arg_468_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_468_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1011ui_story"].transform.position).z)
				arg_468_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_468_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_468_1.actors_["1011ui_story"].transform.localEulerAngles = arg_468_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_471_1 = arg_468_1.actors_["1011ui_story"]

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(var_471_1) and arg_468_1.var_.characterEffect1011ui_story == nil then
				arg_468_1.var_.characterEffect1011ui_story = var_471_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_2 = 0.200000002980232

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_2 and not isNil(var_471_1) then
				if arg_468_1.var_.characterEffect1011ui_story and not isNil(var_471_1) then
					arg_468_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_468_1.time_ >= 0 + var_471_2 and arg_468_1.time_ < 0 + var_471_2 + arg_471_0 and not isNil(var_471_1) and arg_468_1.var_.characterEffect1011ui_story then
				arg_468_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_471_4 = arg_468_1.actors_["1111ui_story"]

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(var_471_4) and arg_468_1.var_.characterEffect1111ui_story == nil then
				arg_468_1.var_.characterEffect1111ui_story = var_471_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_5 = 0.200000002980232

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_5 and not isNil(var_471_4) then
				if arg_468_1.var_.characterEffect1111ui_story and not isNil(var_471_4) then
					arg_468_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_468_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_468_1.time_ - 0) / var_471_5)
				end
			end

			if arg_468_1.time_ >= 0 + var_471_5 and arg_468_1.time_ < 0 + var_471_5 + arg_471_0 and not isNil(var_471_4) and arg_468_1.var_.characterEffect1111ui_story then
				arg_468_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_468_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_471_6 = 0
			local var_471_7 = 0.425

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_6 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_8 = arg_468_1:GetWordFromCfg(1101103114)
				local var_471_9 = arg_468_1:FormatText(var_471_8.content)

				arg_468_1.text_.text = var_471_9

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_11 = 17 <= 0 and var_471_7 or var_471_7 * (utf8.len(var_471_9) / 17)

				if (17 <= 0 and var_471_7 or var_471_7 * (utf8.len(var_471_9) / 17)) > 0 and var_471_7 < var_471_11 then
					arg_468_1.talkMaxDuration = var_471_11

					if var_471_11 + var_471_6 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_11 + var_471_6
					end
				end

				arg_468_1.text_.text = var_471_9
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103114", "story_v_side_new_1101103.awb") ~= 0 then
					local var_471_12 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103114", "story_v_side_new_1101103.awb") / 1000

					if var_471_12 + var_471_6 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_12 + var_471_6
					end

					if var_471_8.prefab_name ~= "" and arg_468_1.actors_[var_471_8.prefab_name] ~= nil then
						local var_471_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_8.prefab_name].transform, "story_v_side_new_1101103", "1101103114", "story_v_side_new_1101103.awb")

						arg_468_1:RecordAudio("1101103114", var_471_13)
						arg_468_1:RecordAudio("1101103114", var_471_13)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103114", "story_v_side_new_1101103.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103114", "story_v_side_new_1101103.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_14 = math.max(var_471_7, arg_468_1.talkMaxDuration)

			if var_471_6 <= arg_468_1.time_ and arg_468_1.time_ < var_471_6 + var_471_14 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_6) / var_471_14

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_6 + var_471_14 and arg_468_1.time_ < var_471_6 + var_471_14 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {
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

		arg_468_1:InitPlayNodeList()
	end,
	Play1101103115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 1101103115
		arg_472_1.duration_ = 10.33

		local var_472_0 = {
			zh = 4.066,
			ja = 10.333
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play1101103116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.var_.moveOldPos1111ui_story = arg_472_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_475_0 = 0.001

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_0 then
				arg_472_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos1111ui_story, Vector3.New(0.7, -0.87, -5.7), (arg_472_1.time_ - 0) / var_475_0)
				arg_472_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_472_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1111ui_story"].transform.position).z)
				arg_472_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_472_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_472_1.actors_["1111ui_story"].transform.localEulerAngles = arg_472_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_472_1.time_ >= 0 + var_475_0 and arg_472_1.time_ < 0 + var_475_0 + arg_475_0 then
				arg_472_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0.7, -0.87, -5.7)
				arg_472_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_472_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_472_1.actors_["1111ui_story"].transform.position).z)
				arg_472_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_472_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_472_1.actors_["1111ui_story"].transform.localEulerAngles = arg_472_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_475_1 = arg_472_1.actors_["1111ui_story"]

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 and not isNil(var_475_1) and arg_472_1.var_.characterEffect1111ui_story == nil then
				arg_472_1.var_.characterEffect1111ui_story = var_475_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_2 = 0.200000002980232

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_2 and not isNil(var_475_1) then
				if arg_472_1.var_.characterEffect1111ui_story and not isNil(var_475_1) then
					arg_472_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_472_1.time_ >= 0 + var_475_2 and arg_472_1.time_ < 0 + var_475_2 + arg_475_0 and not isNil(var_475_1) and arg_472_1.var_.characterEffect1111ui_story then
				arg_472_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_475_4 = arg_472_1.actors_["1011ui_story"]

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 and not isNil(var_475_4) and arg_472_1.var_.characterEffect1011ui_story == nil then
				arg_472_1.var_.characterEffect1011ui_story = var_475_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_475_5 = 0.200000002980232

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_5 and not isNil(var_475_4) then
				if arg_472_1.var_.characterEffect1011ui_story and not isNil(var_475_4) then
					arg_472_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_472_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_472_1.time_ - 0) / var_475_5)
				end
			end

			if arg_472_1.time_ >= 0 + var_475_5 and arg_472_1.time_ < 0 + var_475_5 + arg_475_0 and not isNil(var_475_4) and arg_472_1.var_.characterEffect1011ui_story then
				arg_472_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_472_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_475_6 = 0
			local var_475_7 = 0.425

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_6 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_8 = arg_472_1:GetWordFromCfg(1101103115)
				local var_475_9 = arg_472_1:FormatText(var_475_8.content)

				arg_472_1.text_.text = var_475_9

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_11 = 17 <= 0 and var_475_7 or var_475_7 * (utf8.len(var_475_9) / 17)

				if (17 <= 0 and var_475_7 or var_475_7 * (utf8.len(var_475_9) / 17)) > 0 and var_475_7 < var_475_11 then
					arg_472_1.talkMaxDuration = var_475_11

					if var_475_11 + var_475_6 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_11 + var_475_6
					end
				end

				arg_472_1.text_.text = var_475_9
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103115", "story_v_side_new_1101103.awb") ~= 0 then
					local var_475_12 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103115", "story_v_side_new_1101103.awb") / 1000

					if var_475_12 + var_475_6 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_12 + var_475_6
					end

					if var_475_8.prefab_name ~= "" and arg_472_1.actors_[var_475_8.prefab_name] ~= nil then
						local var_475_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_8.prefab_name].transform, "story_v_side_new_1101103", "1101103115", "story_v_side_new_1101103.awb")

						arg_472_1:RecordAudio("1101103115", var_475_13)
						arg_472_1:RecordAudio("1101103115", var_475_13)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103115", "story_v_side_new_1101103.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103115", "story_v_side_new_1101103.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_14 = math.max(var_475_7, arg_472_1.talkMaxDuration)

			if var_475_6 <= arg_472_1.time_ and arg_472_1.time_ < var_475_6 + var_475_14 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_6) / var_475_14

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_6 + var_475_14 and arg_472_1.time_ < var_475_6 + var_475_14 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_472_1:InitPlayNodeList()
	end,
	Play1101103116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 1101103116
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play1101103117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 and not isNil(arg_476_1.actors_["1111ui_story"]) and arg_476_1.var_.characterEffect1111ui_story == nil then
				arg_476_1.var_.characterEffect1111ui_story = arg_476_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_479_0 = 0.200000002980232

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_0 and not isNil(arg_476_1.actors_["1111ui_story"]) then
				if arg_476_1.var_.characterEffect1111ui_story and not isNil(arg_476_1.actors_["1111ui_story"]) then
					arg_476_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_476_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_476_1.time_ - 0) / var_479_0)
				end
			end

			if arg_476_1.time_ >= 0 + var_479_0 and arg_476_1.time_ < 0 + var_479_0 + arg_479_0 and not isNil(arg_476_1.actors_["1111ui_story"]) and arg_476_1.var_.characterEffect1111ui_story then
				arg_476_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_476_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_479_1 = 0
			local var_479_2 = 0.475

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= var_479_1 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_3 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(1101103116).content)

				arg_476_1.text_.text = var_479_3

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_5 = 19 <= 0 and var_479_2 or var_479_2 * (utf8.len(var_479_3) / 19)

				if (19 <= 0 and var_479_2 or var_479_2 * (utf8.len(var_479_3) / 19)) > 0 and var_479_2 < var_479_5 then
					arg_476_1.talkMaxDuration = var_479_5

					if var_479_5 + var_479_1 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_5 + var_479_1
					end
				end

				arg_476_1.text_.text = var_479_3
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_6 = math.max(var_479_2, arg_476_1.talkMaxDuration)

			if var_479_1 <= arg_476_1.time_ and arg_476_1.time_ < var_479_1 + var_479_6 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_1) / var_479_6

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_1 + var_479_6 and arg_476_1.time_ < var_479_1 + var_479_6 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play1101103117 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 1101103117
		arg_480_1.duration_ = 5

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play1101103118(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.var_.moveOldPos1111ui_story = arg_480_1.actors_["1111ui_story"].transform.localPosition
			end

			local var_483_0 = 0.001

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_0 then
				arg_480_1.actors_["1111ui_story"].transform.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos1111ui_story, Vector3.New(0, 100, 0), (arg_480_1.time_ - 0) / var_483_0)
				arg_480_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_480_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1111ui_story"].transform.position).z)
				arg_480_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_480_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_480_1.actors_["1111ui_story"].transform.localEulerAngles = arg_480_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			if arg_480_1.time_ >= 0 + var_483_0 and arg_480_1.time_ < 0 + var_483_0 + arg_483_0 then
				arg_480_1.actors_["1111ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_480_1.actors_["1111ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_480_1.actors_["1111ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1111ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_480_1.actors_["1111ui_story"].transform.position).z)
				arg_480_1.actors_["1111ui_story"].transform.localEulerAngles.z = 0
				arg_480_1.actors_["1111ui_story"].transform.localEulerAngles.x = 0
				arg_480_1.actors_["1111ui_story"].transform.localEulerAngles = arg_480_1.actors_["1111ui_story"].transform.localEulerAngles
			end

			local var_483_1 = arg_480_1.actors_["1011ui_story"].transform

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.var_.moveOldPos1011ui_story = var_483_1.localPosition
			end

			local var_483_2 = 0.001

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_2 then
				var_483_1.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_480_1.time_ - 0) / var_483_2)
				var_483_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_483_1.position).x, (manager.ui.mainCamera.transform.position - var_483_1.position).y, (manager.ui.mainCamera.transform.position - var_483_1.position).z)
				var_483_1.localEulerAngles.z = 0
				var_483_1.localEulerAngles.x = 0
				var_483_1.localEulerAngles = var_483_1.localEulerAngles
			end

			if arg_480_1.time_ >= 0 + var_483_2 and arg_480_1.time_ < 0 + var_483_2 + arg_483_0 then
				var_483_1.localPosition = Vector3.New(0, 100, 0)
				var_483_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_483_1.position).x, (manager.ui.mainCamera.transform.position - var_483_1.position).y, (manager.ui.mainCamera.transform.position - var_483_1.position).z)
				var_483_1.localEulerAngles.z = 0
				var_483_1.localEulerAngles.x = 0
				var_483_1.localEulerAngles = var_483_1.localEulerAngles
			end

			local var_483_3 = 0
			local var_483_4 = 0.725

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_3 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, false)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_480_1.iconTrs_.gameObject, false)
				arg_480_1.callingController_:SetSelectedState("normal")

				local var_483_5 = arg_480_1:FormatText(arg_480_1:GetWordFromCfg(1101103117).content)

				arg_480_1.text_.text = var_483_5

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_7 = 29 <= 0 and var_483_4 or var_483_4 * (utf8.len(var_483_5) / 29)

				if (29 <= 0 and var_483_4 or var_483_4 * (utf8.len(var_483_5) / 29)) > 0 and var_483_4 < var_483_7 then
					arg_480_1.talkMaxDuration = var_483_7

					if var_483_7 + var_483_3 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_7 + var_483_3
					end
				end

				arg_480_1.text_.text = var_483_5
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)
				arg_480_1:RecordContent(arg_480_1.text_.text)
			end

			local var_483_8 = math.max(var_483_4, arg_480_1.talkMaxDuration)

			if var_483_3 <= arg_480_1.time_ and arg_480_1.time_ < var_483_3 + var_483_8 then
				arg_480_1.typewritter.percent = (arg_480_1.time_ - var_483_3) / var_483_8

				arg_480_1.typewritter:SetDirty()
			end

			if arg_480_1.time_ >= var_483_3 + var_483_8 and arg_480_1.time_ < var_483_3 + var_483_8 + arg_483_0 then
				arg_480_1.typewritter.percent = 1

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(true)
			end
		end

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
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

		arg_480_1:InitPlayNodeList()
	end,
	Play1101103118 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 1101103118
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
		end

		function arg_484_1.playNext_(arg_486_0)
			if arg_486_0 == 1 then
				arg_484_0:Play1101103119(arg_484_1)
			end
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			local var_487_0 = 0.125

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_1 = arg_484_1:FormatText(arg_484_1:GetWordFromCfg(1101103118).content)

				arg_484_1.text_.text = var_487_1

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_3 = 5 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_1) / 5)

				if (5 <= 0 and var_487_0 or var_487_0 * (utf8.len(var_487_1) / 5)) > 0 and var_487_0 < var_487_3 then
					arg_484_1.talkMaxDuration = var_487_3

					if var_487_3 + 0 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_3 + 0
					end
				end

				arg_484_1.text_.text = var_487_1
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_4 = math.max(var_487_0, arg_484_1.talkMaxDuration)

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_4 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - 0) / var_487_4

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= 0 + var_487_4 and arg_484_1.time_ < 0 + var_487_4 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	Play1101103119 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 1101103119
		arg_488_1.duration_ = 2.93

		local var_488_0 = {
			zh = 2.066,
			ja = 2.933
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play1101103120(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 0.175

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, true)
				arg_488_1.iconController_:SetSelectedState("hero")

				arg_488_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_488_1.callingController_:SetSelectedState("normal")

				arg_488_1.keyicon_.color = Color.New(1, 1, 1)
				arg_488_1.icon_.color = Color.New(1, 1, 1)

				local var_491_1 = arg_488_1:GetWordFromCfg(1101103119)
				local var_491_2 = arg_488_1:FormatText(var_491_1.content)

				arg_488_1.text_.text = var_491_2

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_4 = 7 <= 0 and var_491_0 or var_491_0 * (utf8.len(var_491_2) / 7)

				if (7 <= 0 and var_491_0 or var_491_0 * (utf8.len(var_491_2) / 7)) > 0 and var_491_0 < var_491_4 then
					arg_488_1.talkMaxDuration = var_491_4

					if var_491_4 + 0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_4 + 0
					end
				end

				arg_488_1.text_.text = var_491_2
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103119", "story_v_side_new_1101103.awb") ~= 0 then
					local var_491_5 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103119", "story_v_side_new_1101103.awb") / 1000

					if var_491_5 + 0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_5 + 0
					end

					if var_491_1.prefab_name ~= "" and arg_488_1.actors_[var_491_1.prefab_name] ~= nil then
						local var_491_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_1.prefab_name].transform, "story_v_side_new_1101103", "1101103119", "story_v_side_new_1101103.awb")

						arg_488_1:RecordAudio("1101103119", var_491_6)
						arg_488_1:RecordAudio("1101103119", var_491_6)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103119", "story_v_side_new_1101103.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103119", "story_v_side_new_1101103.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_7 = math.max(var_491_0, arg_488_1.talkMaxDuration)

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_7 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - 0) / var_491_7

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= 0 + var_491_7 and arg_488_1.time_ < 0 + var_491_7 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play1101103120 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 1101103120
		arg_492_1.duration_ = 5.37

		local var_492_0 = {
			zh = 3.7,
			ja = 5.366
		}
		local var_492_1 = manager.audio:GetLocalizationFlag()

		if var_492_0[var_492_1] ~= nil then
			arg_492_1.duration_ = var_492_0[var_492_1]
		end

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play1101103121(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.var_.moveOldPos1011ui_story = arg_492_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_495_0 = 0.001

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_0 then
				arg_492_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_492_1.time_ - 0) / var_495_0)
				arg_492_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_492_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["1011ui_story"].transform.position).z)
				arg_492_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_492_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_492_1.actors_["1011ui_story"].transform.localEulerAngles = arg_492_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_492_1.time_ >= 0 + var_495_0 and arg_492_1.time_ < 0 + var_495_0 + arg_495_0 then
				arg_492_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_492_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_492_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_492_1.actors_["1011ui_story"].transform.position).z)
				arg_492_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_492_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_492_1.actors_["1011ui_story"].transform.localEulerAngles = arg_492_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_495_1 = arg_492_1.actors_["1011ui_story"]

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(var_495_1) and arg_492_1.var_.characterEffect1011ui_story == nil then
				arg_492_1.var_.characterEffect1011ui_story = var_495_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_2 = 0.200000002980232

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_2 and not isNil(var_495_1) then
				if arg_492_1.var_.characterEffect1011ui_story and not isNil(var_495_1) then
					arg_492_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_492_1.time_ >= 0 + var_495_2 and arg_492_1.time_ < 0 + var_495_2 + arg_495_0 and not isNil(var_495_1) and arg_492_1.var_.characterEffect1011ui_story then
				arg_492_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_1")
			end

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_495_4 = arg_492_1.actors_["1111ui_story"]

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(var_495_4) and arg_492_1.var_.characterEffect1111ui_story == nil then
				arg_492_1.var_.characterEffect1111ui_story = var_495_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_495_5 = 0.200000002980232

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_5 and not isNil(var_495_4) then
				if arg_492_1.var_.characterEffect1111ui_story and not isNil(var_495_4) then
					arg_492_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_492_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_492_1.time_ - 0) / var_495_5)
				end
			end

			if arg_492_1.time_ >= 0 + var_495_5 and arg_492_1.time_ < 0 + var_495_5 + arg_495_0 and not isNil(var_495_4) and arg_492_1.var_.characterEffect1111ui_story then
				arg_492_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_492_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_495_6 = 0
			local var_495_7 = 0.45

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_6 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				arg_492_1.leftNameTxt_.text = arg_492_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_8 = arg_492_1:GetWordFromCfg(1101103120)
				local var_495_9 = arg_492_1:FormatText(var_495_8.content)

				arg_492_1.text_.text = var_495_9

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_11 = 18 <= 0 and var_495_7 or var_495_7 * (utf8.len(var_495_9) / 18)

				if (18 <= 0 and var_495_7 or var_495_7 * (utf8.len(var_495_9) / 18)) > 0 and var_495_7 < var_495_11 then
					arg_492_1.talkMaxDuration = var_495_11

					if var_495_11 + var_495_6 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_11 + var_495_6
					end
				end

				arg_492_1.text_.text = var_495_9
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103120", "story_v_side_new_1101103.awb") ~= 0 then
					local var_495_12 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103120", "story_v_side_new_1101103.awb") / 1000

					if var_495_12 + var_495_6 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_12 + var_495_6
					end

					if var_495_8.prefab_name ~= "" and arg_492_1.actors_[var_495_8.prefab_name] ~= nil then
						local var_495_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_8.prefab_name].transform, "story_v_side_new_1101103", "1101103120", "story_v_side_new_1101103.awb")

						arg_492_1:RecordAudio("1101103120", var_495_13)
						arg_492_1:RecordAudio("1101103120", var_495_13)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103120", "story_v_side_new_1101103.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103120", "story_v_side_new_1101103.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_14 = math.max(var_495_7, arg_492_1.talkMaxDuration)

			if var_495_6 <= arg_492_1.time_ and arg_492_1.time_ < var_495_6 + var_495_14 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_6) / var_495_14

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_6 + var_495_14 and arg_492_1.time_ < var_495_6 + var_495_14 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
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

		arg_492_1:InitPlayNodeList()
	end,
	Play1101103121 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 1101103121
		arg_496_1.duration_ = 2.9

		local var_496_0 = {
			zh = 2.9,
			ja = 1.966
		}
		local var_496_1 = manager.audio:GetLocalizationFlag()

		if var_496_0[var_496_1] ~= nil then
			arg_496_1.duration_ = var_496_0[var_496_1]
		end

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play1101103122(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 and not isNil(arg_496_1.actors_["1011ui_story"]) and arg_496_1.var_.characterEffect1011ui_story == nil then
				arg_496_1.var_.characterEffect1011ui_story = arg_496_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_499_0 = 0.200000002980232

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_0 and not isNil(arg_496_1.actors_["1011ui_story"]) then
				if arg_496_1.var_.characterEffect1011ui_story and not isNil(arg_496_1.actors_["1011ui_story"]) then
					arg_496_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_496_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_496_1.time_ - 0) / var_499_0)
				end
			end

			if arg_496_1.time_ >= 0 + var_499_0 and arg_496_1.time_ < 0 + var_499_0 + arg_499_0 and not isNil(arg_496_1.actors_["1011ui_story"]) and arg_496_1.var_.characterEffect1011ui_story then
				arg_496_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_496_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_499_1 = 0
			local var_499_2 = 0.325

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_1 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, true)

				arg_496_1.leftNameTxt_.text = arg_496_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_496_1.leftNameTxt_.transform)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1.leftNameTxt_.text)
				SetActive(arg_496_1.iconTrs_.gameObject, true)
				arg_496_1.iconController_:SetSelectedState("hero")

				arg_496_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_496_1.callingController_:SetSelectedState("normal")

				arg_496_1.keyicon_.color = Color.New(1, 1, 1)
				arg_496_1.icon_.color = Color.New(1, 1, 1)

				local var_499_3 = arg_496_1:GetWordFromCfg(1101103121)
				local var_499_4 = arg_496_1:FormatText(var_499_3.content)

				arg_496_1.text_.text = var_499_4

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_6 = 13 <= 0 and var_499_2 or var_499_2 * (utf8.len(var_499_4) / 13)

				if (13 <= 0 and var_499_2 or var_499_2 * (utf8.len(var_499_4) / 13)) > 0 and var_499_2 < var_499_6 then
					arg_496_1.talkMaxDuration = var_499_6

					if var_499_6 + var_499_1 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_6 + var_499_1
					end
				end

				arg_496_1.text_.text = var_499_4
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103121", "story_v_side_new_1101103.awb") ~= 0 then
					local var_499_7 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103121", "story_v_side_new_1101103.awb") / 1000

					if var_499_7 + var_499_1 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_7 + var_499_1
					end

					if var_499_3.prefab_name ~= "" and arg_496_1.actors_[var_499_3.prefab_name] ~= nil then
						local var_499_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_496_1.actors_[var_499_3.prefab_name].transform, "story_v_side_new_1101103", "1101103121", "story_v_side_new_1101103.awb")

						arg_496_1:RecordAudio("1101103121", var_499_8)
						arg_496_1:RecordAudio("1101103121", var_499_8)
					else
						arg_496_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103121", "story_v_side_new_1101103.awb")
					end

					arg_496_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103121", "story_v_side_new_1101103.awb")
				end

				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_9 = math.max(var_499_2, arg_496_1.talkMaxDuration)

			if var_499_1 <= arg_496_1.time_ and arg_496_1.time_ < var_499_1 + var_499_9 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_1) / var_499_9

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_1 + var_499_9 and arg_496_1.time_ < var_499_1 + var_499_9 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play1101103122 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 1101103122
		arg_500_1.duration_ = 14.97

		local var_500_0 = {
			zh = 14.966,
			ja = 9.133
		}
		local var_500_1 = manager.audio:GetLocalizationFlag()

		if var_500_0[var_500_1] ~= nil then
			arg_500_1.duration_ = var_500_0[var_500_1]
		end

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
		end

		function arg_500_1.playNext_(arg_502_0)
			if arg_502_0 == 1 then
				arg_500_0:Play1101103123(arg_500_1)
			end
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			if arg_500_1.bgs_.R1101c == nil then
				local var_503_0 = Object.Instantiate(arg_500_1.paintGo_)

				var_503_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "R1101c")
				var_503_0.name = "R1101c"
				var_503_0.transform.parent = arg_500_1.stage_.transform
				var_503_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_500_1.bgs_.R1101c = var_503_0
			end

			if 4 < arg_500_1.time_ and arg_500_1.time_ <= 4 + arg_503_0 then
				local var_503_1 = arg_500_1.bgs_.R1101c

				arg_500_1.bgs_.R1101c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_503_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_503_2 = var_503_1:GetComponent("SpriteRenderer")

				if var_503_2 and var_503_2.sprite then
					local var_503_3 = 2 * (var_503_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_503_1.transform.localScale = Vector3.New(var_503_3 / var_503_2.sprite.bounds.size.y < var_503_3 * manager.ui.mainCameraCom_.aspect / var_503_2.sprite.bounds.size.x and var_503_3 * manager.ui.mainCameraCom_.aspect / var_503_2.sprite.bounds.size.x or var_503_3 / var_503_2.sprite.bounds.size.y, var_503_3 / var_503_2.sprite.bounds.size.y < var_503_3 * manager.ui.mainCameraCom_.aspect / var_503_2.sprite.bounds.size.x and var_503_3 * manager.ui.mainCameraCom_.aspect / var_503_2.sprite.bounds.size.x or var_503_3 / var_503_2.sprite.bounds.size.y, 0)
				end

				for iter_503_0, iter_503_1 in pairs(arg_500_1.bgs_) do
					if iter_503_0 ~= "R1101c" then
						iter_503_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_503_4 = 0

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_4 + arg_503_0 then
				arg_500_1.mask_.enabled = true
				arg_500_1.mask_.raycastTarget = true

				arg_500_1:SetGaussion(false)
			end

			local var_503_5 = 4

			if var_503_4 <= arg_500_1.time_ and arg_500_1.time_ < var_503_4 + var_503_5 then
				local var_503_6 = Color.New(0, 0, 0)

				var_503_6.a = Mathf.Lerp(0, 1, (arg_500_1.time_ - var_503_4) / var_503_5)
				arg_500_1.mask_.color = var_503_6
			end

			if arg_500_1.time_ >= var_503_4 + var_503_5 and arg_500_1.time_ < var_503_4 + var_503_5 + arg_503_0 then
				local var_503_7 = Color.New(0, 0, 0)

				var_503_7.a = 1
				arg_500_1.mask_.color = var_503_7
			end

			local var_503_8 = 4

			if 4 < arg_500_1.time_ and arg_500_1.time_ <= var_503_8 + arg_503_0 then
				arg_500_1.mask_.enabled = true
				arg_500_1.mask_.raycastTarget = true

				arg_500_1:SetGaussion(false)
			end

			local var_503_9 = 4

			if var_503_8 <= arg_500_1.time_ and arg_500_1.time_ < var_503_8 + var_503_9 then
				local var_503_10 = Color.New(0, 0, 0)

				var_503_10.a = Mathf.Lerp(1, 0, (arg_500_1.time_ - var_503_8) / var_503_9)
				arg_500_1.mask_.color = var_503_10
			end

			if arg_500_1.time_ >= var_503_8 + var_503_9 and arg_500_1.time_ < var_503_8 + var_503_9 + arg_503_0 then
				local var_503_11 = Color.New(0, 0, 0)

				arg_500_1.mask_.enabled = false
				var_503_11.a = 0
				arg_500_1.mask_.color = var_503_11
			end

			local var_503_12 = arg_500_1.actors_["1011ui_story"].transform

			if 4 < arg_500_1.time_ and arg_500_1.time_ <= 4 + arg_503_0 then
				arg_500_1.var_.moveOldPos1011ui_story = var_503_12.localPosition
			end

			local var_503_13 = 0.001

			if 4 <= arg_500_1.time_ and arg_500_1.time_ < 4 + var_503_13 then
				var_503_12.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_500_1.time_ - 4) / var_503_13)
				var_503_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_503_12.position).x, (manager.ui.mainCamera.transform.position - var_503_12.position).y, (manager.ui.mainCamera.transform.position - var_503_12.position).z)
				var_503_12.localEulerAngles.z = 0
				var_503_12.localEulerAngles.x = 0
				var_503_12.localEulerAngles = var_503_12.localEulerAngles
			end

			if arg_500_1.time_ >= 4 + var_503_13 and arg_500_1.time_ < 4 + var_503_13 + arg_503_0 then
				var_503_12.localPosition = Vector3.New(0, 100, 0)
				var_503_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_503_12.position).x, (manager.ui.mainCamera.transform.position - var_503_12.position).y, (manager.ui.mainCamera.transform.position - var_503_12.position).z)
				var_503_12.localEulerAngles.z = 0
				var_503_12.localEulerAngles.x = 0
				var_503_12.localEulerAngles = var_503_12.localEulerAngles
			end

			if 4 < arg_500_1.time_ and arg_500_1.time_ <= 4 + arg_503_0 then
				arg_500_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_503_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_500_1.bgmTxt_.text ~= var_503_16 and arg_500_1.bgmTxt_.text ~= "" then
						if arg_500_1.bgmTxt2_.text ~= "" then
							arg_500_1.bgmTxt_.text = arg_500_1.bgmTxt2_.text
						end

						arg_500_1.bgmTxt2_.text = var_503_16

						arg_500_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_500_1.bgmTxt_.text = var_503_16
						arg_500_1.bgmTxt2_.text = var_503_16
					end

					if arg_500_1.bgmTimer then
						arg_500_1.bgmTimer:Stop()

						arg_500_1.bgmTimer = nil
					end

					if arg_500_1.settingData.show_music_name == 1 then
						arg_500_1.musicController:SetSelectedState("show")
						arg_500_1.musicAnimator_:Play("open", 0, 0)

						if arg_500_1.settingData.music_time ~= 0 then
							arg_500_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_500_1.settingData.music_time), function()
								if arg_500_1 == nil or isNil(arg_500_1.bgmTxt_) then
									return
								end

								arg_500_1.musicController:SetSelectedState("hide")
								arg_500_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_503_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_500_1.bgmTxt_.text ~= var_503_19 and arg_500_1.bgmTxt_.text ~= "" then
						if arg_500_1.bgmTxt2_.text ~= "" then
							arg_500_1.bgmTxt_.text = arg_500_1.bgmTxt2_.text
						end

						arg_500_1.bgmTxt2_.text = var_503_19

						arg_500_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_500_1.bgmTxt_.text = var_503_19
						arg_500_1.bgmTxt2_.text = var_503_19
					end

					if arg_500_1.bgmTimer then
						arg_500_1.bgmTimer:Stop()

						arg_500_1.bgmTimer = nil
					end

					if arg_500_1.settingData.show_music_name == 1 then
						arg_500_1.musicController:SetSelectedState("show")
						arg_500_1.musicAnimator_:Play("open", 0, 0)

						if arg_500_1.settingData.music_time ~= 0 then
							arg_500_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_500_1.settingData.music_time), function()
								if arg_500_1 == nil or isNil(arg_500_1.bgmTxt_) then
									return
								end

								arg_500_1.musicController:SetSelectedState("hide")
								arg_500_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.533333333333333 < arg_500_1.time_ and arg_500_1.time_ <= 0.533333333333333 + arg_503_0 then
				arg_500_1:AudioAction("play", "music", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui.awb")

				local var_503_22 = manager.audio:GetAudioName("bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui")

				if "" ~= "" then
					if arg_500_1.bgmTxt_.text ~= var_503_22 and arg_500_1.bgmTxt_.text ~= "" then
						if arg_500_1.bgmTxt2_.text ~= "" then
							arg_500_1.bgmTxt_.text = arg_500_1.bgmTxt2_.text
						end

						arg_500_1.bgmTxt2_.text = var_503_22

						arg_500_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_500_1.bgmTxt_.text = var_503_22
						arg_500_1.bgmTxt2_.text = var_503_22
					end

					if arg_500_1.bgmTimer then
						arg_500_1.bgmTimer:Stop()

						arg_500_1.bgmTimer = nil
					end

					if arg_500_1.settingData.show_music_name == 1 then
						arg_500_1.musicController:SetSelectedState("show")
						arg_500_1.musicAnimator_:Play("open", 0, 0)

						if arg_500_1.settingData.music_time ~= 0 then
							arg_500_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_500_1.settingData.music_time), function()
								if arg_500_1 == nil or isNil(arg_500_1.bgmTxt_) then
									return
								end

								arg_500_1.musicController:SetSelectedState("hide")
								arg_500_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_500_1.frameCnt_ <= 1 then
				arg_500_1.dialog_:SetActive(false)
			end

			local var_503_23 = 8
			local var_503_24 = 0.05

			if 8 < arg_500_1.time_ and arg_500_1.time_ <= var_503_23 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0

				arg_500_1.dialog_:SetActive(true)

				arg_500_1.dialogCg_.alpha = 0

				local var_503_25 = LeanTween.value(arg_500_1.dialog_, 0, 1, 0.3)

				var_503_25:setOnUpdate(LuaHelper.FloatAction(function(arg_507_0)
					arg_500_1.dialogCg_.alpha = arg_507_0
				end))
				var_503_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_500_1.dialog_)
					var_503_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_500_1.duration_ = arg_500_1.duration_ + 0.3

				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, true)
				arg_500_1.iconController_:SetSelectedState("hero")

				arg_500_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_500_1.callingController_:SetSelectedState("normal")

				arg_500_1.keyicon_.color = Color.New(1, 1, 1)
				arg_500_1.icon_.color = Color.New(1, 1, 1)

				local var_503_26 = arg_500_1:GetWordFromCfg(1101103122)
				local var_503_27 = arg_500_1:FormatText(var_503_26.content)

				arg_500_1.text_.text = var_503_27

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_29 = 2 <= 0 and var_503_24 or var_503_24 * (utf8.len(var_503_27) / 2)

				if (2 <= 0 and var_503_24 or var_503_24 * (utf8.len(var_503_27) / 2)) > 0 and var_503_24 < var_503_29 then
					arg_500_1.talkMaxDuration = var_503_29
					var_503_23 = var_503_23 + 0.3

					if var_503_29 + var_503_23 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_29 + var_503_23
					end
				end

				arg_500_1.text_.text = var_503_27
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103122", "story_v_side_new_1101103.awb") ~= 0 then
					local var_503_30 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103122", "story_v_side_new_1101103.awb") / 1000

					if var_503_30 + var_503_23 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_30 + var_503_23
					end

					if var_503_26.prefab_name ~= "" and arg_500_1.actors_[var_503_26.prefab_name] ~= nil then
						local var_503_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_26.prefab_name].transform, "story_v_side_new_1101103", "1101103122", "story_v_side_new_1101103.awb")

						arg_500_1:RecordAudio("1101103122", var_503_31)
						arg_500_1:RecordAudio("1101103122", var_503_31)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103122", "story_v_side_new_1101103.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103122", "story_v_side_new_1101103.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_32 = var_503_23 + 0.3
			local var_503_33 = math.max(var_503_24, arg_500_1.talkMaxDuration)

			if var_503_23 + 0.3 <= arg_500_1.time_ and arg_500_1.time_ < var_503_32 + var_503_33 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_32) / var_503_33

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_32 + var_503_33 and arg_500_1.time_ < var_503_32 + var_503_33 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_500_1:InitPlayNodeList()
	end,
	Play1101103123 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 1101103123
		arg_509_1.duration_ = 5.57

		local var_509_0 = {
			zh = 5.566,
			ja = 1.233
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
				arg_509_0:Play1101103124(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 0.05

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, true)

				arg_509_1.leftNameTxt_.text = arg_509_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_509_1.leftNameTxt_.transform)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1.leftNameTxt_.text)
				SetActive(arg_509_1.iconTrs_.gameObject, true)
				arg_509_1.iconController_:SetSelectedState("hero")

				arg_509_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_509_1.callingController_:SetSelectedState("normal")

				arg_509_1.keyicon_.color = Color.New(1, 1, 1)
				arg_509_1.icon_.color = Color.New(1, 1, 1)

				local var_512_1 = arg_509_1:GetWordFromCfg(1101103123)
				local var_512_2 = arg_509_1:FormatText(var_512_1.content)

				arg_509_1.text_.text = var_512_2

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_4 = 2 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_2) / 2)

				if (2 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_2) / 2)) > 0 and var_512_0 < var_512_4 then
					arg_509_1.talkMaxDuration = var_512_4

					if var_512_4 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_4 + 0
					end
				end

				arg_509_1.text_.text = var_512_2
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103123", "story_v_side_new_1101103.awb") ~= 0 then
					local var_512_5 = manager.audio:GetVoiceLength("story_v_side_new_1101103", "1101103123", "story_v_side_new_1101103.awb") / 1000

					if var_512_5 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_5 + 0
					end

					if var_512_1.prefab_name ~= "" and arg_509_1.actors_[var_512_1.prefab_name] ~= nil then
						local var_512_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_509_1.actors_[var_512_1.prefab_name].transform, "story_v_side_new_1101103", "1101103123", "story_v_side_new_1101103.awb")

						arg_509_1:RecordAudio("1101103123", var_512_6)
						arg_509_1:RecordAudio("1101103123", var_512_6)
					else
						arg_509_1:AudioAction("play", "voice", "story_v_side_new_1101103", "1101103123", "story_v_side_new_1101103.awb")
					end

					arg_509_1:RecordHistoryTalkVoice("story_v_side_new_1101103", "1101103123", "story_v_side_new_1101103.awb")
				end

				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_7 = math.max(var_512_0, arg_509_1.talkMaxDuration)

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_7 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - 0) / var_512_7

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= 0 + var_512_7 and arg_509_1.time_ < 0 + var_512_7 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play1101103124 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 1101103124
		arg_513_1.duration_ = 5

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play1101103125(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			local var_516_0 = 0.5

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0
				arg_513_1.dialogCg_.alpha = 1

				arg_513_1.dialog_:SetActive(true)
				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_1 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(1101103124).content)

				arg_513_1.text_.text = var_516_1

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_3 = 20 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 20)

				if (20 <= 0 and var_516_0 or var_516_0 * (utf8.len(var_516_1) / 20)) > 0 and var_516_0 < var_516_3 then
					arg_513_1.talkMaxDuration = var_516_3

					if var_516_3 + 0 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_3 + 0
					end
				end

				arg_513_1.text_.text = var_516_1
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_4 = math.max(var_516_0, arg_513_1.talkMaxDuration)

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_4 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - 0) / var_516_4

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= 0 + var_516_4 and arg_513_1.time_ < 0 + var_516_4 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {}

		arg_513_1:InitPlayNodeList()
	end,
	Play1101103125 = function(arg_517_0, arg_517_1)
		arg_517_1.time_ = 0
		arg_517_1.frameCnt_ = 0
		arg_517_1.state_ = "playing"
		arg_517_1.curTalkId_ = 1101103125
		arg_517_1.duration_ = 5

		SetActive(arg_517_1.tipsGo_, false)

		function arg_517_1.onSingleLineFinish_()
			arg_517_1.onSingleLineUpdate_ = nil
			arg_517_1.onSingleLineFinish_ = nil
			arg_517_1.state_ = "waiting"
		end

		function arg_517_1.playNext_(arg_519_0)
			if arg_519_0 == 1 then
				arg_517_0:Play1101103126(arg_517_1)
			end
		end

		function arg_517_1.onSingleLineUpdate_(arg_520_0)
			local var_520_0 = 0.675

			if 0 < arg_517_1.time_ and arg_517_1.time_ <= 0 + arg_520_0 then
				arg_517_1.talkMaxDuration = 0
				arg_517_1.dialogCg_.alpha = 1

				arg_517_1.dialog_:SetActive(true)
				SetActive(arg_517_1.leftNameGo_, false)

				arg_517_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_517_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_517_1:RecordName(arg_517_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_517_1.iconTrs_.gameObject, false)
				arg_517_1.callingController_:SetSelectedState("normal")

				local var_520_1 = arg_517_1:FormatText(arg_517_1:GetWordFromCfg(1101103125).content)

				arg_517_1.text_.text = var_520_1

				LuaForUtil.ClearLinePrefixSymbol(arg_517_1.text_)

				local var_520_3 = 27 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 27)

				if (27 <= 0 and var_520_0 or var_520_0 * (utf8.len(var_520_1) / 27)) > 0 and var_520_0 < var_520_3 then
					arg_517_1.talkMaxDuration = var_520_3

					if var_520_3 + 0 > arg_517_1.duration_ then
						arg_517_1.duration_ = var_520_3 + 0
					end
				end

				arg_517_1.text_.text = var_520_1
				arg_517_1.typewritter.percent = 0

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(false)
				arg_517_1:RecordContent(arg_517_1.text_.text)
			end

			local var_520_4 = math.max(var_520_0, arg_517_1.talkMaxDuration)

			if 0 <= arg_517_1.time_ and arg_517_1.time_ < 0 + var_520_4 then
				arg_517_1.typewritter.percent = (arg_517_1.time_ - 0) / var_520_4

				arg_517_1.typewritter:SetDirty()
			end

			if arg_517_1.time_ >= 0 + var_520_4 and arg_517_1.time_ < 0 + var_520_4 + arg_520_0 then
				arg_517_1.typewritter.percent = 1

				arg_517_1.typewritter:SetDirty()
				arg_517_1:ShowNextGo(true)
			end
		end

		arg_517_1.nodeConfigList_ = {}

		arg_517_1:InitPlayNodeList()
	end,
	Play1101103126 = function(arg_521_0, arg_521_1)
		arg_521_1.time_ = 0
		arg_521_1.frameCnt_ = 0
		arg_521_1.state_ = "playing"
		arg_521_1.curTalkId_ = 1101103126
		arg_521_1.duration_ = 5

		SetActive(arg_521_1.tipsGo_, false)

		function arg_521_1.onSingleLineFinish_()
			arg_521_1.onSingleLineUpdate_ = nil
			arg_521_1.onSingleLineFinish_ = nil
			arg_521_1.state_ = "waiting"
		end

		function arg_521_1.playNext_(arg_523_0)
			if arg_523_0 == 1 then
				arg_521_0:Play1101103127(arg_521_1)
			end
		end

		function arg_521_1.onSingleLineUpdate_(arg_524_0)
			local var_524_0 = 0.925

			if 0 < arg_521_1.time_ and arg_521_1.time_ <= 0 + arg_524_0 then
				arg_521_1.talkMaxDuration = 0
				arg_521_1.dialogCg_.alpha = 1

				arg_521_1.dialog_:SetActive(true)
				SetActive(arg_521_1.leftNameGo_, false)

				arg_521_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_521_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_521_1:RecordName(arg_521_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_521_1.iconTrs_.gameObject, false)
				arg_521_1.callingController_:SetSelectedState("normal")

				local var_524_1 = arg_521_1:FormatText(arg_521_1:GetWordFromCfg(1101103126).content)

				arg_521_1.text_.text = var_524_1

				LuaForUtil.ClearLinePrefixSymbol(arg_521_1.text_)

				local var_524_3 = 37 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_1) / 37)

				if (37 <= 0 and var_524_0 or var_524_0 * (utf8.len(var_524_1) / 37)) > 0 and var_524_0 < var_524_3 then
					arg_521_1.talkMaxDuration = var_524_3

					if var_524_3 + 0 > arg_521_1.duration_ then
						arg_521_1.duration_ = var_524_3 + 0
					end
				end

				arg_521_1.text_.text = var_524_1
				arg_521_1.typewritter.percent = 0

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(false)
				arg_521_1:RecordContent(arg_521_1.text_.text)
			end

			local var_524_4 = math.max(var_524_0, arg_521_1.talkMaxDuration)

			if 0 <= arg_521_1.time_ and arg_521_1.time_ < 0 + var_524_4 then
				arg_521_1.typewritter.percent = (arg_521_1.time_ - 0) / var_524_4

				arg_521_1.typewritter:SetDirty()
			end

			if arg_521_1.time_ >= 0 + var_524_4 and arg_521_1.time_ < 0 + var_524_4 + arg_524_0 then
				arg_521_1.typewritter.percent = 1

				arg_521_1.typewritter:SetDirty()
				arg_521_1:ShowNextGo(true)
			end
		end

		arg_521_1.nodeConfigList_ = {}

		arg_521_1:InitPlayNodeList()
	end,
	Play1101103127 = function(arg_525_0, arg_525_1)
		arg_525_1.time_ = 0
		arg_525_1.frameCnt_ = 0
		arg_525_1.state_ = "playing"
		arg_525_1.curTalkId_ = 1101103127
		arg_525_1.duration_ = 5

		SetActive(arg_525_1.tipsGo_, false)

		function arg_525_1.onSingleLineFinish_()
			arg_525_1.onSingleLineUpdate_ = nil
			arg_525_1.onSingleLineFinish_ = nil
			arg_525_1.state_ = "waiting"
			arg_525_1.auto_ = false
		end

		function arg_525_1.playNext_(arg_527_0)
			arg_525_1.onStoryFinished_()
		end

		function arg_525_1.onSingleLineUpdate_(arg_528_0)
			local var_528_0 = 0.6

			if 0 < arg_525_1.time_ and arg_525_1.time_ <= 0 + arg_528_0 then
				arg_525_1.talkMaxDuration = 0
				arg_525_1.dialogCg_.alpha = 1

				arg_525_1.dialog_:SetActive(true)
				SetActive(arg_525_1.leftNameGo_, false)

				arg_525_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_525_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_525_1:RecordName(arg_525_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_525_1.iconTrs_.gameObject, false)
				arg_525_1.callingController_:SetSelectedState("normal")

				local var_528_1 = arg_525_1:FormatText(arg_525_1:GetWordFromCfg(1101103127).content)

				arg_525_1.text_.text = var_528_1

				LuaForUtil.ClearLinePrefixSymbol(arg_525_1.text_)

				local var_528_3 = 24 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 24)

				if (24 <= 0 and var_528_0 or var_528_0 * (utf8.len(var_528_1) / 24)) > 0 and var_528_0 < var_528_3 then
					arg_525_1.talkMaxDuration = var_528_3

					if var_528_3 + 0 > arg_525_1.duration_ then
						arg_525_1.duration_ = var_528_3 + 0
					end
				end

				arg_525_1.text_.text = var_528_1
				arg_525_1.typewritter.percent = 0

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(false)
				arg_525_1:RecordContent(arg_525_1.text_.text)
			end

			local var_528_4 = math.max(var_528_0, arg_525_1.talkMaxDuration)

			if 0 <= arg_525_1.time_ and arg_525_1.time_ < 0 + var_528_4 then
				arg_525_1.typewritter.percent = (arg_525_1.time_ - 0) / var_528_4

				arg_525_1.typewritter:SetDirty()
			end

			if arg_525_1.time_ >= 0 + var_528_4 and arg_525_1.time_ < 0 + var_528_4 + arg_528_0 then
				arg_525_1.typewritter.percent = 1

				arg_525_1.typewritter:SetDirty()
				arg_525_1:ShowNextGo(true)
			end
		end

		arg_525_1.nodeConfigList_ = {}

		arg_525_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST18",
		"TextureConfig/Background/ST19_blur",
		"TextureConfig/Background/ST19",
		"TextureConfig/Background/R1101c"
	},
	voices = {
		"story_v_side_new_1101103.awb"
	}
}
