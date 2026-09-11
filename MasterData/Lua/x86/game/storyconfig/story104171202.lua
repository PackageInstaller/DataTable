return {
	Play417122001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417122001
		arg_1_1.duration_ = 13.1

		local var_1_0 = {
			zh = 8.3,
			ja = 13.1
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
				arg_1_0:Play417122002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I16i == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I16i")
				var_4_0.name = "I16i"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I16i = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I16i

				arg_1_1.bgs_.I16i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I16i" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 5.4

			if 5.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_7 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_7

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_7
						arg_1_1.bgmTxt2_.text = var_4_7
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg.awb")

				local var_4_10 = manager.audio:GetAudioName("bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg")

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

			local var_4_11 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_12 = 1

			if var_4_11 <= arg_1_1.time_ and arg_1_1.time_ < var_4_11 + var_4_12 then
				local var_4_13 = Color.New(0, 0, 0)

				var_4_13.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_11) / var_4_12)
				arg_1_1.mask_.color = var_4_13
			end

			if arg_1_1.time_ >= var_4_11 + var_4_12 and arg_1_1.time_ < var_4_11 + var_4_12 + arg_4_0 then
				local var_4_14 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_14.a = 0
				arg_1_1.mask_.color = var_4_14
			end

			local var_4_15 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I16i")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501041).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501042).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_15 + 3 and arg_1_1.time_ < var_4_15 + 3 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_16 = 3

			if 3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 1.2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = Color.New(0, 0, 0)

				var_4_18.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_16) / var_4_17)
				arg_1_1.mask_.color = var_4_18
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = 1
				arg_1_1.mask_.color = var_4_19
			end

			local var_4_20 = 4.2

			if 4.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_21 = 1.2

			if var_4_20 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				local var_4_22 = Color.New(0, 0, 0)

				var_4_22.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_20) / var_4_21)
				arg_1_1.mask_.color = var_4_22
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				local var_4_23 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_23.a = 0
				arg_1_1.mask_.color = var_4_23
			end

			local var_4_24 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_24 + 3 and arg_1_1.time_ < var_4_24 + 3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 5.4
			local var_4_26 = 0.4

			if 5.4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_3")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_28 = arg_1_1:GetWordFromCfg(417122001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 16 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 16)

				if (16 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 16)) > 0 and var_4_26 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_25 = var_4_25 + 0.3

					if var_4_31 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_25
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417122", "417122001", "story_v_out_417122.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_417122", "417122001", "story_v_out_417122.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_417122", "417122001", "story_v_out_417122.awb")

						arg_1_1:RecordAudio("417122001", var_4_33)
						arg_1_1:RecordAudio("417122001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_417122", "417122001", "story_v_out_417122.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_417122", "417122001", "story_v_out_417122.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_34 = var_4_25 + 0.3
			local var_4_35 = math.max(var_4_26, arg_1_1.talkMaxDuration)

			if var_4_25 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_34) / var_4_35

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417122002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 417122002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play417122003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0.05 < arg_10_1.time_ and arg_10_1.time_ <= 0.05 + arg_13_0 then
				arg_10_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_attact", "")
			end

			local var_13_1 = 0
			local var_13_2 = 0.725

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_3 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(417122002).content)

				arg_10_1.text_.text = var_13_3

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_5 = 29 <= 0 and var_13_2 or var_13_2 * (utf8.len(var_13_3) / 29)

				if (29 <= 0 and var_13_2 or var_13_2 * (utf8.len(var_13_3) / 29)) > 0 and var_13_2 < var_13_5 then
					arg_10_1.talkMaxDuration = var_13_5

					if var_13_5 + var_13_1 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_5 + var_13_1
					end
				end

				arg_10_1.text_.text = var_13_3
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_6 = math.max(var_13_2, arg_10_1.talkMaxDuration)

			if var_13_1 <= arg_10_1.time_ and arg_10_1.time_ < var_13_1 + var_13_6 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_1) / var_13_6

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_1 + var_13_6 and arg_10_1.time_ < var_13_1 + var_13_6 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play417122003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417122003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417122004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0.333333333333333 < arg_14_1.time_ and arg_14_1.time_ <= 0.333333333333333 + arg_17_0 then
				arg_14_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_hitdown02", "")
			end

			local var_17_1 = 0
			local var_17_2 = 1.125

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_3 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(417122003).content)

				arg_14_1.text_.text = var_17_3

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_5 = 45 <= 0 and var_17_2 or var_17_2 * (utf8.len(var_17_3) / 45)

				if (45 <= 0 and var_17_2 or var_17_2 * (utf8.len(var_17_3) / 45)) > 0 and var_17_2 < var_17_5 then
					arg_14_1.talkMaxDuration = var_17_5

					if var_17_5 + var_17_1 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_5 + var_17_1
					end
				end

				arg_14_1.text_.text = var_17_3
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_6 = math.max(var_17_2, arg_14_1.talkMaxDuration)

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_6 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_1) / var_17_6

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_1 + var_17_6 and arg_14_1.time_ < var_17_1 + var_17_6 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play417122004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417122004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play417122005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0.05 < arg_18_1.time_ and arg_18_1.time_ <= 0.05 + arg_21_0 then
				arg_18_1:AudioAction("play", "effect", "se_story_side_1081", "se_story_side_1081_engine", "")
			end

			local var_21_1 = 0
			local var_21_2 = 0.65

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

				local var_21_3 = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(417122004).content)

				arg_18_1.text_.text = var_21_3

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_5 = 26 <= 0 and var_21_2 or var_21_2 * (utf8.len(var_21_3) / 26)

				if (26 <= 0 and var_21_2 or var_21_2 * (utf8.len(var_21_3) / 26)) > 0 and var_21_2 < var_21_5 then
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
	Play417122005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417122005
		arg_22_1.duration_ = 3.5

		local var_22_0 = {
			zh = 3.5,
			ja = 3.433
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
				arg_22_0:Play417122006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.375

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[1134].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3051")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_1 = arg_22_1:GetWordFromCfg(417122005)
				local var_25_2 = arg_22_1:FormatText(var_25_1.content)

				arg_22_1.text_.text = var_25_2

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_4 = 15 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 15)

				if (15 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_2) / 15)) > 0 and var_25_0 < var_25_4 then
					arg_22_1.talkMaxDuration = var_25_4

					if var_25_4 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_4 + 0
					end
				end

				arg_22_1.text_.text = var_25_2
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417122", "417122005", "story_v_out_417122.awb") ~= 0 then
					local var_25_5 = manager.audio:GetVoiceLength("story_v_out_417122", "417122005", "story_v_out_417122.awb") / 1000

					if var_25_5 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_5 + 0
					end

					if var_25_1.prefab_name ~= "" and arg_22_1.actors_[var_25_1.prefab_name] ~= nil then
						local var_25_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_1.prefab_name].transform, "story_v_out_417122", "417122005", "story_v_out_417122.awb")

						arg_22_1:RecordAudio("417122005", var_25_6)
						arg_22_1:RecordAudio("417122005", var_25_6)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417122", "417122005", "story_v_out_417122.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417122", "417122005", "story_v_out_417122.awb")
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
	Play417122006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417122006
		arg_26_1.duration_ = 6.93

		local var_26_0 = {
			zh = 4.7,
			ja = 6.933
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play417122007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.325

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_3")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_1 = arg_26_1:GetWordFromCfg(417122006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 15 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 15)

				if (15 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 15)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417122", "417122006", "story_v_out_417122.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_417122", "417122006", "story_v_out_417122.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_417122", "417122006", "story_v_out_417122.awb")

						arg_26_1:RecordAudio("417122006", var_29_6)
						arg_26_1:RecordAudio("417122006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_417122", "417122006", "story_v_out_417122.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_417122", "417122006", "story_v_out_417122.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play417122007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417122007
		arg_30_1.duration_ = 5.43

		local var_30_0 = {
			zh = 2.266,
			ja = 5.433
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
				arg_30_0:Play417122008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0.275

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_6")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_1 = arg_30_1:GetWordFromCfg(417122007)
				local var_33_2 = arg_30_1:FormatText(var_33_1.content)

				arg_30_1.text_.text = var_33_2

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_4 = 11 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 11)

				if (11 <= 0 and var_33_0 or var_33_0 * (utf8.len(var_33_2) / 11)) > 0 and var_33_0 < var_33_4 then
					arg_30_1.talkMaxDuration = var_33_4

					if var_33_4 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_4 + 0
					end
				end

				arg_30_1.text_.text = var_33_2
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417122", "417122007", "story_v_out_417122.awb") ~= 0 then
					local var_33_5 = manager.audio:GetVoiceLength("story_v_out_417122", "417122007", "story_v_out_417122.awb") / 1000

					if var_33_5 + 0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + 0
					end

					if var_33_1.prefab_name ~= "" and arg_30_1.actors_[var_33_1.prefab_name] ~= nil then
						local var_33_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_1.prefab_name].transform, "story_v_out_417122", "417122007", "story_v_out_417122.awb")

						arg_30_1:RecordAudio("417122007", var_33_6)
						arg_30_1:RecordAudio("417122007", var_33_6)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417122", "417122007", "story_v_out_417122.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417122", "417122007", "story_v_out_417122.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_7 = math.max(var_33_0, arg_30_1.talkMaxDuration)

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_7 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - 0) / var_33_7

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= 0 + var_33_7 and arg_30_1.time_ < 0 + var_33_7 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play417122008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417122008
		arg_34_1.duration_ = 8.95

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417122009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_9000

			if arg_34_1.bgs_.SS1704 == nil then
				local var_37_0 = Object.Instantiate(arg_34_1.paintGo_)

				var_37_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1704")
				var_37_0.name = "SS1704"
				var_37_0.transform.parent = arg_34_1.stage_.transform
				var_37_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.bgs_.SS1704 = var_37_0
			end

			if 1.93614629460499 < arg_34_1.time_ and arg_34_1.time_ <= 1.93614629460499 + arg_37_0 then
				local var_37_1 = arg_34_1.bgs_.SS1704

				arg_34_1.bgs_.SS1704.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_37_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_37_2 = var_37_1:GetComponent("SpriteRenderer")

				if var_37_2 and var_37_2.sprite then
					local var_37_3 = 2 * (var_37_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_37_1.transform.localScale = Vector3.New(var_37_3 / var_37_2.sprite.bounds.size.y < var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x and var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x or var_37_3 / var_37_2.sprite.bounds.size.y, var_37_3 / var_37_2.sprite.bounds.size.y < var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x and var_37_3 * manager.ui.mainCameraCom_.aspect / var_37_2.sprite.bounds.size.x or var_37_3 / var_37_2.sprite.bounds.size.y, 0)
				end

				for iter_37_0, iter_37_1 in pairs(arg_34_1.bgs_) do
					if iter_37_0 ~= "SS1704" then
						iter_37_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_37_4 = 0

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.allBtn_.enabled = false
			end

			if arg_34_1.time_ >= var_37_4 + 0.3 and arg_34_1.time_ < var_37_4 + 0.3 + arg_37_0 then
				arg_34_1.allBtn_.enabled = true
			end

			local var_37_5 = 0

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_6 = 1.95207314730249

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_6 then
				local var_37_7 = Color.New(0, 0, 0)

				var_37_7.a = Mathf.Lerp(0, 1, (arg_34_1.time_ - var_37_5) / var_37_6)
				arg_34_1.mask_.color = var_37_7
			end

			if arg_34_1.time_ >= var_37_5 + var_37_6 and arg_34_1.time_ < var_37_5 + var_37_6 + arg_37_0 then
				local var_37_8 = Color.New(0, 0, 0)

				var_37_8.a = 1
				arg_34_1.mask_.color = var_37_8
			end

			local var_37_9 = 1.95207314730249

			if 1.95207314730249 < arg_34_1.time_ and arg_34_1.time_ <= var_37_9 + arg_37_0 then
				arg_34_1.mask_.enabled = true
				arg_34_1.mask_.raycastTarget = true

				arg_34_1:SetGaussion(false)
			end

			local var_37_10 = 2.25140648063583

			if var_37_9 <= arg_34_1.time_ and arg_34_1.time_ < var_37_9 + var_37_10 then
				local var_37_11 = Color.New(0, 0, 0)

				var_37_11.a = Mathf.Lerp(1, 0, (arg_34_1.time_ - var_37_9) / var_37_10)
				arg_34_1.mask_.color = var_37_11
			end

			if arg_34_1.time_ >= var_37_9 + var_37_10 and arg_34_1.time_ < var_37_9 + var_37_10 + arg_37_0 then
				local var_37_12 = Color.New(0, 0, 0)

				arg_34_1.mask_.enabled = false
				var_37_12.a = 0
				arg_34_1.mask_.color = var_37_12
			end

			local var_37_13 = "1034"

			if arg_34_1.actors_["1034"] == nil then
				local var_37_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_37_14) then
					local var_37_15 = Object.Instantiate(var_37_14, arg_34_1.canvasGo_.transform)

					var_37_15.transform:SetSiblingIndex(1)

					var_37_15.name = var_37_13
					var_37_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_34_1.actors_[var_37_13] = var_37_15

					if arg_34_1.isInRecall_ then
						for iter_37_2, iter_37_3 in ipairs((var_37_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_37_3.color = arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_37_16 = arg_34_1.actors_["1034"]

			if 1.91807314730249 < arg_34_1.time_ and arg_34_1.time_ <= 1.91807314730249 + arg_37_0 and not isNil(var_37_16) and arg_34_1.var_.actorSpriteComps1034 == nil then
				arg_34_1.var_.actorSpriteComps1034 = var_37_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_17 = 0.2

			if 1.91807314730249 <= arg_34_1.time_ and arg_34_1.time_ < 1.91807314730249 + var_37_17 and not isNil(var_37_16) then
				if arg_34_1.var_.actorSpriteComps1034 then
					for iter_37_4, iter_37_5 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_37_5 then
							if arg_34_1.isInRecall_ then
								iter_37_5.color = Color.New(Mathf.Lerp(iter_37_5.color.r, arg_34_1.hightColor2.r, (arg_34_1.time_ - 1.91807314730249) / var_37_17), Mathf.Lerp(iter_37_5.color.g, arg_34_1.hightColor2.g, (arg_34_1.time_ - 1.91807314730249) / var_37_17), (Mathf.Lerp(iter_37_5.color.b, arg_34_1.hightColor2.b, (arg_34_1.time_ - 1.91807314730249) / var_37_17)))
							else
								local var_37_18 = Mathf.Lerp(iter_37_5.color.r, 0.5, (arg_34_1.time_ - 1.91807314730249) / var_37_17)

								iter_37_5.color = Color.New(var_37_18, var_37_18, var_37_18)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= 1.91807314730249 + var_37_17 and arg_34_1.time_ < 1.91807314730249 + var_37_17 + arg_37_0 and not isNil(var_37_16) and arg_34_1.var_.actorSpriteComps1034 then
				for iter_37_6, iter_37_7 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_37_7 then
						iter_37_7.color = arg_34_1.isInRecall_ and (arg_34_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_34_1.var_.actorSpriteComps1034 = nil
			end

			local var_37_19 = arg_34_1.actors_["1034"].transform

			if 1.91807314730249 < arg_34_1.time_ and arg_34_1.time_ <= 1.91807314730249 + arg_37_0 then
				arg_34_1.var_.moveOldPos1034 = var_37_19.localPosition
				var_37_19.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("1034", 7)

				for iter_37_8 = 0, var_37_19.childCount - 1 do
					local var_37_20 = var_37_19:GetChild(iter_37_8)

					if var_37_20.name == "" or not string.find(var_37_20.name, "split") then
						var_37_20.gameObject:SetActive(true)
					else
						var_37_20.gameObject:SetActive(false)
					end
				end
			end

			local var_37_21 = 0.001

			if 1.91807314730249 <= arg_34_1.time_ and arg_34_1.time_ < 1.91807314730249 + var_37_21 then
				var_37_19.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_34_1.time_ - 1.91807314730249) / var_37_21)
			end

			if arg_34_1.time_ >= 1.91807314730249 + var_37_21 and arg_34_1.time_ < 1.91807314730249 + var_37_21 + arg_37_0 then
				var_37_19.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.95207314730249 < arg_34_1.time_ and arg_34_1.time_ <= 1.95207314730249 + arg_37_0 then
				local var_37_22 = arg_34_1.var_.effect385

				if not arg_34_1.var_.effect385 then
					var_37_22 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), manager.ui.mainCamera.transform)
					var_37_22.name = "385"
					arg_34_1.var_.effect385 = var_37_22
				else
					var_37_22.transform:SetParent(var_37_9000)
				end

				var_37_22.transform.localPosition = Vector3.New(0, 0, -2.65)
				var_37_22.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_37_24 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_37_25 = var_37_22.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_37_9, iter_37_10 in ipairs((var_37_25:ToTable())) do
					iter_37_10.transform.localScale = Vector3.New(iter_37_10.transform.localScale.x / var_37_24 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_37_25 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_37_10.transform.localScale.y / var_37_24, iter_37_10.transform.localScale.z)
				end
			end

			local var_37_27 = arg_34_1.bgs_.SS1704.transform

			if 1.93614629460499 < arg_34_1.time_ and arg_34_1.time_ <= 1.93614629460499 + arg_37_0 then
				arg_34_1.var_.moveOldPosSS1704 = var_37_27.localPosition
			end

			local var_37_28 = 0.001

			if 1.93614629460499 <= arg_34_1.time_ and arg_34_1.time_ < 1.93614629460499 + var_37_28 then
				var_37_27.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPosSS1704, Vector3.New(0, 1, 10), (arg_34_1.time_ - 1.93614629460499) / var_37_28)
			end

			if arg_34_1.time_ >= 1.93614629460499 + var_37_28 and arg_34_1.time_ < 1.93614629460499 + var_37_28 + arg_37_0 then
				var_37_27.localPosition = Vector3.New(0, 1, 10)
			end

			local var_37_29 = arg_34_1.bgs_.SS1704.transform

			if 1.95281296127165 < arg_34_1.time_ and arg_34_1.time_ <= 1.95281296127165 + arg_37_0 then
				arg_34_1.var_.moveOldPosSS1704 = var_37_29.localPosition
			end

			local var_37_30 = 2.21666666666667

			if 1.95281296127165 <= arg_34_1.time_ and arg_34_1.time_ < 1.95281296127165 + var_37_30 then
				var_37_29.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPosSS1704, Vector3.New(0, 1, 9), (arg_34_1.time_ - 1.95281296127165) / var_37_30)
			end

			if arg_34_1.time_ >= 1.95281296127165 + var_37_30 and arg_34_1.time_ < 1.95281296127165 + var_37_30 + arg_37_0 then
				var_37_29.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_34_1.frameCnt_ <= 1 then
				arg_34_1.dialog_:SetActive(false)
			end

			local var_37_31 = 3.95207314730249
			local var_37_32 = 0.75

			if 3.95207314730249 < arg_34_1.time_ and arg_34_1.time_ <= var_37_31 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0

				arg_34_1.dialog_:SetActive(true)

				arg_34_1.dialogCg_.alpha = 0

				local var_37_33 = LeanTween.value(arg_34_1.dialog_, 0, 1, 0.3)

				var_37_33:setOnUpdate(LuaHelper.FloatAction(function(arg_38_0)
					arg_34_1.dialogCg_.alpha = arg_38_0
				end))
				var_37_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_34_1.dialog_)
					var_37_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_34_1.duration_ = arg_34_1.duration_ + 0.3

				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_34 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(417122008).content)

				arg_34_1.text_.text = var_37_34

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_36 = 30 <= 0 and var_37_32 or var_37_32 * (utf8.len(var_37_34) / 30)

				if (30 <= 0 and var_37_32 or var_37_32 * (utf8.len(var_37_34) / 30)) > 0 and var_37_32 < var_37_36 then
					arg_34_1.talkMaxDuration = var_37_36
					var_37_31 = var_37_31 + 0.3

					if var_37_36 + var_37_31 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_36 + var_37_31
					end
				end

				arg_34_1.text_.text = var_37_34
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_37 = var_37_31 + 0.3
			local var_37_38 = math.max(var_37_32, arg_34_1.talkMaxDuration)

			if var_37_31 + 0.3 <= arg_34_1.time_ and arg_34_1.time_ < var_37_37 + var_37_38 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_37) / var_37_38

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_37 + var_37_38 and arg_34_1.time_ < var_37_37 + var_37_38 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.91807314730249,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SS1704",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.93614629460499,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1704",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.21666666666667,
				className = "StoryMoveNode",
				startTime = 1.95281296127165,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play417122009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 417122009
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play417122010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0.299999999998 < arg_40_1.time_ and arg_40_1.time_ <= 0.299999999998 + arg_43_0 then
				arg_40_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_sword01", "")
			end

			local var_43_1 = 0
			local var_43_2 = 1.15

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_3 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(417122009).content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 46 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 46)

				if (46 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_3) / 46)) > 0 and var_43_2 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_6 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_6 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_6

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_6 and arg_40_1.time_ < var_43_1 + var_43_6 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play417122010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 417122010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play417122011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.7

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(417122010).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 28 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 28)

				if (28 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 28)) > 0 and var_47_0 < var_47_3 then
					arg_44_1.talkMaxDuration = var_47_3

					if var_47_3 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_3 + 0
					end
				end

				arg_44_1.text_.text = var_47_1
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_4 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_4

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play417122011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 417122011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play417122012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 1.625

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(417122011).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 65 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 65)

				if (65 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 65)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play417122012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 417122012
		arg_52_1.duration_ = 2.73

		local var_52_0 = {
			zh = 1.4,
			ja = 2.733
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
				arg_52_0:Play417122013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1034"]) and arg_52_1.var_.actorSpriteComps1034 == nil then
				arg_52_1.var_.actorSpriteComps1034 = arg_52_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_0 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1034"]) then
				if arg_52_1.var_.actorSpriteComps1034 then
					for iter_55_0, iter_55_1 in pairs(arg_52_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_55_1 then
							if arg_52_1.isInRecall_ then
								iter_55_1.color = Color.New(Mathf.Lerp(iter_55_1.color.r, arg_52_1.hightColor1.r, (arg_52_1.time_ - 0) / var_55_0), Mathf.Lerp(iter_55_1.color.g, arg_52_1.hightColor1.g, (arg_52_1.time_ - 0) / var_55_0), (Mathf.Lerp(iter_55_1.color.b, arg_52_1.hightColor1.b, (arg_52_1.time_ - 0) / var_55_0)))
							else
								local var_55_1 = Mathf.Lerp(iter_55_1.color.r, 1, (arg_52_1.time_ - 0) / var_55_0)

								iter_55_1.color = Color.New(var_55_1, var_55_1, var_55_1)
							end
						end
					end
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1034"]) and arg_52_1.var_.actorSpriteComps1034 then
				for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_55_3 then
						iter_55_3.color = arg_52_1.isInRecall_ and (arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_52_1.var_.actorSpriteComps1034 = nil
			end

			local var_55_2 = 0
			local var_55_3 = 0.15

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_2 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_4 = arg_52_1:GetWordFromCfg(417122012)
				local var_55_5 = arg_52_1:FormatText(var_55_4.content)

				arg_52_1.text_.text = var_55_5

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_7 = 6 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 6)

				if (6 <= 0 and var_55_3 or var_55_3 * (utf8.len(var_55_5) / 6)) > 0 and var_55_3 < var_55_7 then
					arg_52_1.talkMaxDuration = var_55_7

					if var_55_7 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_2
					end
				end

				arg_52_1.text_.text = var_55_5
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417122", "417122012", "story_v_out_417122.awb") ~= 0 then
					local var_55_8 = manager.audio:GetVoiceLength("story_v_out_417122", "417122012", "story_v_out_417122.awb") / 1000

					if var_55_8 + var_55_2 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_2
					end

					if var_55_4.prefab_name ~= "" and arg_52_1.actors_[var_55_4.prefab_name] ~= nil then
						local var_55_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_4.prefab_name].transform, "story_v_out_417122", "417122012", "story_v_out_417122.awb")

						arg_52_1:RecordAudio("417122012", var_55_9)
						arg_52_1:RecordAudio("417122012", var_55_9)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_417122", "417122012", "story_v_out_417122.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_417122", "417122012", "story_v_out_417122.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_10 = math.max(var_55_3, arg_52_1.talkMaxDuration)

			if var_55_2 <= arg_52_1.time_ and arg_52_1.time_ < var_55_2 + var_55_10 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_2) / var_55_10

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_2 + var_55_10 and arg_52_1.time_ < var_55_2 + var_55_10 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play417122013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 417122013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play417122014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1034"]) and arg_56_1.var_.actorSpriteComps1034 == nil then
				arg_56_1.var_.actorSpriteComps1034 = arg_56_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1034"]) then
				if arg_56_1.var_.actorSpriteComps1034 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								iter_59_1.color = Color.New(Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor2.r, (arg_56_1.time_ - 0) / var_59_0), Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor2.g, (arg_56_1.time_ - 0) / var_59_0), (Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor2.b, (arg_56_1.time_ - 0) / var_59_0)))
							else
								local var_59_1 = Mathf.Lerp(iter_59_1.color.r, 0.5, (arg_56_1.time_ - 0) / var_59_0)

								iter_59_1.color = Color.New(var_59_1, var_59_1, var_59_1)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1034"]) and arg_56_1.var_.actorSpriteComps1034 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_59_3 then
						iter_59_3.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_56_1.var_.actorSpriteComps1034 = nil
			end

			local var_59_2 = 0
			local var_59_3 = 1.025

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_4 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(417122013).content)

				arg_56_1.text_.text = var_59_4

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_6 = 41 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_4) / 41)

				if (41 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_4) / 41)) > 0 and var_59_3 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_4
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_3, arg_56_1.talkMaxDuration)

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_2) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_2 + var_59_7 and arg_56_1.time_ < var_59_2 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play417122014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 417122014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play417122015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 1.025

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(417122014).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 41 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 41)

				if (41 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 41)) > 0 and var_63_0 < var_63_3 then
					arg_60_1.talkMaxDuration = var_63_3

					if var_63_3 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_3 + 0
					end
				end

				arg_60_1.text_.text = var_63_1
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_4 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_4

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play417122015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 417122015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play417122016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0.05 < arg_64_1.time_ and arg_64_1.time_ <= 0.05 + arg_67_0 then
				arg_64_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_motorcycle03", "")
			end

			local var_67_1 = 0
			local var_67_2 = 1.375

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(417122015).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 55 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 55)

				if (55 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 55)) > 0 and var_67_2 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_6 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_6 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_6

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_6 and arg_64_1.time_ < var_67_1 + var_67_6 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play417122016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 417122016
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play417122017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.85

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_1 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(417122016).content)

				arg_68_1.text_.text = var_71_1

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_3 = 34 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 34)

				if (34 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 34)) > 0 and var_71_0 < var_71_3 then
					arg_68_1.talkMaxDuration = var_71_3

					if var_71_3 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_3 + 0
					end
				end

				arg_68_1.text_.text = var_71_1
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_4 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_4

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play417122017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 417122017
		arg_72_1.duration_ = 2.4

		local var_72_0 = {
			zh = 1.633,
			ja = 2.4
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play417122018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1034"]) and arg_72_1.var_.actorSpriteComps1034 == nil then
				arg_72_1.var_.actorSpriteComps1034 = arg_72_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_0 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1034"]) then
				if arg_72_1.var_.actorSpriteComps1034 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_75_1 then
							if arg_72_1.isInRecall_ then
								iter_75_1.color = Color.New(Mathf.Lerp(iter_75_1.color.r, arg_72_1.hightColor1.r, (arg_72_1.time_ - 0) / var_75_0), Mathf.Lerp(iter_75_1.color.g, arg_72_1.hightColor1.g, (arg_72_1.time_ - 0) / var_75_0), (Mathf.Lerp(iter_75_1.color.b, arg_72_1.hightColor1.b, (arg_72_1.time_ - 0) / var_75_0)))
							else
								local var_75_1 = Mathf.Lerp(iter_75_1.color.r, 1, (arg_72_1.time_ - 0) / var_75_0)

								iter_75_1.color = Color.New(var_75_1, var_75_1, var_75_1)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1034"]) and arg_72_1.var_.actorSpriteComps1034 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_75_3 then
						iter_75_3.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_72_1.var_.actorSpriteComps1034 = nil
			end

			local var_75_2 = 0
			local var_75_3 = 0.175

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_4 = arg_72_1:GetWordFromCfg(417122017)
				local var_75_5 = arg_72_1:FormatText(var_75_4.content)

				arg_72_1.text_.text = var_75_5

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 7 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 7)

				if (7 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 7)) > 0 and var_75_3 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_2
					end
				end

				arg_72_1.text_.text = var_75_5
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417122", "417122017", "story_v_out_417122.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_417122", "417122017", "story_v_out_417122.awb") / 1000

					if var_75_8 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_2
					end

					if var_75_4.prefab_name ~= "" and arg_72_1.actors_[var_75_4.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_4.prefab_name].transform, "story_v_out_417122", "417122017", "story_v_out_417122.awb")

						arg_72_1:RecordAudio("417122017", var_75_9)
						arg_72_1:RecordAudio("417122017", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_417122", "417122017", "story_v_out_417122.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_417122", "417122017", "story_v_out_417122.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_3, arg_72_1.talkMaxDuration)

			if var_75_2 <= arg_72_1.time_ and arg_72_1.time_ < var_75_2 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_2) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_2 + var_75_10 and arg_72_1.time_ < var_75_2 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play417122018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 417122018
		arg_76_1.duration_ = 9.5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play417122019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_9001
			local var_79_9000

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_0 = 2.38473981396916

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 then
				local var_79_1 = Color.New(0, 0, 0)

				var_79_1.a = Mathf.Lerp(0, 1, (arg_76_1.time_ - 0) / var_79_0)
				arg_76_1.mask_.color = var_79_1
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 then
				local var_79_2 = Color.New(0, 0, 0)

				var_79_2.a = 1
				arg_76_1.mask_.color = var_79_2
			end

			local var_79_3 = 2.38473981396916

			if 2.38473981396916 < arg_76_1.time_ and arg_76_1.time_ <= var_79_3 + arg_79_0 then
				arg_76_1.mask_.enabled = true
				arg_76_1.mask_.raycastTarget = true

				arg_76_1:SetGaussion(false)
			end

			local var_79_4 = 2.25140648063583

			if var_79_3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_3 + var_79_4 then
				local var_79_5 = Color.New(0, 0, 0)

				var_79_5.a = Mathf.Lerp(1, 0, (arg_76_1.time_ - var_79_3) / var_79_4)
				arg_76_1.mask_.color = var_79_5
			end

			if arg_76_1.time_ >= var_79_3 + var_79_4 and arg_76_1.time_ < var_79_3 + var_79_4 + arg_79_0 then
				local var_79_6 = Color.New(0, 0, 0)

				arg_76_1.mask_.enabled = false
				var_79_6.a = 0
				arg_76_1.mask_.color = var_79_6
			end

			local var_79_7 = "ST2105a"

			if arg_76_1.bgs_.ST2105a == nil then
				local var_79_8 = Object.Instantiate(arg_76_1.paintGo_)

				var_79_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_79_7)
				var_79_8.name = var_79_7
				var_79_8.transform.parent = arg_76_1.stage_.transform
				var_79_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.bgs_[var_79_7] = var_79_8
			end

			if 2.38473981396916 < arg_76_1.time_ and arg_76_1.time_ <= 2.38473981396916 + arg_79_0 then
				local var_79_9 = arg_76_1.bgs_.ST2105a

				arg_76_1.bgs_.ST2105a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_79_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_79_10 = var_79_9:GetComponent("SpriteRenderer")

				if var_79_10 and var_79_10.sprite then
					local var_79_11 = 2 * (var_79_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_79_9.transform.localScale = Vector3.New(var_79_11 / var_79_10.sprite.bounds.size.y < var_79_11 * manager.ui.mainCameraCom_.aspect / var_79_10.sprite.bounds.size.x and var_79_11 * manager.ui.mainCameraCom_.aspect / var_79_10.sprite.bounds.size.x or var_79_11 / var_79_10.sprite.bounds.size.y, var_79_11 / var_79_10.sprite.bounds.size.y < var_79_11 * manager.ui.mainCameraCom_.aspect / var_79_10.sprite.bounds.size.x and var_79_11 * manager.ui.mainCameraCom_.aspect / var_79_10.sprite.bounds.size.x or var_79_11 / var_79_10.sprite.bounds.size.y, 0)
				end

				for iter_79_0, iter_79_1 in pairs(arg_76_1.bgs_) do
					if iter_79_0 ~= "ST2105a" then
						iter_79_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2.38473981396916 < arg_76_1.time_ and arg_76_1.time_ <= 2.38473981396916 + arg_79_0 then
				local var_79_12 = arg_76_1.var_.effect138

				if not arg_76_1.var_.effect138 then
					var_79_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), manager.ui.mainCamera.transform)
					var_79_12.name = "138"
					arg_76_1.var_.effect138 = var_79_12
				else
					var_79_12.transform:SetParent(var_79_9001)
				end

				var_79_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_79_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.38473981396916 < arg_76_1.time_ and arg_76_1.time_ <= 2.38473981396916 + arg_79_0 then
				local var_79_14 = arg_76_1.var_.effect6343

				if not arg_76_1.var_.effect6343 then
					var_79_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy_ui"), manager.ui.mainCamera.transform)
					var_79_14.name = "6343"
					arg_76_1.var_.effect6343 = var_79_14
				else
					var_79_14.transform:SetParent(var_79_9000)
				end

				var_79_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_79_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.38473981396916 < arg_76_1.time_ and arg_76_1.time_ <= 2.38473981396916 + arg_79_0 then
				if arg_76_1.var_.effect385 then
					Object.Destroy(arg_76_1.var_.effect385)

					arg_76_1.var_.effect385 = nil
				end
			end

			if 0.466666666666667 < arg_76_1.time_ and arg_76_1.time_ <= 0.466666666666667 + arg_79_0 then
				arg_76_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_79_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_76_1.bgmTxt_.text ~= var_79_19 and arg_76_1.bgmTxt_.text ~= "" then
						if arg_76_1.bgmTxt2_.text ~= "" then
							arg_76_1.bgmTxt_.text = arg_76_1.bgmTxt2_.text
						end

						arg_76_1.bgmTxt2_.text = var_79_19

						arg_76_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_76_1.bgmTxt_.text = var_79_19
						arg_76_1.bgmTxt2_.text = var_79_19
					end

					if arg_76_1.bgmTimer then
						arg_76_1.bgmTimer:Stop()

						arg_76_1.bgmTimer = nil
					end

					if arg_76_1.settingData.show_music_name == 1 then
						arg_76_1.musicController:SetSelectedState("show")
						arg_76_1.musicAnimator_:Play("open", 0, 0)

						if arg_76_1.settingData.music_time ~= 0 then
							arg_76_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_76_1.settingData.music_time), function()
								if arg_76_1 == nil or isNil(arg_76_1.bgmTxt_) then
									return
								end

								arg_76_1.musicController:SetSelectedState("hide")
								arg_76_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2.38473981396916 < arg_76_1.time_ and arg_76_1.time_ <= 2.38473981396916 + arg_79_0 then
				arg_76_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_crisis02_loop", "")
			end

			if arg_76_1.frameCnt_ <= 1 then
				arg_76_1.dialog_:SetActive(false)
			end

			local var_79_21 = 4.5
			local var_79_22 = 0.475

			if 4.5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_21 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_23 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_23:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_76_1.dialogCg_.alpha = arg_81_0
				end))
				var_79_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_24 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(417122018).content)

				arg_76_1.text_.text = var_79_24

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_26 = 19 <= 0 and var_79_22 or var_79_22 * (utf8.len(var_79_24) / 19)

				if (19 <= 0 and var_79_22 or var_79_22 * (utf8.len(var_79_24) / 19)) > 0 and var_79_22 < var_79_26 then
					arg_76_1.talkMaxDuration = var_79_26
					var_79_21 = var_79_21 + 0.3

					if var_79_26 + var_79_21 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_26 + var_79_21
					end
				end

				arg_76_1.text_.text = var_79_24
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_27 = var_79_21 + 0.3
			local var_79_28 = math.max(var_79_22, arg_76_1.talkMaxDuration)

			if var_79_21 + 0.3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_27 + var_79_28 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_27) / var_79_28

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_27 + var_79_28 and arg_76_1.time_ < var_79_27 + var_79_28 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play417122019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 417122019
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play417122020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0.05 < arg_83_1.time_ and arg_83_1.time_ <= 0.05 + arg_86_0 then
				arg_83_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_motorcycle04", "")
			end

			local var_86_1 = 0
			local var_86_2 = 1.7

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(417122019).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 68 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 68)

				if (68 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 68)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play417122020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 417122020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play417122021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 1.575

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_2 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_2:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(417122020).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 63 <= 0 and var_90_1 or var_90_1 * (utf8.len(var_90_3) / 63)

				if (63 <= 0 and var_90_1 or var_90_1 * (utf8.len(var_90_3) / 63)) > 0 and var_90_1 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5
					var_90_0 = var_90_0 + 0.3

					if var_90_5 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = var_90_0 + 0.3
			local var_90_7 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_6) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_6 + var_90_7 and arg_87_1.time_ < var_90_6 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play417122021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 417122021
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play417122022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.075

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(417122021).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 43 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 43)

				if (43 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 43)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play417122022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 417122022
		arg_97_1.duration_ = 3.73

		local var_97_0 = {
			zh = 2.166,
			ja = 3.733
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
				arg_97_0:Play417122023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.225

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:GetWordFromCfg(417122022)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 9 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 9)

				if (9 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 9)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417122", "417122022", "story_v_out_417122.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_417122", "417122022", "story_v_out_417122.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_417122", "417122022", "story_v_out_417122.awb")

						arg_97_1:RecordAudio("417122022", var_100_6)
						arg_97_1:RecordAudio("417122022", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_417122", "417122022", "story_v_out_417122.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_417122", "417122022", "story_v_out_417122.awb")
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
	Play417122023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 417122023
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play417122024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.6

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

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(417122023).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 64 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 64)

				if (64 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 64)) > 0 and var_104_0 < var_104_3 then
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
	Play417122024 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 417122024
		arg_105_1.duration_ = 2.8

		local var_105_0 = {
			zh = 2,
			ja = 2.8
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
				arg_105_0:Play417122025(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.25

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_7")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:GetWordFromCfg(417122024)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 10 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 10)

				if (10 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 10)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417122", "417122024", "story_v_out_417122.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_417122", "417122024", "story_v_out_417122.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_417122", "417122024", "story_v_out_417122.awb")

						arg_105_1:RecordAudio("417122024", var_108_6)
						arg_105_1:RecordAudio("417122024", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_417122", "417122024", "story_v_out_417122.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_417122", "417122024", "story_v_out_417122.awb")
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
	Play417122025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 417122025
		arg_109_1.duration_ = 2.2

		local var_109_0 = {
			zh = 1.366,
			ja = 2.2
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play417122026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if arg_109_1.actors_["1052"] == nil then
				local var_112_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1052")

				if not isNil(var_112_0) then
					local var_112_1 = Object.Instantiate(var_112_0, arg_109_1.canvasGo_.transform)

					var_112_1.transform:SetSiblingIndex(1)

					var_112_1.name = "1052"
					var_112_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_109_1.actors_["1052"] = var_112_1

					if arg_109_1.isInRecall_ then
						for iter_112_0, iter_112_1 in ipairs((var_112_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_112_1.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_112_2 = arg_109_1.actors_["1052"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps1052 == nil then
				arg_109_1.var_.actorSpriteComps1052 = var_112_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_3 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.actorSpriteComps1052 then
					for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps1052:ToTable()) do
						if iter_112_3 then
							if arg_109_1.isInRecall_ then
								iter_112_3.color = Color.New(Mathf.Lerp(iter_112_3.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 0) / var_112_3), Mathf.Lerp(iter_112_3.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 0) / var_112_3), (Mathf.Lerp(iter_112_3.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 0) / var_112_3)))
							else
								local var_112_4 = Mathf.Lerp(iter_112_3.color.r, 1, (arg_109_1.time_ - 0) / var_112_3)

								iter_112_3.color = Color.New(var_112_4, var_112_4, var_112_4)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.actorSpriteComps1052 then
				for iter_112_4, iter_112_5 in pairs(arg_109_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_112_5 then
						iter_112_5.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps1052 = nil
			end

			local var_112_5 = arg_109_1.actors_["1034"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.actorSpriteComps1034 == nil then
				arg_109_1.var_.actorSpriteComps1034 = var_112_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_6 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.actorSpriteComps1034 then
					for iter_112_6, iter_112_7 in pairs(arg_109_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_112_7 then
							if arg_109_1.isInRecall_ then
								iter_112_7.color = Color.New(Mathf.Lerp(iter_112_7.color.r, arg_109_1.hightColor2.r, (arg_109_1.time_ - 0) / var_112_6), Mathf.Lerp(iter_112_7.color.g, arg_109_1.hightColor2.g, (arg_109_1.time_ - 0) / var_112_6), (Mathf.Lerp(iter_112_7.color.b, arg_109_1.hightColor2.b, (arg_109_1.time_ - 0) / var_112_6)))
							else
								local var_112_7 = Mathf.Lerp(iter_112_7.color.r, 0.5, (arg_109_1.time_ - 0) / var_112_6)

								iter_112_7.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_6 and arg_109_1.time_ < 0 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.actorSpriteComps1034 then
				for iter_112_8, iter_112_9 in pairs(arg_109_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_112_9 then
						iter_112_9.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_109_1.var_.actorSpriteComps1034 = nil
			end

			local var_112_8 = 0
			local var_112_9 = 0.125

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_10 = arg_109_1:GetWordFromCfg(417122025)
				local var_112_11 = arg_109_1:FormatText(var_112_10.content)

				arg_109_1.text_.text = var_112_11

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_13 = 5 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 5)

				if (5 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 5)) > 0 and var_112_9 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_11
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417122", "417122025", "story_v_out_417122.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_417122", "417122025", "story_v_out_417122.awb") / 1000

					if var_112_14 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_8
					end

					if var_112_10.prefab_name ~= "" and arg_109_1.actors_[var_112_10.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_10.prefab_name].transform, "story_v_out_417122", "417122025", "story_v_out_417122.awb")

						arg_109_1:RecordAudio("417122025", var_112_15)
						arg_109_1:RecordAudio("417122025", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_417122", "417122025", "story_v_out_417122.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_417122", "417122025", "story_v_out_417122.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_9, arg_109_1.talkMaxDuration)

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_8) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_8 + var_112_16 and arg_109_1.time_ < var_112_8 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play417122026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 417122026
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play417122027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1052"]) and arg_113_1.var_.actorSpriteComps1052 == nil then
				arg_113_1.var_.actorSpriteComps1052 = arg_113_1.actors_["1052"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1052"]) then
				if arg_113_1.var_.actorSpriteComps1052 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps1052:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								iter_116_1.color = Color.New(Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor2.r, (arg_113_1.time_ - 0) / var_116_0), Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor2.g, (arg_113_1.time_ - 0) / var_116_0), (Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor2.b, (arg_113_1.time_ - 0) / var_116_0)))
							else
								local var_116_1 = Mathf.Lerp(iter_116_1.color.r, 0.5, (arg_113_1.time_ - 0) / var_116_0)

								iter_116_1.color = Color.New(var_116_1, var_116_1, var_116_1)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1052"]) and arg_113_1.var_.actorSpriteComps1052 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_116_3 then
						iter_116_3.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps1052 = nil
			end

			local var_116_2 = 0
			local var_116_3 = 1.5

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_4 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(417122026).content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_6 = 60 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_4) / 60)

				if (60 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_4) / 60)) > 0 and var_116_3 < var_116_6 then
					arg_113_1.talkMaxDuration = var_116_6

					if var_116_6 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_3, arg_113_1.talkMaxDuration)

			if var_116_2 <= arg_113_1.time_ and arg_113_1.time_ < var_116_2 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_2) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_2 + var_116_7 and arg_113_1.time_ < var_116_2 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play417122027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 417122027
		arg_117_1.duration_ = 4

		local var_117_0 = {
			zh = 3.5,
			ja = 4
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
				arg_117_0:Play417122028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1052"]) and arg_117_1.var_.actorSpriteComps1052 == nil then
				arg_117_1.var_.actorSpriteComps1052 = arg_117_1.actors_["1052"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_0 = 0.2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1052"]) then
				if arg_117_1.var_.actorSpriteComps1052 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps1052:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								iter_120_1.color = Color.New(Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_0), Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_0), (Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_0)))
							else
								local var_120_1 = Mathf.Lerp(iter_120_1.color.r, 1, (arg_117_1.time_ - 0) / var_120_0)

								iter_120_1.color = Color.New(var_120_1, var_120_1, var_120_1)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1052"]) and arg_117_1.var_.actorSpriteComps1052 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps1052:ToTable()) do
					if iter_120_3 then
						iter_120_3.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps1052 = nil
			end

			local var_120_2 = 0
			local var_120_3 = 0.325

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_2 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_4 = arg_117_1:GetWordFromCfg(417122027)
				local var_120_5 = arg_117_1:FormatText(var_120_4.content)

				arg_117_1.text_.text = var_120_5

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_7 = 13 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 13)

				if (13 <= 0 and var_120_3 or var_120_3 * (utf8.len(var_120_5) / 13)) > 0 and var_120_3 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_2
					end
				end

				arg_117_1.text_.text = var_120_5
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417122", "417122027", "story_v_out_417122.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_417122", "417122027", "story_v_out_417122.awb") / 1000

					if var_120_8 + var_120_2 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_2
					end

					if var_120_4.prefab_name ~= "" and arg_117_1.actors_[var_120_4.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_4.prefab_name].transform, "story_v_out_417122", "417122027", "story_v_out_417122.awb")

						arg_117_1:RecordAudio("417122027", var_120_9)
						arg_117_1:RecordAudio("417122027", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_417122", "417122027", "story_v_out_417122.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_417122", "417122027", "story_v_out_417122.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_3, arg_117_1.talkMaxDuration)

			if var_120_2 <= arg_117_1.time_ and arg_117_1.time_ < var_120_2 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_2) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_2 + var_120_10 and arg_117_1.time_ < var_120_2 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play417122028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 417122028
		arg_121_1.duration_ = 1.8

		local var_121_0 = {
			zh = 0.999999999999,
			ja = 1.8
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
				arg_121_0:Play417122029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.1

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_5")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:GetWordFromCfg(417122028)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 4 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 4)

				if (4 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 4)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417122", "417122028", "story_v_out_417122.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_417122", "417122028", "story_v_out_417122.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_417122", "417122028", "story_v_out_417122.awb")

						arg_121_1:RecordAudio("417122028", var_124_6)
						arg_121_1:RecordAudio("417122028", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_417122", "417122028", "story_v_out_417122.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_417122", "417122028", "story_v_out_417122.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play417122029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 417122029
		arg_125_1.duration_ = 8.13

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play417122030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 1.66666666666667 < arg_125_1.time_ and arg_125_1.time_ <= 1.66666666666667 + arg_128_0 then
				local var_128_0 = arg_125_1.var_.effect809

				if not arg_125_1.var_.effect809 then
					var_128_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_1"), manager.ui.mainCamera.transform)
					var_128_0.name = "809"
					arg_125_1.var_.effect809 = var_128_0
				else
					var_128_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_128_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_128_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_128_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_128_3 = var_128_0.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_128_0, iter_128_1 in ipairs((var_128_3:ToTable())) do
					iter_128_1.transform.localScale = Vector3.New(iter_128_1.transform.localScale.x / var_128_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_128_3 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_128_1.transform.localScale.y / var_128_2, iter_128_1.transform.localScale.z)
				end
			end

			local var_128_5 = 0

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_6 = 1.66666666666667

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_6 then
				local var_128_7 = Color.New(0, 0, 0)

				var_128_7.a = Mathf.Lerp(0, 1, (arg_125_1.time_ - var_128_5) / var_128_6)
				arg_125_1.mask_.color = var_128_7
			end

			if arg_125_1.time_ >= var_128_5 + var_128_6 and arg_125_1.time_ < var_128_5 + var_128_6 + arg_128_0 then
				local var_128_8 = Color.New(0, 0, 0)

				var_128_8.a = 1
				arg_125_1.mask_.color = var_128_8
			end

			local var_128_9 = 1.66666666666667

			if 1.66666666666667 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_10 = 1.66666666666667

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_10 then
				local var_128_11 = Color.New(0, 0, 0)

				var_128_11.a = Mathf.Lerp(1, 0, (arg_125_1.time_ - var_128_9) / var_128_10)
				arg_125_1.mask_.color = var_128_11
			end

			if arg_125_1.time_ >= var_128_9 + var_128_10 and arg_125_1.time_ < var_128_9 + var_128_10 + arg_128_0 then
				local var_128_12 = Color.New(0, 0, 0)

				arg_125_1.mask_.enabled = false
				var_128_12.a = 0
				arg_125_1.mask_.color = var_128_12
			end

			if 1.63266666666667 < arg_125_1.time_ and arg_125_1.time_ <= 1.63266666666667 + arg_128_0 then
				if arg_125_1.var_.effect138 then
					Object.Destroy(arg_125_1.var_.effect138)

					arg_125_1.var_.effect138 = nil
				end
			end

			if 1.63266666666667 < arg_125_1.time_ and arg_125_1.time_ <= 1.63266666666667 + arg_128_0 then
				if arg_125_1.var_.effect6343 then
					Object.Destroy(arg_125_1.var_.effect6343)

					arg_125_1.var_.effect6343 = nil
				end
			end

			if 0.632666666666666 < arg_125_1.time_ and arg_125_1.time_ <= 0.632666666666666 + arg_128_0 then
				arg_125_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_crisis02_loop", "")
			end

			if 1.46666666666667 < arg_125_1.time_ and arg_125_1.time_ <= 1.46666666666667 + arg_128_0 then
				arg_125_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_thunderrain_loop", "")
			end

			if arg_125_1.frameCnt_ <= 1 then
				arg_125_1.dialog_:SetActive(false)
			end

			local var_128_17 = 3.13333333333333
			local var_128_18 = 1.125

			if 3.13333333333333 < arg_125_1.time_ and arg_125_1.time_ <= var_128_17 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				arg_125_1.dialog_:SetActive(true)

				arg_125_1.dialogCg_.alpha = 0

				local var_128_19 = LeanTween.value(arg_125_1.dialog_, 0, 1, 0.3)

				var_128_19:setOnUpdate(LuaHelper.FloatAction(function(arg_129_0)
					arg_125_1.dialogCg_.alpha = arg_129_0
				end))
				var_128_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_125_1.dialog_)
					var_128_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_125_1.duration_ = arg_125_1.duration_ + 0.3

				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_20 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(417122029).content)

				arg_125_1.text_.text = var_128_20

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_22 = 45 <= 0 and var_128_18 or var_128_18 * (utf8.len(var_128_20) / 45)

				if (45 <= 0 and var_128_18 or var_128_18 * (utf8.len(var_128_20) / 45)) > 0 and var_128_18 < var_128_22 then
					arg_125_1.talkMaxDuration = var_128_22
					var_128_17 = var_128_17 + 0.3

					if var_128_22 + var_128_17 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_22 + var_128_17
					end
				end

				arg_125_1.text_.text = var_128_20
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_23 = var_128_17 + 0.3
			local var_128_24 = math.max(var_128_18, arg_125_1.talkMaxDuration)

			if var_128_17 + 0.3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_23 + var_128_24 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_23) / var_128_24

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_23 + var_128_24 and arg_125_1.time_ < var_128_23 + var_128_24 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play417122030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 417122030
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play417122031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 1.125

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(417122030).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 45 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 45)

				if (45 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 45)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play417122031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 417122031
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play417122032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 1.525

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(417122031).content)

				arg_135_1.text_.text = var_138_1

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_3 = 61 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 61)

				if (61 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 61)) > 0 and var_138_0 < var_138_3 then
					arg_135_1.talkMaxDuration = var_138_3

					if var_138_3 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_3 + 0
					end
				end

				arg_135_1.text_.text = var_138_1
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_4 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_4

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play417122032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 417122032
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play417122033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 1.025

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(417122032).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 41 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 41)

				if (41 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 41)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play417122033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 417122033
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play417122034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 1.05

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(417122033).content)

				arg_143_1.text_.text = var_146_1

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_3 = 42 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 42)

				if (42 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_1) / 42)) > 0 and var_146_0 < var_146_3 then
					arg_143_1.talkMaxDuration = var_146_3

					if var_146_3 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_3 + 0
					end
				end

				arg_143_1.text_.text = var_146_1
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_4 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_4 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_4

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_4 and arg_143_1.time_ < 0 + var_146_4 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play417122034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 417122034
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play417122035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.1

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(417122034).content)

				arg_147_1.text_.text = var_150_1

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_3 = 4 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 4)

				if (4 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_1) / 4)) > 0 and var_150_0 < var_150_3 then
					arg_147_1.talkMaxDuration = var_150_3

					if var_150_3 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_3 + 0
					end
				end

				arg_147_1.text_.text = var_150_1
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_4 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_4

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play417122035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 417122035
		arg_151_1.duration_ = 4.2

		local var_151_0 = {
			zh = 1.166,
			ja = 4.2
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play417122036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1034"]) and arg_151_1.var_.actorSpriteComps1034 == nil then
				arg_151_1.var_.actorSpriteComps1034 = arg_151_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1034"]) then
				if arg_151_1.var_.actorSpriteComps1034 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								iter_154_1.color = Color.New(Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor1.r, (arg_151_1.time_ - 0) / var_154_0), Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor1.g, (arg_151_1.time_ - 0) / var_154_0), (Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor1.b, (arg_151_1.time_ - 0) / var_154_0)))
							else
								local var_154_1 = Mathf.Lerp(iter_154_1.color.r, 1, (arg_151_1.time_ - 0) / var_154_0)

								iter_154_1.color = Color.New(var_154_1, var_154_1, var_154_1)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1034"]) and arg_151_1.var_.actorSpriteComps1034 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_151_1.var_.actorSpriteComps1034 = nil
			end

			local var_154_2 = 0
			local var_154_3 = 0.1

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_4")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_4 = arg_151_1:GetWordFromCfg(417122035)
				local var_154_5 = arg_151_1:FormatText(var_154_4.content)

				arg_151_1.text_.text = var_154_5

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_7 = 4 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 4)

				if (4 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_5) / 4)) > 0 and var_154_3 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_5
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417122", "417122035", "story_v_out_417122.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_417122", "417122035", "story_v_out_417122.awb") / 1000

					if var_154_8 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_2
					end

					if var_154_4.prefab_name ~= "" and arg_151_1.actors_[var_154_4.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_4.prefab_name].transform, "story_v_out_417122", "417122035", "story_v_out_417122.awb")

						arg_151_1:RecordAudio("417122035", var_154_9)
						arg_151_1:RecordAudio("417122035", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_417122", "417122035", "story_v_out_417122.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_417122", "417122035", "story_v_out_417122.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_10 and arg_151_1.time_ < var_154_2 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play417122036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 417122036
		arg_155_1.duration_ = 6.8

		local var_155_0 = {
			zh = 6.8,
			ja = 2.166
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
				arg_155_0:Play417122037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.275

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_4")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_1 = arg_155_1:GetWordFromCfg(417122036)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 11 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 11)

				if (11 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 11)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417122", "417122036", "story_v_out_417122.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_417122", "417122036", "story_v_out_417122.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_417122", "417122036", "story_v_out_417122.awb")

						arg_155_1:RecordAudio("417122036", var_158_6)
						arg_155_1:RecordAudio("417122036", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_417122", "417122036", "story_v_out_417122.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_417122", "417122036", "story_v_out_417122.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play417122037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 417122037
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play417122038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1034"]) and arg_159_1.var_.actorSpriteComps1034 == nil then
				arg_159_1.var_.actorSpriteComps1034 = arg_159_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_0 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1034"]) then
				if arg_159_1.var_.actorSpriteComps1034 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								iter_162_1.color = Color.New(Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor2.r, (arg_159_1.time_ - 0) / var_162_0), Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor2.g, (arg_159_1.time_ - 0) / var_162_0), (Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor2.b, (arg_159_1.time_ - 0) / var_162_0)))
							else
								local var_162_1 = Mathf.Lerp(iter_162_1.color.r, 0.5, (arg_159_1.time_ - 0) / var_162_0)

								iter_162_1.color = Color.New(var_162_1, var_162_1, var_162_1)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1034"]) and arg_159_1.var_.actorSpriteComps1034 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_162_3 then
						iter_162_3.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_159_1.var_.actorSpriteComps1034 = nil
			end

			if 0.05 < arg_159_1.time_ and arg_159_1.time_ <= 0.05 + arg_162_0 then
				arg_159_1:AudioAction("play", "effect", "se_story_139", "se_story_139_branch", "")
			end

			local var_162_3 = 0
			local var_162_4 = 1.45

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_3 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_5 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(417122037).content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 58 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_5) / 58)

				if (58 <= 0 and var_162_4 or var_162_4 * (utf8.len(var_162_5) / 58)) > 0 and var_162_4 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_3 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_3
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_8 = math.max(var_162_4, arg_159_1.talkMaxDuration)

			if var_162_3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_3 + var_162_8 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_3) / var_162_8

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_3 + var_162_8 and arg_159_1.time_ < var_162_3 + var_162_8 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play417122038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 417122038
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play417122039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.875

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

				local var_166_1 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(417122038).content)

				arg_163_1.text_.text = var_166_1

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_3 = 35 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 35)

				if (35 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_1) / 35)) > 0 and var_166_0 < var_166_3 then
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
	Play417122039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 417122039
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play417122040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 1.025

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(417122039).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 41 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 41)

				if (41 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 41)) > 0 and var_170_0 < var_170_3 then
					arg_167_1.talkMaxDuration = var_170_3

					if var_170_3 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_3 + 0
					end
				end

				arg_167_1.text_.text = var_170_1
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_4 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_4

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play417122040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 417122040
		arg_171_1.duration_ = 4.3

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play417122041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_9001
			local var_174_9000

			if 0.866666666666667 < arg_171_1.time_ and arg_171_1.time_ <= 0.866666666666667 + arg_174_0 then
				if arg_171_1.var_.effect809 then
					Object.Destroy(arg_171_1.var_.effect809)

					arg_171_1.var_.effect809 = nil
				end
			end

			if 0.866666666666667 < arg_171_1.time_ and arg_171_1.time_ <= 0.866666666666667 + arg_174_0 then
				arg_171_1.cswbg_:SetActive(true)

				local var_174_1 = arg_171_1.cswt_:GetComponent("RectTransform")

				arg_171_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_174_1.offsetMin = Vector2.New(400, 105)
				var_174_1.offsetMax = Vector2.New(-400, -200)
				arg_171_1.cswt_.text = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(419105).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.cswt_)

				arg_171_1.cswt_.fontSize = 105
				arg_171_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_171_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_171_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0.866666666666668 < arg_171_1.time_ and arg_171_1.time_ <= 0.866666666666668 + arg_174_0 then
				local var_174_2 = arg_171_1.fswbg_.transform:Find("textbox/adapt/content") or arg_171_1.fswbg_.transform:Find("textbox/content")
				local var_174_3 = arg_171_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_174_4 = var_174_2:GetComponent("RectTransform")

				var_174_2:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_174_4.offsetMin = Vector2.New(0, 0)
				var_174_4.offsetMax = Vector2.New(0, 0)
			end

			if 0.866666666666668 < arg_171_1.time_ and arg_171_1.time_ <= 0.866666666666668 + arg_174_0 then
				arg_171_1.fswbg_:SetActive(true)
				arg_171_1.dialog_:SetActive(false)

				arg_171_1.fswtw_.percent = 0
				arg_171_1.fswt_.text = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(417122040).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.fswt_)

				arg_171_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_171_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_171_1.fswtw_:SetDirty()

				arg_171_1.typewritterCharCountI18N = 0

				SetActive(arg_171_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_171_1:ShowNextGo(false)
			end

			local var_174_5 = 2.23333333333233

			if 2.23333333333233 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.var_.oldValueTypewriter = arg_171_1.fswtw_.percent

				SetActive(arg_171_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_171_1:ShowNextGo(false)
			end

			local var_174_6 = 13
			local var_174_7 = 0.866666666666667
			local var_174_8, var_174_9 = arg_171_1:GetPercentByPara(arg_171_1:FormatText(arg_171_1:GetWordFromCfg(417122040).content), 1)

			if var_174_5 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				local var_174_10 = var_174_6 <= 0 and var_174_7 or var_174_7 * ((var_174_9 - arg_171_1.typewritterCharCountI18N) / var_174_6)

				if (var_174_6 <= 0 and var_174_7 or var_174_7 * ((var_174_9 - arg_171_1.typewritterCharCountI18N) / var_174_6)) > 0 and var_174_7 < var_174_10 then
					arg_171_1.talkMaxDuration = var_174_10

					if var_174_10 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_5
					end
				end
			end

			local var_174_11 = math.max(0.866666666666667, arg_171_1.talkMaxDuration)

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_11 then
				arg_171_1.fswtw_.percent = Mathf.Lerp(arg_171_1.var_.oldValueTypewriter, var_174_8, (arg_171_1.time_ - var_174_5) / var_174_11)
				arg_171_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_171_1.fswtw_:SetDirty()
			end

			if arg_171_1.time_ >= var_174_5 + var_174_11 and arg_171_1.time_ < var_174_5 + var_174_11 + arg_174_0 then
				arg_171_1.fswtw_.percent = var_174_8

				arg_171_1.fswtw_:SetDirty()
				arg_171_1:ShowNextGo(true)

				arg_171_1.typewritterCharCountI18N = var_174_9
			end

			local var_174_12 = 0

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_12 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_13 = 1

			if var_174_12 <= arg_171_1.time_ and arg_171_1.time_ < var_174_12 + var_174_13 then
				local var_174_14 = Color.New(0, 0, 0)

				var_174_14.a = Mathf.Lerp(0, 1, (arg_171_1.time_ - var_174_12) / var_174_13)
				arg_171_1.mask_.color = var_174_14
			end

			if arg_171_1.time_ >= var_174_12 + var_174_13 and arg_171_1.time_ < var_174_12 + var_174_13 + arg_174_0 then
				local var_174_15 = Color.New(0, 0, 0)

				var_174_15.a = 1
				arg_171_1.mask_.color = var_174_15
			end

			local var_174_16 = 0.866666666666667

			if 0.866666666666667 < arg_171_1.time_ and arg_171_1.time_ <= var_174_16 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_17 = 1

			if var_174_16 <= arg_171_1.time_ and arg_171_1.time_ < var_174_16 + var_174_17 then
				local var_174_18 = Color.New(0, 0, 0)

				var_174_18.a = Mathf.Lerp(1, 0, (arg_171_1.time_ - var_174_16) / var_174_17)
				arg_171_1.mask_.color = var_174_18
			end

			if arg_171_1.time_ >= var_174_16 + var_174_17 and arg_171_1.time_ < var_174_16 + var_174_17 + arg_174_0 then
				local var_174_19 = Color.New(0, 0, 0)

				arg_171_1.mask_.enabled = false
				var_174_19.a = 0
				arg_171_1.mask_.color = var_174_19
			end

			local var_174_20 = "STblack"

			if arg_171_1.bgs_.STblack == nil then
				local var_174_21 = Object.Instantiate(arg_171_1.paintGo_)

				var_174_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_174_20)
				var_174_21.name = var_174_20
				var_174_21.transform.parent = arg_171_1.stage_.transform
				var_174_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_171_1.bgs_[var_174_20] = var_174_21
			end

			if 0.866666666666667 < arg_171_1.time_ and arg_171_1.time_ <= 0.866666666666667 + arg_174_0 then
				local var_174_22 = arg_171_1.bgs_.STblack

				arg_171_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_174_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_23 = var_174_22:GetComponent("SpriteRenderer")

				if var_174_23 and var_174_23.sprite then
					local var_174_24 = 2 * (var_174_22.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_174_22.transform.localScale = Vector3.New(var_174_24 / var_174_23.sprite.bounds.size.y < var_174_24 * manager.ui.mainCameraCom_.aspect / var_174_23.sprite.bounds.size.x and var_174_24 * manager.ui.mainCameraCom_.aspect / var_174_23.sprite.bounds.size.x or var_174_24 / var_174_23.sprite.bounds.size.y, var_174_24 / var_174_23.sprite.bounds.size.y < var_174_24 * manager.ui.mainCameraCom_.aspect / var_174_23.sprite.bounds.size.x and var_174_24 * manager.ui.mainCameraCom_.aspect / var_174_23.sprite.bounds.size.x or var_174_24 / var_174_23.sprite.bounds.size.y, 0)
				end

				for iter_174_0, iter_174_1 in pairs(arg_171_1.bgs_) do
					if iter_174_0 ~= "STblack" then
						iter_174_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.866666666666667 < arg_171_1.time_ and arg_171_1.time_ <= 0.866666666666667 + arg_174_0 then
				local var_174_25 = arg_171_1.var_.effect809

				if not arg_171_1.var_.effect809 then
					var_174_25 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_1"), manager.ui.mainCamera.transform)
					var_174_25.name = "809"
					arg_171_1.var_.effect809 = var_174_25
				else
					var_174_25.transform:SetParent(var_174_9001)
				end

				var_174_25.transform.localPosition = Vector3.New(0, 0, 0)
				var_174_25.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_174_27 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_174_28 = var_174_25.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_174_2, iter_174_3 in ipairs((var_174_28:ToTable())) do
					iter_174_3.transform.localScale = Vector3.New(iter_174_3.transform.localScale.x / var_174_27 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_174_28 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_174_3.transform.localScale.y / var_174_27, iter_174_3.transform.localScale.z)
				end
			end

			if 0.866666666666666 < arg_171_1.time_ and arg_171_1.time_ <= 0.866666666666666 + arg_174_0 then
				local var_174_30 = arg_171_1.var_.effect244

				if not arg_171_1.var_.effect244 then
					var_174_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_174_30.name = "244"
					arg_171_1.var_.effect244 = var_174_30
				else
					var_174_30.transform:SetParent(var_174_9000)
				end

				var_174_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_174_30.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_174_32 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_174_33 = var_174_30.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_174_4, iter_174_5 in ipairs((var_174_33:ToTable())) do
					iter_174_5.transform.localScale = Vector3.New(iter_174_5.transform.localScale.x / var_174_32 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_174_33 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_174_5.transform.localScale.y / var_174_32, iter_174_5.transform.localScale.z)
				end
			end

			if 1.20947020035237 < arg_171_1.time_ and arg_171_1.time_ <= 1.20947020035237 + arg_174_0 then
				if arg_171_1.var_.effect244 then
					Object.Destroy(arg_171_1.var_.effect244)

					arg_171_1.var_.effect244 = nil
				end
			end

			local var_174_36 = 1.06666666666667

			if 1.06666666666667 < arg_171_1.time_ and arg_171_1.time_ <= var_174_36 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_37 = 0.557196466314296

			if var_174_36 <= arg_171_1.time_ and arg_171_1.time_ < var_174_36 + var_174_37 then
				local var_174_38 = Color.New(0.9528302, 0.9528302, 0.9528302)

				var_174_38.a = Mathf.Lerp(1, 0, (arg_171_1.time_ - var_174_36) / var_174_37)
				arg_171_1.mask_.color = var_174_38
			end

			if arg_171_1.time_ >= var_174_36 + var_174_37 and arg_171_1.time_ < var_174_36 + var_174_37 + arg_174_0 then
				local var_174_39 = Color.New(0.9528302, 0.9528302, 0.9528302)

				arg_171_1.mask_.enabled = false
				var_174_39.a = 0
				arg_171_1.mask_.color = var_174_39
			end

			if 0.900666666666668 < arg_171_1.time_ and arg_171_1.time_ <= 0.900666666666668 + arg_174_0 then
				arg_171_1:AudioAction("play", "effect", "se_story_16", "se_story_16_thunder02", "")
			end

			local var_174_41 = 2.23333333333233
			local var_174_42 = manager.audio:GetVoiceLength("story_v_out_417122", "417122040", "") / 1000

			if var_174_42 > 0 and 2.066 < var_174_42 and var_174_42 + var_174_41 > arg_171_1.duration_ then
				arg_171_1.duration_ = var_174_42 + var_174_41
			end

			if var_174_41 < arg_171_1.time_ and arg_171_1.time_ <= var_174_41 + arg_174_0 then
				arg_171_1:AudioAction("play", "voice", "story_v_out_417122", "417122040", "")
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play417122041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 417122041
		arg_175_1.duration_ = 7.93

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
			arg_175_1.auto_ = false
		end

		function arg_175_1.playNext_(arg_177_0)
			arg_175_1.onStoryFinished_()
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 8.88178419700125e-16 < arg_175_1.time_ and arg_175_1.time_ <= 8.88178419700125e-16 + arg_178_0 then
				arg_175_1.fswbg_:SetActive(true)
				arg_175_1.dialog_:SetActive(false)

				arg_175_1.fswtw_.percent = 0
				arg_175_1.fswt_.text = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(417122041).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.fswt_)

				arg_175_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_175_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_175_1.fswtw_:SetDirty()

				arg_175_1.typewritterCharCountI18N = 0

				SetActive(arg_175_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_175_1:ShowNextGo(false)
			end

			local var_178_0 = 1

			if 1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.var_.oldValueTypewriter = arg_175_1.fswtw_.percent

				SetActive(arg_175_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_175_1:ShowNextGo(false)
			end

			local var_178_1 = 11
			local var_178_2 = 0.733333333333333
			local var_178_3, var_178_4 = arg_175_1:GetPercentByPara(arg_175_1:FormatText(arg_175_1:GetWordFromCfg(417122041).content), 1)

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				local var_178_5 = var_178_1 <= 0 and var_178_2 or var_178_2 * ((var_178_4 - arg_175_1.typewritterCharCountI18N) / var_178_1)

				if (var_178_1 <= 0 and var_178_2 or var_178_2 * ((var_178_4 - arg_175_1.typewritterCharCountI18N) / var_178_1)) > 0 and var_178_2 < var_178_5 then
					arg_175_1.talkMaxDuration = var_178_5

					if var_178_5 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + var_178_0
					end
				end
			end

			local var_178_6 = math.max(0.733333333333333, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_6 then
				arg_175_1.fswtw_.percent = Mathf.Lerp(arg_175_1.var_.oldValueTypewriter, var_178_3, (arg_175_1.time_ - var_178_0) / var_178_6)
				arg_175_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_175_1.fswtw_:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_6 and arg_175_1.time_ < var_178_0 + var_178_6 + arg_178_0 then
				arg_175_1.fswtw_.percent = var_178_3

				arg_175_1.fswtw_:SetDirty()
				arg_175_1:ShowNextGo(true)

				arg_175_1.typewritterCharCountI18N = var_178_4
			end

			local var_178_7 = 0

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_7 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			if arg_175_1.time_ >= var_178_7 + 1.23333333333333 and arg_175_1.time_ < var_178_7 + 1.23333333333333 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			local var_178_8 = 5.76666666666667

			if 5.76666666666667 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = false

				arg_175_1:SetGaussion(false)
			end

			local var_178_9 = 0.5

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_9 then
				local var_178_10 = Color.New(0, 0, 0)

				var_178_10.a = Mathf.Lerp(0, 1, (arg_175_1.time_ - var_178_8) / var_178_9)
				arg_175_1.mask_.color = var_178_10
			end

			if arg_175_1.time_ >= var_178_8 + var_178_9 and arg_175_1.time_ < var_178_8 + var_178_9 + arg_178_0 then
				local var_178_11 = Color.New(0, 0, 0)

				var_178_11.a = 1
				arg_175_1.mask_.color = var_178_11
			end

			local var_178_12 = 6.26666666666667

			if 6.26666666666667 < arg_175_1.time_ and arg_175_1.time_ <= var_178_12 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = false

				arg_175_1:SetGaussion(false)
			end

			local var_178_13 = 0.533333333333333

			if var_178_12 <= arg_175_1.time_ and arg_175_1.time_ < var_178_12 + var_178_13 then
				local var_178_14 = Color.New(0, 0, 0)

				var_178_14.a = Mathf.Lerp(1, 0, (arg_175_1.time_ - var_178_12) / var_178_13)
				arg_175_1.mask_.color = var_178_14
			end

			if arg_175_1.time_ >= var_178_12 + var_178_13 and arg_175_1.time_ < var_178_12 + var_178_13 + arg_178_0 then
				local var_178_15 = Color.New(0, 0, 0)

				arg_175_1.mask_.enabled = false
				var_178_15.a = 0
				arg_175_1.mask_.color = var_178_15
			end

			if 6.26666666666667 < arg_175_1.time_ and arg_175_1.time_ <= 6.26666666666667 + arg_178_0 then
				local var_178_16 = arg_175_1.bgs_.STblack

				arg_175_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_178_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_17 = var_178_16:GetComponent("SpriteRenderer")

				if var_178_17 and var_178_17.sprite then
					local var_178_18 = 2 * (var_178_16.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_178_16.transform.localScale = Vector3.New(var_178_18 / var_178_17.sprite.bounds.size.y < var_178_18 * manager.ui.mainCameraCom_.aspect / var_178_17.sprite.bounds.size.x and var_178_18 * manager.ui.mainCameraCom_.aspect / var_178_17.sprite.bounds.size.x or var_178_18 / var_178_17.sprite.bounds.size.y, var_178_18 / var_178_17.sprite.bounds.size.y < var_178_18 * manager.ui.mainCameraCom_.aspect / var_178_17.sprite.bounds.size.x and var_178_18 * manager.ui.mainCameraCom_.aspect / var_178_17.sprite.bounds.size.x or var_178_18 / var_178_17.sprite.bounds.size.y, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "STblack" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 6.26666666666667 < arg_175_1.time_ and arg_175_1.time_ <= 6.26666666666667 + arg_178_0 then
				if arg_175_1.var_.effect809 then
					Object.Destroy(arg_175_1.var_.effect809)

					arg_175_1.var_.effect809 = nil
				end
			end

			if 6.26666666666667 < arg_175_1.time_ and arg_175_1.time_ <= 6.26666666666667 + arg_178_0 then
				arg_175_1.fswbg_:SetActive(false)
				arg_175_1.dialog_:SetActive(false)
				SetActive(arg_175_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_175_1:ShowNextGo(false)
			end

			if 6.30066666666667 < arg_175_1.time_ and arg_175_1.time_ <= 6.30066666666667 + arg_178_0 then
				arg_175_1.fswbg_:SetActive(false)
				arg_175_1.dialog_:SetActive(false)
				SetActive(arg_175_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_175_1:ShowNextGo(false)
			end

			if 6.26666666666667 < arg_175_1.time_ and arg_175_1.time_ <= 6.26666666666667 + arg_178_0 then
				arg_175_1.cswbg_:SetActive(false)
			end

			local var_178_20 = 1
			local var_178_21 = manager.audio:GetVoiceLength("story_v_out_417122", "417122041", "") / 1000

			if var_178_21 > 0 and 4 < var_178_21 and var_178_21 + var_178_20 > arg_175_1.duration_ then
				arg_175_1.duration_ = var_178_21 + var_178_20
			end

			if var_178_20 < arg_175_1.time_ and arg_175_1.time_ <= var_178_20 + arg_178_0 then
				arg_175_1:AudioAction("play", "voice", "story_v_out_417122", "417122041", "")
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I16i",
		"TextureConfig/Background/SS1704",
		"TextureConfig/Background/ST2105a",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_417122.awb"
	}
}
