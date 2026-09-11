return {
	Play425051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425051001
		arg_1_1.duration_ = 9.4

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play425051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 4.400000333332 < arg_1_1.time_ and arg_1_1.time_ <= 4.400000333332 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 4.400000333332 + 0.399999666668 and arg_1_1.time_ < 4.400000333332 + 0.399999666668 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.timestampController_:SetSelectedState("show")
				arg_1_1.timestampAni_:Play("in")

				arg_1_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13b")

				arg_1_1.timestampColorController_:SetSelectedState("cold")
				arg_1_1.timeColdImg_:SetAlpha(0.031)

				arg_1_1.text_timeText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501100).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_timeText_)

				arg_1_1.text_siteText_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(501101).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_siteText_)
			end

			if arg_1_1.time_ >= var_4_0 + 1.999999999999 and arg_1_1.time_ < var_4_0 + 1.999999999999 + arg_4_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_1_1.timestampAni_, "out", function()
					arg_1_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_4_1 = 2.00000033333333

			if 2.00000033333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_1 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_2 = 1.2

			if var_4_1 <= arg_1_1.time_ and arg_1_1.time_ < var_4_1 + var_4_2 then
				local var_4_3 = Color.New(0, 0, 0)

				var_4_3.a = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_1) / var_4_2)
				arg_1_1.mask_.color = var_4_3
			end

			if arg_1_1.time_ >= var_4_1 + var_4_2 and arg_1_1.time_ < var_4_1 + var_4_2 + arg_4_0 then
				local var_4_4 = Color.New(0, 0, 0)

				var_4_4.a = 1
				arg_1_1.mask_.color = var_4_4
			end

			local var_4_5 = 3.20000033333333

			if 3.20000033333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 1.2

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

			local var_4_9 = "B13b"

			if arg_1_1.bgs_.B13b == nil then
				local var_4_10 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_10:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_9)
				var_4_10.name = var_4_9
				var_4_10.transform.parent = arg_1_1.stage_.transform
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_9] = var_4_10
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_11 = arg_1_1.bgs_.B13b

				arg_1_1.bgs_.B13b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_11.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_12 = var_4_11:GetComponent("SpriteRenderer")

				if var_4_12 and var_4_12.sprite then
					local var_4_13 = 2 * (var_4_11.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_11.transform.localScale = Vector3.New(var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, var_4_13 / var_4_12.sprite.bounds.size.y < var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x and var_4_13 * manager.ui.mainCameraCom_.aspect / var_4_12.sprite.bounds.size.x or var_4_13 / var_4_12.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B13b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 2.9 < arg_1_1.time_ and arg_1_1.time_ <= 2.9 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base.awb")

				local var_4_19 = manager.audio:GetAudioName("bgm_activity_3_10_story_corg_base", "bgm_activity_3_10_story_corg_base")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			if 2.9 < arg_1_1.time_ and arg_1_1.time_ <= 2.9 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_147", "se_story_147_amb_rooftop", "")
			end

			if 2.9 < arg_1_1.time_ and arg_1_1.time_ <= 2.9 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_plane02", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_22 = 4.400000333332
			local var_4_23 = 1

			if 4.400000333332 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(425051001).content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 40 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_25) / 40)

				if (40 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_25) / 40)) > 0 and var_4_23 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_22 = var_4_22 + 0.3

					if var_4_27 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_28 = var_4_22 + 0.3
			local var_4_29 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_22 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_28) / var_4_29

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play425051002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 425051002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play425051003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_machinebattle", "")
			end

			local var_13_1 = 0
			local var_13_2 = 0.975

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

				local var_13_3 = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(425051002).content)

				arg_10_1.text_.text = var_13_3

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_5 = 39 <= 0 and var_13_2 or var_13_2 * (utf8.len(var_13_3) / 39)

				if (39 <= 0 and var_13_2 or var_13_2 * (utf8.len(var_13_3) / 39)) > 0 and var_13_2 < var_13_5 then
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
	Play425051003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 425051003
		arg_14_1.duration_ = 8.1

		local var_14_0 = {
			zh = 8.1,
			ja = 6.766
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
				arg_14_0:Play425051004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if arg_14_1.actors_["10156"] == nil then
				local var_17_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10156")

				if not isNil(var_17_0) then
					local var_17_1 = Object.Instantiate(var_17_0, arg_14_1.canvasGo_.transform)

					var_17_1.transform:SetSiblingIndex(1)

					var_17_1.name = "10156"
					var_17_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_14_1.actors_["10156"] = var_17_1

					if arg_14_1.isInRecall_ then
						for iter_17_0, iter_17_1 in ipairs((var_17_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_17_1.color = arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_17_2 = arg_14_1.actors_["10156"]

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(var_17_2) and arg_14_1.var_.actorSpriteComps10156 == nil then
				arg_14_1.var_.actorSpriteComps10156 = var_17_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_3 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_3 and not isNil(var_17_2) then
				if arg_14_1.var_.actorSpriteComps10156 then
					for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_17_3 then
							if arg_14_1.isInRecall_ then
								iter_17_3.color = Color.New(Mathf.Lerp(iter_17_3.color.r, arg_14_1.hightColor1.r, (arg_14_1.time_ - 0) / var_17_3), Mathf.Lerp(iter_17_3.color.g, arg_14_1.hightColor1.g, (arg_14_1.time_ - 0) / var_17_3), (Mathf.Lerp(iter_17_3.color.b, arg_14_1.hightColor1.b, (arg_14_1.time_ - 0) / var_17_3)))
							else
								local var_17_4 = Mathf.Lerp(iter_17_3.color.r, 1, (arg_14_1.time_ - 0) / var_17_3)

								iter_17_3.color = Color.New(var_17_4, var_17_4, var_17_4)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= 0 + var_17_3 and arg_14_1.time_ < 0 + var_17_3 + arg_17_0 and not isNil(var_17_2) and arg_14_1.var_.actorSpriteComps10156 then
				for iter_17_4, iter_17_5 in pairs(arg_14_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_17_5 then
						iter_17_5.color = arg_14_1.isInRecall_ and (arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_14_1.var_.actorSpriteComps10156 = nil
			end

			local var_17_5 = arg_14_1.actors_["10156"].transform

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPos10156 = var_17_5.localPosition
				var_17_5.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("10156", 3)

				for iter_17_6 = 0, var_17_5.childCount - 1 do
					local var_17_6 = var_17_5:GetChild(iter_17_6)

					if var_17_6.name == "" or not string.find(var_17_6.name, "split") then
						var_17_6.gameObject:SetActive(true)
					else
						var_17_6.gameObject:SetActive(false)
					end
				end
			end

			local var_17_7 = 0.001

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_7 then
				var_17_5.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos10156, Vector3.New(0, -390, -210), (arg_14_1.time_ - 0) / var_17_7)
			end

			if arg_14_1.time_ >= 0 + var_17_7 and arg_14_1.time_ < 0 + var_17_7 + arg_17_0 then
				var_17_5.localPosition = Vector3.New(0, -390, -210)
			end

			local var_17_8 = 0
			local var_17_9 = 0.975

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_8 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_10 = arg_14_1:GetWordFromCfg(425051003)
				local var_17_11 = arg_14_1:FormatText(var_17_10.content)

				arg_14_1.text_.text = var_17_11

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_13 = 39 <= 0 and var_17_9 or var_17_9 * (utf8.len(var_17_11) / 39)

				if (39 <= 0 and var_17_9 or var_17_9 * (utf8.len(var_17_11) / 39)) > 0 and var_17_9 < var_17_13 then
					arg_14_1.talkMaxDuration = var_17_13

					if var_17_13 + var_17_8 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_13 + var_17_8
					end
				end

				arg_14_1.text_.text = var_17_11
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051003", "story_v_out_425051.awb") ~= 0 then
					local var_17_14 = manager.audio:GetVoiceLength("story_v_out_425051", "425051003", "story_v_out_425051.awb") / 1000

					if var_17_14 + var_17_8 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_14 + var_17_8
					end

					if var_17_10.prefab_name ~= "" and arg_14_1.actors_[var_17_10.prefab_name] ~= nil then
						local var_17_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_10.prefab_name].transform, "story_v_out_425051", "425051003", "story_v_out_425051.awb")

						arg_14_1:RecordAudio("425051003", var_17_15)
						arg_14_1:RecordAudio("425051003", var_17_15)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_425051", "425051003", "story_v_out_425051.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_425051", "425051003", "story_v_out_425051.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_16 = math.max(var_17_9, arg_14_1.talkMaxDuration)

			if var_17_8 <= arg_14_1.time_ and arg_14_1.time_ < var_17_8 + var_17_16 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_8) / var_17_16

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_8 + var_17_16 and arg_14_1.time_ < var_17_8 + var_17_16 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play425051004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 425051004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play425051005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(arg_18_1.actors_["10156"]) and arg_18_1.var_.actorSpriteComps10156 == nil then
				arg_18_1.var_.actorSpriteComps10156 = arg_18_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_0 = 0.2

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 and not isNil(arg_18_1.actors_["10156"]) then
				if arg_18_1.var_.actorSpriteComps10156 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_21_1 then
							if arg_18_1.isInRecall_ then
								iter_21_1.color = Color.New(Mathf.Lerp(iter_21_1.color.r, arg_18_1.hightColor2.r, (arg_18_1.time_ - 0) / var_21_0), Mathf.Lerp(iter_21_1.color.g, arg_18_1.hightColor2.g, (arg_18_1.time_ - 0) / var_21_0), (Mathf.Lerp(iter_21_1.color.b, arg_18_1.hightColor2.b, (arg_18_1.time_ - 0) / var_21_0)))
							else
								local var_21_1 = Mathf.Lerp(iter_21_1.color.r, 0.5, (arg_18_1.time_ - 0) / var_21_0)

								iter_21_1.color = Color.New(var_21_1, var_21_1, var_21_1)
							end
						end
					end
				end
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 and not isNil(arg_18_1.actors_["10156"]) and arg_18_1.var_.actorSpriteComps10156 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_21_3 then
						iter_21_3.color = arg_18_1.isInRecall_ and (arg_18_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_18_1.var_.actorSpriteComps10156 = nil
			end

			local var_21_2 = 0
			local var_21_3 = 1.075

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_2 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_4 = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(425051004).content)

				arg_18_1.text_.text = var_21_4

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_6 = 43 <= 0 and var_21_3 or var_21_3 * (utf8.len(var_21_4) / 43)

				if (43 <= 0 and var_21_3 or var_21_3 * (utf8.len(var_21_4) / 43)) > 0 and var_21_3 < var_21_6 then
					arg_18_1.talkMaxDuration = var_21_6

					if var_21_6 + var_21_2 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_6 + var_21_2
					end
				end

				arg_18_1.text_.text = var_21_4
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_3, arg_18_1.talkMaxDuration)

			if var_21_2 <= arg_18_1.time_ and arg_18_1.time_ < var_21_2 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_2) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_2 + var_21_7 and arg_18_1.time_ < var_21_2 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play425051005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 425051005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play425051006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0.725

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, true)
				arg_22_1.iconController_:SetSelectedState("hero")

				arg_22_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_22_1.callingController_:SetSelectedState("normal")

				arg_22_1.keyicon_.color = Color.New(1, 1, 1)
				arg_22_1.icon_.color = Color.New(1, 1, 1)

				local var_25_1 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(425051005).content)

				arg_22_1.text_.text = var_25_1

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_3 = 29 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_1) / 29)

				if (29 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_1) / 29)) > 0 and var_25_0 < var_25_3 then
					arg_22_1.talkMaxDuration = var_25_3

					if var_25_3 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_3 + 0
					end
				end

				arg_22_1.text_.text = var_25_1
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_4 = math.max(var_25_0, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_4 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - 0) / var_25_4

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_4 and arg_22_1.time_ < 0 + var_25_4 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play425051006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 425051006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play425051007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.5

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_1 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(425051006).content)

				arg_26_1.text_.text = var_29_1

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_3 = 20 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_1) / 20)

				if (20 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_1) / 20)) > 0 and var_29_0 < var_29_3 then
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
	Play425051007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 425051007
		arg_30_1.duration_ = 8.47

		local var_30_0 = {
			zh = 8.466,
			ja = 4.933
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
				arg_30_0:Play425051008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["10156"]) and arg_30_1.var_.actorSpriteComps10156 == nil then
				arg_30_1.var_.actorSpriteComps10156 = arg_30_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_0 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["10156"]) then
				if arg_30_1.var_.actorSpriteComps10156 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_33_1 then
							if arg_30_1.isInRecall_ then
								iter_33_1.color = Color.New(Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor1.r, (arg_30_1.time_ - 0) / var_33_0), Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor1.g, (arg_30_1.time_ - 0) / var_33_0), (Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor1.b, (arg_30_1.time_ - 0) / var_33_0)))
							else
								local var_33_1 = Mathf.Lerp(iter_33_1.color.r, 1, (arg_30_1.time_ - 0) / var_33_0)

								iter_33_1.color = Color.New(var_33_1, var_33_1, var_33_1)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["10156"]) and arg_30_1.var_.actorSpriteComps10156 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_33_3 then
						iter_33_3.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_30_1.var_.actorSpriteComps10156 = nil
			end

			local var_33_2 = arg_30_1.actors_["10156"].transform

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos10156 = var_33_2.localPosition
				var_33_2.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("10156", 3)

				for iter_33_4 = 0, var_33_2.childCount - 1 do
					local var_33_3 = var_33_2:GetChild(iter_33_4)

					if var_33_3.name == "" or not string.find(var_33_3.name, "split") then
						var_33_3.gameObject:SetActive(true)
					else
						var_33_3.gameObject:SetActive(false)
					end
				end
			end

			local var_33_4 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				var_33_2.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos10156, Vector3.New(0, -390, -210), (arg_30_1.time_ - 0) / var_33_4)
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				var_33_2.localPosition = Vector3.New(0, -390, -210)
			end

			local var_33_5 = 0
			local var_33_6 = 0.975

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_7 = arg_30_1:GetWordFromCfg(425051007)
				local var_33_8 = arg_30_1:FormatText(var_33_7.content)

				arg_30_1.text_.text = var_33_8

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_10 = 39 <= 0 and var_33_6 or var_33_6 * (utf8.len(var_33_8) / 39)

				if (39 <= 0 and var_33_6 or var_33_6 * (utf8.len(var_33_8) / 39)) > 0 and var_33_6 < var_33_10 then
					arg_30_1.talkMaxDuration = var_33_10

					if var_33_10 + var_33_5 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_5
					end
				end

				arg_30_1.text_.text = var_33_8
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051007", "story_v_out_425051.awb") ~= 0 then
					local var_33_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051007", "story_v_out_425051.awb") / 1000

					if var_33_11 + var_33_5 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_11 + var_33_5
					end

					if var_33_7.prefab_name ~= "" and arg_30_1.actors_[var_33_7.prefab_name] ~= nil then
						local var_33_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_7.prefab_name].transform, "story_v_out_425051", "425051007", "story_v_out_425051.awb")

						arg_30_1:RecordAudio("425051007", var_33_12)
						arg_30_1:RecordAudio("425051007", var_33_12)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_425051", "425051007", "story_v_out_425051.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_425051", "425051007", "story_v_out_425051.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_13 = math.max(var_33_6, arg_30_1.talkMaxDuration)

			if var_33_5 <= arg_30_1.time_ and arg_30_1.time_ < var_33_5 + var_33_13 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_5) / var_33_13

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_5 + var_33_13 and arg_30_1.time_ < var_33_5 + var_33_13 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play425051008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 425051008
		arg_34_1.duration_ = 11.33

		local var_34_0 = {
			zh = 11.333,
			ja = 9.266
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
				arg_34_0:Play425051009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos10156 = arg_34_1.actors_["10156"].transform.localPosition
				arg_34_1.actors_["10156"].transform.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("10156", 3)

				for iter_37_0 = 0, arg_34_1.actors_["10156"].transform.childCount - 1 do
					local var_37_0 = arg_34_1.actors_["10156"].transform:GetChild(iter_37_0)

					if var_37_0.name == "" or not string.find(var_37_0.name, "split") then
						var_37_0.gameObject:SetActive(true)
					else
						var_37_0.gameObject:SetActive(false)
					end
				end
			end

			local var_37_1 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_1 then
				arg_34_1.actors_["10156"].transform.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10156, Vector3.New(0, -390, -210), (arg_34_1.time_ - 0) / var_37_1)
			end

			if arg_34_1.time_ >= 0 + var_37_1 and arg_34_1.time_ < 0 + var_37_1 + arg_37_0 then
				arg_34_1.actors_["10156"].transform.localPosition = Vector3.New(0, -390, -210)
			end

			local var_37_2 = 0
			local var_37_3 = 1.275

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_2 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_4 = arg_34_1:GetWordFromCfg(425051008)
				local var_37_5 = arg_34_1:FormatText(var_37_4.content)

				arg_34_1.text_.text = var_37_5

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_7 = 51 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_5) / 51)

				if (51 <= 0 and var_37_3 or var_37_3 * (utf8.len(var_37_5) / 51)) > 0 and var_37_3 < var_37_7 then
					arg_34_1.talkMaxDuration = var_37_7

					if var_37_7 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_7 + var_37_2
					end
				end

				arg_34_1.text_.text = var_37_5
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051008", "story_v_out_425051.awb") ~= 0 then
					local var_37_8 = manager.audio:GetVoiceLength("story_v_out_425051", "425051008", "story_v_out_425051.awb") / 1000

					if var_37_8 + var_37_2 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_8 + var_37_2
					end

					if var_37_4.prefab_name ~= "" and arg_34_1.actors_[var_37_4.prefab_name] ~= nil then
						local var_37_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_4.prefab_name].transform, "story_v_out_425051", "425051008", "story_v_out_425051.awb")

						arg_34_1:RecordAudio("425051008", var_37_9)
						arg_34_1:RecordAudio("425051008", var_37_9)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_425051", "425051008", "story_v_out_425051.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_425051", "425051008", "story_v_out_425051.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_10 = math.max(var_37_3, arg_34_1.talkMaxDuration)

			if var_37_2 <= arg_34_1.time_ and arg_34_1.time_ < var_37_2 + var_37_10 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_2) / var_37_10

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_2 + var_37_10 and arg_34_1.time_ < var_37_2 + var_37_10 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play425051009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 425051009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play425051010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["10156"]) and arg_38_1.var_.actorSpriteComps10156 == nil then
				arg_38_1.var_.actorSpriteComps10156 = arg_38_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_0 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["10156"]) then
				if arg_38_1.var_.actorSpriteComps10156 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_41_1 then
							if arg_38_1.isInRecall_ then
								iter_41_1.color = Color.New(Mathf.Lerp(iter_41_1.color.r, arg_38_1.hightColor2.r, (arg_38_1.time_ - 0) / var_41_0), Mathf.Lerp(iter_41_1.color.g, arg_38_1.hightColor2.g, (arg_38_1.time_ - 0) / var_41_0), (Mathf.Lerp(iter_41_1.color.b, arg_38_1.hightColor2.b, (arg_38_1.time_ - 0) / var_41_0)))
							else
								local var_41_1 = Mathf.Lerp(iter_41_1.color.r, 0.5, (arg_38_1.time_ - 0) / var_41_0)

								iter_41_1.color = Color.New(var_41_1, var_41_1, var_41_1)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["10156"]) and arg_38_1.var_.actorSpriteComps10156 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_41_3 then
						iter_41_3.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_38_1.var_.actorSpriteComps10156 = nil
			end

			local var_41_2 = 0
			local var_41_3 = 0.6

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_2 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_4 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(425051009).content)

				arg_38_1.text_.text = var_41_4

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_6 = 24 <= 0 and var_41_3 or var_41_3 * (utf8.len(var_41_4) / 24)

				if (24 <= 0 and var_41_3 or var_41_3 * (utf8.len(var_41_4) / 24)) > 0 and var_41_3 < var_41_6 then
					arg_38_1.talkMaxDuration = var_41_6

					if var_41_6 + var_41_2 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_6 + var_41_2
					end
				end

				arg_38_1.text_.text = var_41_4
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_3, arg_38_1.talkMaxDuration)

			if var_41_2 <= arg_38_1.time_ and arg_38_1.time_ < var_41_2 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_2) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_2 + var_41_7 and arg_38_1.time_ < var_41_2 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play425051010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 425051010
		arg_42_1.duration_ = 4.1

		local var_42_0 = {
			zh = 1.6,
			ja = 4.1
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
				arg_42_0:Play425051011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["10156"]) and arg_42_1.var_.actorSpriteComps10156 == nil then
				arg_42_1.var_.actorSpriteComps10156 = arg_42_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_0 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["10156"]) then
				if arg_42_1.var_.actorSpriteComps10156 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_45_1 then
							if arg_42_1.isInRecall_ then
								iter_45_1.color = Color.New(Mathf.Lerp(iter_45_1.color.r, arg_42_1.hightColor1.r, (arg_42_1.time_ - 0) / var_45_0), Mathf.Lerp(iter_45_1.color.g, arg_42_1.hightColor1.g, (arg_42_1.time_ - 0) / var_45_0), (Mathf.Lerp(iter_45_1.color.b, arg_42_1.hightColor1.b, (arg_42_1.time_ - 0) / var_45_0)))
							else
								local var_45_1 = Mathf.Lerp(iter_45_1.color.r, 1, (arg_42_1.time_ - 0) / var_45_0)

								iter_45_1.color = Color.New(var_45_1, var_45_1, var_45_1)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["10156"]) and arg_42_1.var_.actorSpriteComps10156 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_45_3 then
						iter_45_3.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_42_1.var_.actorSpriteComps10156 = nil
			end

			local var_45_2 = arg_42_1.actors_["10156"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos10156 = var_45_2.localPosition
				var_45_2.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10156", 3)

				for iter_45_4 = 0, var_45_2.childCount - 1 do
					local var_45_3 = var_45_2:GetChild(iter_45_4)

					if var_45_3.name == "" or not string.find(var_45_3.name, "split") then
						var_45_3.gameObject:SetActive(true)
					else
						var_45_3.gameObject:SetActive(false)
					end
				end
			end

			local var_45_4 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 then
				var_45_2.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10156, Vector3.New(0, -390, -210), (arg_42_1.time_ - 0) / var_45_4)
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 then
				var_45_2.localPosition = Vector3.New(0, -390, -210)
			end

			local var_45_5 = 0
			local var_45_6 = 0.175

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_7 = arg_42_1:GetWordFromCfg(425051010)
				local var_45_8 = arg_42_1:FormatText(var_45_7.content)

				arg_42_1.text_.text = var_45_8

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_10 = 7 <= 0 and var_45_6 or var_45_6 * (utf8.len(var_45_8) / 7)

				if (7 <= 0 and var_45_6 or var_45_6 * (utf8.len(var_45_8) / 7)) > 0 and var_45_6 < var_45_10 then
					arg_42_1.talkMaxDuration = var_45_10

					if var_45_10 + var_45_5 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_10 + var_45_5
					end
				end

				arg_42_1.text_.text = var_45_8
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051010", "story_v_out_425051.awb") ~= 0 then
					local var_45_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051010", "story_v_out_425051.awb") / 1000

					if var_45_11 + var_45_5 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_11 + var_45_5
					end

					if var_45_7.prefab_name ~= "" and arg_42_1.actors_[var_45_7.prefab_name] ~= nil then
						local var_45_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_7.prefab_name].transform, "story_v_out_425051", "425051010", "story_v_out_425051.awb")

						arg_42_1:RecordAudio("425051010", var_45_12)
						arg_42_1:RecordAudio("425051010", var_45_12)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_425051", "425051010", "story_v_out_425051.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_425051", "425051010", "story_v_out_425051.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_13 = math.max(var_45_6, arg_42_1.talkMaxDuration)

			if var_45_5 <= arg_42_1.time_ and arg_42_1.time_ < var_45_5 + var_45_13 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_5) / var_45_13

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_5 + var_45_13 and arg_42_1.time_ < var_45_5 + var_45_13 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play425051011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 425051011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play425051012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["10156"]) and arg_46_1.var_.actorSpriteComps10156 == nil then
				arg_46_1.var_.actorSpriteComps10156 = arg_46_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["10156"]) then
				if arg_46_1.var_.actorSpriteComps10156 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_49_1 then
							if arg_46_1.isInRecall_ then
								iter_49_1.color = Color.New(Mathf.Lerp(iter_49_1.color.r, arg_46_1.hightColor2.r, (arg_46_1.time_ - 0) / var_49_0), Mathf.Lerp(iter_49_1.color.g, arg_46_1.hightColor2.g, (arg_46_1.time_ - 0) / var_49_0), (Mathf.Lerp(iter_49_1.color.b, arg_46_1.hightColor2.b, (arg_46_1.time_ - 0) / var_49_0)))
							else
								local var_49_1 = Mathf.Lerp(iter_49_1.color.r, 0.5, (arg_46_1.time_ - 0) / var_49_0)

								iter_49_1.color = Color.New(var_49_1, var_49_1, var_49_1)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["10156"]) and arg_46_1.var_.actorSpriteComps10156 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_49_3 then
						iter_49_3.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_46_1.var_.actorSpriteComps10156 = nil
			end

			local var_49_2 = 0
			local var_49_3 = 0.3

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_2 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_4 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(425051011).content)

				arg_46_1.text_.text = var_49_4

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_6 = 12 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_4) / 12)

				if (12 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_4) / 12)) > 0 and var_49_3 < var_49_6 then
					arg_46_1.talkMaxDuration = var_49_6

					if var_49_6 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_6 + var_49_2
					end
				end

				arg_46_1.text_.text = var_49_4
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_3, arg_46_1.talkMaxDuration)

			if var_49_2 <= arg_46_1.time_ and arg_46_1.time_ < var_49_2 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_2) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_2 + var_49_7 and arg_46_1.time_ < var_49_2 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play425051012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 425051012
		arg_50_1.duration_ = 10.07

		local var_50_0 = {
			zh = 9.7,
			ja = 10.066
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
				arg_50_0:Play425051013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["10156"]) and arg_50_1.var_.actorSpriteComps10156 == nil then
				arg_50_1.var_.actorSpriteComps10156 = arg_50_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_0 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["10156"]) then
				if arg_50_1.var_.actorSpriteComps10156 then
					for iter_53_0, iter_53_1 in pairs(arg_50_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_53_1 then
							if arg_50_1.isInRecall_ then
								iter_53_1.color = Color.New(Mathf.Lerp(iter_53_1.color.r, arg_50_1.hightColor1.r, (arg_50_1.time_ - 0) / var_53_0), Mathf.Lerp(iter_53_1.color.g, arg_50_1.hightColor1.g, (arg_50_1.time_ - 0) / var_53_0), (Mathf.Lerp(iter_53_1.color.b, arg_50_1.hightColor1.b, (arg_50_1.time_ - 0) / var_53_0)))
							else
								local var_53_1 = Mathf.Lerp(iter_53_1.color.r, 1, (arg_50_1.time_ - 0) / var_53_0)

								iter_53_1.color = Color.New(var_53_1, var_53_1, var_53_1)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["10156"]) and arg_50_1.var_.actorSpriteComps10156 then
				for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_53_3 then
						iter_53_3.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_50_1.var_.actorSpriteComps10156 = nil
			end

			local var_53_2 = arg_50_1.actors_["10156"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos10156 = var_53_2.localPosition
				var_53_2.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("10156", 3)

				for iter_53_4 = 0, var_53_2.childCount - 1 do
					local var_53_3 = var_53_2:GetChild(iter_53_4)

					if var_53_3.name == "" or not string.find(var_53_3.name, "split") then
						var_53_3.gameObject:SetActive(true)
					else
						var_53_3.gameObject:SetActive(false)
					end
				end
			end

			local var_53_4 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				var_53_2.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10156, Vector3.New(0, -390, -210), (arg_50_1.time_ - 0) / var_53_4)
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				var_53_2.localPosition = Vector3.New(0, -390, -210)
			end

			local var_53_5 = 0
			local var_53_6 = 1.05

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_7 = arg_50_1:GetWordFromCfg(425051012)
				local var_53_8 = arg_50_1:FormatText(var_53_7.content)

				arg_50_1.text_.text = var_53_8

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_10 = 42 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 42)

				if (42 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 42)) > 0 and var_53_6 < var_53_10 then
					arg_50_1.talkMaxDuration = var_53_10

					if var_53_10 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_5
					end
				end

				arg_50_1.text_.text = var_53_8
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051012", "story_v_out_425051.awb") ~= 0 then
					local var_53_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051012", "story_v_out_425051.awb") / 1000

					if var_53_11 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_11 + var_53_5
					end

					if var_53_7.prefab_name ~= "" and arg_50_1.actors_[var_53_7.prefab_name] ~= nil then
						local var_53_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_7.prefab_name].transform, "story_v_out_425051", "425051012", "story_v_out_425051.awb")

						arg_50_1:RecordAudio("425051012", var_53_12)
						arg_50_1:RecordAudio("425051012", var_53_12)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_425051", "425051012", "story_v_out_425051.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_425051", "425051012", "story_v_out_425051.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_13 = math.max(var_53_6, arg_50_1.talkMaxDuration)

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_13 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_5) / var_53_13

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_5 + var_53_13 and arg_50_1.time_ < var_53_5 + var_53_13 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play425051013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 425051013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play425051014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["10156"]) and arg_54_1.var_.actorSpriteComps10156 == nil then
				arg_54_1.var_.actorSpriteComps10156 = arg_54_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_57_0 = 0.2

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["10156"]) then
				if arg_54_1.var_.actorSpriteComps10156 then
					for iter_57_0, iter_57_1 in pairs(arg_54_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_57_1 then
							if arg_54_1.isInRecall_ then
								iter_57_1.color = Color.New(Mathf.Lerp(iter_57_1.color.r, arg_54_1.hightColor2.r, (arg_54_1.time_ - 0) / var_57_0), Mathf.Lerp(iter_57_1.color.g, arg_54_1.hightColor2.g, (arg_54_1.time_ - 0) / var_57_0), (Mathf.Lerp(iter_57_1.color.b, arg_54_1.hightColor2.b, (arg_54_1.time_ - 0) / var_57_0)))
							else
								local var_57_1 = Mathf.Lerp(iter_57_1.color.r, 0.5, (arg_54_1.time_ - 0) / var_57_0)

								iter_57_1.color = Color.New(var_57_1, var_57_1, var_57_1)
							end
						end
					end
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["10156"]) and arg_54_1.var_.actorSpriteComps10156 then
				for iter_57_2, iter_57_3 in pairs(arg_54_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_57_3 then
						iter_57_3.color = arg_54_1.isInRecall_ and (arg_54_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_54_1.var_.actorSpriteComps10156 = nil
			end

			local var_57_2 = 0
			local var_57_3 = 0.475

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
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

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_4 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(425051013).content)

				arg_54_1.text_.text = var_57_4

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_6 = 19 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_4) / 19)

				if (19 <= 0 and var_57_3 or var_57_3 * (utf8.len(var_57_4) / 19)) > 0 and var_57_3 < var_57_6 then
					arg_54_1.talkMaxDuration = var_57_6

					if var_57_6 + var_57_2 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_6 + var_57_2
					end
				end

				arg_54_1.text_.text = var_57_4
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_3, arg_54_1.talkMaxDuration)

			if var_57_2 <= arg_54_1.time_ and arg_54_1.time_ < var_57_2 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_2) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_2 + var_57_7 and arg_54_1.time_ < var_57_2 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play425051014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 425051014
		arg_58_1.duration_ = 3.93

		local var_58_0 = {
			zh = 3.1,
			ja = 3.933
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
				arg_58_0:Play425051015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["10156"]) and arg_58_1.var_.actorSpriteComps10156 == nil then
				arg_58_1.var_.actorSpriteComps10156 = arg_58_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_0 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["10156"]) then
				if arg_58_1.var_.actorSpriteComps10156 then
					for iter_61_0, iter_61_1 in pairs(arg_58_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_61_1 then
							if arg_58_1.isInRecall_ then
								iter_61_1.color = Color.New(Mathf.Lerp(iter_61_1.color.r, arg_58_1.hightColor1.r, (arg_58_1.time_ - 0) / var_61_0), Mathf.Lerp(iter_61_1.color.g, arg_58_1.hightColor1.g, (arg_58_1.time_ - 0) / var_61_0), (Mathf.Lerp(iter_61_1.color.b, arg_58_1.hightColor1.b, (arg_58_1.time_ - 0) / var_61_0)))
							else
								local var_61_1 = Mathf.Lerp(iter_61_1.color.r, 1, (arg_58_1.time_ - 0) / var_61_0)

								iter_61_1.color = Color.New(var_61_1, var_61_1, var_61_1)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["10156"]) and arg_58_1.var_.actorSpriteComps10156 then
				for iter_61_2, iter_61_3 in pairs(arg_58_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_61_3 then
						iter_61_3.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_58_1.var_.actorSpriteComps10156 = nil
			end

			local var_61_2 = arg_58_1.actors_["10156"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos10156 = var_61_2.localPosition
				var_61_2.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("10156", 3)

				for iter_61_4 = 0, var_61_2.childCount - 1 do
					local var_61_3 = var_61_2:GetChild(iter_61_4)

					if var_61_3.name == "split_1" or not string.find(var_61_3.name, "split") then
						var_61_3.gameObject:SetActive(true)
					else
						var_61_3.gameObject:SetActive(false)
					end
				end
			end

			local var_61_4 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_4 then
				var_61_2.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10156, Vector3.New(0, -390, -210), (arg_58_1.time_ - 0) / var_61_4)
			end

			if arg_58_1.time_ >= 0 + var_61_4 and arg_58_1.time_ < 0 + var_61_4 + arg_61_0 then
				var_61_2.localPosition = Vector3.New(0, -390, -210)
			end

			local var_61_5 = 0
			local var_61_6 = 0.325

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_7 = arg_58_1:GetWordFromCfg(425051014)
				local var_61_8 = arg_58_1:FormatText(var_61_7.content)

				arg_58_1.text_.text = var_61_8

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_10 = 13 <= 0 and var_61_6 or var_61_6 * (utf8.len(var_61_8) / 13)

				if (13 <= 0 and var_61_6 or var_61_6 * (utf8.len(var_61_8) / 13)) > 0 and var_61_6 < var_61_10 then
					arg_58_1.talkMaxDuration = var_61_10

					if var_61_10 + var_61_5 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_10 + var_61_5
					end
				end

				arg_58_1.text_.text = var_61_8
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051014", "story_v_out_425051.awb") ~= 0 then
					local var_61_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051014", "story_v_out_425051.awb") / 1000

					if var_61_11 + var_61_5 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_11 + var_61_5
					end

					if var_61_7.prefab_name ~= "" and arg_58_1.actors_[var_61_7.prefab_name] ~= nil then
						local var_61_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_7.prefab_name].transform, "story_v_out_425051", "425051014", "story_v_out_425051.awb")

						arg_58_1:RecordAudio("425051014", var_61_12)
						arg_58_1:RecordAudio("425051014", var_61_12)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_425051", "425051014", "story_v_out_425051.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_425051", "425051014", "story_v_out_425051.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_13 = math.max(var_61_6, arg_58_1.talkMaxDuration)

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_13 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_5) / var_61_13

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_5 + var_61_13 and arg_58_1.time_ < var_61_5 + var_61_13 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play425051015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 425051015
		arg_62_1.duration_ = 3.4

		local var_62_0 = {
			zh = 3.4,
			ja = 3.1
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
				arg_62_0:Play425051016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.4

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:GetWordFromCfg(425051015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 16 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 16)

				if (16 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 16)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051015", "story_v_out_425051.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_425051", "425051015", "story_v_out_425051.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_425051", "425051015", "story_v_out_425051.awb")

						arg_62_1:RecordAudio("425051015", var_65_6)
						arg_62_1:RecordAudio("425051015", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_425051", "425051015", "story_v_out_425051.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_425051", "425051015", "story_v_out_425051.awb")
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
	Play425051016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 425051016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play425051017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos10156 = arg_66_1.actors_["10156"].transform.localPosition
				arg_66_1.actors_["10156"].transform.localScale = Vector3.New(1, 1, 1)

				arg_66_1:CheckSpriteTmpPos("10156", 7)

				for iter_69_0 = 0, arg_66_1.actors_["10156"].transform.childCount - 1 do
					local var_69_0 = arg_66_1.actors_["10156"].transform:GetChild(iter_69_0)

					if var_69_0.name == "" or not string.find(var_69_0.name, "split") then
						var_69_0.gameObject:SetActive(true)
					else
						var_69_0.gameObject:SetActive(false)
					end
				end
			end

			local var_69_1 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_1 then
				arg_66_1.actors_["10156"].transform.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10156, Vector3.New(0, -2000, 0), (arg_66_1.time_ - 0) / var_69_1)
			end

			if arg_66_1.time_ >= 0 + var_69_1 and arg_66_1.time_ < 0 + var_69_1 + arg_69_0 then
				arg_66_1.actors_["10156"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.1 < arg_66_1.time_ and arg_66_1.time_ <= 0.1 + arg_69_0 then
				arg_66_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_plane01", "")
			end

			local var_69_3 = 0
			local var_69_4 = 1.65

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_3 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_5 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(425051016).content)

				arg_66_1.text_.text = var_69_5

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_7 = 66 <= 0 and var_69_4 or var_69_4 * (utf8.len(var_69_5) / 66)

				if (66 <= 0 and var_69_4 or var_69_4 * (utf8.len(var_69_5) / 66)) > 0 and var_69_4 < var_69_7 then
					arg_66_1.talkMaxDuration = var_69_7

					if var_69_7 + var_69_3 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_7 + var_69_3
					end
				end

				arg_66_1.text_.text = var_69_5
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_8 = math.max(var_69_4, arg_66_1.talkMaxDuration)

			if var_69_3 <= arg_66_1.time_ and arg_66_1.time_ < var_69_3 + var_69_8 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_3) / var_69_8

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_3 + var_69_8 and arg_66_1.time_ < var_69_3 + var_69_8 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play425051017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 425051017
		arg_70_1.duration_ = 9

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play425051018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if arg_70_1.bgs_.ST60 == nil then
				local var_73_0 = Object.Instantiate(arg_70_1.paintGo_)

				var_73_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST60")
				var_73_0.name = "ST60"
				var_73_0.transform.parent = arg_70_1.stage_.transform
				var_73_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_70_1.bgs_.ST60 = var_73_0
			end

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= 2 + arg_73_0 then
				local var_73_1 = arg_70_1.bgs_.ST60

				arg_70_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_73_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_73_2 = var_73_1:GetComponent("SpriteRenderer")

				if var_73_2 and var_73_2.sprite then
					local var_73_3 = 2 * (var_73_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_73_1.transform.localScale = Vector3.New(var_73_3 / var_73_2.sprite.bounds.size.y < var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x and var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x or var_73_3 / var_73_2.sprite.bounds.size.y, var_73_3 / var_73_2.sprite.bounds.size.y < var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x and var_73_3 * manager.ui.mainCameraCom_.aspect / var_73_2.sprite.bounds.size.x or var_73_3 / var_73_2.sprite.bounds.size.y, 0)
				end

				for iter_73_0, iter_73_1 in pairs(arg_70_1.bgs_) do
					if iter_73_0 ~= "ST60" then
						iter_73_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_73_4 = 4

			if 4 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.allBtn_.enabled = false
			end

			if arg_70_1.time_ >= var_73_4 + 0.3 and arg_70_1.time_ < var_73_4 + 0.3 + arg_73_0 then
				arg_70_1.allBtn_.enabled = true
			end

			local var_73_5 = 0

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_6 = 2

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_6 then
				local var_73_7 = Color.New(0, 0, 0)

				var_73_7.a = Mathf.Lerp(0, 1, (arg_70_1.time_ - var_73_5) / var_73_6)
				arg_70_1.mask_.color = var_73_7
			end

			if arg_70_1.time_ >= var_73_5 + var_73_6 and arg_70_1.time_ < var_73_5 + var_73_6 + arg_73_0 then
				local var_73_8 = Color.New(0, 0, 0)

				var_73_8.a = 1
				arg_70_1.mask_.color = var_73_8
			end

			local var_73_9 = 2

			if 2 < arg_70_1.time_ and arg_70_1.time_ <= var_73_9 + arg_73_0 then
				arg_70_1.mask_.enabled = true
				arg_70_1.mask_.raycastTarget = true

				arg_70_1:SetGaussion(false)
			end

			local var_73_10 = 2

			if var_73_9 <= arg_70_1.time_ and arg_70_1.time_ < var_73_9 + var_73_10 then
				local var_73_11 = Color.New(0, 0, 0)

				var_73_11.a = Mathf.Lerp(1, 0, (arg_70_1.time_ - var_73_9) / var_73_10)
				arg_70_1.mask_.color = var_73_11
			end

			if arg_70_1.time_ >= var_73_9 + var_73_10 and arg_70_1.time_ < var_73_9 + var_73_10 + arg_73_0 then
				local var_73_12 = Color.New(0, 0, 0)

				arg_70_1.mask_.enabled = false
				var_73_12.a = 0
				arg_70_1.mask_.color = var_73_12
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_13 = 4
			local var_73_14 = 0.525

			if 4 < arg_70_1.time_ and arg_70_1.time_ <= var_73_13 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_15 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_15:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_70_1.dialogCg_.alpha = arg_74_0
				end))
				var_73_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_16 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(425051017).content)

				arg_70_1.text_.text = var_73_16

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_18 = 21 <= 0 and var_73_14 or var_73_14 * (utf8.len(var_73_16) / 21)

				if (21 <= 0 and var_73_14 or var_73_14 * (utf8.len(var_73_16) / 21)) > 0 and var_73_14 < var_73_18 then
					arg_70_1.talkMaxDuration = var_73_18
					var_73_13 = var_73_13 + 0.3

					if var_73_18 + var_73_13 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_18 + var_73_13
					end
				end

				arg_70_1.text_.text = var_73_16
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_19 = var_73_13 + 0.3
			local var_73_20 = math.max(var_73_14, arg_70_1.talkMaxDuration)

			if var_73_13 + 0.3 <= arg_70_1.time_ and arg_70_1.time_ < var_73_19 + var_73_20 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_19) / var_73_20

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_19 + var_73_20 and arg_70_1.time_ < var_73_19 + var_73_20 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play425051018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 425051018
		arg_76_1.duration_ = 11.57

		local var_76_0 = {
			zh = 5.466,
			ja = 11.566
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play425051019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if arg_76_1.actors_["1037"] == nil then
				local var_79_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1037")

				if not isNil(var_79_0) then
					local var_79_1 = Object.Instantiate(var_79_0, arg_76_1.canvasGo_.transform)

					var_79_1.transform:SetSiblingIndex(1)

					var_79_1.name = "1037"
					var_79_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_76_1.actors_["1037"] = var_79_1

					if arg_76_1.isInRecall_ then
						for iter_79_0, iter_79_1 in ipairs((var_79_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_79_1.color = arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_79_2 = arg_76_1.actors_["1037"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps1037 == nil then
				arg_76_1.var_.actorSpriteComps1037 = var_79_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_3 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.actorSpriteComps1037 then
					for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_79_3 then
							if arg_76_1.isInRecall_ then
								iter_79_3.color = Color.New(Mathf.Lerp(iter_79_3.color.r, arg_76_1.hightColor1.r, (arg_76_1.time_ - 0) / var_79_3), Mathf.Lerp(iter_79_3.color.g, arg_76_1.hightColor1.g, (arg_76_1.time_ - 0) / var_79_3), (Mathf.Lerp(iter_79_3.color.b, arg_76_1.hightColor1.b, (arg_76_1.time_ - 0) / var_79_3)))
							else
								local var_79_4 = Mathf.Lerp(iter_79_3.color.r, 1, (arg_76_1.time_ - 0) / var_79_3)

								iter_79_3.color = Color.New(var_79_4, var_79_4, var_79_4)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps1037 then
				for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_79_5 then
						iter_79_5.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_76_1.var_.actorSpriteComps1037 = nil
			end

			local var_79_5 = arg_76_1.actors_["1037"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1037 = var_79_5.localPosition
				var_79_5.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("1037", 3)

				for iter_79_6 = 0, var_79_5.childCount - 1 do
					local var_79_6 = var_79_5:GetChild(iter_79_6)

					if var_79_6.name == "split_4" or not string.find(var_79_6.name, "split") then
						var_79_6.gameObject:SetActive(true)
					else
						var_79_6.gameObject:SetActive(false)
					end
				end
			end

			local var_79_7 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				var_79_5.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_76_1.time_ - 0) / var_79_7)
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				var_79_5.localPosition = Vector3.New(0, -430, -55)
			end

			local var_79_8 = 0
			local var_79_9 = 0.5

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_8 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_10 = arg_76_1:GetWordFromCfg(425051018)
				local var_79_11 = arg_76_1:FormatText(var_79_10.content)

				arg_76_1.text_.text = var_79_11

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_13 = 20 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_11) / 20)

				if (20 <= 0 and var_79_9 or var_79_9 * (utf8.len(var_79_11) / 20)) > 0 and var_79_9 < var_79_13 then
					arg_76_1.talkMaxDuration = var_79_13

					if var_79_13 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_13 + var_79_8
					end
				end

				arg_76_1.text_.text = var_79_11
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051018", "story_v_out_425051.awb") ~= 0 then
					local var_79_14 = manager.audio:GetVoiceLength("story_v_out_425051", "425051018", "story_v_out_425051.awb") / 1000

					if var_79_14 + var_79_8 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_8
					end

					if var_79_10.prefab_name ~= "" and arg_76_1.actors_[var_79_10.prefab_name] ~= nil then
						local var_79_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_10.prefab_name].transform, "story_v_out_425051", "425051018", "story_v_out_425051.awb")

						arg_76_1:RecordAudio("425051018", var_79_15)
						arg_76_1:RecordAudio("425051018", var_79_15)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_425051", "425051018", "story_v_out_425051.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_425051", "425051018", "story_v_out_425051.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_16 = math.max(var_79_9, arg_76_1.talkMaxDuration)

			if var_79_8 <= arg_76_1.time_ and arg_76_1.time_ < var_79_8 + var_79_16 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_8) / var_79_16

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_8 + var_79_16 and arg_76_1.time_ < var_79_8 + var_79_16 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play425051019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 425051019
		arg_80_1.duration_ = 12

		local var_80_0 = {
			zh = 5.9,
			ja = 12
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play425051020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.875

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:GetWordFromCfg(425051019)
				local var_83_2 = arg_80_1:FormatText(var_83_1.content)

				arg_80_1.text_.text = var_83_2

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 35 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 35)

				if (35 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 35)) > 0 and var_83_0 < var_83_4 then
					arg_80_1.talkMaxDuration = var_83_4

					if var_83_4 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_4 + 0
					end
				end

				arg_80_1.text_.text = var_83_2
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051019", "story_v_out_425051.awb") ~= 0 then
					local var_83_5 = manager.audio:GetVoiceLength("story_v_out_425051", "425051019", "story_v_out_425051.awb") / 1000

					if var_83_5 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + 0
					end

					if var_83_1.prefab_name ~= "" and arg_80_1.actors_[var_83_1.prefab_name] ~= nil then
						local var_83_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_1.prefab_name].transform, "story_v_out_425051", "425051019", "story_v_out_425051.awb")

						arg_80_1:RecordAudio("425051019", var_83_6)
						arg_80_1:RecordAudio("425051019", var_83_6)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_425051", "425051019", "story_v_out_425051.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_425051", "425051019", "story_v_out_425051.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play425051020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 425051020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play425051021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1037"]) and arg_84_1.var_.actorSpriteComps1037 == nil then
				arg_84_1.var_.actorSpriteComps1037 = arg_84_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_87_0 = 0.2

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1037"]) then
				if arg_84_1.var_.actorSpriteComps1037 then
					for iter_87_0, iter_87_1 in pairs(arg_84_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_87_1 then
							if arg_84_1.isInRecall_ then
								iter_87_1.color = Color.New(Mathf.Lerp(iter_87_1.color.r, arg_84_1.hightColor2.r, (arg_84_1.time_ - 0) / var_87_0), Mathf.Lerp(iter_87_1.color.g, arg_84_1.hightColor2.g, (arg_84_1.time_ - 0) / var_87_0), (Mathf.Lerp(iter_87_1.color.b, arg_84_1.hightColor2.b, (arg_84_1.time_ - 0) / var_87_0)))
							else
								local var_87_1 = Mathf.Lerp(iter_87_1.color.r, 0.5, (arg_84_1.time_ - 0) / var_87_0)

								iter_87_1.color = Color.New(var_87_1, var_87_1, var_87_1)
							end
						end
					end
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1037"]) and arg_84_1.var_.actorSpriteComps1037 then
				for iter_87_2, iter_87_3 in pairs(arg_84_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_87_3 then
						iter_87_3.color = arg_84_1.isInRecall_ and (arg_84_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_84_1.var_.actorSpriteComps1037 = nil
			end

			local var_87_2 = 0
			local var_87_3 = 0.25

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_4 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(425051020).content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_6 = 10 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_4) / 10)

				if (10 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_4) / 10)) > 0 and var_87_3 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_7 and arg_84_1.time_ < var_87_2 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play425051021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 425051021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play425051022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 1

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(425051021).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 40 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 40)

				if (40 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 40)) > 0 and var_91_0 < var_91_3 then
					arg_88_1.talkMaxDuration = var_91_3

					if var_91_3 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_3 + 0
					end
				end

				arg_88_1.text_.text = var_91_1
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_4 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_4

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play425051022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 425051022
		arg_92_1.duration_ = 1.13

		local var_92_0 = {
			zh = 1.133,
			ja = 1.1
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play425051023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1037"]) and arg_92_1.var_.actorSpriteComps1037 == nil then
				arg_92_1.var_.actorSpriteComps1037 = arg_92_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_0 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1037"]) then
				if arg_92_1.var_.actorSpriteComps1037 then
					for iter_95_0, iter_95_1 in pairs(arg_92_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_95_1 then
							if arg_92_1.isInRecall_ then
								iter_95_1.color = Color.New(Mathf.Lerp(iter_95_1.color.r, arg_92_1.hightColor1.r, (arg_92_1.time_ - 0) / var_95_0), Mathf.Lerp(iter_95_1.color.g, arg_92_1.hightColor1.g, (arg_92_1.time_ - 0) / var_95_0), (Mathf.Lerp(iter_95_1.color.b, arg_92_1.hightColor1.b, (arg_92_1.time_ - 0) / var_95_0)))
							else
								local var_95_1 = Mathf.Lerp(iter_95_1.color.r, 1, (arg_92_1.time_ - 0) / var_95_0)

								iter_95_1.color = Color.New(var_95_1, var_95_1, var_95_1)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1037"]) and arg_92_1.var_.actorSpriteComps1037 then
				for iter_95_2, iter_95_3 in pairs(arg_92_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_95_3 then
						iter_95_3.color = arg_92_1.isInRecall_ and (arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_92_1.var_.actorSpriteComps1037 = nil
			end

			local var_95_2 = arg_92_1.actors_["1037"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1037 = var_95_2.localPosition
				var_95_2.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1037", 3)

				for iter_95_4 = 0, var_95_2.childCount - 1 do
					local var_95_3 = var_95_2:GetChild(iter_95_4)

					if var_95_3.name == "split_5" then
						var_95_3:SetAsLastSibling()
						var_95_3.gameObject:SetActive(true)

						arg_92_1.var_.actorSpriteSplit1037 = var_95_3.gameObject:GetComponent(typeof(Image))

						arg_92_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_95_4 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				var_95_2.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_92_1.time_ - 0) / var_95_4)

				if arg_92_1.var_.actorSpriteSplit1037 ~= nil then
					arg_92_1.var_.actorSpriteSplit1037:SetAlpha((arg_92_1.time_ - 0) / var_95_4)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				var_95_2.localPosition = Vector3.New(0, -430, -55)

				if arg_92_1.var_.actorSpriteSplit1037 ~= nil then
					arg_92_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_95_5 = 0
			local var_95_6 = 0.075

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_7 = arg_92_1:GetWordFromCfg(425051022)
				local var_95_8 = arg_92_1:FormatText(var_95_7.content)

				arg_92_1.text_.text = var_95_8

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_10 = 3 <= 0 and var_95_6 or var_95_6 * (utf8.len(var_95_8) / 3)

				if (3 <= 0 and var_95_6 or var_95_6 * (utf8.len(var_95_8) / 3)) > 0 and var_95_6 < var_95_10 then
					arg_92_1.talkMaxDuration = var_95_10

					if var_95_10 + var_95_5 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_5
					end
				end

				arg_92_1.text_.text = var_95_8
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051022", "story_v_out_425051.awb") ~= 0 then
					local var_95_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051022", "story_v_out_425051.awb") / 1000

					if var_95_11 + var_95_5 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_11 + var_95_5
					end

					if var_95_7.prefab_name ~= "" and arg_92_1.actors_[var_95_7.prefab_name] ~= nil then
						local var_95_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_7.prefab_name].transform, "story_v_out_425051", "425051022", "story_v_out_425051.awb")

						arg_92_1:RecordAudio("425051022", var_95_12)
						arg_92_1:RecordAudio("425051022", var_95_12)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_425051", "425051022", "story_v_out_425051.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_425051", "425051022", "story_v_out_425051.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_13 = math.max(var_95_6, arg_92_1.talkMaxDuration)

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_13 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_5) / var_95_13

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_5 + var_95_13 and arg_92_1.time_ < var_95_5 + var_95_13 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				frequency = 10,
				className = "StoryShakeNode",
				duration = 0.333333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.ACTOR_SPRITE,
				offset = Vector3.New(8, 8, 8)
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play425051023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 425051023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play425051024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1037"]) and arg_96_1.var_.actorSpriteComps1037 == nil then
				arg_96_1.var_.actorSpriteComps1037 = arg_96_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_99_0 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1037"]) then
				if arg_96_1.var_.actorSpriteComps1037 then
					for iter_99_0, iter_99_1 in pairs(arg_96_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_99_1 then
							if arg_96_1.isInRecall_ then
								iter_99_1.color = Color.New(Mathf.Lerp(iter_99_1.color.r, arg_96_1.hightColor2.r, (arg_96_1.time_ - 0) / var_99_0), Mathf.Lerp(iter_99_1.color.g, arg_96_1.hightColor2.g, (arg_96_1.time_ - 0) / var_99_0), (Mathf.Lerp(iter_99_1.color.b, arg_96_1.hightColor2.b, (arg_96_1.time_ - 0) / var_99_0)))
							else
								local var_99_1 = Mathf.Lerp(iter_99_1.color.r, 0.5, (arg_96_1.time_ - 0) / var_99_0)

								iter_99_1.color = Color.New(var_99_1, var_99_1, var_99_1)
							end
						end
					end
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1037"]) and arg_96_1.var_.actorSpriteComps1037 then
				for iter_99_2, iter_99_3 in pairs(arg_96_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_99_3 then
						iter_99_3.color = arg_96_1.isInRecall_ and (arg_96_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_96_1.var_.actorSpriteComps1037 = nil
			end

			local var_99_2 = 0
			local var_99_3 = 0.375

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_4 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(425051023).content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_6 = 15 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_4) / 15)

				if (15 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_4) / 15)) > 0 and var_99_3 < var_99_6 then
					arg_96_1.talkMaxDuration = var_99_6

					if var_99_6 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_7 and arg_96_1.time_ < var_99_2 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play425051024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 425051024
		arg_100_1.duration_ = 2.03

		local var_100_0 = {
			zh = 1.6,
			ja = 2.033
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play425051025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1037"]) and arg_100_1.var_.actorSpriteComps1037 == nil then
				arg_100_1.var_.actorSpriteComps1037 = arg_100_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1037"]) then
				if arg_100_1.var_.actorSpriteComps1037 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								iter_103_1.color = Color.New(Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor1.r, (arg_100_1.time_ - 0) / var_103_0), Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor1.g, (arg_100_1.time_ - 0) / var_103_0), (Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor1.b, (arg_100_1.time_ - 0) / var_103_0)))
							else
								local var_103_1 = Mathf.Lerp(iter_103_1.color.r, 1, (arg_100_1.time_ - 0) / var_103_0)

								iter_103_1.color = Color.New(var_103_1, var_103_1, var_103_1)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1037"]) and arg_100_1.var_.actorSpriteComps1037 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_103_3 then
						iter_103_3.color = arg_100_1.isInRecall_ and (arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_100_1.var_.actorSpriteComps1037 = nil
			end

			local var_103_2 = arg_100_1.actors_["1037"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos1037 = var_103_2.localPosition
				var_103_2.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("1037", 3)

				for iter_103_4 = 0, var_103_2.childCount - 1 do
					local var_103_3 = var_103_2:GetChild(iter_103_4)

					if var_103_3.name == "split_4" then
						var_103_3:SetAsLastSibling()
						var_103_3.gameObject:SetActive(true)

						arg_100_1.var_.actorSpriteSplit1037 = var_103_3.gameObject:GetComponent(typeof(Image))

						arg_100_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_103_4 = 0.5

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				var_103_2.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_100_1.time_ - 0) / var_103_4)

				if arg_100_1.var_.actorSpriteSplit1037 ~= nil then
					arg_100_1.var_.actorSpriteSplit1037:SetAlpha((arg_100_1.time_ - 0) / var_103_4)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				var_103_2.localPosition = Vector3.New(0, -430, -55)

				if arg_100_1.var_.actorSpriteSplit1037 ~= nil then
					arg_100_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_103_5 = 0
			local var_103_6 = 0.1

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_7 = arg_100_1:GetWordFromCfg(425051024)
				local var_103_8 = arg_100_1:FormatText(var_103_7.content)

				arg_100_1.text_.text = var_103_8

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_10 = 4 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_8) / 4)

				if (4 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_8) / 4)) > 0 and var_103_6 < var_103_10 then
					arg_100_1.talkMaxDuration = var_103_10

					if var_103_10 + var_103_5 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_5
					end
				end

				arg_100_1.text_.text = var_103_8
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051024", "story_v_out_425051.awb") ~= 0 then
					local var_103_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051024", "story_v_out_425051.awb") / 1000

					if var_103_11 + var_103_5 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_11 + var_103_5
					end

					if var_103_7.prefab_name ~= "" and arg_100_1.actors_[var_103_7.prefab_name] ~= nil then
						local var_103_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_7.prefab_name].transform, "story_v_out_425051", "425051024", "story_v_out_425051.awb")

						arg_100_1:RecordAudio("425051024", var_103_12)
						arg_100_1:RecordAudio("425051024", var_103_12)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_425051", "425051024", "story_v_out_425051.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_425051", "425051024", "story_v_out_425051.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_13 = math.max(var_103_6, arg_100_1.talkMaxDuration)

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_13 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_5) / var_103_13

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_5 + var_103_13 and arg_100_1.time_ < var_103_5 + var_103_13 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play425051025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 425051025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play425051026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1037 = arg_104_1.actors_["1037"].transform.localPosition
				arg_104_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1037", 7)

				for iter_107_0 = 0, arg_104_1.actors_["1037"].transform.childCount - 1 do
					local var_107_0 = arg_104_1.actors_["1037"].transform:GetChild(iter_107_0)

					if var_107_0.name == "" or not string.find(var_107_0.name, "split") then
						var_107_0.gameObject:SetActive(true)
					else
						var_107_0.gameObject:SetActive(false)
					end
				end
			end

			local var_107_1 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 then
				arg_104_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_104_1.time_ - 0) / var_107_1)
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 then
				arg_104_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_107_2 = 0
			local var_107_3 = 0.875

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_4 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(425051025).content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_6 = 35 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_4) / 35)

				if (35 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_4) / 35)) > 0 and var_107_3 < var_107_6 then
					arg_104_1.talkMaxDuration = var_107_6

					if var_107_6 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_6 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_7 and arg_104_1.time_ < var_107_2 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play425051026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 425051026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play425051027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 1.175

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(425051026).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 47 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 47)

				if (47 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 47)) > 0 and var_111_0 < var_111_3 then
					arg_108_1.talkMaxDuration = var_111_3

					if var_111_3 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_3 + 0
					end
				end

				arg_108_1.text_.text = var_111_1
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_4 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_4

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play425051027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 425051027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play425051028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 1.075

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_1 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(425051027).content)

				arg_112_1.text_.text = var_115_1

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_3 = 43 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 43)

				if (43 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 43)) > 0 and var_115_0 < var_115_3 then
					arg_112_1.talkMaxDuration = var_115_3

					if var_115_3 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_3 + 0
					end
				end

				arg_112_1.text_.text = var_115_1
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_4 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_4

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play425051028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 425051028
		arg_116_1.duration_ = 11.43

		local var_116_0 = {
			zh = 10.4000003333333,
			ja = 11.4330003333333
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play425051029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 5.60000033333333 < arg_116_1.time_ and arg_116_1.time_ <= 5.60000033333333 + arg_119_0 then
				arg_116_1.allBtn_.enabled = false
			end

			if arg_116_1.time_ >= 5.60000033333333 + 0.3 and arg_116_1.time_ < 5.60000033333333 + 0.3 + arg_119_0 then
				arg_116_1.allBtn_.enabled = true
			end

			local var_119_0 = "1047"

			if arg_116_1.actors_["1047"] == nil then
				local var_119_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1047")

				if not isNil(var_119_1) then
					local var_119_2 = Object.Instantiate(var_119_1, arg_116_1.canvasGo_.transform)

					var_119_2.transform:SetSiblingIndex(1)

					var_119_2.name = var_119_0
					var_119_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_116_1.actors_[var_119_0] = var_119_2

					if arg_116_1.isInRecall_ then
						for iter_119_0, iter_119_1 in ipairs((var_119_2:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_119_1.color = arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_119_3 = arg_116_1.actors_["1047"]

			if 5.40000033333333 < arg_116_1.time_ and arg_116_1.time_ <= 5.40000033333333 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.actorSpriteComps1047 == nil then
				arg_116_1.var_.actorSpriteComps1047 = var_119_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_4 = 0.2

			if 5.40000033333333 <= arg_116_1.time_ and arg_116_1.time_ < 5.40000033333333 + var_119_4 and not isNil(var_119_3) then
				if arg_116_1.var_.actorSpriteComps1047 then
					for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_119_3 then
							if arg_116_1.isInRecall_ then
								iter_119_3.color = Color.New(Mathf.Lerp(iter_119_3.color.r, arg_116_1.hightColor1.r, (arg_116_1.time_ - 5.40000033333333) / var_119_4), Mathf.Lerp(iter_119_3.color.g, arg_116_1.hightColor1.g, (arg_116_1.time_ - 5.40000033333333) / var_119_4), (Mathf.Lerp(iter_119_3.color.b, arg_116_1.hightColor1.b, (arg_116_1.time_ - 5.40000033333333) / var_119_4)))
							else
								local var_119_5 = Mathf.Lerp(iter_119_3.color.r, 1, (arg_116_1.time_ - 5.40000033333333) / var_119_4)

								iter_119_3.color = Color.New(var_119_5, var_119_5, var_119_5)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 5.40000033333333 + var_119_4 and arg_116_1.time_ < 5.40000033333333 + var_119_4 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.actorSpriteComps1047 then
				for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_119_5 then
						iter_119_5.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_116_1.var_.actorSpriteComps1047 = nil
			end

			local var_119_6 = 0

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_6 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_7 = 1.2

			if var_119_6 <= arg_116_1.time_ and arg_116_1.time_ < var_119_6 + var_119_7 then
				local var_119_8 = Color.New(0, 0, 0)

				var_119_8.a = Mathf.Lerp(0, 1, (arg_116_1.time_ - var_119_6) / var_119_7)
				arg_116_1.mask_.color = var_119_8
			end

			if arg_116_1.time_ >= var_119_6 + var_119_7 and arg_116_1.time_ < var_119_6 + var_119_7 + arg_119_0 then
				local var_119_9 = Color.New(0, 0, 0)

				var_119_9.a = 1
				arg_116_1.mask_.color = var_119_9
			end

			local var_119_10 = 1.2

			if 1.2 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_11 = 1.2

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_11 then
				local var_119_12 = Color.New(0, 0, 0)

				var_119_12.a = Mathf.Lerp(1, 0, (arg_116_1.time_ - var_119_10) / var_119_11)
				arg_116_1.mask_.color = var_119_12
			end

			if arg_116_1.time_ >= var_119_10 + var_119_11 and arg_116_1.time_ < var_119_10 + var_119_11 + arg_119_0 then
				local var_119_13 = Color.New(0, 0, 0)

				arg_116_1.mask_.enabled = false
				var_119_13.a = 0
				arg_116_1.mask_.color = var_119_13
			end

			local var_119_14 = arg_116_1.actors_["1047"].transform

			if 5.40000033333333 < arg_116_1.time_ and arg_116_1.time_ <= 5.40000033333333 + arg_119_0 then
				arg_116_1.var_.moveOldPos1047 = var_119_14.localPosition
				var_119_14.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("1047", 3)

				for iter_119_6 = 0, var_119_14.childCount - 1 do
					local var_119_15 = var_119_14:GetChild(iter_119_6)

					if var_119_15.name == "" or not string.find(var_119_15.name, "split") then
						var_119_15.gameObject:SetActive(true)
					else
						var_119_15.gameObject:SetActive(false)
					end
				end
			end

			local var_119_16 = 0.001

			if 5.40000033333333 <= arg_116_1.time_ and arg_116_1.time_ < 5.40000033333333 + var_119_16 then
				var_119_14.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_116_1.time_ - 5.40000033333333) / var_119_16)
			end

			if arg_116_1.time_ >= 5.40000033333333 + var_119_16 and arg_116_1.time_ < 5.40000033333333 + var_119_16 + arg_119_0 then
				var_119_14.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_119_17 = 1.2

			if 1.2 < arg_116_1.time_ and arg_116_1.time_ <= var_119_17 + arg_119_0 then
				arg_116_1.timestampController_:SetSelectedState("show")
				arg_116_1.timestampAni_:Play("in")

				arg_116_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13")

				arg_116_1.timestampColorController_:SetSelectedState("cold")
				arg_116_1.timeColdImg_:SetAlpha(0.031)

				arg_116_1.text_timeText_.text = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(501128).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_timeText_)

				arg_116_1.text_siteText_.text = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(501101).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_siteText_)
			end

			if arg_116_1.time_ >= var_119_17 + 1.999999999999 and arg_116_1.time_ < var_119_17 + 1.999999999999 + arg_119_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_116_1.timestampAni_, "out", function()
					arg_116_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_119_18 = 3.20000033333333

			if 3.20000033333333 < arg_116_1.time_ and arg_116_1.time_ <= var_119_18 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_19 = 1.2

			if var_119_18 <= arg_116_1.time_ and arg_116_1.time_ < var_119_18 + var_119_19 then
				local var_119_20 = Color.New(0, 0, 0)

				var_119_20.a = Mathf.Lerp(0, 1, (arg_116_1.time_ - var_119_18) / var_119_19)
				arg_116_1.mask_.color = var_119_20
			end

			if arg_116_1.time_ >= var_119_18 + var_119_19 and arg_116_1.time_ < var_119_18 + var_119_19 + arg_119_0 then
				local var_119_21 = Color.New(0, 0, 0)

				var_119_21.a = 1
				arg_116_1.mask_.color = var_119_21
			end

			local var_119_22 = 4.40000033333333

			if 4.40000033333333 < arg_116_1.time_ and arg_116_1.time_ <= var_119_22 + arg_119_0 then
				arg_116_1.mask_.enabled = true
				arg_116_1.mask_.raycastTarget = true

				arg_116_1:SetGaussion(false)
			end

			local var_119_23 = 1.2

			if var_119_22 <= arg_116_1.time_ and arg_116_1.time_ < var_119_22 + var_119_23 then
				local var_119_24 = Color.New(0, 0, 0)

				var_119_24.a = Mathf.Lerp(1, 0, (arg_116_1.time_ - var_119_22) / var_119_23)
				arg_116_1.mask_.color = var_119_24
			end

			if arg_116_1.time_ >= var_119_22 + var_119_23 and arg_116_1.time_ < var_119_22 + var_119_23 + arg_119_0 then
				local var_119_25 = Color.New(0, 0, 0)

				arg_116_1.mask_.enabled = false
				var_119_25.a = 0
				arg_116_1.mask_.color = var_119_25
			end

			local var_119_26 = "B13"

			if arg_116_1.bgs_.B13 == nil then
				local var_119_27 = Object.Instantiate(arg_116_1.paintGo_)

				var_119_27:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_119_26)
				var_119_27.name = var_119_26
				var_119_27.transform.parent = arg_116_1.stage_.transform
				var_119_27.transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.bgs_[var_119_26] = var_119_27
			end

			if 1.2 < arg_116_1.time_ and arg_116_1.time_ <= 1.2 + arg_119_0 then
				local var_119_28 = arg_116_1.bgs_.B13

				arg_116_1.bgs_.B13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_119_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_119_29 = var_119_28:GetComponent("SpriteRenderer")

				if var_119_29 and var_119_29.sprite then
					local var_119_30 = 2 * (var_119_28.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_119_28.transform.localScale = Vector3.New(var_119_30 / var_119_29.sprite.bounds.size.y < var_119_30 * manager.ui.mainCameraCom_.aspect / var_119_29.sprite.bounds.size.x and var_119_30 * manager.ui.mainCameraCom_.aspect / var_119_29.sprite.bounds.size.x or var_119_30 / var_119_29.sprite.bounds.size.y, var_119_30 / var_119_29.sprite.bounds.size.y < var_119_30 * manager.ui.mainCameraCom_.aspect / var_119_29.sprite.bounds.size.x and var_119_30 * manager.ui.mainCameraCom_.aspect / var_119_29.sprite.bounds.size.x or var_119_30 / var_119_29.sprite.bounds.size.y, 0)
				end

				for iter_119_7, iter_119_8 in pairs(arg_116_1.bgs_) do
					if iter_119_7 ~= "B13" then
						iter_119_8.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.1 < arg_116_1.time_ and arg_116_1.time_ <= 0.1 + arg_119_0 then
				arg_116_1:AudioAction("stop", "effect", "se_story_147", "se_story_147_amb_rooftop", "")
			end

			if 4.11153880064376 < arg_116_1.time_ and arg_116_1.time_ <= 4.11153880064376 + arg_119_0 then
				arg_116_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_33 = 5.60000033333333
			local var_119_34 = 0.575

			if 5.60000033333333 < arg_116_1.time_ and arg_116_1.time_ <= var_119_33 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_35 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_35:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_116_1.dialogCg_.alpha = arg_121_0
				end))
				var_119_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_36 = arg_116_1:GetWordFromCfg(425051028)
				local var_119_37 = arg_116_1:FormatText(var_119_36.content)

				arg_116_1.text_.text = var_119_37

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_39 = 23 <= 0 and var_119_34 or var_119_34 * (utf8.len(var_119_37) / 23)

				if (23 <= 0 and var_119_34 or var_119_34 * (utf8.len(var_119_37) / 23)) > 0 and var_119_34 < var_119_39 then
					arg_116_1.talkMaxDuration = var_119_39
					var_119_33 = var_119_33 + 0.3

					if var_119_39 + var_119_33 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_39 + var_119_33
					end
				end

				arg_116_1.text_.text = var_119_37
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051028", "story_v_out_425051.awb") ~= 0 then
					local var_119_40 = manager.audio:GetVoiceLength("story_v_out_425051", "425051028", "story_v_out_425051.awb") / 1000

					if var_119_40 + var_119_33 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_40 + var_119_33
					end

					if var_119_36.prefab_name ~= "" and arg_116_1.actors_[var_119_36.prefab_name] ~= nil then
						local var_119_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_36.prefab_name].transform, "story_v_out_425051", "425051028", "story_v_out_425051.awb")

						arg_116_1:RecordAudio("425051028", var_119_41)
						arg_116_1:RecordAudio("425051028", var_119_41)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_425051", "425051028", "story_v_out_425051.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_425051", "425051028", "story_v_out_425051.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_42 = var_119_33 + 0.3
			local var_119_43 = math.max(var_119_34, arg_116_1.talkMaxDuration)

			if var_119_33 + 0.3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_42 + var_119_43 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_42) / var_119_43

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_42 + var_119_43 and arg_116_1.time_ < var_119_42 + var_119_43 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.40000033333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play425051029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 425051029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play425051030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1047"]) and arg_123_1.var_.actorSpriteComps1047 == nil then
				arg_123_1.var_.actorSpriteComps1047 = arg_123_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_0 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1047"]) then
				if arg_123_1.var_.actorSpriteComps1047 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								iter_126_1.color = Color.New(Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_0), Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_0), (Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_0)))
							else
								local var_126_1 = Mathf.Lerp(iter_126_1.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_0)

								iter_126_1.color = Color.New(var_126_1, var_126_1, var_126_1)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1047"]) and arg_123_1.var_.actorSpriteComps1047 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_126_3 then
						iter_126_3.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps1047 = nil
			end

			local var_126_2 = 0
			local var_126_3 = 0.55

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
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

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_4 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(425051029).content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_6 = 22 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_4) / 22)

				if (22 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_4) / 22)) > 0 and var_126_3 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_2
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_3, arg_123_1.talkMaxDuration)

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_2) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_2 + var_126_7 and arg_123_1.time_ < var_126_2 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play425051030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 425051030
		arg_127_1.duration_ = 7.3

		local var_127_0 = {
			zh = 4.7,
			ja = 7.3
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
				arg_127_0:Play425051031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["1047"]) and arg_127_1.var_.actorSpriteComps1047 == nil then
				arg_127_1.var_.actorSpriteComps1047 = arg_127_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["1047"]) then
				if arg_127_1.var_.actorSpriteComps1047 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["1047"]) and arg_127_1.var_.actorSpriteComps1047 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps1047 = nil
			end

			local var_130_2 = arg_127_1.actors_["1047"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1047 = var_130_2.localPosition
				var_130_2.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1047", 3)

				for iter_130_4 = 0, var_130_2.childCount - 1 do
					local var_130_3 = var_130_2:GetChild(iter_130_4)

					if var_130_3.name == "split_1" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_2.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_127_1.time_ - 0) / var_130_4)
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_2.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_130_5 = 0
			local var_130_6 = 0.325

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_7 = arg_127_1:GetWordFromCfg(425051030)
				local var_130_8 = arg_127_1:FormatText(var_130_7.content)

				arg_127_1.text_.text = var_130_8

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 13 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 13)

				if (13 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 13)) > 0 and var_130_6 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_8
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051030", "story_v_out_425051.awb") ~= 0 then
					local var_130_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051030", "story_v_out_425051.awb") / 1000

					if var_130_11 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_5
					end

					if var_130_7.prefab_name ~= "" and arg_127_1.actors_[var_130_7.prefab_name] ~= nil then
						local var_130_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_7.prefab_name].transform, "story_v_out_425051", "425051030", "story_v_out_425051.awb")

						arg_127_1:RecordAudio("425051030", var_130_12)
						arg_127_1:RecordAudio("425051030", var_130_12)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_425051", "425051030", "story_v_out_425051.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_425051", "425051030", "story_v_out_425051.awb")
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
				actorName = "1047",
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
	Play425051031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 425051031
		arg_131_1.duration_ = 13.13

		local var_131_0 = {
			zh = 10.766,
			ja = 13.133
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play425051032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 1.35

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:GetWordFromCfg(425051031)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 54 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 54)

				if (54 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 54)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051031", "story_v_out_425051.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_425051", "425051031", "story_v_out_425051.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_425051", "425051031", "story_v_out_425051.awb")

						arg_131_1:RecordAudio("425051031", var_134_6)
						arg_131_1:RecordAudio("425051031", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_425051", "425051031", "story_v_out_425051.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_425051", "425051031", "story_v_out_425051.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play425051032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 425051032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play425051033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1047"]) and arg_135_1.var_.actorSpriteComps1047 == nil then
				arg_135_1.var_.actorSpriteComps1047 = arg_135_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1047"]) then
				if arg_135_1.var_.actorSpriteComps1047 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								iter_138_1.color = Color.New(Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_0), Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_0), (Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_0)))
							else
								local var_138_1 = Mathf.Lerp(iter_138_1.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_0)

								iter_138_1.color = Color.New(var_138_1, var_138_1, var_138_1)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1047"]) and arg_135_1.var_.actorSpriteComps1047 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps1047 = nil
			end

			local var_138_2 = 0
			local var_138_3 = 0.475

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_4 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(425051032).content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_6 = 19 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_4) / 19)

				if (19 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_4) / 19)) > 0 and var_138_3 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_2
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_3, arg_135_1.talkMaxDuration)

			if var_138_2 <= arg_135_1.time_ and arg_135_1.time_ < var_138_2 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_2) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_2 + var_138_7 and arg_135_1.time_ < var_138_2 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play425051033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 425051033
		arg_139_1.duration_ = 10.8

		local var_139_0 = {
			zh = 5.6,
			ja = 10.8
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play425051034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1047"]) and arg_139_1.var_.actorSpriteComps1047 == nil then
				arg_139_1.var_.actorSpriteComps1047 = arg_139_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1047"]) then
				if arg_139_1.var_.actorSpriteComps1047 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								iter_142_1.color = Color.New(Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 0) / var_142_0), Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 0) / var_142_0), (Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 0) / var_142_0)))
							else
								local var_142_1 = Mathf.Lerp(iter_142_1.color.r, 1, (arg_139_1.time_ - 0) / var_142_0)

								iter_142_1.color = Color.New(var_142_1, var_142_1, var_142_1)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1047"]) and arg_139_1.var_.actorSpriteComps1047 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps1047 = nil
			end

			local var_142_2 = 0
			local var_142_3 = 0.7

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_4 = arg_139_1:GetWordFromCfg(425051033)
				local var_142_5 = arg_139_1:FormatText(var_142_4.content)

				arg_139_1.text_.text = var_142_5

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 28 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 28)

				if (28 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 28)) > 0 and var_142_3 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_5
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051033", "story_v_out_425051.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_425051", "425051033", "story_v_out_425051.awb") / 1000

					if var_142_8 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_2
					end

					if var_142_4.prefab_name ~= "" and arg_139_1.actors_[var_142_4.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_4.prefab_name].transform, "story_v_out_425051", "425051033", "story_v_out_425051.awb")

						arg_139_1:RecordAudio("425051033", var_142_9)
						arg_139_1:RecordAudio("425051033", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_425051", "425051033", "story_v_out_425051.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_425051", "425051033", "story_v_out_425051.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_10 and arg_139_1.time_ < var_142_2 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play425051034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 425051034
		arg_143_1.duration_ = 17.2

		local var_143_0 = {
			zh = 12.4,
			ja = 17.2
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
				arg_143_0:Play425051035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 1.45

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:GetWordFromCfg(425051034)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 58 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 58)

				if (58 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 58)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051034", "story_v_out_425051.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_425051", "425051034", "story_v_out_425051.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_425051", "425051034", "story_v_out_425051.awb")

						arg_143_1:RecordAudio("425051034", var_146_6)
						arg_143_1:RecordAudio("425051034", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_425051", "425051034", "story_v_out_425051.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_425051", "425051034", "story_v_out_425051.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play425051035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 425051035
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play425051036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1047"]) and arg_147_1.var_.actorSpriteComps1047 == nil then
				arg_147_1.var_.actorSpriteComps1047 = arg_147_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_0 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1047"]) then
				if arg_147_1.var_.actorSpriteComps1047 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps1047:ToTable()) do
						if iter_150_1 then
							if arg_147_1.isInRecall_ then
								iter_150_1.color = Color.New(Mathf.Lerp(iter_150_1.color.r, arg_147_1.hightColor2.r, (arg_147_1.time_ - 0) / var_150_0), Mathf.Lerp(iter_150_1.color.g, arg_147_1.hightColor2.g, (arg_147_1.time_ - 0) / var_150_0), (Mathf.Lerp(iter_150_1.color.b, arg_147_1.hightColor2.b, (arg_147_1.time_ - 0) / var_150_0)))
							else
								local var_150_1 = Mathf.Lerp(iter_150_1.color.r, 0.5, (arg_147_1.time_ - 0) / var_150_0)

								iter_150_1.color = Color.New(var_150_1, var_150_1, var_150_1)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1047"]) and arg_147_1.var_.actorSpriteComps1047 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_150_3 then
						iter_150_3.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps1047 = nil
			end

			local var_150_2 = 0
			local var_150_3 = 0.375

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_4 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(425051035).content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_6 = 15 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_4) / 15)

				if (15 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_4) / 15)) > 0 and var_150_3 < var_150_6 then
					arg_147_1.talkMaxDuration = var_150_6

					if var_150_6 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_6 + var_150_2
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_3, arg_147_1.talkMaxDuration)

			if var_150_2 <= arg_147_1.time_ and arg_147_1.time_ < var_150_2 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_2) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_2 + var_150_7 and arg_147_1.time_ < var_150_2 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play425051036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 425051036
		arg_151_1.duration_ = 19.3

		local var_151_0 = {
			zh = 10.4,
			ja = 19.3
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
				arg_151_0:Play425051037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1047"]) and arg_151_1.var_.actorSpriteComps1047 == nil then
				arg_151_1.var_.actorSpriteComps1047 = arg_151_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1047"]) then
				if arg_151_1.var_.actorSpriteComps1047 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1047"]) and arg_151_1.var_.actorSpriteComps1047 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_151_1.var_.actorSpriteComps1047 = nil
			end

			local var_154_2 = arg_151_1.actors_["1047"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos1047 = var_154_2.localPosition
				var_154_2.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("1047", 3)

				for iter_154_4 = 0, var_154_2.childCount - 1 do
					local var_154_3 = var_154_2:GetChild(iter_154_4)

					if var_154_3.name == "split_2" then
						var_154_3:SetAsLastSibling()
						var_154_3.gameObject:SetActive(true)

						arg_151_1.var_.actorSpriteSplit1047 = var_154_3.gameObject:GetComponent(typeof(Image))

						arg_151_1.var_.actorSpriteSplit1047:SetAlpha(0)
					end
				end
			end

			local var_154_4 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				var_154_2.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_151_1.time_ - 0) / var_154_4)

				if arg_151_1.var_.actorSpriteSplit1047 ~= nil then
					arg_151_1.var_.actorSpriteSplit1047:SetAlpha((arg_151_1.time_ - 0) / var_154_4)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				var_154_2.localPosition = Vector3.New(-38.9, -360, -319.3)

				if arg_151_1.var_.actorSpriteSplit1047 ~= nil then
					arg_151_1.var_.actorSpriteSplit1047:SetAlpha(1)
				end
			end

			local var_154_5 = 0
			local var_154_6 = 1.275

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_7 = arg_151_1:GetWordFromCfg(425051036)
				local var_154_8 = arg_151_1:FormatText(var_154_7.content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 51 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 51)

				if (51 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 51)) > 0 and var_154_6 < var_154_10 then
					arg_151_1.talkMaxDuration = var_154_10

					if var_154_10 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_5
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051036", "story_v_out_425051.awb") ~= 0 then
					local var_154_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051036", "story_v_out_425051.awb") / 1000

					if var_154_11 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_5
					end

					if var_154_7.prefab_name ~= "" and arg_151_1.actors_[var_154_7.prefab_name] ~= nil then
						local var_154_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_7.prefab_name].transform, "story_v_out_425051", "425051036", "story_v_out_425051.awb")

						arg_151_1:RecordAudio("425051036", var_154_12)
						arg_151_1:RecordAudio("425051036", var_154_12)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_425051", "425051036", "story_v_out_425051.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_425051", "425051036", "story_v_out_425051.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_13 = math.max(var_154_6, arg_151_1.talkMaxDuration)

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_13 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_5) / var_154_13

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_5 + var_154_13 and arg_151_1.time_ < var_154_5 + var_154_13 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play425051037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 425051037
		arg_155_1.duration_ = 6.97

		local var_155_0 = {
			zh = 3.166,
			ja = 6.966
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
				arg_155_0:Play425051038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1047 = arg_155_1.actors_["1047"].transform.localPosition
				arg_155_1.actors_["1047"].transform.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1047", 3)

				for iter_158_0 = 0, arg_155_1.actors_["1047"].transform.childCount - 1 do
					local var_158_0 = arg_155_1.actors_["1047"].transform:GetChild(iter_158_0)

					if var_158_0.name == "" then
						var_158_0:SetAsLastSibling()
						var_158_0.gameObject:SetActive(true)

						arg_155_1.var_.actorSpriteSplit1047 = var_158_0.gameObject:GetComponent(typeof(Image))

						arg_155_1.var_.actorSpriteSplit1047:SetAlpha(0)
					end
				end
			end

			local var_158_1 = 0.375

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["1047"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_155_1.time_ - 0) / var_158_1)

				if arg_155_1.var_.actorSpriteSplit1047 ~= nil then
					arg_155_1.var_.actorSpriteSplit1047:SetAlpha((arg_155_1.time_ - 0) / var_158_1)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["1047"].transform.localPosition = Vector3.New(-38.9, -360, -319.3)

				if arg_155_1.var_.actorSpriteSplit1047 ~= nil then
					arg_155_1.var_.actorSpriteSplit1047:SetAlpha(1)
				end
			end

			local var_158_2 = 0
			local var_158_3 = 0.375

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_4 = arg_155_1:GetWordFromCfg(425051037)
				local var_158_5 = arg_155_1:FormatText(var_158_4.content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 15 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 15)

				if (15 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_5) / 15)) > 0 and var_158_3 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051037", "story_v_out_425051.awb") ~= 0 then
					local var_158_8 = manager.audio:GetVoiceLength("story_v_out_425051", "425051037", "story_v_out_425051.awb") / 1000

					if var_158_8 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_8 + var_158_2
					end

					if var_158_4.prefab_name ~= "" and arg_155_1.actors_[var_158_4.prefab_name] ~= nil then
						local var_158_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_4.prefab_name].transform, "story_v_out_425051", "425051037", "story_v_out_425051.awb")

						arg_155_1:RecordAudio("425051037", var_158_9)
						arg_155_1:RecordAudio("425051037", var_158_9)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_425051", "425051037", "story_v_out_425051.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_425051", "425051037", "story_v_out_425051.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_10 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_10 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_10

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_10 and arg_155_1.time_ < var_158_2 + var_158_10 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.375,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play425051038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 425051038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play425051039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1047"]) and arg_159_1.var_.actorSpriteComps1047 == nil then
				arg_159_1.var_.actorSpriteComps1047 = arg_159_1.actors_["1047"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_0 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1047"]) then
				if arg_159_1.var_.actorSpriteComps1047 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps1047:ToTable()) do
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

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1047"]) and arg_159_1.var_.actorSpriteComps1047 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps1047:ToTable()) do
					if iter_162_3 then
						iter_162_3.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_159_1.var_.actorSpriteComps1047 = nil
			end

			local var_162_2 = 0
			local var_162_3 = 0.25

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_4 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(425051038).content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_6 = 10 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_4) / 10)

				if (10 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_4) / 10)) > 0 and var_162_3 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_7 and arg_159_1.time_ < var_162_2 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play425051039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 425051039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play425051040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1047 = arg_163_1.actors_["1047"].transform.localPosition
				arg_163_1.actors_["1047"].transform.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1047", 7)

				for iter_166_0 = 0, arg_163_1.actors_["1047"].transform.childCount - 1 do
					local var_166_0 = arg_163_1.actors_["1047"].transform:GetChild(iter_166_0)

					if var_166_0.name == "" or not string.find(var_166_0.name, "split") then
						var_166_0.gameObject:SetActive(true)
					else
						var_166_0.gameObject:SetActive(false)
					end
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["1047"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1047, Vector3.New(0, -2000, 0), (arg_163_1.time_ - 0) / var_166_1)
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["1047"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_166_2 = 0
			local var_166_3 = 0.975

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_4 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(425051039).content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_6 = 39 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_4) / 39)

				if (39 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_4) / 39)) > 0 and var_166_3 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_3, arg_163_1.talkMaxDuration)

			if var_166_2 <= arg_163_1.time_ and arg_163_1.time_ < var_166_2 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_2) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_2 + var_166_7 and arg_163_1.time_ < var_166_2 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play425051040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 425051040
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play425051041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0.1 < arg_167_1.time_ and arg_167_1.time_ <= 0.1 + arg_170_0 then
				arg_167_1:AudioAction("play", "effect", "se_story_side_1068", "se_story_1068_footstep", "")
			end

			local var_170_1 = 0
			local var_170_2 = 1.15

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_3 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(425051040).content)

				arg_167_1.text_.text = var_170_3

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_5 = 46 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 46)

				if (46 <= 0 and var_170_2 or var_170_2 * (utf8.len(var_170_3) / 46)) > 0 and var_170_2 < var_170_5 then
					arg_167_1.talkMaxDuration = var_170_5

					if var_170_5 + var_170_1 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + var_170_1
					end
				end

				arg_167_1.text_.text = var_170_3
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_6 = math.max(var_170_2, arg_167_1.talkMaxDuration)

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_6 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_1) / var_170_6

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_1 + var_170_6 and arg_167_1.time_ < var_170_1 + var_170_6 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play425051041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 425051041
		arg_171_1.duration_ = 7

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play425051042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_9001
			local var_174_9000

			if 1 < arg_171_1.time_ and arg_171_1.time_ <= 1 + arg_174_0 then
				local var_174_0 = arg_171_1.bgs_.ST60

				arg_171_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_174_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_174_1 = var_174_0:GetComponent("SpriteRenderer")

				if var_174_1 and var_174_1.sprite then
					local var_174_2 = 2 * (var_174_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_174_0.transform.localScale = Vector3.New(var_174_2 / var_174_1.sprite.bounds.size.y < var_174_2 * manager.ui.mainCameraCom_.aspect / var_174_1.sprite.bounds.size.x and var_174_2 * manager.ui.mainCameraCom_.aspect / var_174_1.sprite.bounds.size.x or var_174_2 / var_174_1.sprite.bounds.size.y, var_174_2 / var_174_1.sprite.bounds.size.y < var_174_2 * manager.ui.mainCameraCom_.aspect / var_174_1.sprite.bounds.size.x and var_174_2 * manager.ui.mainCameraCom_.aspect / var_174_1.sprite.bounds.size.x or var_174_2 / var_174_1.sprite.bounds.size.y, 0)
				end

				for iter_174_0, iter_174_1 in pairs(arg_171_1.bgs_) do
					if iter_174_0 ~= "ST60" then
						iter_174_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_174_3 = 0

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_3 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_4 = 1

			if var_174_3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_3 + var_174_4 then
				local var_174_5 = Color.New(0, 0, 0)

				var_174_5.a = Mathf.Lerp(0, 1, (arg_171_1.time_ - var_174_3) / var_174_4)
				arg_171_1.mask_.color = var_174_5
			end

			if arg_171_1.time_ >= var_174_3 + var_174_4 and arg_171_1.time_ < var_174_3 + var_174_4 + arg_174_0 then
				local var_174_6 = Color.New(0, 0, 0)

				var_174_6.a = 1
				arg_171_1.mask_.color = var_174_6
			end

			local var_174_7 = 1

			if 1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_7 + arg_174_0 then
				arg_171_1.mask_.enabled = true
				arg_171_1.mask_.raycastTarget = true

				arg_171_1:SetGaussion(false)
			end

			local var_174_8 = 1

			if var_174_7 <= arg_171_1.time_ and arg_171_1.time_ < var_174_7 + var_174_8 then
				local var_174_9 = Color.New(0, 0, 0)

				var_174_9.a = Mathf.Lerp(1, 0, (arg_171_1.time_ - var_174_7) / var_174_8)
				arg_171_1.mask_.color = var_174_9
			end

			if arg_171_1.time_ >= var_174_7 + var_174_8 and arg_171_1.time_ < var_174_7 + var_174_8 + arg_174_0 then
				local var_174_10 = Color.New(0, 0, 0)

				arg_171_1.mask_.enabled = false
				var_174_10.a = 0
				arg_171_1.mask_.color = var_174_10
			end

			if 1 < arg_171_1.time_ and arg_171_1.time_ <= 1 + arg_174_0 then
				local var_174_11 = arg_171_1.var_.effect10091041

				if not arg_171_1.var_.effect10091041 then
					var_174_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_vignetting"), manager.ui.mainCamera.transform)
					var_174_11.name = "1041"
					arg_171_1.var_.effect10091041 = var_174_11
				else
					var_174_11.transform:SetParent(var_174_9001)
				end

				var_174_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_174_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_171_1.time_ and arg_171_1.time_ <= 1 + arg_174_0 then
				local var_174_13 = arg_171_1.var_.effect100910411

				if not arg_171_1.var_.effect100910411 then
					var_174_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), manager.ui.mainCamera.transform)
					var_174_13.name = "10411"
					arg_171_1.var_.effect100910411 = var_174_13
				else
					var_174_13.transform:SetParent(var_174_9000)
				end

				var_174_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_174_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_171_1.frameCnt_ <= 1 then
				arg_171_1.dialog_:SetActive(false)
			end

			local var_174_15 = 2
			local var_174_16 = 0.125

			if 2 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0

				arg_171_1.dialog_:SetActive(true)

				arg_171_1.dialogCg_.alpha = 0

				local var_174_17 = LeanTween.value(arg_171_1.dialog_, 0, 1, 0.3)

				var_174_17:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_171_1.dialogCg_.alpha = arg_175_0
				end))
				var_174_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_171_1.dialog_)
					var_174_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_171_1.duration_ = arg_171_1.duration_ + 0.3

				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_18 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(425051041).content)

				arg_171_1.text_.text = var_174_18

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_20 = 5 <= 0 and var_174_16 or var_174_16 * (utf8.len(var_174_18) / 5)

				if (5 <= 0 and var_174_16 or var_174_16 * (utf8.len(var_174_18) / 5)) > 0 and var_174_16 < var_174_20 then
					arg_171_1.talkMaxDuration = var_174_20
					var_174_15 = var_174_15 + 0.3

					if var_174_20 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_20 + var_174_15
					end
				end

				arg_171_1.text_.text = var_174_18
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_21 = var_174_15 + 0.3
			local var_174_22 = math.max(var_174_16, arg_171_1.talkMaxDuration)

			if var_174_15 + 0.3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_21 + var_174_22 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_21) / var_174_22

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_21 + var_174_22 and arg_171_1.time_ < var_174_21 + var_174_22 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play425051042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 425051042
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play425051043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.775

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_1 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(425051042).content)

				arg_177_1.text_.text = var_180_1

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_3 = 31 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 31)

				if (31 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_1) / 31)) > 0 and var_180_0 < var_180_3 then
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
	Play425051043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 425051043
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play425051044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.95

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

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(425051043).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 38 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 38)

				if (38 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 38)) > 0 and var_184_0 < var_184_3 then
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
	Play425051044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 425051044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play425051045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 1.35

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(425051044).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 54 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 54)

				if (54 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 54)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play425051045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 425051045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play425051046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.4

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(425051045).content)

				arg_189_1.text_.text = var_192_1

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_3 = 16 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 16)

				if (16 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 16)) > 0 and var_192_0 < var_192_3 then
					arg_189_1.talkMaxDuration = var_192_3

					if var_192_3 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_3 + 0
					end
				end

				arg_189_1.text_.text = var_192_1
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_4 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_4

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play425051046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 425051046
		arg_193_1.duration_ = 7

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play425051047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if arg_193_1.bgs_.ST08a == nil then
				local var_196_0 = Object.Instantiate(arg_193_1.paintGo_)

				var_196_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST08a")
				var_196_0.name = "ST08a"
				var_196_0.transform.parent = arg_193_1.stage_.transform
				var_196_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.bgs_.ST08a = var_196_0
			end

			if 1 < arg_193_1.time_ and arg_193_1.time_ <= 1 + arg_196_0 then
				local var_196_1 = arg_193_1.bgs_.ST08a

				arg_193_1.bgs_.ST08a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_196_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_2 = var_196_1:GetComponent("SpriteRenderer")

				if var_196_2 and var_196_2.sprite then
					local var_196_3 = 2 * (var_196_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_196_1.transform.localScale = Vector3.New(var_196_3 / var_196_2.sprite.bounds.size.y < var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x and var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x or var_196_3 / var_196_2.sprite.bounds.size.y, var_196_3 / var_196_2.sprite.bounds.size.y < var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x and var_196_3 * manager.ui.mainCameraCom_.aspect / var_196_2.sprite.bounds.size.x or var_196_3 / var_196_2.sprite.bounds.size.y, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "ST08a" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_4 = 0

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_5 = 1

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_5 then
				local var_196_6 = Color.New(0, 0, 0)

				var_196_6.a = Mathf.Lerp(0, 1, (arg_193_1.time_ - var_196_4) / var_196_5)
				arg_193_1.mask_.color = var_196_6
			end

			if arg_193_1.time_ >= var_196_4 + var_196_5 and arg_193_1.time_ < var_196_4 + var_196_5 + arg_196_0 then
				local var_196_7 = Color.New(0, 0, 0)

				var_196_7.a = 1
				arg_193_1.mask_.color = var_196_7
			end

			local var_196_8 = 1

			if 1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_9 = 1

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_9 then
				local var_196_10 = Color.New(0, 0, 0)

				var_196_10.a = Mathf.Lerp(1, 0, (arg_193_1.time_ - var_196_8) / var_196_9)
				arg_193_1.mask_.color = var_196_10
			end

			if arg_193_1.time_ >= var_196_8 + var_196_9 and arg_193_1.time_ < var_196_8 + var_196_9 + arg_196_0 then
				local var_196_11 = Color.New(0, 0, 0)

				arg_193_1.mask_.enabled = false
				var_196_11.a = 0
				arg_193_1.mask_.color = var_196_11
			end

			local var_196_12 = 2
			local var_196_13 = 1.225

			if 2 < arg_193_1.time_ and arg_193_1.time_ <= var_196_12 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_14 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(425051046).content)

				arg_193_1.text_.text = var_196_14

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_16 = 49 <= 0 and var_196_13 or var_196_13 * (utf8.len(var_196_14) / 49)

				if (49 <= 0 and var_196_13 or var_196_13 * (utf8.len(var_196_14) / 49)) > 0 and var_196_13 < var_196_16 then
					arg_193_1.talkMaxDuration = var_196_16

					if var_196_16 + var_196_12 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_16 + var_196_12
					end
				end

				arg_193_1.text_.text = var_196_14
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_17 = math.max(var_196_13, arg_193_1.talkMaxDuration)

			if var_196_12 <= arg_193_1.time_ and arg_193_1.time_ < var_196_12 + var_196_17 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_12) / var_196_17

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_12 + var_196_17 and arg_193_1.time_ < var_196_12 + var_196_17 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play425051047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 425051047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play425051048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 1

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(425051047).content)

				arg_197_1.text_.text = var_200_1

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_3 = 40 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 40)

				if (40 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 40)) > 0 and var_200_0 < var_200_3 then
					arg_197_1.talkMaxDuration = var_200_3

					if var_200_3 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_3 + 0
					end
				end

				arg_197_1.text_.text = var_200_1
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_4 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_4

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play425051048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 425051048
		arg_201_1.duration_ = 5.7

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play425051049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_0 = 0.333333343267441

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				local var_204_1 = Color.New(0, 0, 0)

				var_204_1.a = Mathf.Lerp(0, 1, (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.mask_.color = var_204_1
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				local var_204_2 = Color.New(0, 0, 0)

				var_204_2.a = 1
				arg_201_1.mask_.color = var_204_2
			end

			local var_204_3 = 0.333333343267441

			if 0.333333343267441 < arg_201_1.time_ and arg_201_1.time_ <= var_204_3 + arg_204_0 then
				arg_201_1.mask_.enabled = true
				arg_201_1.mask_.raycastTarget = true

				arg_201_1:SetGaussion(false)
			end

			local var_204_4 = 0.366666656732559

			if var_204_3 <= arg_201_1.time_ and arg_201_1.time_ < var_204_3 + var_204_4 then
				local var_204_5 = Color.New(0, 0, 0)

				var_204_5.a = Mathf.Lerp(1, 0, (arg_201_1.time_ - var_204_3) / var_204_4)
				arg_201_1.mask_.color = var_204_5
			end

			if arg_201_1.time_ >= var_204_3 + var_204_4 and arg_201_1.time_ < var_204_3 + var_204_4 + arg_204_0 then
				local var_204_6 = Color.New(0, 0, 0)

				arg_201_1.mask_.enabled = false
				var_204_6.a = 0
				arg_201_1.mask_.color = var_204_6
			end

			if 0.333333343267441 < arg_201_1.time_ and arg_201_1.time_ <= 0.333333343267441 + arg_204_0 then
				if arg_201_1.var_.effect10091041 then
					Object.Destroy(arg_201_1.var_.effect10091041)

					arg_201_1.var_.effect10091041 = nil
				end
			end

			if 0.333333343267441 < arg_201_1.time_ and arg_201_1.time_ <= 0.333333343267441 + arg_204_0 then
				if arg_201_1.var_.effect100910411 then
					Object.Destroy(arg_201_1.var_.effect100910411)

					arg_201_1.var_.effect100910411 = nil
				end
			end

			local var_204_9 = 0.7
			local var_204_10 = 0.4

			if 0.7 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_11 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(425051048).content)

				arg_201_1.text_.text = var_204_11

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_13 = 16 <= 0 and var_204_10 or var_204_10 * (utf8.len(var_204_11) / 16)

				if (16 <= 0 and var_204_10 or var_204_10 * (utf8.len(var_204_11) / 16)) > 0 and var_204_10 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_9 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_9
					end
				end

				arg_201_1.text_.text = var_204_11
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_14 = math.max(var_204_10, arg_201_1.talkMaxDuration)

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_14 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_9) / var_204_14

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_9 + var_204_14 and arg_201_1.time_ < var_204_9 + var_204_14 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play425051049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 425051049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play425051050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.15

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(425051049).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 6 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 6)

				if (6 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 6)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play425051050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 425051050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play425051051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_212_0 = 0.233333333333333

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				local var_212_1, var_212_2 = math.modf((arg_209_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_212_2 * 0.2, var_212_2 * 0.2, var_212_2 * 0.2) + arg_209_1.var_.shakeOldPos
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				manager.ui.mainCamera.transform.localPosition = arg_209_1.var_.shakeOldPos
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:AudioAction("play", "effect", "se_story_147", "se_story_147_light_button_off", "")
			end

			local var_212_4 = 0
			local var_212_5 = 0.233333333333333

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_4 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_6 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(425051050).content)

				arg_209_1.text_.text = var_212_6

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_8 = 3 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_6) / 3)

				if (3 <= 0 and var_212_5 or var_212_5 * (utf8.len(var_212_6) / 3)) > 0 and var_212_5 < var_212_8 then
					arg_209_1.talkMaxDuration = var_212_8

					if var_212_8 + var_212_4 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_4
					end
				end

				arg_209_1.text_.text = var_212_6
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_9 = math.max(var_212_5, arg_209_1.talkMaxDuration)

			if var_212_4 <= arg_209_1.time_ and arg_209_1.time_ < var_212_4 + var_212_9 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_4) / var_212_9

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_4 + var_212_9 and arg_209_1.time_ < var_212_4 + var_212_9 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play425051051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 425051051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play425051052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.225

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(425051051).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 9 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 9)

				if (9 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 9)) > 0 and var_216_0 < var_216_3 then
					arg_213_1.talkMaxDuration = var_216_3

					if var_216_3 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_3 + 0
					end
				end

				arg_213_1.text_.text = var_216_1
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_4 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_4

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play425051052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 425051052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play425051053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 1.3

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(425051052).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 52 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 52)

				if (52 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 52)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play425051053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 425051053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play425051054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.525

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_1 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(425051053).content)

				arg_221_1.text_.text = var_224_1

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_3 = 21 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 21)

				if (21 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 21)) > 0 and var_224_0 < var_224_3 then
					arg_221_1.talkMaxDuration = var_224_3

					if var_224_3 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_3 + 0
					end
				end

				arg_221_1.text_.text = var_224_1
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_4 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_4

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play425051054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 425051054
		arg_225_1.duration_ = 1.43

		local var_225_0 = {
			zh = 1.1,
			ja = 1.433
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
				arg_225_0:Play425051055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.1

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_1 = arg_225_1:GetWordFromCfg(425051054)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 4 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 4)

				if (4 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 4)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051054", "story_v_out_425051.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_425051", "425051054", "story_v_out_425051.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_425051", "425051054", "story_v_out_425051.awb")

						arg_225_1:RecordAudio("425051054", var_228_6)
						arg_225_1:RecordAudio("425051054", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_425051", "425051054", "story_v_out_425051.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_425051", "425051054", "story_v_out_425051.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 15,
				className = "StoryShakeNode",
				duration = 0.333333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(5, 5, 5)
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play425051055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 425051055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play425051056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0.05

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(425051055).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 2 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 2)

				if (2 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 2)) > 0 and var_232_0 < var_232_3 then
					arg_229_1.talkMaxDuration = var_232_3

					if var_232_3 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_3 + 0
					end
				end

				arg_229_1.text_.text = var_232_1
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_4 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_4

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play425051056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 425051056
		arg_233_1.duration_ = 7

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play425051057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_0 = 1

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				local var_236_1 = Color.New(0, 0, 0)

				var_236_1.a = Mathf.Lerp(0, 1, (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.mask_.color = var_236_1
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				local var_236_2 = Color.New(0, 0, 0)

				var_236_2.a = 1
				arg_233_1.mask_.color = var_236_2
			end

			local var_236_3 = 1

			if 1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_3 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_4 = 1

			if var_236_3 <= arg_233_1.time_ and arg_233_1.time_ < var_236_3 + var_236_4 then
				local var_236_5 = Color.New(0, 0, 0)

				var_236_5.a = Mathf.Lerp(1, 0, (arg_233_1.time_ - var_236_3) / var_236_4)
				arg_233_1.mask_.color = var_236_5
			end

			if arg_233_1.time_ >= var_236_3 + var_236_4 and arg_233_1.time_ < var_236_3 + var_236_4 + arg_236_0 then
				local var_236_6 = Color.New(0, 0, 0)

				arg_233_1.mask_.enabled = false
				var_236_6.a = 0
				arg_233_1.mask_.color = var_236_6
			end

			local var_236_7 = "STblack"

			if arg_233_1.bgs_.STblack == nil then
				local var_236_8 = Object.Instantiate(arg_233_1.paintGo_)

				var_236_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_236_7)
				var_236_8.name = var_236_7
				var_236_8.transform.parent = arg_233_1.stage_.transform
				var_236_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.bgs_[var_236_7] = var_236_8
			end

			if 1 < arg_233_1.time_ and arg_233_1.time_ <= 1 + arg_236_0 then
				local var_236_9 = arg_233_1.bgs_.STblack

				arg_233_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_236_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_10 = var_236_9:GetComponent("SpriteRenderer")

				if var_236_10 and var_236_10.sprite then
					local var_236_11 = 2 * (var_236_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_236_9.transform.localScale = Vector3.New(var_236_11 / var_236_10.sprite.bounds.size.y < var_236_11 * manager.ui.mainCameraCom_.aspect / var_236_10.sprite.bounds.size.x and var_236_11 * manager.ui.mainCameraCom_.aspect / var_236_10.sprite.bounds.size.x or var_236_11 / var_236_10.sprite.bounds.size.y, var_236_11 / var_236_10.sprite.bounds.size.y < var_236_11 * manager.ui.mainCameraCom_.aspect / var_236_10.sprite.bounds.size.x and var_236_11 * manager.ui.mainCameraCom_.aspect / var_236_10.sprite.bounds.size.x or var_236_11 / var_236_10.sprite.bounds.size.y, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "STblack" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_12 = 2
			local var_236_13 = 0.1

			if 2 < arg_233_1.time_ and arg_233_1.time_ <= var_236_12 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_14 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_14:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_15 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(425051056).content)

				arg_233_1.text_.text = var_236_15

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_17 = 4 <= 0 and var_236_13 or var_236_13 * (utf8.len(var_236_15) / 4)

				if (4 <= 0 and var_236_13 or var_236_13 * (utf8.len(var_236_15) / 4)) > 0 and var_236_13 < var_236_17 then
					arg_233_1.talkMaxDuration = var_236_17
					var_236_12 = var_236_12 + 0.3

					if var_236_17 + var_236_12 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_17 + var_236_12
					end
				end

				arg_233_1.text_.text = var_236_15
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_18 = var_236_12 + 0.3
			local var_236_19 = math.max(var_236_13, arg_233_1.talkMaxDuration)

			if var_236_12 + 0.3 <= arg_233_1.time_ and arg_233_1.time_ < var_236_18 + var_236_19 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_18) / var_236_19

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_18 + var_236_19 and arg_233_1.time_ < var_236_18 + var_236_19 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 419171,
				charCount = 4,
				enableLayoutChange = true,
				duration = 1,
				groupID = "1",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 110,
					fontAssetPath = "Fonts/SourceHanSerifCN-Bold-3.0",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					startAlpha = 0,
					endAlpha = 1,
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.ALPHA
				}
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play425051057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 425051057
		arg_239_1.duration_ = 1.6

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play425051058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			return
		end

		arg_239_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425051057,
				charCount = 24,
				enableLayoutChange = true,
				duration = 1.6,
				groupID = "2",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play425051058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 425051058
		arg_243_1.duration_ = 2.4

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play425051059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			return
		end

		arg_243_1.nodeConfigList_ = {
			{
				groupID = "2",
				duration = 1.6,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 425051058,
				charCount = 36,
				enableLayoutChange = true,
				duration = 2.4,
				groupID = "3",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play425051059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 425051059
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play425051060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.05

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_1 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(425051059).content)

				arg_247_1.text_.text = var_250_1

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_3 = 2 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 2)

				if (2 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_1) / 2)) > 0 and var_250_0 < var_250_3 then
					arg_247_1.talkMaxDuration = var_250_3

					if var_250_3 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_3 + 0
					end
				end

				arg_247_1.text_.text = var_250_1
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_4 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_4

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				groupID = "3",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play425051060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 425051060
		arg_251_1.duration_ = 7

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play425051061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_0 = 1

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				local var_254_1 = Color.New(0, 0, 0)

				var_254_1.a = Mathf.Lerp(0, 1, (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.mask_.color = var_254_1
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				local var_254_2 = Color.New(0, 0, 0)

				var_254_2.a = 1
				arg_251_1.mask_.color = var_254_2
			end

			local var_254_3 = 1

			if 1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_3 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_4 = 1

			if var_254_3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_3 + var_254_4 then
				local var_254_5 = Color.New(0, 0, 0)

				var_254_5.a = Mathf.Lerp(1, 0, (arg_251_1.time_ - var_254_3) / var_254_4)
				arg_251_1.mask_.color = var_254_5
			end

			if arg_251_1.time_ >= var_254_3 + var_254_4 and arg_251_1.time_ < var_254_3 + var_254_4 + arg_254_0 then
				local var_254_6 = Color.New(0, 0, 0)

				arg_251_1.mask_.enabled = false
				var_254_6.a = 0
				arg_251_1.mask_.color = var_254_6
			end

			if 1 < arg_251_1.time_ and arg_251_1.time_ <= 1 + arg_254_0 then
				local var_254_7 = arg_251_1.bgs_.ST08a

				arg_251_1.bgs_.ST08a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_254_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_254_8 = var_254_7:GetComponent("SpriteRenderer")

				if var_254_8 and var_254_8.sprite then
					local var_254_9 = 2 * (var_254_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_254_7.transform.localScale = Vector3.New(var_254_9 / var_254_8.sprite.bounds.size.y < var_254_9 * manager.ui.mainCameraCom_.aspect / var_254_8.sprite.bounds.size.x and var_254_9 * manager.ui.mainCameraCom_.aspect / var_254_8.sprite.bounds.size.x or var_254_9 / var_254_8.sprite.bounds.size.y, var_254_9 / var_254_8.sprite.bounds.size.y < var_254_9 * manager.ui.mainCameraCom_.aspect / var_254_8.sprite.bounds.size.x and var_254_9 * manager.ui.mainCameraCom_.aspect / var_254_8.sprite.bounds.size.x or var_254_9 / var_254_8.sprite.bounds.size.y, 0)
				end

				for iter_254_0, iter_254_1 in pairs(arg_251_1.bgs_) do
					if iter_254_0 ~= "ST08a" then
						iter_254_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_251_1.frameCnt_ <= 1 then
				arg_251_1.dialog_:SetActive(false)
			end

			local var_254_10 = 2
			local var_254_11 = 1.35

			if 2 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				arg_251_1.dialog_:SetActive(true)

				arg_251_1.dialogCg_.alpha = 0

				local var_254_12 = LeanTween.value(arg_251_1.dialog_, 0, 1, 0.3)

				var_254_12:setOnUpdate(LuaHelper.FloatAction(function(arg_255_0)
					arg_251_1.dialogCg_.alpha = arg_255_0
				end))
				var_254_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_251_1.dialog_)
					var_254_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_251_1.duration_ = arg_251_1.duration_ + 0.3

				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_13 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(425051060).content)

				arg_251_1.text_.text = var_254_13

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_15 = 54 <= 0 and var_254_11 or var_254_11 * (utf8.len(var_254_13) / 54)

				if (54 <= 0 and var_254_11 or var_254_11 * (utf8.len(var_254_13) / 54)) > 0 and var_254_11 < var_254_15 then
					arg_251_1.talkMaxDuration = var_254_15
					var_254_10 = var_254_10 + 0.3

					if var_254_15 + var_254_10 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_15 + var_254_10
					end
				end

				arg_251_1.text_.text = var_254_13
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_16 = var_254_10 + 0.3
			local var_254_17 = math.max(var_254_11, arg_251_1.talkMaxDuration)

			if var_254_10 + 0.3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_16 + var_254_17 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_16) / var_254_17

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_16 + var_254_17 and arg_251_1.time_ < var_254_16 + var_254_17 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				groupID = "1",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play425051061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 425051061
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play425051062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0.1

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(425051061).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 4 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 4)

				if (4 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 4)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play425051062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 425051062
		arg_261_1.duration_ = 2.2

		local var_261_0 = {
			zh = 2.066,
			ja = 2.2
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
				arg_261_0:Play425051063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.166666666666667

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_1 = arg_261_1:GetWordFromCfg(425051062)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 2 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 2)

				if (2 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 2)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051062", "story_v_out_425051.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_425051", "425051062", "story_v_out_425051.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_425051", "425051062", "story_v_out_425051.awb")

						arg_261_1:RecordAudio("425051062", var_264_6)
						arg_261_1:RecordAudio("425051062", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_425051", "425051062", "story_v_out_425051.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_425051", "425051062", "story_v_out_425051.awb")
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
	Play425051063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 425051063
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play425051064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.5

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

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(425051063).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 20 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 20)

				if (20 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 20)) > 0 and var_268_0 < var_268_3 then
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
	Play425051064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 425051064
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play425051065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.7

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(425051064).content)

				arg_269_1.text_.text = var_272_1

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_3 = 28 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 28)

				if (28 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_1) / 28)) > 0 and var_272_0 < var_272_3 then
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
	Play425051065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 425051065
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play425051066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 1.775

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_1 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(425051065).content)

				arg_273_1.text_.text = var_276_1

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_3 = 71 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 71)

				if (71 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_1) / 71)) > 0 and var_276_0 < var_276_3 then
					arg_273_1.talkMaxDuration = var_276_3

					if var_276_3 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_3 + 0
					end
				end

				arg_273_1.text_.text = var_276_1
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_4 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_4 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_4

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_4 and arg_273_1.time_ < 0 + var_276_4 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play425051066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 425051066
		arg_277_1.duration_ = 3.57

		local var_277_0 = {
			zh = 1.833,
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
				arg_277_0:Play425051067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0.075

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:GetWordFromCfg(425051066)
				local var_280_2 = arg_277_1:FormatText(var_280_1.content)

				arg_277_1.text_.text = var_280_2

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 3 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 3)

				if (3 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_2) / 3)) > 0 and var_280_0 < var_280_4 then
					arg_277_1.talkMaxDuration = var_280_4

					if var_280_4 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_4 + 0
					end
				end

				arg_277_1.text_.text = var_280_2
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051066", "story_v_out_425051.awb") ~= 0 then
					local var_280_5 = manager.audio:GetVoiceLength("story_v_out_425051", "425051066", "story_v_out_425051.awb") / 1000

					if var_280_5 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + 0
					end

					if var_280_1.prefab_name ~= "" and arg_277_1.actors_[var_280_1.prefab_name] ~= nil then
						local var_280_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_1.prefab_name].transform, "story_v_out_425051", "425051066", "story_v_out_425051.awb")

						arg_277_1:RecordAudio("425051066", var_280_6)
						arg_277_1:RecordAudio("425051066", var_280_6)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_425051", "425051066", "story_v_out_425051.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_425051", "425051066", "story_v_out_425051.awb")
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
	Play425051067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 425051067
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play425051068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 1.1

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(425051067).content)

				arg_281_1.text_.text = var_284_1

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_3 = 44 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 44)

				if (44 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 44)) > 0 and var_284_0 < var_284_3 then
					arg_281_1.talkMaxDuration = var_284_3

					if var_284_3 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_3 + 0
					end
				end

				arg_281_1.text_.text = var_284_1
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_4 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_4

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play425051068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 425051068
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play425051069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0.1 < arg_285_1.time_ and arg_285_1.time_ <= 0.1 + arg_288_0 then
				arg_285_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_clothhit", "")
			end

			if 0.3 < arg_285_1.time_ and arg_285_1.time_ <= 0.3 + arg_288_0 then
				arg_285_1:AudioAction("play", "effect", "se_story_144", "se_story_144_door_close", "")
			end

			local var_288_2 = 0
			local var_288_3 = 1.525

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_2 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_4 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(425051068).content)

				arg_285_1.text_.text = var_288_4

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_6 = 61 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_4) / 61)

				if (61 <= 0 and var_288_3 or var_288_3 * (utf8.len(var_288_4) / 61)) > 0 and var_288_3 < var_288_6 then
					arg_285_1.talkMaxDuration = var_288_6

					if var_288_6 + var_288_2 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_6 + var_288_2
					end
				end

				arg_285_1.text_.text = var_288_4
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_3, arg_285_1.talkMaxDuration)

			if var_288_2 <= arg_285_1.time_ and arg_285_1.time_ < var_288_2 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_2) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_2 + var_288_7 and arg_285_1.time_ < var_288_2 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play425051069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 425051069
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play425051070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.225

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(425051069).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 9 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 9)

				if (9 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 9)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play425051070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 425051070
		arg_293_1.duration_ = 8.43

		local var_293_0 = {
			zh = 6.933,
			ja = 8.433
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play425051071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if arg_293_1.bgs_.ST20 == nil then
				local var_296_0 = Object.Instantiate(arg_293_1.paintGo_)

				var_296_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST20")
				var_296_0.name = "ST20"
				var_296_0.transform.parent = arg_293_1.stage_.transform
				var_296_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_293_1.bgs_.ST20 = var_296_0
			end

			if 2 < arg_293_1.time_ and arg_293_1.time_ <= 2 + arg_296_0 then
				local var_296_1 = arg_293_1.bgs_.ST20

				arg_293_1.bgs_.ST20.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_296_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_296_2 = var_296_1:GetComponent("SpriteRenderer")

				if var_296_2 and var_296_2.sprite then
					local var_296_3 = 2 * (var_296_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_296_1.transform.localScale = Vector3.New(var_296_3 / var_296_2.sprite.bounds.size.y < var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x and var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x or var_296_3 / var_296_2.sprite.bounds.size.y, var_296_3 / var_296_2.sprite.bounds.size.y < var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x and var_296_3 * manager.ui.mainCameraCom_.aspect / var_296_2.sprite.bounds.size.x or var_296_3 / var_296_2.sprite.bounds.size.y, 0)
				end

				for iter_296_0, iter_296_1 in pairs(arg_293_1.bgs_) do
					if iter_296_0 ~= "ST20" then
						iter_296_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_296_4 = 4

			if 4 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.allBtn_.enabled = false
			end

			if arg_293_1.time_ >= var_296_4 + 0.3 and arg_293_1.time_ < var_296_4 + 0.3 + arg_296_0 then
				arg_293_1.allBtn_.enabled = true
			end

			local var_296_5 = 0

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_6 = 2

			if var_296_5 <= arg_293_1.time_ and arg_293_1.time_ < var_296_5 + var_296_6 then
				local var_296_7 = Color.New(0, 0, 0)

				var_296_7.a = Mathf.Lerp(0, 1, (arg_293_1.time_ - var_296_5) / var_296_6)
				arg_293_1.mask_.color = var_296_7
			end

			if arg_293_1.time_ >= var_296_5 + var_296_6 and arg_293_1.time_ < var_296_5 + var_296_6 + arg_296_0 then
				local var_296_8 = Color.New(0, 0, 0)

				var_296_8.a = 1
				arg_293_1.mask_.color = var_296_8
			end

			local var_296_9 = 2

			if 2 < arg_293_1.time_ and arg_293_1.time_ <= var_296_9 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_10 = 2

			if var_296_9 <= arg_293_1.time_ and arg_293_1.time_ < var_296_9 + var_296_10 then
				local var_296_11 = Color.New(0, 0, 0)

				var_296_11.a = Mathf.Lerp(1, 0, (arg_293_1.time_ - var_296_9) / var_296_10)
				arg_293_1.mask_.color = var_296_11
			end

			if arg_293_1.time_ >= var_296_9 + var_296_10 and arg_293_1.time_ < var_296_9 + var_296_10 + arg_296_0 then
				local var_296_12 = Color.New(0, 0, 0)

				arg_293_1.mask_.enabled = false
				var_296_12.a = 0
				arg_293_1.mask_.color = var_296_12
			end

			local var_296_13 = "1036"

			if arg_293_1.actors_["1036"] == nil then
				local var_296_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1036")

				if not isNil(var_296_14) then
					local var_296_15 = Object.Instantiate(var_296_14, arg_293_1.canvasGo_.transform)

					var_296_15.transform:SetSiblingIndex(1)

					var_296_15.name = var_296_13
					var_296_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_293_1.actors_[var_296_13] = var_296_15

					if arg_293_1.isInRecall_ then
						for iter_296_2, iter_296_3 in ipairs((var_296_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_296_3.color = arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_296_16 = arg_293_1.actors_["1036"]

			if 3.8 < arg_293_1.time_ and arg_293_1.time_ <= 3.8 + arg_296_0 and not isNil(var_296_16) and arg_293_1.var_.actorSpriteComps1036 == nil then
				arg_293_1.var_.actorSpriteComps1036 = var_296_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_17 = 0.2

			if 3.8 <= arg_293_1.time_ and arg_293_1.time_ < 3.8 + var_296_17 and not isNil(var_296_16) then
				if arg_293_1.var_.actorSpriteComps1036 then
					for iter_296_4, iter_296_5 in pairs(arg_293_1.var_.actorSpriteComps1036:ToTable()) do
						if iter_296_5 then
							if arg_293_1.isInRecall_ then
								iter_296_5.color = Color.New(Mathf.Lerp(iter_296_5.color.r, arg_293_1.hightColor1.r, (arg_293_1.time_ - 3.8) / var_296_17), Mathf.Lerp(iter_296_5.color.g, arg_293_1.hightColor1.g, (arg_293_1.time_ - 3.8) / var_296_17), (Mathf.Lerp(iter_296_5.color.b, arg_293_1.hightColor1.b, (arg_293_1.time_ - 3.8) / var_296_17)))
							else
								local var_296_18 = Mathf.Lerp(iter_296_5.color.r, 1, (arg_293_1.time_ - 3.8) / var_296_17)

								iter_296_5.color = Color.New(var_296_18, var_296_18, var_296_18)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 3.8 + var_296_17 and arg_293_1.time_ < 3.8 + var_296_17 + arg_296_0 and not isNil(var_296_16) and arg_293_1.var_.actorSpriteComps1036 then
				for iter_296_6, iter_296_7 in pairs(arg_293_1.var_.actorSpriteComps1036:ToTable()) do
					if iter_296_7 then
						iter_296_7.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_293_1.var_.actorSpriteComps1036 = nil
			end

			local var_296_19 = arg_293_1.actors_["1036"].transform

			if 3.8 < arg_293_1.time_ and arg_293_1.time_ <= 3.8 + arg_296_0 then
				arg_293_1.var_.moveOldPos1036 = var_296_19.localPosition
				var_296_19.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1036", 3)

				for iter_296_8 = 0, var_296_19.childCount - 1 do
					local var_296_20 = var_296_19:GetChild(iter_296_8)

					if var_296_20.name == "" or not string.find(var_296_20.name, "split") then
						var_296_20.gameObject:SetActive(true)
					else
						var_296_20.gameObject:SetActive(false)
					end
				end
			end

			local var_296_21 = 0.001

			if 3.8 <= arg_293_1.time_ and arg_293_1.time_ < 3.8 + var_296_21 then
				var_296_19.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1036, Vector3.New(0, -388, -250), (arg_293_1.time_ - 3.8) / var_296_21)
			end

			if arg_293_1.time_ >= 3.8 + var_296_21 and arg_293_1.time_ < 3.8 + var_296_21 + arg_296_0 then
				var_296_19.localPosition = Vector3.New(0, -388, -250)
			end

			if 0.233333333333333 < arg_293_1.time_ and arg_293_1.time_ <= 0.233333333333333 + arg_296_0 then
				arg_293_1:AudioAction("stop", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 1.73333333333333 < arg_293_1.time_ and arg_293_1.time_ <= 1.73333333333333 + arg_296_0 then
				arg_293_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if arg_293_1.frameCnt_ <= 1 then
				arg_293_1.dialog_:SetActive(false)
			end

			local var_296_24 = 4
			local var_296_25 = 0.375

			if 4 < arg_293_1.time_ and arg_293_1.time_ <= var_296_24 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0

				arg_293_1.dialog_:SetActive(true)

				arg_293_1.dialogCg_.alpha = 0

				local var_296_26 = LeanTween.value(arg_293_1.dialog_, 0, 1, 0.3)

				var_296_26:setOnUpdate(LuaHelper.FloatAction(function(arg_297_0)
					arg_293_1.dialogCg_.alpha = arg_297_0
				end))
				var_296_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_293_1.dialog_)
					var_296_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_293_1.duration_ = arg_293_1.duration_ + 0.3

				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_27 = arg_293_1:GetWordFromCfg(425051070)
				local var_296_28 = arg_293_1:FormatText(var_296_27.content)

				arg_293_1.text_.text = var_296_28

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_30 = 15 <= 0 and var_296_25 or var_296_25 * (utf8.len(var_296_28) / 15)

				if (15 <= 0 and var_296_25 or var_296_25 * (utf8.len(var_296_28) / 15)) > 0 and var_296_25 < var_296_30 then
					arg_293_1.talkMaxDuration = var_296_30
					var_296_24 = var_296_24 + 0.3

					if var_296_30 + var_296_24 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_30 + var_296_24
					end
				end

				arg_293_1.text_.text = var_296_28
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051070", "story_v_out_425051.awb") ~= 0 then
					local var_296_31 = manager.audio:GetVoiceLength("story_v_out_425051", "425051070", "story_v_out_425051.awb") / 1000

					if var_296_31 + var_296_24 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_31 + var_296_24
					end

					if var_296_27.prefab_name ~= "" and arg_293_1.actors_[var_296_27.prefab_name] ~= nil then
						local var_296_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_27.prefab_name].transform, "story_v_out_425051", "425051070", "story_v_out_425051.awb")

						arg_293_1:RecordAudio("425051070", var_296_32)
						arg_293_1:RecordAudio("425051070", var_296_32)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_425051", "425051070", "story_v_out_425051.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_425051", "425051070", "story_v_out_425051.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_33 = var_296_24 + 0.3
			local var_296_34 = math.max(var_296_25, arg_293_1.talkMaxDuration)

			if var_296_24 + 0.3 <= arg_293_1.time_ and arg_293_1.time_ < var_296_33 + var_296_34 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_33) / var_296_34

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_33 + var_296_34 and arg_293_1.time_ < var_296_33 + var_296_34 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play425051071 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 425051071
		arg_299_1.duration_ = 6

		local var_299_0 = {
			zh = 6,
			ja = 5.433
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
				arg_299_0:Play425051072(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.925

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:GetWordFromCfg(425051071)
				local var_302_2 = arg_299_1:FormatText(var_302_1.content)

				arg_299_1.text_.text = var_302_2

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 37 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 37)

				if (37 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 37)) > 0 and var_302_0 < var_302_4 then
					arg_299_1.talkMaxDuration = var_302_4

					if var_302_4 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_4 + 0
					end
				end

				arg_299_1.text_.text = var_302_2
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051071", "story_v_out_425051.awb") ~= 0 then
					local var_302_5 = manager.audio:GetVoiceLength("story_v_out_425051", "425051071", "story_v_out_425051.awb") / 1000

					if var_302_5 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + 0
					end

					if var_302_1.prefab_name ~= "" and arg_299_1.actors_[var_302_1.prefab_name] ~= nil then
						local var_302_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_1.prefab_name].transform, "story_v_out_425051", "425051071", "story_v_out_425051.awb")

						arg_299_1:RecordAudio("425051071", var_302_6)
						arg_299_1:RecordAudio("425051071", var_302_6)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_425051", "425051071", "story_v_out_425051.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_425051", "425051071", "story_v_out_425051.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_7 and arg_299_1.time_ < 0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play425051072 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 425051072
		arg_303_1.duration_ = 2.07

		local var_303_0 = {
			zh = 2.066,
			ja = 1.9
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play425051073(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1037"]) and arg_303_1.var_.actorSpriteComps1037 == nil then
				arg_303_1.var_.actorSpriteComps1037 = arg_303_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_0 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1037"]) then
				if arg_303_1.var_.actorSpriteComps1037 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								iter_306_1.color = Color.New(Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor1.r, (arg_303_1.time_ - 0) / var_306_0), Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor1.g, (arg_303_1.time_ - 0) / var_306_0), (Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor1.b, (arg_303_1.time_ - 0) / var_306_0)))
							else
								local var_306_1 = Mathf.Lerp(iter_306_1.color.r, 1, (arg_303_1.time_ - 0) / var_306_0)

								iter_306_1.color = Color.New(var_306_1, var_306_1, var_306_1)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1037"]) and arg_303_1.var_.actorSpriteComps1037 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_306_3 then
						iter_306_3.color = arg_303_1.isInRecall_ and (arg_303_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_303_1.var_.actorSpriteComps1037 = nil
			end

			local var_306_2 = arg_303_1.actors_["1037"].transform

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1037 = var_306_2.localPosition
				var_306_2.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("1037", 3)

				for iter_306_4 = 0, var_306_2.childCount - 1 do
					local var_306_3 = var_306_2:GetChild(iter_306_4)

					if var_306_3.name == "" or not string.find(var_306_3.name, "split") then
						var_306_3.gameObject:SetActive(true)
					else
						var_306_3.gameObject:SetActive(false)
					end
				end
			end

			local var_306_4 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				var_306_2.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_303_1.time_ - 0) / var_306_4)
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				var_306_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_306_5 = arg_303_1.actors_["1036"].transform

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1036 = var_306_5.localPosition
				var_306_5.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("1036", 7)

				for iter_306_5 = 0, var_306_5.childCount - 1 do
					local var_306_6 = var_306_5:GetChild(iter_306_5)

					if var_306_6.name == "" or not string.find(var_306_6.name, "split") then
						var_306_6.gameObject:SetActive(true)
					else
						var_306_6.gameObject:SetActive(false)
					end
				end
			end

			local var_306_7 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_7 then
				var_306_5.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1036, Vector3.New(0, -2000, 0), (arg_303_1.time_ - 0) / var_306_7)
			end

			if arg_303_1.time_ >= 0 + var_306_7 and arg_303_1.time_ < 0 + var_306_7 + arg_306_0 then
				var_306_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_306_8 = 0
			local var_306_9 = 0.05

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_8 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[1435].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_10 = arg_303_1:GetWordFromCfg(425051072)
				local var_306_11 = arg_303_1:FormatText(var_306_10.content)

				arg_303_1.text_.text = var_306_11

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_13 = 2 <= 0 and var_306_9 or var_306_9 * (utf8.len(var_306_11) / 2)

				if (2 <= 0 and var_306_9 or var_306_9 * (utf8.len(var_306_11) / 2)) > 0 and var_306_9 < var_306_13 then
					arg_303_1.talkMaxDuration = var_306_13

					if var_306_13 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_13 + var_306_8
					end
				end

				arg_303_1.text_.text = var_306_11
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051072", "story_v_out_425051.awb") ~= 0 then
					local var_306_14 = manager.audio:GetVoiceLength("story_v_out_425051", "425051072", "story_v_out_425051.awb") / 1000

					if var_306_14 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_14 + var_306_8
					end

					if var_306_10.prefab_name ~= "" and arg_303_1.actors_[var_306_10.prefab_name] ~= nil then
						local var_306_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_10.prefab_name].transform, "story_v_out_425051", "425051072", "story_v_out_425051.awb")

						arg_303_1:RecordAudio("425051072", var_306_15)
						arg_303_1:RecordAudio("425051072", var_306_15)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_425051", "425051072", "story_v_out_425051.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_425051", "425051072", "story_v_out_425051.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_16 = math.max(var_306_9, arg_303_1.talkMaxDuration)

			if var_306_8 <= arg_303_1.time_ and arg_303_1.time_ < var_306_8 + var_306_16 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_8) / var_306_16

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_8 + var_306_16 and arg_303_1.time_ < var_306_8 + var_306_16 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1036",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play425051073 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 425051073
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play425051074(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1037 = arg_307_1.actors_["1037"].transform.localPosition
				arg_307_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("1037", 7)

				for iter_310_0 = 0, arg_307_1.actors_["1037"].transform.childCount - 1 do
					local var_310_0 = arg_307_1.actors_["1037"].transform:GetChild(iter_310_0)

					if var_310_0.name == "" or not string.find(var_310_0.name, "split") then
						var_310_0.gameObject:SetActive(true)
					else
						var_310_0.gameObject:SetActive(false)
					end
				end
			end

			local var_310_1 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_1 then
				arg_307_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_307_1.time_ - 0) / var_310_1)
			end

			if arg_307_1.time_ >= 0 + var_310_1 and arg_307_1.time_ < 0 + var_310_1 + arg_310_0 then
				arg_307_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_310_2 = 0
			local var_310_3 = 1.175

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_4 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(425051073).content)

				arg_307_1.text_.text = var_310_4

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_6 = 47 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_4) / 47)

				if (47 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_4) / 47)) > 0 and var_310_3 < var_310_6 then
					arg_307_1.talkMaxDuration = var_310_6

					if var_310_6 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_6 + var_310_2
					end
				end

				arg_307_1.text_.text = var_310_4
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_3, arg_307_1.talkMaxDuration)

			if var_310_2 <= arg_307_1.time_ and arg_307_1.time_ < var_310_2 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_2) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_2 + var_310_7 and arg_307_1.time_ < var_310_2 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play425051074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 425051074
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play425051075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 1.4

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

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(425051074).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 56 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 56)

				if (56 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 56)) > 0 and var_314_0 < var_314_3 then
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
	Play425051075 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 425051075
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play425051076(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0.05 < arg_315_1.time_ and arg_315_1.time_ <= 0.05 + arg_318_0 then
				arg_315_1:AudioAction("play", "effect", "se_story_17", "se_story_17_door_close02", "")
			end

			local var_318_1 = 0
			local var_318_2 = 1.05

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_1 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_3 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(425051075).content)

				arg_315_1.text_.text = var_318_3

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 42 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 42)

				if (42 <= 0 and var_318_2 or var_318_2 * (utf8.len(var_318_3) / 42)) > 0 and var_318_2 < var_318_5 then
					arg_315_1.talkMaxDuration = var_318_5

					if var_318_5 + var_318_1 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + var_318_1
					end
				end

				arg_315_1.text_.text = var_318_3
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_6 = math.max(var_318_2, arg_315_1.talkMaxDuration)

			if var_318_1 <= arg_315_1.time_ and arg_315_1.time_ < var_318_1 + var_318_6 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_1) / var_318_6

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_1 + var_318_6 and arg_315_1.time_ < var_318_1 + var_318_6 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play425051076 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 425051076
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play425051077(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0.125

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_1 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(425051076).content)

				arg_319_1.text_.text = var_322_1

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_3 = 5 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 5)

				if (5 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 5)) > 0 and var_322_0 < var_322_3 then
					arg_319_1.talkMaxDuration = var_322_3

					if var_322_3 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_3 + 0
					end
				end

				arg_319_1.text_.text = var_322_1
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_4 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_4

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play425051077 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 425051077
		arg_323_1.duration_ = 1.2

		local var_323_0 = {
			zh = 1.033,
			ja = 1.2
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
				arg_323_0:Play425051078(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1037"]) and arg_323_1.var_.actorSpriteComps1037 == nil then
				arg_323_1.var_.actorSpriteComps1037 = arg_323_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_0 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1037"]) then
				if arg_323_1.var_.actorSpriteComps1037 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_326_1 then
							if arg_323_1.isInRecall_ then
								iter_326_1.color = Color.New(Mathf.Lerp(iter_326_1.color.r, arg_323_1.hightColor1.r, (arg_323_1.time_ - 0) / var_326_0), Mathf.Lerp(iter_326_1.color.g, arg_323_1.hightColor1.g, (arg_323_1.time_ - 0) / var_326_0), (Mathf.Lerp(iter_326_1.color.b, arg_323_1.hightColor1.b, (arg_323_1.time_ - 0) / var_326_0)))
							else
								local var_326_1 = Mathf.Lerp(iter_326_1.color.r, 1, (arg_323_1.time_ - 0) / var_326_0)

								iter_326_1.color = Color.New(var_326_1, var_326_1, var_326_1)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1037"]) and arg_323_1.var_.actorSpriteComps1037 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_326_3 then
						iter_326_3.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_323_1.var_.actorSpriteComps1037 = nil
			end

			local var_326_2 = arg_323_1.actors_["1037"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1037 = var_326_2.localPosition
				var_326_2.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("1037", 3)

				for iter_326_4 = 0, var_326_2.childCount - 1 do
					local var_326_3 = var_326_2:GetChild(iter_326_4)

					if var_326_3.name == "split_5" or not string.find(var_326_3.name, "split") then
						var_326_3.gameObject:SetActive(true)
					else
						var_326_3.gameObject:SetActive(false)
					end
				end
			end

			local var_326_4 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 then
				var_326_2.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_323_1.time_ - 0) / var_326_4)
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 then
				var_326_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_326_5 = 0
			local var_326_6 = 0.075

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_5 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_7 = arg_323_1:GetWordFromCfg(425051077)
				local var_326_8 = arg_323_1:FormatText(var_326_7.content)

				arg_323_1.text_.text = var_326_8

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_10 = 3 <= 0 and var_326_6 or var_326_6 * (utf8.len(var_326_8) / 3)

				if (3 <= 0 and var_326_6 or var_326_6 * (utf8.len(var_326_8) / 3)) > 0 and var_326_6 < var_326_10 then
					arg_323_1.talkMaxDuration = var_326_10

					if var_326_10 + var_326_5 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_10 + var_326_5
					end
				end

				arg_323_1.text_.text = var_326_8
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051077", "story_v_out_425051.awb") ~= 0 then
					local var_326_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051077", "story_v_out_425051.awb") / 1000

					if var_326_11 + var_326_5 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_11 + var_326_5
					end

					if var_326_7.prefab_name ~= "" and arg_323_1.actors_[var_326_7.prefab_name] ~= nil then
						local var_326_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_7.prefab_name].transform, "story_v_out_425051", "425051077", "story_v_out_425051.awb")

						arg_323_1:RecordAudio("425051077", var_326_12)
						arg_323_1:RecordAudio("425051077", var_326_12)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_425051", "425051077", "story_v_out_425051.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_425051", "425051077", "story_v_out_425051.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_13 = math.max(var_326_6, arg_323_1.talkMaxDuration)

			if var_326_5 <= arg_323_1.time_ and arg_323_1.time_ < var_326_5 + var_326_13 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_5) / var_326_13

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_5 + var_326_13 and arg_323_1.time_ < var_326_5 + var_326_13 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play425051078 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 425051078
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play425051079(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1037"]) and arg_327_1.var_.actorSpriteComps1037 == nil then
				arg_327_1.var_.actorSpriteComps1037 = arg_327_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_0 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1037"]) then
				if arg_327_1.var_.actorSpriteComps1037 then
					for iter_330_0, iter_330_1 in pairs(arg_327_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_330_1 then
							if arg_327_1.isInRecall_ then
								iter_330_1.color = Color.New(Mathf.Lerp(iter_330_1.color.r, arg_327_1.hightColor2.r, (arg_327_1.time_ - 0) / var_330_0), Mathf.Lerp(iter_330_1.color.g, arg_327_1.hightColor2.g, (arg_327_1.time_ - 0) / var_330_0), (Mathf.Lerp(iter_330_1.color.b, arg_327_1.hightColor2.b, (arg_327_1.time_ - 0) / var_330_0)))
							else
								local var_330_1 = Mathf.Lerp(iter_330_1.color.r, 0.5, (arg_327_1.time_ - 0) / var_330_0)

								iter_330_1.color = Color.New(var_330_1, var_330_1, var_330_1)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1037"]) and arg_327_1.var_.actorSpriteComps1037 then
				for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_330_3 then
						iter_330_3.color = arg_327_1.isInRecall_ and (arg_327_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_327_1.var_.actorSpriteComps1037 = nil
			end

			local var_330_2 = 0
			local var_330_3 = 0.25

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_2 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_4 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(425051078).content)

				arg_327_1.text_.text = var_330_4

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_6 = 10 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_4) / 10)

				if (10 <= 0 and var_330_3 or var_330_3 * (utf8.len(var_330_4) / 10)) > 0 and var_330_3 < var_330_6 then
					arg_327_1.talkMaxDuration = var_330_6

					if var_330_6 + var_330_2 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_6 + var_330_2
					end
				end

				arg_327_1.text_.text = var_330_4
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_3, arg_327_1.talkMaxDuration)

			if var_330_2 <= arg_327_1.time_ and arg_327_1.time_ < var_330_2 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_2) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_2 + var_330_7 and arg_327_1.time_ < var_330_2 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play425051079 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 425051079
		arg_331_1.duration_ = 2.3

		local var_331_0 = {
			zh = 2.3,
			ja = 2.033
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
				arg_331_0:Play425051080(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["1037"]) and arg_331_1.var_.actorSpriteComps1037 == nil then
				arg_331_1.var_.actorSpriteComps1037 = arg_331_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_0 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["1037"]) then
				if arg_331_1.var_.actorSpriteComps1037 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_334_1 then
							if arg_331_1.isInRecall_ then
								iter_334_1.color = Color.New(Mathf.Lerp(iter_334_1.color.r, arg_331_1.hightColor1.r, (arg_331_1.time_ - 0) / var_334_0), Mathf.Lerp(iter_334_1.color.g, arg_331_1.hightColor1.g, (arg_331_1.time_ - 0) / var_334_0), (Mathf.Lerp(iter_334_1.color.b, arg_331_1.hightColor1.b, (arg_331_1.time_ - 0) / var_334_0)))
							else
								local var_334_1 = Mathf.Lerp(iter_334_1.color.r, 1, (arg_331_1.time_ - 0) / var_334_0)

								iter_334_1.color = Color.New(var_334_1, var_334_1, var_334_1)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["1037"]) and arg_331_1.var_.actorSpriteComps1037 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_334_3 then
						iter_334_3.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_331_1.var_.actorSpriteComps1037 = nil
			end

			local var_334_2 = arg_331_1.actors_["1037"].transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1037 = var_334_2.localPosition
				var_334_2.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("1037", 3)

				for iter_334_4 = 0, var_334_2.childCount - 1 do
					local var_334_3 = var_334_2:GetChild(iter_334_4)

					if var_334_3.name == "split_4" then
						var_334_3:SetAsLastSibling()
						var_334_3.gameObject:SetActive(true)

						arg_331_1.var_.actorSpriteSplit1037 = var_334_3.gameObject:GetComponent(typeof(Image))

						arg_331_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_334_4 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				var_334_2.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_331_1.time_ - 0) / var_334_4)

				if arg_331_1.var_.actorSpriteSplit1037 ~= nil then
					arg_331_1.var_.actorSpriteSplit1037:SetAlpha((arg_331_1.time_ - 0) / var_334_4)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				var_334_2.localPosition = Vector3.New(0, -430, -55)

				if arg_331_1.var_.actorSpriteSplit1037 ~= nil then
					arg_331_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_334_5 = 0
			local var_334_6 = 0.05

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_5 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_7 = arg_331_1:GetWordFromCfg(425051079)
				local var_334_8 = arg_331_1:FormatText(var_334_7.content)

				arg_331_1.text_.text = var_334_8

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_10 = 2 <= 0 and var_334_6 or var_334_6 * (utf8.len(var_334_8) / 2)

				if (2 <= 0 and var_334_6 or var_334_6 * (utf8.len(var_334_8) / 2)) > 0 and var_334_6 < var_334_10 then
					arg_331_1.talkMaxDuration = var_334_10

					if var_334_10 + var_334_5 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_10 + var_334_5
					end
				end

				arg_331_1.text_.text = var_334_8
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051079", "story_v_out_425051.awb") ~= 0 then
					local var_334_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051079", "story_v_out_425051.awb") / 1000

					if var_334_11 + var_334_5 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_11 + var_334_5
					end

					if var_334_7.prefab_name ~= "" and arg_331_1.actors_[var_334_7.prefab_name] ~= nil then
						local var_334_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_7.prefab_name].transform, "story_v_out_425051", "425051079", "story_v_out_425051.awb")

						arg_331_1:RecordAudio("425051079", var_334_12)
						arg_331_1:RecordAudio("425051079", var_334_12)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_425051", "425051079", "story_v_out_425051.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_425051", "425051079", "story_v_out_425051.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_13 = math.max(var_334_6, arg_331_1.talkMaxDuration)

			if var_334_5 <= arg_331_1.time_ and arg_331_1.time_ < var_334_5 + var_334_13 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_5) / var_334_13

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_5 + var_334_13 and arg_331_1.time_ < var_334_5 + var_334_13 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play425051080 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 425051080
		arg_335_1.duration_ = 3.7

		local var_335_0 = {
			zh = 1.233,
			ja = 3.7
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
				arg_335_0:Play425051081(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.125

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_1 = arg_335_1:GetWordFromCfg(425051080)
				local var_338_2 = arg_335_1:FormatText(var_338_1.content)

				arg_335_1.text_.text = var_338_2

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_4 = 5 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 5)

				if (5 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 5)) > 0 and var_338_0 < var_338_4 then
					arg_335_1.talkMaxDuration = var_338_4

					if var_338_4 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_4 + 0
					end
				end

				arg_335_1.text_.text = var_338_2
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051080", "story_v_out_425051.awb") ~= 0 then
					local var_338_5 = manager.audio:GetVoiceLength("story_v_out_425051", "425051080", "story_v_out_425051.awb") / 1000

					if var_338_5 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + 0
					end

					if var_338_1.prefab_name ~= "" and arg_335_1.actors_[var_338_1.prefab_name] ~= nil then
						local var_338_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_1.prefab_name].transform, "story_v_out_425051", "425051080", "story_v_out_425051.awb")

						arg_335_1:RecordAudio("425051080", var_338_6)
						arg_335_1:RecordAudio("425051080", var_338_6)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_425051", "425051080", "story_v_out_425051.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_425051", "425051080", "story_v_out_425051.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_7 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_7 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_7

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_7 and arg_335_1.time_ < 0 + var_338_7 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play425051081 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 425051081
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play425051082(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["1037"]) and arg_339_1.var_.actorSpriteComps1037 == nil then
				arg_339_1.var_.actorSpriteComps1037 = arg_339_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_0 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["1037"]) then
				if arg_339_1.var_.actorSpriteComps1037 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_342_1 then
							if arg_339_1.isInRecall_ then
								iter_342_1.color = Color.New(Mathf.Lerp(iter_342_1.color.r, arg_339_1.hightColor2.r, (arg_339_1.time_ - 0) / var_342_0), Mathf.Lerp(iter_342_1.color.g, arg_339_1.hightColor2.g, (arg_339_1.time_ - 0) / var_342_0), (Mathf.Lerp(iter_342_1.color.b, arg_339_1.hightColor2.b, (arg_339_1.time_ - 0) / var_342_0)))
							else
								local var_342_1 = Mathf.Lerp(iter_342_1.color.r, 0.5, (arg_339_1.time_ - 0) / var_342_0)

								iter_342_1.color = Color.New(var_342_1, var_342_1, var_342_1)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["1037"]) and arg_339_1.var_.actorSpriteComps1037 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_342_3 then
						iter_342_3.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_339_1.var_.actorSpriteComps1037 = nil
			end

			local var_342_2 = 0
			local var_342_3 = 0.775

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_2 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_4 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(425051081).content)

				arg_339_1.text_.text = var_342_4

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_6 = 31 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_4) / 31)

				if (31 <= 0 and var_342_3 or var_342_3 * (utf8.len(var_342_4) / 31)) > 0 and var_342_3 < var_342_6 then
					arg_339_1.talkMaxDuration = var_342_6

					if var_342_6 + var_342_2 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_6 + var_342_2
					end
				end

				arg_339_1.text_.text = var_342_4
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_3, arg_339_1.talkMaxDuration)

			if var_342_2 <= arg_339_1.time_ and arg_339_1.time_ < var_342_2 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_2) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_2 + var_342_7 and arg_339_1.time_ < var_342_2 + var_342_7 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play425051082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 425051082
		arg_343_1.duration_ = 4.03

		local var_343_0 = {
			zh = 2.366,
			ja = 4.033
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
				arg_343_0:Play425051083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1037"]) and arg_343_1.var_.actorSpriteComps1037 == nil then
				arg_343_1.var_.actorSpriteComps1037 = arg_343_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_0 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1037"]) then
				if arg_343_1.var_.actorSpriteComps1037 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_346_1 then
							if arg_343_1.isInRecall_ then
								iter_346_1.color = Color.New(Mathf.Lerp(iter_346_1.color.r, arg_343_1.hightColor1.r, (arg_343_1.time_ - 0) / var_346_0), Mathf.Lerp(iter_346_1.color.g, arg_343_1.hightColor1.g, (arg_343_1.time_ - 0) / var_346_0), (Mathf.Lerp(iter_346_1.color.b, arg_343_1.hightColor1.b, (arg_343_1.time_ - 0) / var_346_0)))
							else
								local var_346_1 = Mathf.Lerp(iter_346_1.color.r, 1, (arg_343_1.time_ - 0) / var_346_0)

								iter_346_1.color = Color.New(var_346_1, var_346_1, var_346_1)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1037"]) and arg_343_1.var_.actorSpriteComps1037 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_346_3 then
						iter_346_3.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_343_1.var_.actorSpriteComps1037 = nil
			end

			local var_346_2 = 0
			local var_346_3 = 0.275

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_2 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_4 = arg_343_1:GetWordFromCfg(425051082)
				local var_346_5 = arg_343_1:FormatText(var_346_4.content)

				arg_343_1.text_.text = var_346_5

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_7 = 11 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_5) / 11)

				if (11 <= 0 and var_346_3 or var_346_3 * (utf8.len(var_346_5) / 11)) > 0 and var_346_3 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_2 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_2
					end
				end

				arg_343_1.text_.text = var_346_5
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051082", "story_v_out_425051.awb") ~= 0 then
					local var_346_8 = manager.audio:GetVoiceLength("story_v_out_425051", "425051082", "story_v_out_425051.awb") / 1000

					if var_346_8 + var_346_2 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_2
					end

					if var_346_4.prefab_name ~= "" and arg_343_1.actors_[var_346_4.prefab_name] ~= nil then
						local var_346_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_4.prefab_name].transform, "story_v_out_425051", "425051082", "story_v_out_425051.awb")

						arg_343_1:RecordAudio("425051082", var_346_9)
						arg_343_1:RecordAudio("425051082", var_346_9)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_425051", "425051082", "story_v_out_425051.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_425051", "425051082", "story_v_out_425051.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_3, arg_343_1.talkMaxDuration)

			if var_346_2 <= arg_343_1.time_ and arg_343_1.time_ < var_346_2 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_2) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_2 + var_346_10 and arg_343_1.time_ < var_346_2 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play425051083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 425051083
		arg_347_1.duration_ = 1

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"

			SetActive(arg_347_1.choicesGo_, true)

			for iter_348_0, iter_348_1 in ipairs(arg_347_1.choices_) do
				SetActive(iter_348_1.go, iter_348_0 <= 1)
			end

			arg_347_1.choices_[1].txt.text = arg_347_1:FormatText(StoryChoiceCfg[1533].name)
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play425051084(arg_347_1)
			end

			arg_347_1:RecordChoiceLog(425051083, 1533)
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1037"]) and arg_347_1.var_.actorSpriteComps1037 == nil then
				arg_347_1.var_.actorSpriteComps1037 = arg_347_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_0 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1037"]) then
				if arg_347_1.var_.actorSpriteComps1037 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_350_1 then
							if arg_347_1.isInRecall_ then
								iter_350_1.color = Color.New(Mathf.Lerp(iter_350_1.color.r, arg_347_1.hightColor2.r, (arg_347_1.time_ - 0) / var_350_0), Mathf.Lerp(iter_350_1.color.g, arg_347_1.hightColor2.g, (arg_347_1.time_ - 0) / var_350_0), (Mathf.Lerp(iter_350_1.color.b, arg_347_1.hightColor2.b, (arg_347_1.time_ - 0) / var_350_0)))
							else
								local var_350_1 = Mathf.Lerp(iter_350_1.color.r, 0.5, (arg_347_1.time_ - 0) / var_350_0)

								iter_350_1.color = Color.New(var_350_1, var_350_1, var_350_1)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1037"]) and arg_347_1.var_.actorSpriteComps1037 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_350_3 then
						iter_350_3.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_347_1.var_.actorSpriteComps1037 = nil
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play425051084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 425051084
		arg_351_1.duration_ = 10.97

		local var_351_0 = {
			zh = 9.133,
			ja = 10.966
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
				arg_351_0:Play425051085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1037"]) and arg_351_1.var_.actorSpriteComps1037 == nil then
				arg_351_1.var_.actorSpriteComps1037 = arg_351_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_0 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1037"]) then
				if arg_351_1.var_.actorSpriteComps1037 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								iter_354_1.color = Color.New(Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor1.r, (arg_351_1.time_ - 0) / var_354_0), Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor1.g, (arg_351_1.time_ - 0) / var_354_0), (Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor1.b, (arg_351_1.time_ - 0) / var_354_0)))
							else
								local var_354_1 = Mathf.Lerp(iter_354_1.color.r, 1, (arg_351_1.time_ - 0) / var_354_0)

								iter_354_1.color = Color.New(var_354_1, var_354_1, var_354_1)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1037"]) and arg_351_1.var_.actorSpriteComps1037 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_354_3 then
						iter_354_3.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_351_1.var_.actorSpriteComps1037 = nil
			end

			local var_354_2 = arg_351_1.actors_["1037"].transform

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1037 = var_354_2.localPosition
				var_354_2.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("1037", 3)

				for iter_354_4 = 0, var_354_2.childCount - 1 do
					local var_354_3 = var_354_2:GetChild(iter_354_4)

					if var_354_3.name == "split_3" then
						var_354_3:SetAsLastSibling()
						var_354_3.gameObject:SetActive(true)

						arg_351_1.var_.actorSpriteSplit1037 = var_354_3.gameObject:GetComponent(typeof(Image))

						arg_351_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_354_4 = 0.4

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_4 then
				var_354_2.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_351_1.time_ - 0) / var_354_4)

				if arg_351_1.var_.actorSpriteSplit1037 ~= nil then
					arg_351_1.var_.actorSpriteSplit1037:SetAlpha((arg_351_1.time_ - 0) / var_354_4)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_4 and arg_351_1.time_ < 0 + var_354_4 + arg_354_0 then
				var_354_2.localPosition = Vector3.New(0, -430, -55)

				if arg_351_1.var_.actorSpriteSplit1037 ~= nil then
					arg_351_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_354_5 = 0
			local var_354_6 = 0.8

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_7 = arg_351_1:GetWordFromCfg(425051084)
				local var_354_8 = arg_351_1:FormatText(var_354_7.content)

				arg_351_1.text_.text = var_354_8

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_10 = 32 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_8) / 32)

				if (32 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_8) / 32)) > 0 and var_354_6 < var_354_10 then
					arg_351_1.talkMaxDuration = var_354_10

					if var_354_10 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_5
					end
				end

				arg_351_1.text_.text = var_354_8
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051084", "story_v_out_425051.awb") ~= 0 then
					local var_354_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051084", "story_v_out_425051.awb") / 1000

					if var_354_11 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_11 + var_354_5
					end

					if var_354_7.prefab_name ~= "" and arg_351_1.actors_[var_354_7.prefab_name] ~= nil then
						local var_354_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_7.prefab_name].transform, "story_v_out_425051", "425051084", "story_v_out_425051.awb")

						arg_351_1:RecordAudio("425051084", var_354_12)
						arg_351_1:RecordAudio("425051084", var_354_12)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_425051", "425051084", "story_v_out_425051.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_425051", "425051084", "story_v_out_425051.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_13 = math.max(var_354_6, arg_351_1.talkMaxDuration)

			if var_354_5 <= arg_351_1.time_ and arg_351_1.time_ < var_354_5 + var_354_13 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_5) / var_354_13

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_5 + var_354_13 and arg_351_1.time_ < var_354_5 + var_354_13 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.4,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play425051085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 425051085
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play425051086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["1037"]) and arg_355_1.var_.actorSpriteComps1037 == nil then
				arg_355_1.var_.actorSpriteComps1037 = arg_355_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_0 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["1037"]) then
				if arg_355_1.var_.actorSpriteComps1037 then
					for iter_358_0, iter_358_1 in pairs(arg_355_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_358_1 then
							if arg_355_1.isInRecall_ then
								iter_358_1.color = Color.New(Mathf.Lerp(iter_358_1.color.r, arg_355_1.hightColor2.r, (arg_355_1.time_ - 0) / var_358_0), Mathf.Lerp(iter_358_1.color.g, arg_355_1.hightColor2.g, (arg_355_1.time_ - 0) / var_358_0), (Mathf.Lerp(iter_358_1.color.b, arg_355_1.hightColor2.b, (arg_355_1.time_ - 0) / var_358_0)))
							else
								local var_358_1 = Mathf.Lerp(iter_358_1.color.r, 0.5, (arg_355_1.time_ - 0) / var_358_0)

								iter_358_1.color = Color.New(var_358_1, var_358_1, var_358_1)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["1037"]) and arg_355_1.var_.actorSpriteComps1037 then
				for iter_358_2, iter_358_3 in pairs(arg_355_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_358_3 then
						iter_358_3.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_355_1.var_.actorSpriteComps1037 = nil
			end

			local var_358_2 = 0
			local var_358_3 = 0.2

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_2 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_4 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(425051085).content)

				arg_355_1.text_.text = var_358_4

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_6 = 8 <= 0 and var_358_3 or var_358_3 * (utf8.len(var_358_4) / 8)

				if (8 <= 0 and var_358_3 or var_358_3 * (utf8.len(var_358_4) / 8)) > 0 and var_358_3 < var_358_6 then
					arg_355_1.talkMaxDuration = var_358_6

					if var_358_6 + var_358_2 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_6 + var_358_2
					end
				end

				arg_355_1.text_.text = var_358_4
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_7 = math.max(var_358_3, arg_355_1.talkMaxDuration)

			if var_358_2 <= arg_355_1.time_ and arg_355_1.time_ < var_358_2 + var_358_7 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_2) / var_358_7

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_2 + var_358_7 and arg_355_1.time_ < var_358_2 + var_358_7 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play425051086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 425051086
		arg_359_1.duration_ = 7.07

		local var_359_0 = {
			zh = 7.066,
			ja = 6.7
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
				arg_359_0:Play425051087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["1037"]) and arg_359_1.var_.actorSpriteComps1037 == nil then
				arg_359_1.var_.actorSpriteComps1037 = arg_359_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_0 = 0.2

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["1037"]) then
				if arg_359_1.var_.actorSpriteComps1037 then
					for iter_362_0, iter_362_1 in pairs(arg_359_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_362_1 then
							if arg_359_1.isInRecall_ then
								iter_362_1.color = Color.New(Mathf.Lerp(iter_362_1.color.r, arg_359_1.hightColor1.r, (arg_359_1.time_ - 0) / var_362_0), Mathf.Lerp(iter_362_1.color.g, arg_359_1.hightColor1.g, (arg_359_1.time_ - 0) / var_362_0), (Mathf.Lerp(iter_362_1.color.b, arg_359_1.hightColor1.b, (arg_359_1.time_ - 0) / var_362_0)))
							else
								local var_362_1 = Mathf.Lerp(iter_362_1.color.r, 1, (arg_359_1.time_ - 0) / var_362_0)

								iter_362_1.color = Color.New(var_362_1, var_362_1, var_362_1)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["1037"]) and arg_359_1.var_.actorSpriteComps1037 then
				for iter_362_2, iter_362_3 in pairs(arg_359_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_362_3 then
						iter_362_3.color = arg_359_1.isInRecall_ and (arg_359_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_359_1.var_.actorSpriteComps1037 = nil
			end

			local var_362_2 = arg_359_1.actors_["1037"].transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPos1037 = var_362_2.localPosition
				var_362_2.localScale = Vector3.New(1, 1, 1)

				arg_359_1:CheckSpriteTmpPos("1037", 3)

				for iter_362_4 = 0, var_362_2.childCount - 1 do
					local var_362_3 = var_362_2:GetChild(iter_362_4)

					if var_362_3.name == "split_4" then
						var_362_3:SetAsLastSibling()
						var_362_3.gameObject:SetActive(true)

						arg_359_1.var_.actorSpriteSplit1037 = var_362_3.gameObject:GetComponent(typeof(Image))

						arg_359_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_362_4 = 0.5

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				var_362_2.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_359_1.time_ - 0) / var_362_4)

				if arg_359_1.var_.actorSpriteSplit1037 ~= nil then
					arg_359_1.var_.actorSpriteSplit1037:SetAlpha((arg_359_1.time_ - 0) / var_362_4)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				var_362_2.localPosition = Vector3.New(0, -430, -55)

				if arg_359_1.var_.actorSpriteSplit1037 ~= nil then
					arg_359_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_362_5 = 0
			local var_362_6 = 0.775

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_5 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_7 = arg_359_1:GetWordFromCfg(425051086)
				local var_362_8 = arg_359_1:FormatText(var_362_7.content)

				arg_359_1.text_.text = var_362_8

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_10 = 31 <= 0 and var_362_6 or var_362_6 * (utf8.len(var_362_8) / 31)

				if (31 <= 0 and var_362_6 or var_362_6 * (utf8.len(var_362_8) / 31)) > 0 and var_362_6 < var_362_10 then
					arg_359_1.talkMaxDuration = var_362_10

					if var_362_10 + var_362_5 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_5
					end
				end

				arg_359_1.text_.text = var_362_8
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051086", "story_v_out_425051.awb") ~= 0 then
					local var_362_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051086", "story_v_out_425051.awb") / 1000

					if var_362_11 + var_362_5 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_11 + var_362_5
					end

					if var_362_7.prefab_name ~= "" and arg_359_1.actors_[var_362_7.prefab_name] ~= nil then
						local var_362_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_7.prefab_name].transform, "story_v_out_425051", "425051086", "story_v_out_425051.awb")

						arg_359_1:RecordAudio("425051086", var_362_12)
						arg_359_1:RecordAudio("425051086", var_362_12)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_425051", "425051086", "story_v_out_425051.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_425051", "425051086", "story_v_out_425051.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_13 = math.max(var_362_6, arg_359_1.talkMaxDuration)

			if var_362_5 <= arg_359_1.time_ and arg_359_1.time_ < var_362_5 + var_362_13 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_5) / var_362_13

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_5 + var_362_13 and arg_359_1.time_ < var_362_5 + var_362_13 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play425051087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 425051087
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play425051088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1037 = arg_363_1.actors_["1037"].transform.localPosition
				arg_363_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("1037", 7)

				for iter_366_0 = 0, arg_363_1.actors_["1037"].transform.childCount - 1 do
					local var_366_0 = arg_363_1.actors_["1037"].transform:GetChild(iter_366_0)

					if var_366_0.name == "" or not string.find(var_366_0.name, "split") then
						var_366_0.gameObject:SetActive(true)
					else
						var_366_0.gameObject:SetActive(false)
					end
				end
			end

			local var_366_1 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_1 then
				arg_363_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_363_1.time_ - 0) / var_366_1)
			end

			if arg_363_1.time_ >= 0 + var_366_1 and arg_363_1.time_ < 0 + var_366_1 + arg_366_0 then
				arg_363_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			if 0.833333333333333 < arg_363_1.time_ and arg_363_1.time_ <= 0.833333333333333 + arg_366_0 then
				arg_363_1:AudioAction("play", "effect", "se_story_147", "se_story_147_lock", "")
			end

			local var_366_3 = 0
			local var_366_4 = 1.45

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_3 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_5 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(425051087).content)

				arg_363_1.text_.text = var_366_5

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_7 = 58 <= 0 and var_366_4 or var_366_4 * (utf8.len(var_366_5) / 58)

				if (58 <= 0 and var_366_4 or var_366_4 * (utf8.len(var_366_5) / 58)) > 0 and var_366_4 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_3 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_3
					end
				end

				arg_363_1.text_.text = var_366_5
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_8 = math.max(var_366_4, arg_363_1.talkMaxDuration)

			if var_366_3 <= arg_363_1.time_ and arg_363_1.time_ < var_366_3 + var_366_8 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_3) / var_366_8

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_3 + var_366_8 and arg_363_1.time_ < var_366_3 + var_366_8 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play425051088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 425051088
		arg_367_1.duration_ = 3.57

		local var_367_0 = {
			zh = 3,
			ja = 3.566
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play425051089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["1037"]) and arg_367_1.var_.actorSpriteComps1037 == nil then
				arg_367_1.var_.actorSpriteComps1037 = arg_367_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_0 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["1037"]) then
				if arg_367_1.var_.actorSpriteComps1037 then
					for iter_370_0, iter_370_1 in pairs(arg_367_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_370_1 then
							if arg_367_1.isInRecall_ then
								iter_370_1.color = Color.New(Mathf.Lerp(iter_370_1.color.r, arg_367_1.hightColor1.r, (arg_367_1.time_ - 0) / var_370_0), Mathf.Lerp(iter_370_1.color.g, arg_367_1.hightColor1.g, (arg_367_1.time_ - 0) / var_370_0), (Mathf.Lerp(iter_370_1.color.b, arg_367_1.hightColor1.b, (arg_367_1.time_ - 0) / var_370_0)))
							else
								local var_370_1 = Mathf.Lerp(iter_370_1.color.r, 1, (arg_367_1.time_ - 0) / var_370_0)

								iter_370_1.color = Color.New(var_370_1, var_370_1, var_370_1)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["1037"]) and arg_367_1.var_.actorSpriteComps1037 then
				for iter_370_2, iter_370_3 in pairs(arg_367_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_370_3 then
						iter_370_3.color = arg_367_1.isInRecall_ and (arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_367_1.var_.actorSpriteComps1037 = nil
			end

			local var_370_2 = arg_367_1.actors_["1037"].transform

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos1037 = var_370_2.localPosition
				var_370_2.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("1037", 3)

				for iter_370_4 = 0, var_370_2.childCount - 1 do
					local var_370_3 = var_370_2:GetChild(iter_370_4)

					if var_370_3.name == "split_6" or not string.find(var_370_3.name, "split") then
						var_370_3.gameObject:SetActive(true)
					else
						var_370_3.gameObject:SetActive(false)
					end
				end
			end

			local var_370_4 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				var_370_2.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_367_1.time_ - 0) / var_370_4)
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				var_370_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_370_5 = 0
			local var_370_6 = 0.275

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_5 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_7 = arg_367_1:GetWordFromCfg(425051088)
				local var_370_8 = arg_367_1:FormatText(var_370_7.content)

				arg_367_1.text_.text = var_370_8

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_10 = 11 <= 0 and var_370_6 or var_370_6 * (utf8.len(var_370_8) / 11)

				if (11 <= 0 and var_370_6 or var_370_6 * (utf8.len(var_370_8) / 11)) > 0 and var_370_6 < var_370_10 then
					arg_367_1.talkMaxDuration = var_370_10

					if var_370_10 + var_370_5 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_5
					end
				end

				arg_367_1.text_.text = var_370_8
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051088", "story_v_out_425051.awb") ~= 0 then
					local var_370_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051088", "story_v_out_425051.awb") / 1000

					if var_370_11 + var_370_5 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_11 + var_370_5
					end

					if var_370_7.prefab_name ~= "" and arg_367_1.actors_[var_370_7.prefab_name] ~= nil then
						local var_370_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_7.prefab_name].transform, "story_v_out_425051", "425051088", "story_v_out_425051.awb")

						arg_367_1:RecordAudio("425051088", var_370_12)
						arg_367_1:RecordAudio("425051088", var_370_12)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_425051", "425051088", "story_v_out_425051.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_425051", "425051088", "story_v_out_425051.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_13 = math.max(var_370_6, arg_367_1.talkMaxDuration)

			if var_370_5 <= arg_367_1.time_ and arg_367_1.time_ < var_370_5 + var_370_13 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_5) / var_370_13

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_5 + var_370_13 and arg_367_1.time_ < var_370_5 + var_370_13 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play425051089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 425051089
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play425051090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["1037"]) and arg_371_1.var_.actorSpriteComps1037 == nil then
				arg_371_1.var_.actorSpriteComps1037 = arg_371_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_0 = 0.2

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["1037"]) then
				if arg_371_1.var_.actorSpriteComps1037 then
					for iter_374_0, iter_374_1 in pairs(arg_371_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_374_1 then
							if arg_371_1.isInRecall_ then
								iter_374_1.color = Color.New(Mathf.Lerp(iter_374_1.color.r, arg_371_1.hightColor2.r, (arg_371_1.time_ - 0) / var_374_0), Mathf.Lerp(iter_374_1.color.g, arg_371_1.hightColor2.g, (arg_371_1.time_ - 0) / var_374_0), (Mathf.Lerp(iter_374_1.color.b, arg_371_1.hightColor2.b, (arg_371_1.time_ - 0) / var_374_0)))
							else
								local var_374_1 = Mathf.Lerp(iter_374_1.color.r, 0.5, (arg_371_1.time_ - 0) / var_374_0)

								iter_374_1.color = Color.New(var_374_1, var_374_1, var_374_1)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["1037"]) and arg_371_1.var_.actorSpriteComps1037 then
				for iter_374_2, iter_374_3 in pairs(arg_371_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_374_3 then
						iter_374_3.color = arg_371_1.isInRecall_ and (arg_371_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_371_1.var_.actorSpriteComps1037 = nil
			end

			local var_374_2 = 0
			local var_374_3 = 0.35

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_2 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_4 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(425051089).content)

				arg_371_1.text_.text = var_374_4

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_6 = 14 <= 0 and var_374_3 or var_374_3 * (utf8.len(var_374_4) / 14)

				if (14 <= 0 and var_374_3 or var_374_3 * (utf8.len(var_374_4) / 14)) > 0 and var_374_3 < var_374_6 then
					arg_371_1.talkMaxDuration = var_374_6

					if var_374_6 + var_374_2 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_6 + var_374_2
					end
				end

				arg_371_1.text_.text = var_374_4
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_3, arg_371_1.talkMaxDuration)

			if var_374_2 <= arg_371_1.time_ and arg_371_1.time_ < var_374_2 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_2) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_2 + var_374_7 and arg_371_1.time_ < var_374_2 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play425051090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 425051090
		arg_375_1.duration_ = 13.87

		local var_375_0 = {
			zh = 6.5,
			ja = 13.866
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play425051091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["1037"]) and arg_375_1.var_.actorSpriteComps1037 == nil then
				arg_375_1.var_.actorSpriteComps1037 = arg_375_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_0 = 0.2

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["1037"]) then
				if arg_375_1.var_.actorSpriteComps1037 then
					for iter_378_0, iter_378_1 in pairs(arg_375_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_378_1 then
							if arg_375_1.isInRecall_ then
								iter_378_1.color = Color.New(Mathf.Lerp(iter_378_1.color.r, arg_375_1.hightColor1.r, (arg_375_1.time_ - 0) / var_378_0), Mathf.Lerp(iter_378_1.color.g, arg_375_1.hightColor1.g, (arg_375_1.time_ - 0) / var_378_0), (Mathf.Lerp(iter_378_1.color.b, arg_375_1.hightColor1.b, (arg_375_1.time_ - 0) / var_378_0)))
							else
								local var_378_1 = Mathf.Lerp(iter_378_1.color.r, 1, (arg_375_1.time_ - 0) / var_378_0)

								iter_378_1.color = Color.New(var_378_1, var_378_1, var_378_1)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["1037"]) and arg_375_1.var_.actorSpriteComps1037 then
				for iter_378_2, iter_378_3 in pairs(arg_375_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_378_3 then
						iter_378_3.color = arg_375_1.isInRecall_ and (arg_375_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_375_1.var_.actorSpriteComps1037 = nil
			end

			local var_378_2 = arg_375_1.actors_["1037"].transform

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1037 = var_378_2.localPosition
				var_378_2.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("1037", 3)

				for iter_378_4 = 0, var_378_2.childCount - 1 do
					local var_378_3 = var_378_2:GetChild(iter_378_4)

					if var_378_3.name == "split_1" then
						var_378_3:SetAsLastSibling()
						var_378_3.gameObject:SetActive(true)

						arg_375_1.var_.actorSpriteSplit1037 = var_378_3.gameObject:GetComponent(typeof(Image))

						arg_375_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_378_4 = 0.5

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_4 then
				var_378_2.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_375_1.time_ - 0) / var_378_4)

				if arg_375_1.var_.actorSpriteSplit1037 ~= nil then
					arg_375_1.var_.actorSpriteSplit1037:SetAlpha((arg_375_1.time_ - 0) / var_378_4)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_4 and arg_375_1.time_ < 0 + var_378_4 + arg_378_0 then
				var_378_2.localPosition = Vector3.New(0, -430, -55)

				if arg_375_1.var_.actorSpriteSplit1037 ~= nil then
					arg_375_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_378_5 = 0
			local var_378_6 = 0.575

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_5 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_7 = arg_375_1:GetWordFromCfg(425051090)
				local var_378_8 = arg_375_1:FormatText(var_378_7.content)

				arg_375_1.text_.text = var_378_8

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_10 = 23 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_8) / 23)

				if (23 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_8) / 23)) > 0 and var_378_6 < var_378_10 then
					arg_375_1.talkMaxDuration = var_378_10

					if var_378_10 + var_378_5 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_5
					end
				end

				arg_375_1.text_.text = var_378_8
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051090", "story_v_out_425051.awb") ~= 0 then
					local var_378_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051090", "story_v_out_425051.awb") / 1000

					if var_378_11 + var_378_5 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_11 + var_378_5
					end

					if var_378_7.prefab_name ~= "" and arg_375_1.actors_[var_378_7.prefab_name] ~= nil then
						local var_378_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_7.prefab_name].transform, "story_v_out_425051", "425051090", "story_v_out_425051.awb")

						arg_375_1:RecordAudio("425051090", var_378_12)
						arg_375_1:RecordAudio("425051090", var_378_12)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_425051", "425051090", "story_v_out_425051.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_425051", "425051090", "story_v_out_425051.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_13 = math.max(var_378_6, arg_375_1.talkMaxDuration)

			if var_378_5 <= arg_375_1.time_ and arg_375_1.time_ < var_378_5 + var_378_13 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_5) / var_378_13

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_5 + var_378_13 and arg_375_1.time_ < var_378_5 + var_378_13 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play425051091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 425051091
		arg_379_1.duration_ = 1

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"

			SetActive(arg_379_1.choicesGo_, true)

			for iter_380_0, iter_380_1 in ipairs(arg_379_1.choices_) do
				SetActive(iter_380_1.go, iter_380_0 <= 1)
			end

			arg_379_1.choices_[1].txt.text = arg_379_1:FormatText(StoryChoiceCfg[1534].name)
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play425051092(arg_379_1)
			end

			arg_379_1:RecordChoiceLog(425051091, 1534)
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(arg_379_1.actors_["1037"]) and arg_379_1.var_.actorSpriteComps1037 == nil then
				arg_379_1.var_.actorSpriteComps1037 = arg_379_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_0 = 0.2

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_0 and not isNil(arg_379_1.actors_["1037"]) then
				if arg_379_1.var_.actorSpriteComps1037 then
					for iter_382_0, iter_382_1 in pairs(arg_379_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_382_1 then
							if arg_379_1.isInRecall_ then
								iter_382_1.color = Color.New(Mathf.Lerp(iter_382_1.color.r, arg_379_1.hightColor2.r, (arg_379_1.time_ - 0) / var_382_0), Mathf.Lerp(iter_382_1.color.g, arg_379_1.hightColor2.g, (arg_379_1.time_ - 0) / var_382_0), (Mathf.Lerp(iter_382_1.color.b, arg_379_1.hightColor2.b, (arg_379_1.time_ - 0) / var_382_0)))
							else
								local var_382_1 = Mathf.Lerp(iter_382_1.color.r, 0.5, (arg_379_1.time_ - 0) / var_382_0)

								iter_382_1.color = Color.New(var_382_1, var_382_1, var_382_1)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= 0 + var_382_0 and arg_379_1.time_ < 0 + var_382_0 + arg_382_0 and not isNil(arg_379_1.actors_["1037"]) and arg_379_1.var_.actorSpriteComps1037 then
				for iter_382_2, iter_382_3 in pairs(arg_379_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_382_3 then
						iter_382_3.color = arg_379_1.isInRecall_ and (arg_379_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_379_1.var_.actorSpriteComps1037 = nil
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play425051092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 425051092
		arg_383_1.duration_ = 4.9

		local var_383_0 = {
			zh = 3.7,
			ja = 4.9
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play425051093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1037"]) and arg_383_1.var_.actorSpriteComps1037 == nil then
				arg_383_1.var_.actorSpriteComps1037 = arg_383_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_0 = 0.2

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1037"]) then
				if arg_383_1.var_.actorSpriteComps1037 then
					for iter_386_0, iter_386_1 in pairs(arg_383_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_386_1 then
							if arg_383_1.isInRecall_ then
								iter_386_1.color = Color.New(Mathf.Lerp(iter_386_1.color.r, arg_383_1.hightColor1.r, (arg_383_1.time_ - 0) / var_386_0), Mathf.Lerp(iter_386_1.color.g, arg_383_1.hightColor1.g, (arg_383_1.time_ - 0) / var_386_0), (Mathf.Lerp(iter_386_1.color.b, arg_383_1.hightColor1.b, (arg_383_1.time_ - 0) / var_386_0)))
							else
								local var_386_1 = Mathf.Lerp(iter_386_1.color.r, 1, (arg_383_1.time_ - 0) / var_386_0)

								iter_386_1.color = Color.New(var_386_1, var_386_1, var_386_1)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1037"]) and arg_383_1.var_.actorSpriteComps1037 then
				for iter_386_2, iter_386_3 in pairs(arg_383_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_386_3 then
						iter_386_3.color = arg_383_1.isInRecall_ and (arg_383_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_383_1.var_.actorSpriteComps1037 = nil
			end

			local var_386_2 = 0
			local var_386_3 = 0.35

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_2 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_4 = arg_383_1:GetWordFromCfg(425051092)
				local var_386_5 = arg_383_1:FormatText(var_386_4.content)

				arg_383_1.text_.text = var_386_5

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_7 = 14 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 14)

				if (14 <= 0 and var_386_3 or var_386_3 * (utf8.len(var_386_5) / 14)) > 0 and var_386_3 < var_386_7 then
					arg_383_1.talkMaxDuration = var_386_7

					if var_386_7 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_7 + var_386_2
					end
				end

				arg_383_1.text_.text = var_386_5
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051092", "story_v_out_425051.awb") ~= 0 then
					local var_386_8 = manager.audio:GetVoiceLength("story_v_out_425051", "425051092", "story_v_out_425051.awb") / 1000

					if var_386_8 + var_386_2 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_8 + var_386_2
					end

					if var_386_4.prefab_name ~= "" and arg_383_1.actors_[var_386_4.prefab_name] ~= nil then
						local var_386_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_4.prefab_name].transform, "story_v_out_425051", "425051092", "story_v_out_425051.awb")

						arg_383_1:RecordAudio("425051092", var_386_9)
						arg_383_1:RecordAudio("425051092", var_386_9)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_425051", "425051092", "story_v_out_425051.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_425051", "425051092", "story_v_out_425051.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_10 = math.max(var_386_3, arg_383_1.talkMaxDuration)

			if var_386_2 <= arg_383_1.time_ and arg_383_1.time_ < var_386_2 + var_386_10 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_2) / var_386_10

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_2 + var_386_10 and arg_383_1.time_ < var_386_2 + var_386_10 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play425051093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 425051093
		arg_387_1.duration_ = 5

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play425051094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos1037 = arg_387_1.actors_["1037"].transform.localPosition
				arg_387_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_387_1:CheckSpriteTmpPos("1037", 7)

				for iter_390_0 = 0, arg_387_1.actors_["1037"].transform.childCount - 1 do
					local var_390_0 = arg_387_1.actors_["1037"].transform:GetChild(iter_390_0)

					if var_390_0.name == "" or not string.find(var_390_0.name, "split") then
						var_390_0.gameObject:SetActive(true)
					else
						var_390_0.gameObject:SetActive(false)
					end
				end
			end

			local var_390_1 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_1 then
				arg_387_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_387_1.time_ - 0) / var_390_1)
			end

			if arg_387_1.time_ >= 0 + var_390_1 and arg_387_1.time_ < 0 + var_390_1 + arg_390_0 then
				arg_387_1.actors_["1037"].transform.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_390_2 = 0
			local var_390_3 = 1.05

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_2 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_4 = arg_387_1:FormatText(arg_387_1:GetWordFromCfg(425051093).content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_6 = 42 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_4) / 42)

				if (42 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_4) / 42)) > 0 and var_390_3 < var_390_6 then
					arg_387_1.talkMaxDuration = var_390_6

					if var_390_6 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_6 + var_390_2
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_7 = math.max(var_390_3, arg_387_1.talkMaxDuration)

			if var_390_2 <= arg_387_1.time_ and arg_387_1.time_ < var_390_2 + var_390_7 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_2) / var_390_7

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_2 + var_390_7 and arg_387_1.time_ < var_390_2 + var_390_7 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play425051094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 425051094
		arg_391_1.duration_ = 10.03

		local var_391_0 = {
			zh = 7,
			ja = 10.033
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play425051095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["1037"]) and arg_391_1.var_.actorSpriteComps1037 == nil then
				arg_391_1.var_.actorSpriteComps1037 = arg_391_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_394_0 = 0.2

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["1037"]) then
				if arg_391_1.var_.actorSpriteComps1037 then
					for iter_394_0, iter_394_1 in pairs(arg_391_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_394_1 then
							if arg_391_1.isInRecall_ then
								iter_394_1.color = Color.New(Mathf.Lerp(iter_394_1.color.r, arg_391_1.hightColor1.r, (arg_391_1.time_ - 0) / var_394_0), Mathf.Lerp(iter_394_1.color.g, arg_391_1.hightColor1.g, (arg_391_1.time_ - 0) / var_394_0), (Mathf.Lerp(iter_394_1.color.b, arg_391_1.hightColor1.b, (arg_391_1.time_ - 0) / var_394_0)))
							else
								local var_394_1 = Mathf.Lerp(iter_394_1.color.r, 1, (arg_391_1.time_ - 0) / var_394_0)

								iter_394_1.color = Color.New(var_394_1, var_394_1, var_394_1)
							end
						end
					end
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["1037"]) and arg_391_1.var_.actorSpriteComps1037 then
				for iter_394_2, iter_394_3 in pairs(arg_391_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_394_3 then
						iter_394_3.color = arg_391_1.isInRecall_ and (arg_391_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_391_1.var_.actorSpriteComps1037 = nil
			end

			local var_394_2 = arg_391_1.actors_["1037"].transform

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos1037 = var_394_2.localPosition
				var_394_2.localScale = Vector3.New(1, 1, 1)

				arg_391_1:CheckSpriteTmpPos("1037", 3)

				for iter_394_4 = 0, var_394_2.childCount - 1 do
					local var_394_3 = var_394_2:GetChild(iter_394_4)

					if var_394_3.name == "split_1" or not string.find(var_394_3.name, "split") then
						var_394_3.gameObject:SetActive(true)
					else
						var_394_3.gameObject:SetActive(false)
					end
				end
			end

			local var_394_4 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_4 then
				var_394_2.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_391_1.time_ - 0) / var_394_4)
			end

			if arg_391_1.time_ >= 0 + var_394_4 and arg_391_1.time_ < 0 + var_394_4 + arg_394_0 then
				var_394_2.localPosition = Vector3.New(0, -430, -55)
			end

			local var_394_5 = 0
			local var_394_6 = 0.625

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_5 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_7 = arg_391_1:GetWordFromCfg(425051094)
				local var_394_8 = arg_391_1:FormatText(var_394_7.content)

				arg_391_1.text_.text = var_394_8

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_10 = 25 <= 0 and var_394_6 or var_394_6 * (utf8.len(var_394_8) / 25)

				if (25 <= 0 and var_394_6 or var_394_6 * (utf8.len(var_394_8) / 25)) > 0 and var_394_6 < var_394_10 then
					arg_391_1.talkMaxDuration = var_394_10

					if var_394_10 + var_394_5 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_10 + var_394_5
					end
				end

				arg_391_1.text_.text = var_394_8
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051094", "story_v_out_425051.awb") ~= 0 then
					local var_394_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051094", "story_v_out_425051.awb") / 1000

					if var_394_11 + var_394_5 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_11 + var_394_5
					end

					if var_394_7.prefab_name ~= "" and arg_391_1.actors_[var_394_7.prefab_name] ~= nil then
						local var_394_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_7.prefab_name].transform, "story_v_out_425051", "425051094", "story_v_out_425051.awb")

						arg_391_1:RecordAudio("425051094", var_394_12)
						arg_391_1:RecordAudio("425051094", var_394_12)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_425051", "425051094", "story_v_out_425051.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_425051", "425051094", "story_v_out_425051.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_13 = math.max(var_394_6, arg_391_1.talkMaxDuration)

			if var_394_5 <= arg_391_1.time_ and arg_391_1.time_ < var_394_5 + var_394_13 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_5) / var_394_13

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_5 + var_394_13 and arg_391_1.time_ < var_394_5 + var_394_13 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play425051095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 425051095
		arg_395_1.duration_ = 5.73

		local var_395_0 = {
			zh = 2.4,
			ja = 5.733
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play425051096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos1037 = arg_395_1.actors_["1037"].transform.localPosition
				arg_395_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_395_1:CheckSpriteTmpPos("1037", 3)

				for iter_398_0 = 0, arg_395_1.actors_["1037"].transform.childCount - 1 do
					local var_398_0 = arg_395_1.actors_["1037"].transform:GetChild(iter_398_0)

					if var_398_0.name == "split_6" then
						var_398_0:SetAsLastSibling()
						var_398_0.gameObject:SetActive(true)

						arg_395_1.var_.actorSpriteSplit1037 = var_398_0.gameObject:GetComponent(typeof(Image))

						arg_395_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_398_1 = 0.275

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_1 then
				arg_395_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_395_1.time_ - 0) / var_398_1)

				if arg_395_1.var_.actorSpriteSplit1037 ~= nil then
					arg_395_1.var_.actorSpriteSplit1037:SetAlpha((arg_395_1.time_ - 0) / var_398_1)
				end
			end

			if arg_395_1.time_ >= 0 + var_398_1 and arg_395_1.time_ < 0 + var_398_1 + arg_398_0 then
				arg_395_1.actors_["1037"].transform.localPosition = Vector3.New(0, -430, -55)

				if arg_395_1.var_.actorSpriteSplit1037 ~= nil then
					arg_395_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_398_2 = 0
			local var_398_3 = 0.275

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_2 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_4 = arg_395_1:GetWordFromCfg(425051095)
				local var_398_5 = arg_395_1:FormatText(var_398_4.content)

				arg_395_1.text_.text = var_398_5

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_7 = 11 <= 0 and var_398_3 or var_398_3 * (utf8.len(var_398_5) / 11)

				if (11 <= 0 and var_398_3 or var_398_3 * (utf8.len(var_398_5) / 11)) > 0 and var_398_3 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_2
					end
				end

				arg_395_1.text_.text = var_398_5
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051095", "story_v_out_425051.awb") ~= 0 then
					local var_398_8 = manager.audio:GetVoiceLength("story_v_out_425051", "425051095", "story_v_out_425051.awb") / 1000

					if var_398_8 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_8 + var_398_2
					end

					if var_398_4.prefab_name ~= "" and arg_395_1.actors_[var_398_4.prefab_name] ~= nil then
						local var_398_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_4.prefab_name].transform, "story_v_out_425051", "425051095", "story_v_out_425051.awb")

						arg_395_1:RecordAudio("425051095", var_398_9)
						arg_395_1:RecordAudio("425051095", var_398_9)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_425051", "425051095", "story_v_out_425051.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_425051", "425051095", "story_v_out_425051.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_10 = math.max(var_398_3, arg_395_1.talkMaxDuration)

			if var_398_2 <= arg_395_1.time_ and arg_395_1.time_ < var_398_2 + var_398_10 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_2) / var_398_10

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_2 + var_398_10 and arg_395_1.time_ < var_398_2 + var_398_10 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.275,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_395_1:InitPlayNodeList()
	end,
	Play425051096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 425051096
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play425051097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1037"]) and arg_399_1.var_.actorSpriteComps1037 == nil then
				arg_399_1.var_.actorSpriteComps1037 = arg_399_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_0 = 0.2

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1037"]) then
				if arg_399_1.var_.actorSpriteComps1037 then
					for iter_402_0, iter_402_1 in pairs(arg_399_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_402_1 then
							if arg_399_1.isInRecall_ then
								iter_402_1.color = Color.New(Mathf.Lerp(iter_402_1.color.r, arg_399_1.hightColor2.r, (arg_399_1.time_ - 0) / var_402_0), Mathf.Lerp(iter_402_1.color.g, arg_399_1.hightColor2.g, (arg_399_1.time_ - 0) / var_402_0), (Mathf.Lerp(iter_402_1.color.b, arg_399_1.hightColor2.b, (arg_399_1.time_ - 0) / var_402_0)))
							else
								local var_402_1 = Mathf.Lerp(iter_402_1.color.r, 0.5, (arg_399_1.time_ - 0) / var_402_0)

								iter_402_1.color = Color.New(var_402_1, var_402_1, var_402_1)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1037"]) and arg_399_1.var_.actorSpriteComps1037 then
				for iter_402_2, iter_402_3 in pairs(arg_399_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_402_3 then
						iter_402_3.color = arg_399_1.isInRecall_ and (arg_399_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_399_1.var_.actorSpriteComps1037 = nil
			end

			local var_402_2 = 0
			local var_402_3 = 0.75

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_2 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_4 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(425051096).content)

				arg_399_1.text_.text = var_402_4

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_6 = 30 <= 0 and var_402_3 or var_402_3 * (utf8.len(var_402_4) / 30)

				if (30 <= 0 and var_402_3 or var_402_3 * (utf8.len(var_402_4) / 30)) > 0 and var_402_3 < var_402_6 then
					arg_399_1.talkMaxDuration = var_402_6

					if var_402_6 + var_402_2 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_6 + var_402_2
					end
				end

				arg_399_1.text_.text = var_402_4
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_7 = math.max(var_402_3, arg_399_1.talkMaxDuration)

			if var_402_2 <= arg_399_1.time_ and arg_399_1.time_ < var_402_2 + var_402_7 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_2) / var_402_7

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_2 + var_402_7 and arg_399_1.time_ < var_402_2 + var_402_7 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play425051097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 425051097
		arg_403_1.duration_ = 1.57

		local var_403_0 = {
			zh = 0.999999999999,
			ja = 1.566
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play425051098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["1037"]) and arg_403_1.var_.actorSpriteComps1037 == nil then
				arg_403_1.var_.actorSpriteComps1037 = arg_403_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_0 = 0.2

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["1037"]) then
				if arg_403_1.var_.actorSpriteComps1037 then
					for iter_406_0, iter_406_1 in pairs(arg_403_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_406_1 then
							if arg_403_1.isInRecall_ then
								iter_406_1.color = Color.New(Mathf.Lerp(iter_406_1.color.r, arg_403_1.hightColor1.r, (arg_403_1.time_ - 0) / var_406_0), Mathf.Lerp(iter_406_1.color.g, arg_403_1.hightColor1.g, (arg_403_1.time_ - 0) / var_406_0), (Mathf.Lerp(iter_406_1.color.b, arg_403_1.hightColor1.b, (arg_403_1.time_ - 0) / var_406_0)))
							else
								local var_406_1 = Mathf.Lerp(iter_406_1.color.r, 1, (arg_403_1.time_ - 0) / var_406_0)

								iter_406_1.color = Color.New(var_406_1, var_406_1, var_406_1)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["1037"]) and arg_403_1.var_.actorSpriteComps1037 then
				for iter_406_2, iter_406_3 in pairs(arg_403_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_406_3 then
						iter_406_3.color = arg_403_1.isInRecall_ and (arg_403_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_403_1.var_.actorSpriteComps1037 = nil
			end

			local var_406_2 = arg_403_1.actors_["1037"].transform

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos1037 = var_406_2.localPosition
				var_406_2.localScale = Vector3.New(1, 1, 1)

				arg_403_1:CheckSpriteTmpPos("1037", 3)

				for iter_406_4 = 0, var_406_2.childCount - 1 do
					local var_406_3 = var_406_2:GetChild(iter_406_4)

					if var_406_3.name == "split_1" then
						var_406_3:SetAsLastSibling()
						var_406_3.gameObject:SetActive(true)

						arg_403_1.var_.actorSpriteSplit1037 = var_406_3.gameObject:GetComponent(typeof(Image))

						arg_403_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_406_4 = 0.2

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				var_406_2.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos1037, Vector3.New(0, -430, -55), (arg_403_1.time_ - 0) / var_406_4)

				if arg_403_1.var_.actorSpriteSplit1037 ~= nil then
					arg_403_1.var_.actorSpriteSplit1037:SetAlpha((arg_403_1.time_ - 0) / var_406_4)
				end
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				var_406_2.localPosition = Vector3.New(0, -430, -55)

				if arg_403_1.var_.actorSpriteSplit1037 ~= nil then
					arg_403_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_406_5 = 0
			local var_406_6 = 0.1

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_5 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_7 = arg_403_1:GetWordFromCfg(425051097)
				local var_406_8 = arg_403_1:FormatText(var_406_7.content)

				arg_403_1.text_.text = var_406_8

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_10 = 4 <= 0 and var_406_6 or var_406_6 * (utf8.len(var_406_8) / 4)

				if (4 <= 0 and var_406_6 or var_406_6 * (utf8.len(var_406_8) / 4)) > 0 and var_406_6 < var_406_10 then
					arg_403_1.talkMaxDuration = var_406_10

					if var_406_10 + var_406_5 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_10 + var_406_5
					end
				end

				arg_403_1.text_.text = var_406_8
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051097", "story_v_out_425051.awb") ~= 0 then
					local var_406_11 = manager.audio:GetVoiceLength("story_v_out_425051", "425051097", "story_v_out_425051.awb") / 1000

					if var_406_11 + var_406_5 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_11 + var_406_5
					end

					if var_406_7.prefab_name ~= "" and arg_403_1.actors_[var_406_7.prefab_name] ~= nil then
						local var_406_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_7.prefab_name].transform, "story_v_out_425051", "425051097", "story_v_out_425051.awb")

						arg_403_1:RecordAudio("425051097", var_406_12)
						arg_403_1:RecordAudio("425051097", var_406_12)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_425051", "425051097", "story_v_out_425051.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_425051", "425051097", "story_v_out_425051.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_13 = math.max(var_406_6, arg_403_1.talkMaxDuration)

			if var_406_5 <= arg_403_1.time_ and arg_403_1.time_ < var_406_5 + var_406_13 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_5) / var_406_13

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_5 + var_406_13 and arg_403_1.time_ < var_406_5 + var_406_13 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play425051098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 425051098
		arg_407_1.duration_ = 12.2

		local var_407_0 = {
			zh = 6.166,
			ja = 12.2
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
			arg_407_1.auto_ = false
		end

		function arg_407_1.playNext_(arg_409_0)
			arg_407_1.onStoryFinished_()
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0.775

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_1 = arg_407_1:GetWordFromCfg(425051098)
				local var_410_2 = arg_407_1:FormatText(var_410_1.content)

				arg_407_1.text_.text = var_410_2

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_4 = 31 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_2) / 31)

				if (31 <= 0 and var_410_0 or var_410_0 * (utf8.len(var_410_2) / 31)) > 0 and var_410_0 < var_410_4 then
					arg_407_1.talkMaxDuration = var_410_4

					if var_410_4 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_4 + 0
					end
				end

				arg_407_1.text_.text = var_410_2
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425051", "425051098", "story_v_out_425051.awb") ~= 0 then
					local var_410_5 = manager.audio:GetVoiceLength("story_v_out_425051", "425051098", "story_v_out_425051.awb") / 1000

					if var_410_5 + 0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_5 + 0
					end

					if var_410_1.prefab_name ~= "" and arg_407_1.actors_[var_410_1.prefab_name] ~= nil then
						local var_410_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_1.prefab_name].transform, "story_v_out_425051", "425051098", "story_v_out_425051.awb")

						arg_407_1:RecordAudio("425051098", var_410_6)
						arg_407_1:RecordAudio("425051098", var_410_6)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_425051", "425051098", "story_v_out_425051.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_425051", "425051098", "story_v_out_425051.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_7 = math.max(var_410_0, arg_407_1.talkMaxDuration)

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_7 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - 0) / var_410_7

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= 0 + var_410_7 and arg_407_1.time_ < 0 + var_410_7 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B13b",
		"TextureConfig/Background/ST60",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST08a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST20"
	},
	voices = {
		"story_v_out_425051.awb"
	}
}
