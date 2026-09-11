return {
	Play323611001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323611001
		arg_1_1.duration_ = 10.9

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play323611002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.J21f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J21f")
				var_4_0.name = "J21f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J21f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J21f

				arg_1_1.bgs_.J21f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J21f" then
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

			local var_4_6 = 1.43333333333333

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

			local var_4_9 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J21f")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(102).content)
				arg_1_1.text_timeText_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501125).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_9 + 3 and arg_1_1.time_ < var_4_9 + 3 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_10 = 3

			if 3 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_11 = 1.2

			if var_4_10 <= arg_1_1.time_ and arg_1_1.time_ < var_4_10 + var_4_11 then
				local var_4_12 = Color.New(0, 0, 0)

				var_4_12.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_10) / var_4_11)
				arg_1_1.mask_.color = var_4_12
			end

			if arg_1_1.time_ >= var_4_10 + var_4_11 and arg_1_1.time_ < var_4_10 + var_4_11 + arg_4_0 then
				local var_4_13 = Color.New(0, 0, 0)

				var_4_13.a = 1
				arg_1_1.mask_.color = var_4_13
			end

			local var_4_14 = 4.2

			if 4.2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_15 = 1.26666666666667

			if var_4_14 <= arg_1_1.time_ and arg_1_1.time_ < var_4_14 + var_4_15 then
				local var_4_16 = Color.New(0, 0, 0)

				var_4_16.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_14) / var_4_15)
				arg_1_1.mask_.color = var_4_16
			end

			if arg_1_1.time_ >= var_4_14 + var_4_15 and arg_1_1.time_ < var_4_14 + var_4_15 + arg_4_0 then
				local var_4_17 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_17.a = 0
				arg_1_1.mask_.color = var_4_17
			end

			if 5.06666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 5.06666666666667 + arg_4_0 then
				local var_4_18 = arg_1_1.var_.effect444

				if not arg_1_1.var_.effect444 then
					var_4_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_4_18.name = "444"
					arg_1_1.var_.effect444 = var_4_18
				else
					var_4_18.transform:SetParent(var_4_9000)
				end

				var_4_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_18.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_20 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_4_18.transform.localScale = Vector3.New(var_4_18.transform.localScale.x * var_4_20, var_4_18.transform.localScale.y * var_4_20, var_4_18.transform.localScale.z * var_4_20)
			end

			if 6.84112076393018 < arg_1_1.time_ and arg_1_1.time_ <= 6.84112076393018 + arg_4_0 then
				if arg_1_1.var_.effect444 then
					Object.Destroy(arg_1_1.var_.effect444)

					arg_1_1.var_.effect444 = nil
				end
			end

			local var_4_22 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_22 + 6.1 and arg_1_1.time_ < var_4_22 + 6.1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_battleground", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_26 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_26

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_26
						arg_1_1.bgmTxt2_.text = var_4_26
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan.awb")

				local var_4_29 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_dahuang_pingyuan", "init_story", "bgm_activity_4_8_story_dahuang_pingyuan.awb")

				local var_4_32 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_pingyuan", "init_story")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_32 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_32

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_32
						arg_1_1.bgmTxt2_.text = var_4_32
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_wind", "")
			end

			if 5.06666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 5.06666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_sword", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_35 = 5.9
			local var_4_36 = 1.05

			if 5.9 < arg_1_1.time_ and arg_1_1.time_ <= var_4_35 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_37 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_37:setOnUpdate(LuaHelper.FloatAction(function(arg_9_0)
					arg_1_1.dialogCg_.alpha = arg_9_0
				end))
				var_4_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_38 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(323611001).content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_40 = 42 <= 0 and var_4_36 or var_4_36 * (utf8.len(var_4_38) / 42)

				if (42 <= 0 and var_4_36 or var_4_36 * (utf8.len(var_4_38) / 42)) > 0 and var_4_36 < var_4_40 then
					arg_1_1.talkMaxDuration = var_4_40
					var_4_35 = var_4_35 + 0.3

					if var_4_40 + var_4_35 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_40 + var_4_35
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_41 = var_4_35 + 0.3
			local var_4_42 = math.max(var_4_36, arg_1_1.talkMaxDuration)

			if var_4_35 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_41) / var_4_42

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323611002 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 323611002
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play323611003(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 1.4

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_1 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(323611002).content)

				arg_11_1.text_.text = var_14_1

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_3 = 56 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 56)

				if (56 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 56)) > 0 and var_14_0 < var_14_3 then
					arg_11_1.talkMaxDuration = var_14_3

					if var_14_3 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_3 + 0
					end
				end

				arg_11_1.text_.text = var_14_1
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_4 = math.max(var_14_0, arg_11_1.talkMaxDuration)

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - 0) / var_14_4

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play323611003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 323611003
		arg_15_1.duration_ = 1

		local var_15_0 = {
			zh = 0.999999999999,
			ja = 1
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play323611004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if arg_15_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_18_0 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_15_1.stage_.transform)

				var_18_0.name = "1033ui_story"
				var_18_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_["1033ui_story"] = var_18_0

				local var_18_1 = var_18_0:GetComponentInChildren(typeof(CharacterEffect))

				var_18_1.enabled = true

				local var_18_2 = GameObjectTools.GetOrAddComponent(var_18_0, typeof(DynamicBoneHelper))

				if var_18_2 then
					var_18_2:EnableDynamicBone(false)
				end

				arg_15_1:ShowWeapon(var_18_1.transform, false)

				arg_15_1.var_["1033ui_story" .. "Animator"] = var_18_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_15_1.var_["1033ui_story" .. "Animator"].applyRootMotion = true
				arg_15_1.var_["1033ui_story" .. "LipSync"] = var_18_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_18_3 = arg_15_1.actors_["1033ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_3) and arg_15_1.var_.characterEffect1033ui_story == nil then
				arg_15_1.var_.characterEffect1033ui_story = var_18_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_4 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_4 and not isNil(var_18_3) then
				if arg_15_1.var_.characterEffect1033ui_story and not isNil(var_18_3) then
					arg_15_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_4 and arg_15_1.time_ < 0 + var_18_4 + arg_18_0 and not isNil(var_18_3) and arg_15_1.var_.characterEffect1033ui_story then
				arg_15_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_18_6 = 0
			local var_18_7 = 0.075

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_8 = arg_15_1:GetWordFromCfg(323611003)
				local var_18_9 = arg_15_1:FormatText(var_18_8.content)

				arg_15_1.text_.text = var_18_9

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_11 = 3 <= 0 and var_18_7 or var_18_7 * (utf8.len(var_18_9) / 3)

				if (3 <= 0 and var_18_7 or var_18_7 * (utf8.len(var_18_9) / 3)) > 0 and var_18_7 < var_18_11 then
					arg_15_1.talkMaxDuration = var_18_11

					if var_18_11 + var_18_6 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_11 + var_18_6
					end
				end

				arg_15_1.text_.text = var_18_9
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323611", "323611003", "story_v_out_323611.awb") ~= 0 then
					local var_18_12 = manager.audio:GetVoiceLength("story_v_out_323611", "323611003", "story_v_out_323611.awb") / 1000

					if var_18_12 + var_18_6 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_12 + var_18_6
					end

					if var_18_8.prefab_name ~= "" and arg_15_1.actors_[var_18_8.prefab_name] ~= nil then
						local var_18_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_8.prefab_name].transform, "story_v_out_323611", "323611003", "story_v_out_323611.awb")

						arg_15_1:RecordAudio("323611003", var_18_13)
						arg_15_1:RecordAudio("323611003", var_18_13)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_323611", "323611003", "story_v_out_323611.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_323611", "323611003", "story_v_out_323611.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_14 = math.max(var_18_7, arg_15_1.talkMaxDuration)

			if var_18_6 <= arg_15_1.time_ and arg_15_1.time_ < var_18_6 + var_18_14 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_6) / var_18_14

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_6 + var_18_14 and arg_15_1.time_ < var_18_6 + var_18_14 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play323611004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 323611004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play323611005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1033ui_story"]) and arg_19_1.var_.characterEffect1033ui_story == nil then
				arg_19_1.var_.characterEffect1033ui_story = arg_19_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_0 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["1033ui_story"]) then
				if arg_19_1.var_.characterEffect1033ui_story and not isNil(arg_19_1.actors_["1033ui_story"]) then
					arg_19_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_19_1.time_ - 0) / var_22_0)
				end
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["1033ui_story"]) and arg_19_1.var_.characterEffect1033ui_story then
				arg_19_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_22_1 = 0
			local var_22_2 = 0.05

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_19_1.callingController_:SetSelectedState("calling")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_3 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(323611004).content)

				arg_19_1.text_.text = var_22_3

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_5 = 2 <= 0 and var_22_2 or var_22_2 * (utf8.len(var_22_3) / 2)

				if (2 <= 0 and var_22_2 or var_22_2 * (utf8.len(var_22_3) / 2)) > 0 and var_22_2 < var_22_5 then
					arg_19_1.talkMaxDuration = var_22_5

					if var_22_5 + var_22_1 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_5 + var_22_1
					end
				end

				arg_19_1.text_.text = var_22_3
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_6 = math.max(var_22_2, arg_19_1.talkMaxDuration)

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_6 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_1) / var_22_6

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_1 + var_22_6 and arg_19_1.time_ < var_22_1 + var_22_6 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play323611005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 323611005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play323611006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 1.175

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_1 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(323611005).content)

				arg_23_1.text_.text = var_26_1

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_3 = 47 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 47)

				if (47 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_1) / 47)) > 0 and var_26_0 < var_26_3 then
					arg_23_1.talkMaxDuration = var_26_3

					if var_26_3 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_3 + 0
					end
				end

				arg_23_1.text_.text = var_26_1
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_4 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_4

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play323611006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 323611006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play323611007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 1.05

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_1 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(323611006).content)

				arg_27_1.text_.text = var_30_1

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_3 = 42 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 42)

				if (42 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_1) / 42)) > 0 and var_30_0 < var_30_3 then
					arg_27_1.talkMaxDuration = var_30_3

					if var_30_3 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_3 + 0
					end
				end

				arg_27_1.text_.text = var_30_1
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_4 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_4

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play323611007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 323611007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play323611008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 1.8

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_1 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(323611007).content)

				arg_31_1.text_.text = var_34_1

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_3 = 72 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 72)

				if (72 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_1) / 72)) > 0 and var_34_0 < var_34_3 then
					arg_31_1.talkMaxDuration = var_34_3

					if var_34_3 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_3 + 0
					end
				end

				arg_31_1.text_.text = var_34_1
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_4 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_4

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play323611008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 323611008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play323611009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 1.375

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(323611008).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 55 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 55)

				if (55 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 55)) > 0 and var_38_0 < var_38_3 then
					arg_35_1.talkMaxDuration = var_38_3

					if var_38_3 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_3 + 0
					end
				end

				arg_35_1.text_.text = var_38_1
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_4 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_4

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play323611009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 323611009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play323611010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0.5 < arg_39_1.time_ and arg_39_1.time_ <= 0.5 + arg_42_0 then
				arg_39_1:AudioAction("play", "effect", "se_story_148", "se_story_148_dig", "")
			end

			local var_42_1 = 0
			local var_42_2 = 1.275

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(323611009).content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_5 = 51 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 51)

				if (51 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_3) / 51)) > 0 and var_42_2 < var_42_5 then
					arg_39_1.talkMaxDuration = var_42_5

					if var_42_5 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_6 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_6 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_6

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_6 and arg_39_1.time_ < var_42_1 + var_42_6 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play323611010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 323611010
		arg_43_1.duration_ = 5.23

		local var_43_0 = {
			zh = 4.4,
			ja = 5.233
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
				arg_43_0:Play323611011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.actors_["1067ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1067ui_story"))) then
				local var_46_0 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_43_1.stage_.transform)

				var_46_0.name = "1067ui_story"
				var_46_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["1067ui_story"] = var_46_0

				local var_46_1 = var_46_0:GetComponentInChildren(typeof(CharacterEffect))

				var_46_1.enabled = true

				local var_46_2 = GameObjectTools.GetOrAddComponent(var_46_0, typeof(DynamicBoneHelper))

				if var_46_2 then
					var_46_2:EnableDynamicBone(false)
				end

				arg_43_1:ShowWeapon(var_46_1.transform, false)

				arg_43_1.var_["1067ui_story" .. "Animator"] = var_46_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_43_1.var_["1067ui_story" .. "Animator"].applyRootMotion = true
				arg_43_1.var_["1067ui_story" .. "LipSync"] = var_46_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_46_3 = arg_43_1.actors_["1067ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_3) and arg_43_1.var_.characterEffect1067ui_story == nil then
				arg_43_1.var_.characterEffect1067ui_story = var_46_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_4 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 and not isNil(var_46_3) then
				if arg_43_1.var_.characterEffect1067ui_story and not isNil(var_46_3) then
					arg_43_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 and not isNil(var_46_3) and arg_43_1.var_.characterEffect1067ui_story then
				arg_43_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_46_6 = 0
			local var_46_7 = 0.575

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1459].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_8 = arg_43_1:GetWordFromCfg(323611010)
				local var_46_9 = arg_43_1:FormatText(var_46_8.content)

				arg_43_1.text_.text = var_46_9

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_11 = 23 <= 0 and var_46_7 or var_46_7 * (utf8.len(var_46_9) / 23)

				if (23 <= 0 and var_46_7 or var_46_7 * (utf8.len(var_46_9) / 23)) > 0 and var_46_7 < var_46_11 then
					arg_43_1.talkMaxDuration = var_46_11

					if var_46_11 + var_46_6 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_11 + var_46_6
					end
				end

				arg_43_1.text_.text = var_46_9
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323611", "323611010", "story_v_out_323611.awb") ~= 0 then
					local var_46_12 = manager.audio:GetVoiceLength("story_v_out_323611", "323611010", "story_v_out_323611.awb") / 1000

					if var_46_12 + var_46_6 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_12 + var_46_6
					end

					if var_46_8.prefab_name ~= "" and arg_43_1.actors_[var_46_8.prefab_name] ~= nil then
						local var_46_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_8.prefab_name].transform, "story_v_out_323611", "323611010", "story_v_out_323611.awb")

						arg_43_1:RecordAudio("323611010", var_46_13)
						arg_43_1:RecordAudio("323611010", var_46_13)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_323611", "323611010", "story_v_out_323611.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_323611", "323611010", "story_v_out_323611.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_14 = math.max(var_46_7, arg_43_1.talkMaxDuration)

			if var_46_6 <= arg_43_1.time_ and arg_43_1.time_ < var_46_6 + var_46_14 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_6) / var_46_14

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_6 + var_46_14 and arg_43_1.time_ < var_46_6 + var_46_14 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play323611011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 323611011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play323611012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1067ui_story"]) and arg_47_1.var_.characterEffect1067ui_story == nil then
				arg_47_1.var_.characterEffect1067ui_story = arg_47_1.actors_["1067ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1067ui_story"]) then
				if arg_47_1.var_.characterEffect1067ui_story and not isNil(arg_47_1.actors_["1067ui_story"]) then
					arg_47_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1067ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1067ui_story"]) and arg_47_1.var_.characterEffect1067ui_story then
				arg_47_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1067ui_story.fillRatio = 0.5
			end

			local var_50_1 = 0
			local var_50_2 = 1.025

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(323611011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 41 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 41)

				if (41 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 41)) > 0 and var_50_2 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_6 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_6 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_6

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_6 and arg_47_1.time_ < var_50_1 + var_50_6 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play323611012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 323611012
		arg_51_1.duration_ = 5.63

		local var_51_0 = {
			zh = 5.633,
			ja = 5.166
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play323611013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if arg_51_1.actors_["10162ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10162ui_story"))) then
				local var_54_0 = Object.Instantiate(Asset.Load("Char/" .. "10162ui_story"), arg_51_1.stage_.transform)

				var_54_0.name = "10162ui_story"
				var_54_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_["10162ui_story"] = var_54_0

				local var_54_1 = var_54_0:GetComponentInChildren(typeof(CharacterEffect))

				var_54_1.enabled = true

				local var_54_2 = GameObjectTools.GetOrAddComponent(var_54_0, typeof(DynamicBoneHelper))

				if var_54_2 then
					var_54_2:EnableDynamicBone(false)
				end

				arg_51_1:ShowWeapon(var_54_1.transform, false)

				arg_51_1.var_["10162ui_story" .. "Animator"] = var_54_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_51_1.var_["10162ui_story" .. "Animator"].applyRootMotion = true
				arg_51_1.var_["10162ui_story" .. "LipSync"] = var_54_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_54_3 = arg_51_1.actors_["10162ui_story"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10162ui_story = var_54_3.localPosition

				local var_54_4 = GameObjectTools.GetOrAddComponent(var_54_3.gameObject, typeof(DynamicBoneHelper))

				if var_54_4 then
					var_54_4:EnableDynamicBone(false)
				end
			end

			local var_54_5 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_5 then
				var_54_3.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10162ui_story, Vector3.New(0, -1.08, -5.83), (arg_51_1.time_ - 0) / var_54_5)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_5 and arg_51_1.time_ < 0 + var_54_5 + arg_54_0 then
				var_54_3.localPosition = Vector3.New(0, -1.08, -5.83)
				var_54_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_3.position).x, (manager.ui.mainCamera.transform.position - var_54_3.position).y, (manager.ui.mainCamera.transform.position - var_54_3.position).z)
				var_54_3.localEulerAngles.z = 0
				var_54_3.localEulerAngles.x = 0
				var_54_3.localEulerAngles = var_54_3.localEulerAngles

				local var_54_6 = GameObjectTools.GetOrAddComponent(var_54_3.gameObject, typeof(DynamicBoneHelper))

				if var_54_6 then
					var_54_6:EnableDynamicBone(true)
				end
			end

			local var_54_7 = arg_51_1.actors_["10162ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_7) and arg_51_1.var_.characterEffect10162ui_story == nil then
				arg_51_1.var_.characterEffect10162ui_story = var_54_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_8 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_8 and not isNil(var_54_7) then
				if arg_51_1.var_.characterEffect10162ui_story and not isNil(var_54_7) then
					arg_51_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_8 and arg_51_1.time_ < 0 + var_54_8 + arg_54_0 and not isNil(var_54_7) and arg_51_1.var_.characterEffect10162ui_story then
				arg_51_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			local var_54_10 = 0
			local var_54_11 = 0.7

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_10 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[1459].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_12 = arg_51_1:GetWordFromCfg(323611012)
				local var_54_13 = arg_51_1:FormatText(var_54_12.content)

				arg_51_1.text_.text = var_54_13

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_15 = 28 <= 0 and var_54_11 or var_54_11 * (utf8.len(var_54_13) / 28)

				if (28 <= 0 and var_54_11 or var_54_11 * (utf8.len(var_54_13) / 28)) > 0 and var_54_11 < var_54_15 then
					arg_51_1.talkMaxDuration = var_54_15

					if var_54_15 + var_54_10 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_15 + var_54_10
					end
				end

				arg_51_1.text_.text = var_54_13
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323611", "323611012", "story_v_out_323611.awb") ~= 0 then
					local var_54_16 = manager.audio:GetVoiceLength("story_v_out_323611", "323611012", "story_v_out_323611.awb") / 1000

					if var_54_16 + var_54_10 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_16 + var_54_10
					end

					if var_54_12.prefab_name ~= "" and arg_51_1.actors_[var_54_12.prefab_name] ~= nil then
						local var_54_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_12.prefab_name].transform, "story_v_out_323611", "323611012", "story_v_out_323611.awb")

						arg_51_1:RecordAudio("323611012", var_54_17)
						arg_51_1:RecordAudio("323611012", var_54_17)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_323611", "323611012", "story_v_out_323611.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_323611", "323611012", "story_v_out_323611.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_18 = math.max(var_54_11, arg_51_1.talkMaxDuration)

			if var_54_10 <= arg_51_1.time_ and arg_51_1.time_ < var_54_10 + var_54_18 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_10) / var_54_18

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_10 + var_54_18 and arg_51_1.time_ < var_54_10 + var_54_18 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play323611013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 323611013
		arg_55_1.duration_ = 2

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play323611014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10162ui_story = arg_55_1.actors_["10162ui_story"].transform.localPosition

				local var_58_0 = GameObjectTools.GetOrAddComponent(arg_55_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_58_0 then
					var_58_0:EnableDynamicBone(false)
				end
			end

			local var_58_1 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 then
				arg_55_1.actors_["10162ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10162ui_story, Vector3.New(0.7, -1.08, -5.83), (arg_55_1.time_ - 0) / var_58_1)
				arg_55_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["10162ui_story"].transform.position).z)
				arg_55_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["10162ui_story"].transform.localEulerAngles = arg_55_1.actors_["10162ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 then
				arg_55_1.actors_["10162ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -5.83)
				arg_55_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["10162ui_story"].transform.position).z)
				arg_55_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["10162ui_story"].transform.localEulerAngles = arg_55_1.actors_["10162ui_story"].transform.localEulerAngles

				local var_58_2 = GameObjectTools.GetOrAddComponent(arg_55_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_58_2 then
					var_58_2:EnableDynamicBone(true)
				end
			end

			local var_58_3 = arg_55_1.actors_["10162ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect10162ui_story == nil then
				arg_55_1.var_.characterEffect10162ui_story = var_58_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_4 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 and not isNil(var_58_3) then
				if arg_55_1.var_.characterEffect10162ui_story and not isNil(var_58_3) then
					arg_55_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_55_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_4)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect10162ui_story then
				arg_55_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_55_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			local var_58_5 = "10170ui_story"

			if arg_55_1.actors_["10170ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10170ui_story"))) then
				local var_58_6 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_55_1.stage_.transform)

				var_58_6.name = var_58_5
				var_58_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_[var_58_5] = var_58_6

				local var_58_7 = var_58_6:GetComponentInChildren(typeof(CharacterEffect))

				var_58_7.enabled = true

				local var_58_8 = GameObjectTools.GetOrAddComponent(var_58_6, typeof(DynamicBoneHelper))

				if var_58_8 then
					var_58_8:EnableDynamicBone(false)
				end

				arg_55_1:ShowWeapon(var_58_7.transform, false)

				arg_55_1.var_[var_58_5 .. "Animator"] = var_58_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_55_1.var_[var_58_5 .. "Animator"].applyRootMotion = true
				arg_55_1.var_[var_58_5 .. "LipSync"] = var_58_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_58_9 = arg_55_1.actors_["10170ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10170ui_story = var_58_9.localPosition

				local var_58_10 = GameObjectTools.GetOrAddComponent(var_58_9.gameObject, typeof(DynamicBoneHelper))

				if var_58_10 then
					var_58_10:EnableDynamicBone(false)
				end
			end

			local var_58_11 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_11 then
				var_58_9.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10170ui_story, Vector3.New(-0.7, -1.03, -6.05), (arg_55_1.time_ - 0) / var_58_11)
				var_58_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_9.position).x, (manager.ui.mainCamera.transform.position - var_58_9.position).y, (manager.ui.mainCamera.transform.position - var_58_9.position).z)
				var_58_9.localEulerAngles.z = 0
				var_58_9.localEulerAngles.x = 0
				var_58_9.localEulerAngles = var_58_9.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_11 and arg_55_1.time_ < 0 + var_58_11 + arg_58_0 then
				var_58_9.localPosition = Vector3.New(-0.7, -1.03, -6.05)
				var_58_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_9.position).x, (manager.ui.mainCamera.transform.position - var_58_9.position).y, (manager.ui.mainCamera.transform.position - var_58_9.position).z)
				var_58_9.localEulerAngles.z = 0
				var_58_9.localEulerAngles.x = 0
				var_58_9.localEulerAngles = var_58_9.localEulerAngles

				local var_58_12 = GameObjectTools.GetOrAddComponent(var_58_9.gameObject, typeof(DynamicBoneHelper))

				if var_58_12 then
					var_58_12:EnableDynamicBone(true)
				end
			end

			local var_58_13 = arg_55_1.actors_["10170ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_13) and arg_55_1.var_.characterEffect10170ui_story == nil then
				arg_55_1.var_.characterEffect10170ui_story = var_58_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_14 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_14 and not isNil(var_58_13) then
				if arg_55_1.var_.characterEffect10170ui_story and not isNil(var_58_13) then
					arg_55_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_14 and arg_55_1.time_ < 0 + var_58_14 + arg_58_0 and not isNil(var_58_13) and arg_55_1.var_.characterEffect10170ui_story then
				arg_55_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_58_16 = 0
			local var_58_17 = 0.15

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_18 = arg_55_1:GetWordFromCfg(323611013)
				local var_58_19 = arg_55_1:FormatText(var_58_18.content)

				arg_55_1.text_.text = var_58_19

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_21 = 6 <= 0 and var_58_17 or var_58_17 * (utf8.len(var_58_19) / 6)

				if (6 <= 0 and var_58_17 or var_58_17 * (utf8.len(var_58_19) / 6)) > 0 and var_58_17 < var_58_21 then
					arg_55_1.talkMaxDuration = var_58_21

					if var_58_21 + var_58_16 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_21 + var_58_16
					end
				end

				arg_55_1.text_.text = var_58_19
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323611", "323611013", "story_v_out_323611.awb") ~= 0 then
					local var_58_22 = manager.audio:GetVoiceLength("story_v_out_323611", "323611013", "story_v_out_323611.awb") / 1000

					if var_58_22 + var_58_16 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_22 + var_58_16
					end

					if var_58_18.prefab_name ~= "" and arg_55_1.actors_[var_58_18.prefab_name] ~= nil then
						local var_58_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_18.prefab_name].transform, "story_v_out_323611", "323611013", "story_v_out_323611.awb")

						arg_55_1:RecordAudio("323611013", var_58_23)
						arg_55_1:RecordAudio("323611013", var_58_23)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_323611", "323611013", "story_v_out_323611.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_323611", "323611013", "story_v_out_323611.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_24 = math.max(var_58_17, arg_55_1.talkMaxDuration)

			if var_58_16 <= arg_55_1.time_ and arg_55_1.time_ < var_58_16 + var_58_24 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_16) / var_58_24

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_16 + var_58_24 and arg_55_1.time_ < var_58_16 + var_58_24 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play323611014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 323611014
		arg_59_1.duration_ = 5.6

		local var_59_0 = {
			zh = 3.9,
			ja = 5.6
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play323611015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["10162ui_story"]) and arg_59_1.var_.characterEffect10162ui_story == nil then
				arg_59_1.var_.characterEffect10162ui_story = arg_59_1.actors_["10162ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["10162ui_story"]) then
				if arg_59_1.var_.characterEffect10162ui_story and not isNil(arg_59_1.actors_["10162ui_story"]) then
					arg_59_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["10162ui_story"]) and arg_59_1.var_.characterEffect10162ui_story then
				arg_59_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_62_2 = arg_59_1.actors_["1033ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.characterEffect1033ui_story == nil then
				arg_59_1.var_.characterEffect1033ui_story = var_62_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_3 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_3 and not isNil(var_62_2) then
				if arg_59_1.var_.characterEffect1033ui_story and not isNil(var_62_2) then
					arg_59_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_3)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_3 and arg_59_1.time_ < 0 + var_62_3 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.characterEffect1033ui_story then
				arg_59_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_62_4 = arg_59_1.actors_["10170ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_4) and arg_59_1.var_.characterEffect10170ui_story == nil then
				arg_59_1.var_.characterEffect10170ui_story = var_62_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_5 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_5 and not isNil(var_62_4) then
				if arg_59_1.var_.characterEffect10170ui_story and not isNil(var_62_4) then
					arg_59_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_59_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_5)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_5 and arg_59_1.time_ < 0 + var_62_5 + arg_62_0 and not isNil(var_62_4) and arg_59_1.var_.characterEffect10170ui_story then
				arg_59_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_59_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_62_6 = 0
			local var_62_7 = 0.5

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_6 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1459].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_8 = arg_59_1:GetWordFromCfg(323611014)
				local var_62_9 = arg_59_1:FormatText(var_62_8.content)

				arg_59_1.text_.text = var_62_9

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_11 = 20 <= 0 and var_62_7 or var_62_7 * (utf8.len(var_62_9) / 20)

				if (20 <= 0 and var_62_7 or var_62_7 * (utf8.len(var_62_9) / 20)) > 0 and var_62_7 < var_62_11 then
					arg_59_1.talkMaxDuration = var_62_11

					if var_62_11 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_11 + var_62_6
					end
				end

				arg_59_1.text_.text = var_62_9
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323611", "323611014", "story_v_out_323611.awb") ~= 0 then
					local var_62_12 = manager.audio:GetVoiceLength("story_v_out_323611", "323611014", "story_v_out_323611.awb") / 1000

					if var_62_12 + var_62_6 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_6
					end

					if var_62_8.prefab_name ~= "" and arg_59_1.actors_[var_62_8.prefab_name] ~= nil then
						local var_62_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_8.prefab_name].transform, "story_v_out_323611", "323611014", "story_v_out_323611.awb")

						arg_59_1:RecordAudio("323611014", var_62_13)
						arg_59_1:RecordAudio("323611014", var_62_13)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_323611", "323611014", "story_v_out_323611.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_323611", "323611014", "story_v_out_323611.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_14 = math.max(var_62_7, arg_59_1.talkMaxDuration)

			if var_62_6 <= arg_59_1.time_ and arg_59_1.time_ < var_62_6 + var_62_14 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_6) / var_62_14

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_6 + var_62_14 and arg_59_1.time_ < var_62_6 + var_62_14 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play323611015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 323611015
		arg_63_1.duration_ = 5.8

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play323611016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_9002
			local var_66_9001
			local var_66_9000

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos10162ui_story = arg_63_1.actors_["10162ui_story"].transform.localPosition

				local var_66_0 = GameObjectTools.GetOrAddComponent(arg_63_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_66_0 then
					var_66_0:EnableDynamicBone(false)
				end
			end

			local var_66_1 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_1 then
				arg_63_1.actors_["10162ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10162ui_story, Vector3.New(0, 100, 0), (arg_63_1.time_ - 0) / var_66_1)
				arg_63_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["10162ui_story"].transform.position).z)
				arg_63_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["10162ui_story"].transform.localEulerAngles = arg_63_1.actors_["10162ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_1 and arg_63_1.time_ < 0 + var_66_1 + arg_66_0 then
				arg_63_1.actors_["10162ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_63_1.actors_["10162ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["10162ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["10162ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["10162ui_story"].transform.position).z)
				arg_63_1.actors_["10162ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["10162ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["10162ui_story"].transform.localEulerAngles = arg_63_1.actors_["10162ui_story"].transform.localEulerAngles

				local var_66_2 = GameObjectTools.GetOrAddComponent(arg_63_1.actors_["10162ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_66_2 then
					var_66_2:EnableDynamicBone(true)
				end
			end

			local var_66_3 = arg_63_1.actors_["10162ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_3) and arg_63_1.var_.characterEffect10162ui_story == nil then
				arg_63_1.var_.characterEffect10162ui_story = var_66_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_4 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 and not isNil(var_66_3) then
				if arg_63_1.var_.characterEffect10162ui_story and not isNil(var_66_3) then
					arg_63_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10162ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_4)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 and not isNil(var_66_3) and arg_63_1.var_.characterEffect10162ui_story then
				arg_63_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10162ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_63_1.time_ and arg_63_1.time_ <= 0.1 + arg_66_0 then
				arg_63_1:AudioAction("play", "effect", "se_story_148", "se_story_148_explosion", "")
			end

			local var_66_6 = arg_63_1.actors_["10170ui_story"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos10170ui_story = var_66_6.localPosition

				local var_66_7 = GameObjectTools.GetOrAddComponent(var_66_6.gameObject, typeof(DynamicBoneHelper))

				if var_66_7 then
					var_66_7:EnableDynamicBone(false)
				end
			end

			local var_66_8 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_8 then
				var_66_6.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_63_1.time_ - 0) / var_66_8)
				var_66_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_6.position).x, (manager.ui.mainCamera.transform.position - var_66_6.position).y, (manager.ui.mainCamera.transform.position - var_66_6.position).z)
				var_66_6.localEulerAngles.z = 0
				var_66_6.localEulerAngles.x = 0
				var_66_6.localEulerAngles = var_66_6.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_8 and arg_63_1.time_ < 0 + var_66_8 + arg_66_0 then
				var_66_6.localPosition = Vector3.New(0, 100, 0)
				var_66_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_66_6.position).x, (manager.ui.mainCamera.transform.position - var_66_6.position).y, (manager.ui.mainCamera.transform.position - var_66_6.position).z)
				var_66_6.localEulerAngles.z = 0
				var_66_6.localEulerAngles.x = 0
				var_66_6.localEulerAngles = var_66_6.localEulerAngles

				local var_66_9 = GameObjectTools.GetOrAddComponent(var_66_6.gameObject, typeof(DynamicBoneHelper))

				if var_66_9 then
					var_66_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				local var_66_10 = arg_63_1.var_.effect444233

				if not arg_63_1.var_.effect444233 then
					var_66_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_66_10.name = "444233"
					arg_63_1.var_.effect444233 = var_66_10
				else
					var_66_10.transform:SetParent(var_66_9002)
				end

				var_66_10.transform.localPosition = Vector3.New(-1.41, -0.06, -0.09)
				var_66_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.2 < arg_63_1.time_ and arg_63_1.time_ <= 0.2 + arg_66_0 then
				local var_66_12 = arg_63_1.var_.effect444234

				if not arg_63_1.var_.effect444234 then
					var_66_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_66_12.name = "444234"
					arg_63_1.var_.effect444234 = var_66_12
				else
					var_66_12.transform:SetParent(var_66_9001)
				end

				var_66_12.transform.localPosition = Vector3.New(-0.25, -0.28, 0)
				var_66_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.433333333333334 < arg_63_1.time_ and arg_63_1.time_ <= 0.433333333333334 + arg_66_0 then
				local var_66_14 = arg_63_1.var_.effect444235

				if not arg_63_1.var_.effect444235 then
					var_66_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_66_14.name = "444235"
					arg_63_1.var_.effect444235 = var_66_14
				else
					var_66_14.transform:SetParent(var_66_9000)
				end

				var_66_14.transform.localPosition = Vector3.New(0.63, -0.34, -1.1)
				var_66_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.36666666666667 < arg_63_1.time_ and arg_63_1.time_ <= 1.36666666666667 + arg_66_0 then
				if arg_63_1.var_.effect444233 then
					Object.Destroy(arg_63_1.var_.effect444233)

					arg_63_1.var_.effect444233 = nil
				end
			end

			if 1.56666666666667 < arg_63_1.time_ and arg_63_1.time_ <= 1.56666666666667 + arg_66_0 then
				if arg_63_1.var_.effect444234 then
					Object.Destroy(arg_63_1.var_.effect444234)

					arg_63_1.var_.effect444234 = nil
				end
			end

			if 1.8 < arg_63_1.time_ and arg_63_1.time_ <= 1.8 + arg_66_0 then
				if arg_63_1.var_.effect444235 then
					Object.Destroy(arg_63_1.var_.effect444235)

					arg_63_1.var_.effect444235 = nil
				end
			end

			local var_66_19 = 0

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_19 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			if arg_63_1.time_ >= var_66_19 + 1.55 and arg_63_1.time_ < var_66_19 + 1.55 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_20 = 0.8
			local var_66_21 = 1.775

			if 0.8 < arg_63_1.time_ and arg_63_1.time_ <= var_66_20 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_22 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_22:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_23 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(323611015).content)

				arg_63_1.text_.text = var_66_23

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_25 = 71 <= 0 and var_66_21 or var_66_21 * (utf8.len(var_66_23) / 71)

				if (71 <= 0 and var_66_21 or var_66_21 * (utf8.len(var_66_23) / 71)) > 0 and var_66_21 < var_66_25 then
					arg_63_1.talkMaxDuration = var_66_25
					var_66_20 = var_66_20 + 0.3

					if var_66_25 + var_66_20 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_25 + var_66_20
					end
				end

				arg_63_1.text_.text = var_66_23
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_26 = var_66_20 + 0.3
			local var_66_27 = math.max(var_66_21, arg_63_1.talkMaxDuration)

			if var_66_20 + 0.3 <= arg_63_1.time_ and arg_63_1.time_ < var_66_26 + var_66_27 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_26) / var_66_27

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_26 + var_66_27 and arg_63_1.time_ < var_66_26 + var_66_27 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play323611016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 323611016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play323611017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.35

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
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

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_69_1.callingController_:SetSelectedState("calling")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(323611016).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 14 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 14)

				if (14 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 14)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play323611017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 323611017
		arg_73_1.duration_ = 1.23

		local var_73_0 = {
			zh = 0.999999999999,
			ja = 1.233
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
				arg_73_0:Play323611018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.05

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:GetWordFromCfg(323611017)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 2 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 2)

				if (2 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 2)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323611", "323611017", "story_v_out_323611.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_323611", "323611017", "story_v_out_323611.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_323611", "323611017", "story_v_out_323611.awb")

						arg_73_1:RecordAudio("323611017", var_76_6)
						arg_73_1:RecordAudio("323611017", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_323611", "323611017", "story_v_out_323611.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_323611", "323611017", "story_v_out_323611.awb")
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
	Play323611018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 323611018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play323611019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 1

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

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(323611018).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 40 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 40)

				if (40 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 40)) > 0 and var_80_0 < var_80_3 then
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
	Play323611019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 323611019
		arg_81_1.duration_ = 1.2

		local var_81_0 = {
			zh = 1,
			ja = 1.2
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
				arg_81_0:Play323611020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.4

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_1 = arg_81_1:GetWordFromCfg(323611019)
				local var_84_2 = arg_81_1:FormatText(var_84_1.content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 16 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 16)

				if (16 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_2) / 16)) > 0 and var_84_0 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + 0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323611", "323611019", "story_v_out_323611.awb") ~= 0 then
					local var_84_5 = manager.audio:GetVoiceLength("story_v_out_323611", "323611019", "story_v_out_323611.awb") / 1000

					if var_84_5 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + 0
					end

					if var_84_1.prefab_name ~= "" and arg_81_1.actors_[var_84_1.prefab_name] ~= nil then
						local var_84_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_1.prefab_name].transform, "story_v_out_323611", "323611019", "story_v_out_323611.awb")

						arg_81_1:RecordAudio("323611019", var_84_6)
						arg_81_1:RecordAudio("323611019", var_84_6)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_323611", "323611019", "story_v_out_323611.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_323611", "323611019", "story_v_out_323611.awb")
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
	Play323611020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 323611020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play323611021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1033ui_story"]) and arg_85_1.var_.characterEffect1033ui_story == nil then
				arg_85_1.var_.characterEffect1033ui_story = arg_85_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1033ui_story"]) then
				if arg_85_1.var_.characterEffect1033ui_story and not isNil(arg_85_1.actors_["1033ui_story"]) then
					arg_85_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1033ui_story"]) and arg_85_1.var_.characterEffect1033ui_story then
				arg_85_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_88_1 = 0
			local var_88_2 = 0.075

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_85_1.callingController_:SetSelectedState("calling")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(323611020).content)

				arg_85_1.text_.text = var_88_3

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 3 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 3)

				if (3 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_3) / 3)) > 0 and var_88_2 < var_88_5 then
					arg_85_1.talkMaxDuration = var_88_5

					if var_88_5 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_3
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_6 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_6 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_6

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_6 and arg_85_1.time_ < var_88_1 + var_88_6 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play323611021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 323611021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play323611022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 1.5

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(323611021).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 60 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 60)

				if (60 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 60)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play323611022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 323611022
		arg_93_1.duration_ = 5.43

		local var_93_0 = {
			zh = 3.666,
			ja = 5.433
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
				arg_93_0:Play323611023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if arg_93_1.actors_["1026ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1026ui_story"))) then
				local var_96_0 = Object.Instantiate(Asset.Load("Char/" .. "1026ui_story"), arg_93_1.stage_.transform)

				var_96_0.name = "1026ui_story"
				var_96_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_93_1.actors_["1026ui_story"] = var_96_0

				local var_96_1 = var_96_0:GetComponentInChildren(typeof(CharacterEffect))

				var_96_1.enabled = true

				local var_96_2 = GameObjectTools.GetOrAddComponent(var_96_0, typeof(DynamicBoneHelper))

				if var_96_2 then
					var_96_2:EnableDynamicBone(false)
				end

				arg_93_1:ShowWeapon(var_96_1.transform, false)

				arg_93_1.var_["1026ui_story" .. "Animator"] = var_96_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_93_1.var_["1026ui_story" .. "Animator"].applyRootMotion = true
				arg_93_1.var_["1026ui_story" .. "LipSync"] = var_96_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_96_3 = arg_93_1.actors_["1026ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_3) and arg_93_1.var_.characterEffect1026ui_story == nil then
				arg_93_1.var_.characterEffect1026ui_story = var_96_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_4 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 and not isNil(var_96_3) then
				if arg_93_1.var_.characterEffect1026ui_story and not isNil(var_96_3) then
					arg_93_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 and not isNil(var_96_3) and arg_93_1.var_.characterEffect1026ui_story then
				arg_93_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_96_6 = 0

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				arg_93_1.allBtn_.enabled = false
			end

			if arg_93_1.time_ >= var_96_6 + 1 and arg_93_1.time_ < var_96_6 + 1 + arg_96_0 then
				arg_93_1.allBtn_.enabled = true
			end

			local var_96_7 = 0
			local var_96_8 = 0.25

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_7 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_9 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_9:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:GetWordFromCfg(323611022)
				local var_96_11 = arg_93_1:FormatText(var_96_10.content)

				arg_93_1.text_.text = var_96_11

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 10 <= 0 and var_96_8 or var_96_8 * (utf8.len(var_96_11) / 10)

				if (10 <= 0 and var_96_8 or var_96_8 * (utf8.len(var_96_11) / 10)) > 0 and var_96_8 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13
					var_96_7 = var_96_7 + 0.3

					if var_96_13 + var_96_7 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_7
					end
				end

				arg_93_1.text_.text = var_96_11
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323611", "323611022", "story_v_out_323611.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_323611", "323611022", "story_v_out_323611.awb") / 1000

					if var_96_14 + var_96_7 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_7
					end

					if var_96_10.prefab_name ~= "" and arg_93_1.actors_[var_96_10.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_10.prefab_name].transform, "story_v_out_323611", "323611022", "story_v_out_323611.awb")

						arg_93_1:RecordAudio("323611022", var_96_15)
						arg_93_1:RecordAudio("323611022", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_323611", "323611022", "story_v_out_323611.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_323611", "323611022", "story_v_out_323611.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = var_96_7 + 0.3
			local var_96_17 = math.max(var_96_8, arg_93_1.talkMaxDuration)

			if var_96_7 + 0.3 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_17 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_16) / var_96_17

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_16 + var_96_17 and arg_93_1.time_ < var_96_16 + var_96_17 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 11,
				className = "StoryShakeNode",
				duration = 0.733333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(5, 0, 0.1)
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play323611023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 323611023
		arg_99_1.duration_ = 2.9

		local var_99_0 = {
			zh = 2.166,
			ja = 2.9
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
				arg_99_0:Play323611024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.275

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:GetWordFromCfg(323611023)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 11 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 11)

				if (11 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 11)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323611", "323611023", "story_v_out_323611.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_323611", "323611023", "story_v_out_323611.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_323611", "323611023", "story_v_out_323611.awb")

						arg_99_1:RecordAudio("323611023", var_102_6)
						arg_99_1:RecordAudio("323611023", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_323611", "323611023", "story_v_out_323611.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_323611", "323611023", "story_v_out_323611.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_7 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_7 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_7

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_7 and arg_99_1.time_ < 0 + var_102_7 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play323611024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 323611024
		arg_103_1.duration_ = 7.73

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play323611025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if arg_103_1.bgs_.J21h == nil then
				local var_106_0 = Object.Instantiate(arg_103_1.paintGo_)

				var_106_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J21h")
				var_106_0.name = "J21h"
				var_106_0.transform.parent = arg_103_1.stage_.transform
				var_106_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.bgs_.J21h = var_106_0
			end

			if 1.2 < arg_103_1.time_ and arg_103_1.time_ <= 1.2 + arg_106_0 then
				local var_106_1 = arg_103_1.bgs_.J21h

				arg_103_1.bgs_.J21h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_106_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_2 = var_106_1:GetComponent("SpriteRenderer")

				if var_106_2 and var_106_2.sprite then
					local var_106_3 = 2 * (var_106_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_106_1.transform.localScale = Vector3.New(var_106_3 / var_106_2.sprite.bounds.size.y < var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x and var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x or var_106_3 / var_106_2.sprite.bounds.size.y, var_106_3 / var_106_2.sprite.bounds.size.y < var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x and var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x or var_106_3 / var_106_2.sprite.bounds.size.y, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "J21h" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_4 = 0

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.allBtn_.enabled = false
			end

			if arg_103_1.time_ >= var_106_4 + 0.3 and arg_103_1.time_ < var_106_4 + 0.3 + arg_106_0 then
				arg_103_1.allBtn_.enabled = true
			end

			local var_106_5 = 0

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_6 = 1.2

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_6 then
				local var_106_7 = Color.New(0, 0, 0)

				var_106_7.a = Mathf.Lerp(0, 1, (arg_103_1.time_ - var_106_5) / var_106_6)
				arg_103_1.mask_.color = var_106_7
			end

			if arg_103_1.time_ >= var_106_5 + var_106_6 and arg_103_1.time_ < var_106_5 + var_106_6 + arg_106_0 then
				local var_106_8 = Color.New(0, 0, 0)

				var_106_8.a = 1
				arg_103_1.mask_.color = var_106_8
			end

			local var_106_9 = 1.2

			if 1.2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_9 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_10 = 1.63333333333333

			if var_106_9 <= arg_103_1.time_ and arg_103_1.time_ < var_106_9 + var_106_10 then
				local var_106_11 = Color.New(0, 0, 0)

				var_106_11.a = Mathf.Lerp(1, 0, (arg_103_1.time_ - var_106_9) / var_106_10)
				arg_103_1.mask_.color = var_106_11
			end

			if arg_103_1.time_ >= var_106_9 + var_106_10 and arg_103_1.time_ < var_106_9 + var_106_10 + arg_106_0 then
				local var_106_12 = Color.New(0, 0, 0)

				arg_103_1.mask_.enabled = false
				var_106_12.a = 0
				arg_103_1.mask_.color = var_106_12
			end

			local var_106_13 = arg_103_1.actors_["1033ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_13) and arg_103_1.var_.characterEffect1033ui_story == nil then
				arg_103_1.var_.characterEffect1033ui_story = var_106_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_14 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_14 and not isNil(var_106_13) then
				if arg_103_1.var_.characterEffect1033ui_story and not isNil(var_106_13) then
					arg_103_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_14)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_14 and arg_103_1.time_ < 0 + var_106_14 + arg_106_0 and not isNil(var_106_13) and arg_103_1.var_.characterEffect1033ui_story then
				arg_103_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_103_1.time_ and arg_103_1.time_ <= 0.1 + arg_106_0 then
				arg_103_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_battleground", "")
			end

			if 0.9 < arg_103_1.time_ and arg_103_1.time_ <= 0.9 + arg_106_0 then
				arg_103_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lfe", "")
			end

			if 0.9 < arg_103_1.time_ and arg_103_1.time_ <= 0.9 + arg_106_0 then
				arg_103_1:AudioAction("play", "effect", "se_story_8", "se_story_8_fire_environment_loop", "")
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_18 = 2.73333333333333
			local var_106_19 = 0.95

			if 2.73333333333333 < arg_103_1.time_ and arg_103_1.time_ <= var_106_18 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_20 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_20:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_21 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(323611024).content)

				arg_103_1.text_.text = var_106_21

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_23 = 38 <= 0 and var_106_19 or var_106_19 * (utf8.len(var_106_21) / 38)

				if (38 <= 0 and var_106_19 or var_106_19 * (utf8.len(var_106_21) / 38)) > 0 and var_106_19 < var_106_23 then
					arg_103_1.talkMaxDuration = var_106_23
					var_106_18 = var_106_18 + 0.3

					if var_106_23 + var_106_18 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_18
					end
				end

				arg_103_1.text_.text = var_106_21
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_24 = var_106_18 + 0.3
			local var_106_25 = math.max(var_106_19, arg_103_1.talkMaxDuration)

			if var_106_18 + 0.3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_24 + var_106_25 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_24) / var_106_25

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_24 + var_106_25 and arg_103_1.time_ < var_106_24 + var_106_25 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play323611025 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 323611025
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play323611026(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 1.2

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

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(323611025).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 48 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 48)

				if (48 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 48)) > 0 and var_112_0 < var_112_3 then
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
	Play323611026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 323611026
		arg_113_1.duration_ = 6.07

		local var_113_0 = {
			zh = 4.1,
			ja = 6.066
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
				arg_113_0:Play323611027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1026ui_story"]) and arg_113_1.var_.characterEffect1026ui_story == nil then
				arg_113_1.var_.characterEffect1026ui_story = arg_113_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1026ui_story"]) then
				if arg_113_1.var_.characterEffect1026ui_story and not isNil(arg_113_1.actors_["1026ui_story"]) then
					arg_113_1.var_.characterEffect1026ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1026ui_story"]) and arg_113_1.var_.characterEffect1026ui_story then
				arg_113_1.var_.characterEffect1026ui_story.fillFlat = false
			end

			local var_116_2 = 0
			local var_116_3 = 0.25

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10165")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_4 = arg_113_1:GetWordFromCfg(323611026)
				local var_116_5 = arg_113_1:FormatText(var_116_4.content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 10 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 10)

				if (10 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 10)) > 0 and var_116_3 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323611", "323611026", "story_v_out_323611.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_323611", "323611026", "story_v_out_323611.awb") / 1000

					if var_116_8 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_2
					end

					if var_116_4.prefab_name ~= "" and arg_113_1.actors_[var_116_4.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_4.prefab_name].transform, "story_v_out_323611", "323611026", "story_v_out_323611.awb")

						arg_113_1:RecordAudio("323611026", var_116_9)
						arg_113_1:RecordAudio("323611026", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_323611", "323611026", "story_v_out_323611.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_323611", "323611026", "story_v_out_323611.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_3, arg_113_1.talkMaxDuration)

			if var_116_2 <= arg_113_1.time_ and arg_113_1.time_ < var_116_2 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_2) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_2 + var_116_10 and arg_113_1.time_ < var_116_2 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play323611027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 323611027
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play323611028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1026ui_story"]) and arg_117_1.var_.characterEffect1026ui_story == nil then
				arg_117_1.var_.characterEffect1026ui_story = arg_117_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1026ui_story"]) then
				if arg_117_1.var_.characterEffect1026ui_story and not isNil(arg_117_1.actors_["1026ui_story"]) then
					arg_117_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1026ui_story"]) and arg_117_1.var_.characterEffect1026ui_story then
				arg_117_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_120_1 = 0
			local var_120_2 = 0.1

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(323611027).content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 4 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 4)

				if (4 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 4)) > 0 and var_120_2 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_6 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_6 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_6

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_6 and arg_117_1.time_ < var_120_1 + var_120_6 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play323611028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 323611028
		arg_121_1.duration_ = 1.43

		local var_121_0 = {
			zh = 1.066,
			ja = 1.433
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
				arg_121_0:Play323611029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.15

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:GetWordFromCfg(323611028)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 6 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 6)

				if (6 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 6)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323611", "323611028", "story_v_out_323611.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_323611", "323611028", "story_v_out_323611.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_323611", "323611028", "story_v_out_323611.awb")

						arg_121_1:RecordAudio("323611028", var_124_6)
						arg_121_1:RecordAudio("323611028", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_323611", "323611028", "story_v_out_323611.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_323611", "323611028", "story_v_out_323611.awb")
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
	Play323611029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 323611029
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play323611030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.275

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(323611029).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 11 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 11)

				if (11 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 11)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play323611030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 323611030
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play323611031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 1.2

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(323611030).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 48 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 48)

				if (48 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 48)) > 0 and var_132_0 < var_132_3 then
					arg_129_1.talkMaxDuration = var_132_3

					if var_132_3 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_3 + 0
					end
				end

				arg_129_1.text_.text = var_132_1
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_4 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_4

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play323611031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 323611031
		arg_133_1.duration_ = 5.2

		local var_133_0 = {
			zh = 4.433,
			ja = 5.2
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
				arg_133_0:Play323611032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.45

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1467].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1077")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:GetWordFromCfg(323611031)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 18 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 18)

				if (18 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 18)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323611", "323611031", "story_v_out_323611.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_323611", "323611031", "story_v_out_323611.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_323611", "323611031", "story_v_out_323611.awb")

						arg_133_1:RecordAudio("323611031", var_136_6)
						arg_133_1:RecordAudio("323611031", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_323611", "323611031", "story_v_out_323611.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_323611", "323611031", "story_v_out_323611.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play323611032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 323611032
		arg_137_1.duration_ = 9.5

		local var_137_0 = {
			zh = 5.466,
			ja = 9.5
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
				arg_137_0:Play323611033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if arg_137_1.actors_["10165ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10165ui_story"))) then
				local var_140_0 = Object.Instantiate(Asset.Load("Char/" .. "10165ui_story"), arg_137_1.stage_.transform)

				var_140_0.name = "10165ui_story"
				var_140_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["10165ui_story"] = var_140_0

				local var_140_1 = var_140_0:GetComponentInChildren(typeof(CharacterEffect))

				var_140_1.enabled = true

				local var_140_2 = GameObjectTools.GetOrAddComponent(var_140_0, typeof(DynamicBoneHelper))

				if var_140_2 then
					var_140_2:EnableDynamicBone(false)
				end

				arg_137_1:ShowWeapon(var_140_1.transform, false)

				arg_137_1.var_["10165ui_story" .. "Animator"] = var_140_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_137_1.var_["10165ui_story" .. "Animator"].applyRootMotion = true
				arg_137_1.var_["10165ui_story" .. "LipSync"] = var_140_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_140_3 = arg_137_1.actors_["10165ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10165ui_story = var_140_3.localPosition

				local var_140_4 = GameObjectTools.GetOrAddComponent(var_140_3.gameObject, typeof(DynamicBoneHelper))

				if var_140_4 then
					var_140_4:EnableDynamicBone(false)
				end
			end

			local var_140_5 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_5 then
				var_140_3.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10165ui_story, Vector3.New(0, -1.08, -5.83), (arg_137_1.time_ - 0) / var_140_5)
				var_140_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_3.position).x, (manager.ui.mainCamera.transform.position - var_140_3.position).y, (manager.ui.mainCamera.transform.position - var_140_3.position).z)
				var_140_3.localEulerAngles.z = 0
				var_140_3.localEulerAngles.x = 0
				var_140_3.localEulerAngles = var_140_3.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_5 and arg_137_1.time_ < 0 + var_140_5 + arg_140_0 then
				var_140_3.localPosition = Vector3.New(0, -1.08, -5.83)
				var_140_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_3.position).x, (manager.ui.mainCamera.transform.position - var_140_3.position).y, (manager.ui.mainCamera.transform.position - var_140_3.position).z)
				var_140_3.localEulerAngles.z = 0
				var_140_3.localEulerAngles.x = 0
				var_140_3.localEulerAngles = var_140_3.localEulerAngles

				local var_140_6 = GameObjectTools.GetOrAddComponent(var_140_3.gameObject, typeof(DynamicBoneHelper))

				if var_140_6 then
					var_140_6:EnableDynamicBone(true)
				end
			end

			local var_140_7 = arg_137_1.actors_["10165ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.characterEffect10165ui_story == nil then
				arg_137_1.var_.characterEffect10165ui_story = var_140_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_8 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_8 and not isNil(var_140_7) then
				if arg_137_1.var_.characterEffect10165ui_story and not isNil(var_140_7) then
					arg_137_1.var_.characterEffect10165ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_8 and arg_137_1.time_ < 0 + var_140_8 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.characterEffect10165ui_story then
				arg_137_1.var_.characterEffect10165ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10165ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_140_10 = 0
			local var_140_11 = 0.375

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_10 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1446].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_12 = arg_137_1:GetWordFromCfg(323611032)
				local var_140_13 = arg_137_1:FormatText(var_140_12.content)

				arg_137_1.text_.text = var_140_13

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_15 = 15 <= 0 and var_140_11 or var_140_11 * (utf8.len(var_140_13) / 15)

				if (15 <= 0 and var_140_11 or var_140_11 * (utf8.len(var_140_13) / 15)) > 0 and var_140_11 < var_140_15 then
					arg_137_1.talkMaxDuration = var_140_15

					if var_140_15 + var_140_10 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_15 + var_140_10
					end
				end

				arg_137_1.text_.text = var_140_13
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323611", "323611032", "story_v_out_323611.awb") ~= 0 then
					local var_140_16 = manager.audio:GetVoiceLength("story_v_out_323611", "323611032", "story_v_out_323611.awb") / 1000

					if var_140_16 + var_140_10 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_16 + var_140_10
					end

					if var_140_12.prefab_name ~= "" and arg_137_1.actors_[var_140_12.prefab_name] ~= nil then
						local var_140_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_12.prefab_name].transform, "story_v_out_323611", "323611032", "story_v_out_323611.awb")

						arg_137_1:RecordAudio("323611032", var_140_17)
						arg_137_1:RecordAudio("323611032", var_140_17)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_323611", "323611032", "story_v_out_323611.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_323611", "323611032", "story_v_out_323611.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_18 = math.max(var_140_11, arg_137_1.talkMaxDuration)

			if var_140_10 <= arg_137_1.time_ and arg_137_1.time_ < var_140_10 + var_140_18 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_10) / var_140_18

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_10 + var_140_18 and arg_137_1.time_ < var_140_10 + var_140_18 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10165ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play323611033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 323611033
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
			arg_141_1.auto_ = false
		end

		function arg_141_1.playNext_(arg_143_0)
			arg_141_1.onStoryFinished_()
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1026ui_story"]) and arg_141_1.var_.characterEffect1026ui_story == nil then
				arg_141_1.var_.characterEffect1026ui_story = arg_141_1.actors_["1026ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1026ui_story"]) then
				if arg_141_1.var_.characterEffect1026ui_story and not isNil(arg_141_1.actors_["1026ui_story"]) then
					arg_141_1.var_.characterEffect1026ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1026ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1026ui_story"]) and arg_141_1.var_.characterEffect1026ui_story then
				arg_141_1.var_.characterEffect1026ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1026ui_story.fillRatio = 0.5
			end

			local var_144_1 = 0
			local var_144_2 = 0.15

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(323611033).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 6 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 6)

				if (6 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 6)) > 0 and var_144_2 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_6 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_6 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_6

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_6 and arg_141_1.time_ < var_144_1 + var_144_6 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J21f",
		"TextureConfig/Background/J21h"
	},
	voices = {
		"story_v_out_323611.awb"
	}
}
